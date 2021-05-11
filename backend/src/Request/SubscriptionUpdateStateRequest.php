<?php

namespace App\Request;

class SubscriptionUpdateStateRequest
{
    private $id;

    private $status;

    private $note;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}
