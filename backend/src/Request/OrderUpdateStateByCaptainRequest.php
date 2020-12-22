<?php

namespace App\Request;

class OrderUpdateStateByCaptainRequest
{
    private $id;

    private $state;

    private $updateDate;

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
}
