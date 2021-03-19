<?php

namespace App\Request;

class CaptainVacationByAdminRequest
{
    private $captainID;

    private $state;
    
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
     * Get the value of state
     */ 
    public function getState()
    {
        return $this->state;
    }

    /**
     * Set the value of state
     *
     * @return  self
     */ 
    public function setState($state)
    {
        $this->state = $state;

        return $this;
    }
}
