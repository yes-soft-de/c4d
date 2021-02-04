<?php

namespace App\Request;

class BranchesCreateRequest
{
    private $ownerID;
    private $location = [];
    private $city;
    private $brancheName;
    private $isActive;
      
    /**
    * @param mixed $ownerID
    */
    public function setOwnerID($ownerID): void
    {
        $this->ownerID = $ownerID;
    }

    /**
    * @return mixed
    */
    public function getOwnerID()
    {
        return $this->ownerID;
    }
}
