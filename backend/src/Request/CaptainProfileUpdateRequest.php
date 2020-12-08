<?php

namespace App\Request;

class CaptainProfileUpdateRequest
{
    private $id;

    private $captainID;

    private $name;

    private $image;

    private $location;

    private $age;

    private $car;

    private $drivingLicence;

    private $salary;

    private $status;

    private $state;

    private $bounce;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Get the value of captainID
     */
    public function getCaptainID()
    {
        return $this->captainID;
    }

    /**
     * Set the value of captainID
     *
     * @return  self
     */
    public function setCaptainID($captainID)
    {
        $this->captainID = $captainID;

        return $this;
    }

    /**
     * Get the value of name
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set the value of name
     *
     * @return  self
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Get the value of image
     */
    public function getImage()
    {
        return $this->image;
    }

    /**
     * Set the value of image
     *
     * @return  self
     */
    public function setImage($image)
    {
        $this->image = $image;

        return $this;
    }

    /**
     * Get the value of location
     */
    public function getLocation()
    {
        return $this->location;
    }

    /**
     * Set the value of location
     *
     * @return  self
     */
    public function setLocation($location)
    {
        $this->location = $location;

        return $this;
    }

    /**
     * Get the value of age
     */
    public function getAge()
    {
        return $this->age;
    }

    /**
     * Set the value of age
     *
     * @return  self
     */
    public function setAge($age)
    {
        $this->age = $age;

        return $this;
    }

    /**
     * Get the value of car
     */
    public function getCar()
    {
        return $this->car;
    }

    /**
     * Set the value of car
     *
     * @return  self
     */
    public function setCar($car)
    {
        $this->car = $car;

        return $this;
    }

    /**
     * Get the value of drivingLicence
     */
    public function getDrivingLicence()
    {
        return $this->drivingLicence;
    }

    /**
     * Set the value of drivingLicence
     *
     * @return  self
     */
    public function setDrivingLicence($drivingLicence)
    {
        $this->drivingLicence = $drivingLicence;

        return $this;
    }
    
    /**
     * Get the value of salary
     */
    public function getSalary(): ?float
    {
        return $this->salary;
    }

    /**
     * Set the value of salary
     *
     * @return  self
     */
    public function setSalary(float $salary): self
    {
        $this->salary = $salary;

        return $this;
    }

    /**
     * Get the value of status
     */
    public function getStatus(): ?string
    {
        return $this->status;
    }

    /**
     * Set the value of status
     *
     * @return  self
     */
    public function setStatus(string $status): self
    {
        $this->status = $status;

        return $this;
    }

    /**
     * Get the value of bounce
     */
    public function getBounce(): ?string
    {
        return $this->bounce;
    }

    /**
     * Set the value of bounce
     *
     * @return  self
     */
    public function setBounce(string $bounce): self
    {
        $this->bounce = $bounce;

        return $this;
    }
}
