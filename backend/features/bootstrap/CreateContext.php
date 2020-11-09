<?php

use Behat\Behat\Context\Context;

/**
 * Defines application features from the specific context.
 */
class CreateContext implements Context
{
    /**
     * @var array $user
     */
    private $user;

    /**
     * @var array $profile
     */
    private $profile;

    /**
     * @var array $admin
     */
    private $admin;

    public function __construct()
    {
    }

    /**
     * @Given I have valid new user data
     */
    public function iHaveValidNewUserData()
    {
        $factoryRequest = new RequestFactory();

        $this->user = $factoryRequest->prepareCreateUserRequestPayload();
    }

    /**
     * @When I request create a new user with the data I have
     */
    public function iRequestCreateANewUserWithTheDataIHave()
    {
        $this->response = $this->httpClient->post(
            ConfigLinks::$BASE_API . ConfigLinks::$USER_ENDPOINT,
            [
                "json"=>$this->user
            ]
        );
    }

    /**
     * @Given /^A json response with the new user information$/
     */
    public function aJsonResponseWithTheNewUserInformation()
    {
        $data = json_decode($this->response->getBody(), true);

        if($data['Data']['roles'] != ['user'])
        {
            throw new Exception('Error in register a new user!');
        }
    }

    /**
     * @Given I have valid new admin data
     */
    public function iHaveValidNewAdminData()
    {
        $factoryRequest = new RequestFactory();

        $this->admin = $factoryRequest->prepareCreateAdminRequestPayload();
    }

    /**
     * @When I request create a new admin with the data I have
     */
    public function iRequestCreateANewAdminWithTheDataIHave()
    {
        $this->response = $this->httpClient->post(
            ConfigLinks::$BASE_API . 'createnimda',
            [
                "json"=>$this->admin
            ]
        );
    }

    /**
     * @Then A json response with the new admin information
     */
    public function aJsonResponseWithTheNewAdminInformation()
    {
        $data = json_decode($this->response->getBody(), true);

        if($data['Data']['email'] != "a22@test.com")
        {
            throw new Exception('Retrieved information does not match the new one!');
        }
    }

    /**
     * @Given /^I have valid new profile data$/
     */
    public function iHaveValidNewProfileData()
    {
        $factoryRequest = new RequestFactory();

        $this->profile = $factoryRequest->prepareCreateProfileRequestPayload();
    }

    /**
     * @When /^I request create a profile with the data I have$/
     */
    public function iRequestCreateAProfileWithTheDataIHave()
    {
        $this->response = $this->httpClient->post(
            ConfigLinks::$BASE_API . ConfigLinks::$PROFILE_ENDPOINTS,
            [
                'body'=>json_encode($this->profile),
                'headers'=>[
                    "Authorization" => "Bearer " . $this->token,
                    "Accept"        => "application/json",
                ]
            ]
        );
    }

    /**
     * @Given /^A json response with the profile information$/
     */
    public function aJsonResponseWithTheProfileInformation()
    {
        $data = json_decode($this->response->getBody(), true);

        if($data['Data']['userName'] != "u5000")
        {
            throw new Exception('Created data does not match the new one!');
        }
    }

    use CreateCommon;
}
