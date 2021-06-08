<?php

namespace App\Request;

class OrderUpdateStateByCaptainRequest
{
    private $id;

    private $state;

    private $updateDate;
    
    private $kilometer;

    private $captainID;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setId($id): void
    {
        $this->id = $id;
    }

    /**
     * @return mixed
     */ 
    public function getState()
    {
        return $this->state;
    }

    /**
     * @return mixed
     */  
    public function getKilometer()
    {
        return $this->kilometer;
    }

    /**
     * Set the value of kilometer
     *
     * @return  self
     */ 
    public function setKilometer($kilometer)
    {
        $this->kilometer = $kilometer;

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
}
