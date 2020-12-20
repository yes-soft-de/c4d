<?php

namespace App\Request;

class AcceptedOrderUpdateStateByCaptainRequest
{
    private $id;
    private $state;
    private $orderId;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $state
     */
    public function getState()
    {
        return $this->state;
    }

    /**
     * @return mixed
     */
    public function setState($state)
    {
        $this->state = $state;

        return $this;
    }

    /**
     * @param mixed $orderId
     */ 
    public function getOrderId()
    {
        return $this->orderId;
    }
}
