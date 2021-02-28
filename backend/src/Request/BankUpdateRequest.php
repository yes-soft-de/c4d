<?php

namespace App\Request;

class BankUpdateRequest
{
    private $id;
    private $bankName;
    private $accountID;
    private $stcPay;
      
    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}
