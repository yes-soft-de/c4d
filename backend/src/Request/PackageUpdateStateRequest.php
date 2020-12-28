<?php

namespace App\Request;

class PackageUpdateStateRequest
{
    private $id;

    private $status;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}
