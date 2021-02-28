<?php

namespace App\Request;

class SubscriptionChangeIsFutureRequest
{
    private $id;

    private $isFuture;

    private $startDate;
    
    private $endDate;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Get the value of isFuture
     */ 
    public function getIsFuture()
    {
        return $this->isFuture;
    }

    /**
     * Set the value of isFuture
     *
     * @return  self
     */ 
    public function setIsFuture($isFuture)
    {
        $this->isFuture = $isFuture;

        return $this;
    }

    /**
     * Get the value of startDate
     */ 
    public function getStartDate()
    {
        return $this->startDate;
    }

    /**
     * Set the value of startDate
     *
     * @return  self
     */ 
    public function setStartDate($startDate)
    {
        $this->startDate = $startDate;

        return $this;
    }

    /**
     * Get the value of endDate
     */ 
    public function getEndDate()
    {
        return $this->endDate;
    }

    /**
     * Set the value of endDate
     *
     * @return  self
     */ 
    public function setEndDate($endDate)
    {
        $this->endDate = $endDate;

        return $this;
    }
}
