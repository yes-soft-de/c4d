<?php

namespace App\Request;

class BranchesDeleteRequest
{
    private $id;
    private $isActive;
      
    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}
