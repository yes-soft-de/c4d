<?php

namespace App\Request;

class OrderCreateRequest
{
    private $ownerID;
    private $source = [];
    private $destination = [];
    private $date;
    private $note;
    private $payment;
    private $recipientName;
    private $recipientPhone;
    private $state;

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
    public function getState(): ?string
    {
        return $this->state;
    }

    public function setState(?string $state): self
    {
        $this->state = $state;

        return $this;
    }
}
