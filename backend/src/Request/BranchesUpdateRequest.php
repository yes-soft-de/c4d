<?php

namespace App\Request;

class BranchesUpdateRequest
{
    private $id;
    private $location = [];
    private $city;
    private $brancheName;
      
    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}
