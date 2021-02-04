<?php

namespace App\Request;

class OrderUpdateStateByCaptainRequest
{
    private $id;

    private $state;

    private $updateDate;
    
    private $kilometer;

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
}
