<?php

use Behat\Behat\Context\Context;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;

/**
 * Defines application features from the specific context.
 */
class QueryContext implements Context
{
    /**
     * Initializes context.
     *
     * Every scenario gets its own context instance.
     * You can also pass arbitrary arguments to the
     * context constructor through behat.yml.
     */
    public function __construct()
    {
    }

    /**
     * @When /^I request my profile$/
     */
    public function iRequestMyProfile()
    {
        try
        {
            $this->response = $this->httpClient->get(
                ConfigLinks::$BASE_API . 'userprofile',
                [
                    'headers' => [
                        "Authorization" => "Bearer " . $this->token,
                        "Accept" => "application/json",
                    ]
                ]
            );
        }
        catch (GuzzleHttp\Exception\ClientException $ex)
        {
            throw new Exception('No data were found!');
        }
    }

    /**
     * @Given /^A json response with my information$/
     */
    public function aJsonResponseWithMyInformation()
    {
        $data = json_decode($this->response->getBody(), true);

        if($data['Data']['userName'] != "u22")
        {
            throw new Exception('Wrong returned data !');
        }
    }

    /**
     * @When I request active packages
     */
    public function iRequestActivePackages()
    {
        try
        {
            $this->response = $this->httpClient->get(
                ConfigLinks::$BASE_API . 'activepackages',
                [
                    'headers' => [
                        "Authorization" => "Bearer " . $this->token,
                        "Accept" => "application/json",
                    ]
                ]
            );
        }
        catch (GuzzleHttp\Exception\ClientException $ex)
        {
            throw new Exception('No data were found!');
        }
    }

    /**
     * @When /^I request packages for location "([^"]*)"$/
     */
    public function iRequestPackagesForLocation($arg1)
    {
        try
        {
            $this->response = $this->httpClient->get(
                ConfigLinks::$BASE_API . 'packages/' . $arg1,
                [
                    'headers' => [
                        "Authorization" => "Bearer " . $this->token,
                        "Accept" => "application/json",
                    ]
                ]
            );
        }
        catch (GuzzleHttp\Exception\ClientException $ex)
        {
            throw new Exception('No data were found!');
        }
    }

    /**
     * @When /^I request current subscriptions$/
     */
    public function iRequestCurrentSubscriptions()
    {
        try
        {
            $this->response = $this->httpClient->get(
                ConfigLinks::$BASE_API . 'currentsubscriptions',
                [
                    'headers' => [
                        "Authorization" => "Bearer " . $this->token,
                        "Accept" => "application/json",
                    ]
                ]
            );
        }
        catch (GuzzleHttp\Exception\ClientException $ex)
        {
            throw new Exception('No data were found!');
        }
    }

    use CreateCommon;
}
