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
    private $fromBranch;
    private $uuid;
    private $subscribeId;

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

    public function getUuid(): ?string
    {
        return $this->uuid;
    }

    public function setUuid(?string $uuid): self
    {
        $this->uuid = $uuid;

        return $this;
    }
    
    public function getSubscribeId(): ?int
    {
        return $this->subscribeId;
    }

    public function setSubscribeId(?int $subscribeId): self
    {
        $this->subscribeId = $subscribeId;

        return $this;
    }
}
