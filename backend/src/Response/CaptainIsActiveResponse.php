<?php

namespace App\Response;

class CaptainIsActiveResponse
{
    public $status;

    /**
     * Get the value of status
     */ 
    public function getStatus()
    {
        return $this->status;
    }
}
