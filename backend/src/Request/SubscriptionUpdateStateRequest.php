<?php

namespace App\Request;

class SubscriptionUpdateStateRequest
{
    private $id;

    private $endDate;

    private $status;

    private $note;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    public function getEndDate()
    {
        return $this->endDate;
    }

    public function setEndDate($endDate): self
    {
        $this->endDate = new \DateTime($endDate);

        return $this;
    }
}
