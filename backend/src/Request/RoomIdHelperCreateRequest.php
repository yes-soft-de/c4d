<?php

namespace App\Request;

class RoomIdHelperCreateRequest
{
    private $id;
    private $captainID;
    private $ownerID;
    private $roomID;

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set the value of id
     *
     * @return  self
     */ 
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }

    /**
     * Get the value of captainID
     */ 
    public function getCaptainID()
    {
        return $this->captainID;
    }

    /**
     * Set the value of captainID
     *
     * @return  self
     */ 
    public function setCaptainID($captainID)
    {
        $this->captainID = $captainID;

        return $this;
    }

    /**
     * Get the value of ownerID
     */ 
    public function getOwnerID()
    {
        return $this->ownerID;
    }

    /**
     * Set the value of ownerID
     *
     * @return  self
     */ 
    public function setOwnerID($ownerID)
    {
        $this->ownerID = $ownerID;

        return $this;
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
