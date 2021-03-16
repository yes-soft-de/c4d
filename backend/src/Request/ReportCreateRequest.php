<?php

namespace App\Request;

class ReportCreateRequest
{
    private $userId;
    private $orderId;
    private $reason;
    private $uuid;
      
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

    /**
     * Get the value of uuid
     */ 
    public function getUuid()
    {
        return $this->uuid;
    }

    /**
     * Set the value of uuid
     *
     * @return  self
     */ 
    public function setUuid($uuid)
    {
        $this->uuid = $uuid;

        return $this;
    }
}
