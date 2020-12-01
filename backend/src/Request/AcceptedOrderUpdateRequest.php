<?php

namespace App\Request;

class AcceptedOrderUpdateRequest
{
    private $id;
    private $orderID;
    // private $captainID;
    private $date;
    private $cost;
    private $state;

     /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
   
     /**
     * @param mixed $date
     */
    public function setDate($date): void
    {
        $this->date = $date;
    }

     /**
     * @return mixed
     */
    public function getDate()
    {
        $this->date = new \DateTime($date);
        return $this;
    }
}
