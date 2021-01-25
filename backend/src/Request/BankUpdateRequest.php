<?php

namespace App\Request;

class BankUpdateRequest
{
    private $id;
    private $bankName;
    private $accountID;
      
    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}
