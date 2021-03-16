<?php

namespace App\Request;

class companyInfoUpdateRequest
{
    private $id;
    private $phone;
    private $phone2;
    private $whatsapp;
    private $fax;
    private $bank;
    private $stc;
    private $email;

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set the value of id
     *
     * @return  self
     */ 
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }
}
