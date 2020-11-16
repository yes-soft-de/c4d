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
}
