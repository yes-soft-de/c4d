<?php

namespace App\Request;

class PackageUpdateRequest
{
    private $id;

    private $name;

    private $cost;

    private $note;

    private $carCount;

    private $city;

    private $orderCount;

    private $status;
    
    private $branch;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}
