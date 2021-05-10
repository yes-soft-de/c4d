<?php

namespace App\Request;

class userProfileUpdateByAdminRequest
{
    private $id;
    private $status;
    private $free;
    private $roomID;

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }

    /**
     * Get the value of roomID
     */ 
    public function getRoomID()
    {
        return $this->roomID;
    }

    /**
     * Set the value of roomID
     *
     * @return  self
     */ 
    public function setRoomID($roomID)
    {
        $this->roomID = $roomID;

        return $this;
    }
}
