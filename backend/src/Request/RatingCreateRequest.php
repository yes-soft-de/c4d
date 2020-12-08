<?php

namespace App\Request;

class RatingCreateRequest
{
    private $ownerID;
    private $captainID;
    private $type;
    private $orderID;
  
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
