<?php

namespace App\Request;

class AcceptedOrderUpdateRequest
{
    private $id;
    private $orderID;
    private $date;
    private $duration;

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

    /**
     * @param mixed $duration
     */
    public function setDuration($duration): void
    {
        $this->duration = $duration;
    }

    /**
     * @return mixed
     */
    public function getDuration()
    {
        return $this->duration;
    }
}
