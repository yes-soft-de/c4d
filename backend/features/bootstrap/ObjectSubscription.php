<?php


class ObjectSubscription
{
    private $ownerID;
    private $packageID;
    private $startDate;
    private $endDate;
    private $status;

    public function __construct()
    {
    }

    /**
     * @return mixed
     */
    public function getOwnerID()
    {
        return $this->ownerID;
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
    public function getPackageID()
    {
        return $this->packageID;
    }

    /**
     * @param mixed $packageID
     */
    public function setPackageID($packageID): void
    {
        $this->packageID = $packageID;
    }

    /**
     * @return mixed
     */
    public function getStartDate()
    {
        return $this->startDate;
    }

    /**
     * @param mixed $startDate
     */
    public function setStartDate($startDate): void
    {
        $this->startDate = $startDate;
    }

    /**
     * @return mixed
     */
    public function getEndDate()
    {
        return $this->endDate;
    }

    /**
     * @param mixed $endDate
     */
    public function setEndDate($endDate): void
    {
        $this->endDate = $endDate;
    }

    /**
     * @return mixed
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * @param mixed $status
     */
    public function setStatus($status): void
    {
        $this->status = $status;
    }

}