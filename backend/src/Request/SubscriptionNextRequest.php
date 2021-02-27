<?php

namespace App\Request;

class SubscriptionNextRequest
{
    private $ownerID;

    private $packageID;

    private $startDate;

    private $endDate;

    private $status;

    private $isFuture;

    /**
     * @param mixed $ownerID
     */
    public function setOwnerID($ownerID): void
    {
        $this->ownerID = $ownerID;
    }

     /**
     * @return mixed
     */
    public function getOwnerID()
    {
        return $this->ownerID;
    }
    /**
     * @param mixed $status
     */
    public function setStatus($status): void
    {
        $this->status = $status;
    }

     /**
     * @return mixed
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * Get the value of isFuture
     */ 
    public function getIsFuture()
    {
        return $this->isFuture;
    }

    /**
     * Set the value of isFuture
     *
     * @return  self
     */ 
    public function setIsFuture($isFuture)
    {
        $this->isFuture = $isFuture;

        return $this;
    }
}
