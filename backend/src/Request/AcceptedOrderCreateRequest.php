<?php

namespace App\Request;

class AcceptedOrderCreateRequest
{
    private $orderID;
    private $captainID;
    private $date;
    private $cost;
    private $duration;

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
    
}
