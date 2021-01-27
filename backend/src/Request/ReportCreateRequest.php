<?php

namespace App\Request;

class ReportCreateRequest
{
    private $userId;
    private $orderId;
    private $reason;
      
    /**
    * @param mixed $userId
    */
    public function setUserId($userId): void
    {
        $this->userId = $userId;
    }

    /**
    * @return mixed
    */
    public function getUserId()
    {
        return $this->userId;
    }
}
