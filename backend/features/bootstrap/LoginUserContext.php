<?php


use Behat\Behat\Context\Context;

class LoginUserContext implements Context
{
    public function __construct()
    {
    }

    use CreateCommon;
}