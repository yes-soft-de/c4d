<?php


class ObjectPackage
{
    private $name;
    private $cost;
    private $note;
    private $carCount;
    private $city;
    private $orderCount;
    private $status;

    public function __construct()
    {
    }

    /**
     * @return mixed
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @param mixed $name
     */
    public function setName($name): void
    {
        $this->name = $name;
    }

    /**
     * @return mixed
     */
    public function getCost()
    {
        return $this->cost;
    }

    /**
     * @param mixed $cost
     */
    public function setCost($cost): void
    {
        $this->cost = $cost;
    }

    /**
     * @return mixed
     */
    public function getNote()
    {
        return $this->note;
    }

    /**
     * @param mixed $note
     */
    public function setNote($note): void
    {
        $this->note = $note;
    }

    /**
     * @return mixed
     */
    public function getCarCount()
    {
        return $this->carCount;
    }

    /**
     * @param mixed $carCount
     */
    public function setCarCount($carCount): void
    {
        $this->carCount = $carCount;
    }

    /**
     * @return mixed
     */
    public function getCity()
    {
        return $this->city;
    }

    /**
     * @param mixed $city
     */
    public function setCity($city): void
    {
        $this->city = $city;
    }

    /**
     * @return mixed
     */
    public function getOrderCount()
    {
        return $this->orderCount;
    }

    /**
     * @param mixed $orderCount
     */
    public function setOrderCount($orderCount): void
    {
        $this->orderCount = $orderCount;
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