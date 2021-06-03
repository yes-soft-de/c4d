<?php


namespace App\Request;


class UserUpdateRequest
{
    private $id;

    private $password;

    private $userID;

    public function getId()
    {
        return $this->id;
    }

    public function getPassword()
    {
        return $this->password;
    }

    public function getUserID()
    {
        return $this->userID;
    }
    
}
