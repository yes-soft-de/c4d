<?php

use GuzzleHttp\Client;
use GuzzleHttp\Psr7\Response;

trait CreateCommon
{
    /**
     * @var Response $response
     */
    private $response;

    /**
     * @var string $exception
     */
    protected $exception;

    /**
     * @var string $token
     */
    protected $token;

    /**
     * @var array $userCredentials
     */
    private $userCredentials;

    /**
     * @var Client $httpClient
     */
    private $httpClient;

    /**
     * @Given I have access to backend
     */
    public function iHaveAccessToBackend()
    {
        $this->httpClient = new Client([
            'base_uri'=>ConfigLinks::$BASE_API
        ]);
    }

    /**
     * @Given I have valid user credentials
     */
    public function iHaveValidUserCredentials()
    {
        $factoryRequest = new RequestFactory();

        $this->userCredentials = $factoryRequest->prepareUserLoginRequestPayload();
    }

    /**
     * @Given /^I have valid admin credentials$/
     */
    public function iHaveValidAdminCredentials()
    {
        $factoryRequest = new RequestFactory();

        $this->userCredentials = $factoryRequest->prepareAdminLoginRequestPayload();
    }

    /**
     * @When I request login check
     */
    public function iRequestLoginCheck()
    {
        $this->response = $this->httpClient->post(
            ConfigLinks::$BASE_API . 'login_check',
            [
                "json"=>$this->userCredentials
            ]
        );
    }

    /**
     * @Then I expect a token within the response
     */
    public function iExpectATokenWithinTheResponse()
    {
        $data = json_decode($this->response->getBody(), true);

        if($data['token'] == null)
        {
            throw new Exception('Error in retrieving the token!');
        }
        else
        {
            $this->token = $data['token'];
        }
    }

    /**
     * @Given I am signed in user
     */
    public function iAmSignedInUser()
    {
        $this->iHaveAccessToBackend();
        $this->iHaveValidUserCredentials();
        $this->iRequestLoginCheck();
        $this->iExpectATokenWithinTheResponse();
    }

    /**
     * @Then I expect response code :arg1
     */
    public function iExpectResponseCode($arg1)
    {
        if ($this->response->getStatusCode() == $arg1)
            return;
        else {
            return new Exception("Status Code Error", -1);
        }
    }

    /**
     * @Then I get the Not Found response
     */
    public function iGetTheNotFoundResponse()
    {
        $data = json_decode($this->exception, true);

        if($data["status_code"] != "404")
        {
            throw new Exception('Wrong status code!');
        }

    }

    /**
     * @Then A response with message data not found
     */
    public function aResponseWithMessageDataNotFound()
    {
        $data = json_decode($this->exception, true);

        if($data["msg"] != "Data not found!")
        {
            throw new Exception('Unexpected response message!');
        }
    }

    /**
     * @Given /^A json response with expired token$/
     */
    public function aJsonResponseWithExpiredToken()
    {
        $data = json_decode($this->exception, true);

        if($data["message"] != "Expired JWT Token")
        {
            throw new Exception('Unexpected response message!');
        }
    }

    /**
     * @Given /^I am not signed in user$/
     */
    public function iAmNotSignedInUser()
    {
        $this->token = null;
    }

    /**
     * @Then I expect the response update successfully
     */
    public function iExpectTheResponseUpdateSuccessfully()
    {
        $data = json_decode($this->response->getBody(), true);

        if($data['msg'] != "updated Successfully.")
        {
            throw new Exception('Wrong returned data !');
        }
    }

    /**
     * @Given /^I am signed in admin$/
     */
    public function iAmSignedInAdmin()
    {
        $this->iHaveAccessToBackend();
        $this->iHaveValidUserCredentials();
        $this->iRequestLoginCheck();
        $this->iExpectATokenWithinTheResponse();
    }

    /**
     * @Given /^A json response with the required information$/
     */
    public function aJsonResponseWithTheRequiredInformation()
    {
        $data = json_decode($this->response->getBody(), true);

        if($data['Data'] == null)
        {
            throw new Exception('Error in retrieving the token!');
        }
    }


}