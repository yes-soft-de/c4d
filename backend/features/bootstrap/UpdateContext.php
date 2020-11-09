<?php


use Behat\Behat\Context\Context;

class UpdateContext implements Context
{
    /**
     * @var array $userProfile
     */
    private $userProfile;

    public function __construct()
    {
    }

    use CreateCommon;

//    /**
//     * @Given /^I have a valid car update request of ID "([^"]*)"$/
//     */
//    public function iHaveAValidCarUpdateRequestOfID($arg1)
//    {
//        $requestFactory = new RequestFactory();
//
//        $this->car = $requestFactory->prepareCarUpdateRequestPayload($arg1);
//    }
//
//    /**
//     * @When I request update a car
//     */
//    public function iRequestUpdateACar()
//    {
//        $this->response = $this->httpClient->put(
//            ConfigLinks::$BASE_API . ConfigLinks::$CAR_ENDPOINTS,
//            [
//                'body'=>json_encode($this->car),
//                'headers'=>[
//                    "Authorization" => "Bearer " . $this->token,
//                    "Accept"        => "application/json",
//                ]
//            ]
//        );
//    }
//
//    /**
//     * @Then I expect the response update successfully
//     */
//    public function iExpectTheResponseUpdateSuccessfully()
//    {
//        $data = json_decode($this->response->getBody(), true);
//
//        if($data['msg'] != 'updated Successfully.')
//        {
//            throw new Exception('Error in updating the required data!');
//        }
//    }
//
//    /**
//     * @Then I expect the updated car match the data
//     */
//    public function iExpectTheUpdatedCarMatchTheData()
//    {
//        $data = json_decode($this->response->getBody(), true);
//
//        if($data['Data']['brand'] != 'updated Test model')
//        {
//            throw new Exception('Wrong data were being updated!');
//        }
//    }

    /**
     * @Given /^I have new profile information$/
     */
    public function iHaveNewProfileInformation()
    {
        $requestFactory = new RequestFactory();

        $this->userProfile = $requestFactory->prepareUserProfileUpdateRequestPayload();
    }

    /**
     * @When /^I request update my profile$/
     */
    public function iRequestUpdateMyProfile()
    {
        $this->response = $this->httpClient->put(
            ConfigLinks::$BASE_API . ConfigLinks::$PROFILE_ENDPOINTS,
            [
                'body'=>json_encode($this->userProfile),
                'headers'=>[
                    "Authorization" => "Bearer " . $this->token,
                    "Accept"        => "application/json",
                ]
            ]
        );
    }

    /**
     * @Given /^I expect the response match the new information$/
     */
    public function iExpectTheResponseMatchTheNewInformation()
    {
        $data = json_decode($this->response->getBody(), true);

        if($data['Data']['userName'] != 'u22')
        {
            throw new Exception('Wrong data were being updated!');
        }
    }

}