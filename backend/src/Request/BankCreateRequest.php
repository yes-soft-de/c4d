<?php

namespace App\Request;

class BankCreateRequest
{
    private $userID;
    private $bankName;
    private $accountID;
      
    /**
    * @param mixed $userID
    */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }

    /**
    * @return mixed
    */
    public function getUserID()
    {
        return $this->userID;
    }
}
