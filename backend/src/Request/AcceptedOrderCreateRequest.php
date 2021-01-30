<?php

namespace App\Request;

class AcceptedOrderCreateRequest
{
    private $orderID;
    private $captainID;
    private $date;
    private $duration;
    private $state;
    private $dateOnly;

    /**
     * @param mixed $captainID
     */
    public function setCaptainID($captainID): void
    {
        $this->captainID = $captainID;
    }

    /**
     * @return mixed
     */
    public function getCaptainID()
    {
        return $this->captainID;
    }
    
    /**
     * @return mixed
     */
    public function getState()
    {
        return $this->state;
    }

   /**
     * @param mixed $state
     */
    public function setState($state)
    {
        $this->state = $state;

        return $this;
    }

     /**
     * @return mixed
     */
    public function getOrderID()
    {
        return $this->orderID;
    }
}
