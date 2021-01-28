<?php

namespace App\Request;

class DatingCreateRequest
{
    private $userName;
    private $phone;
    private $isDone;

    /**
     * Get the value of isDone
     */ 
    public function getIsDone()
    {
        return $this->isDone;
    }

    /**
     * Set the value of isDone
     *
     * @return  self
     */ 
    public function setIsDone($isDone)
    {
        $this->isDone = $isDone;

        return $this;
    }
}