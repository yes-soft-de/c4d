<?php


namespace App\Request;


class UserUpdateRequest
{
    private $id;

    private $password;

    public function getId()
    {
        return $this->id;
    }

    public function getPassword()
    {
        return $this->password;
    }
    
}
