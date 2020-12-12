<?php

namespace App\Request;

class OrderUpdateRequest
{
    private $id;
    private $ownerID;
    private $source = [];
    private $destination = [];
    private $note;
    private $payment;
    private $recipientName;
    private $recipientPhone;
    private $updateDate;
    private $fromBranch;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setId($id): void
    {
        $this->id = $id;
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
}
