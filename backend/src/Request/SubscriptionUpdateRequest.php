<?php

namespace App\Request;

class SubscriptionUpdateRequest
{
    private $id;

    private $ownerID;

    private $packageID;

    private $startDate;

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

    public function setStartDate(?\DateTimeInterface $startDate): self
    {
        $this->startDate = $startDate;

        return $this;
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
