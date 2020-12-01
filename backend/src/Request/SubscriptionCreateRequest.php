<?php

namespace App\Request;

class SubscriptionCreateRequest
{
    private $ownerID;

    private $packageID;

    private $startDate;

    private $endDate;

    private $status;

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
}
