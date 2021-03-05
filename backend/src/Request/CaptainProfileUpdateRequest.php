<?php

namespace App\Request;

class CaptainProfileUpdateRequest
{
    private $userID;
    
    private $name;

    private $image;

    private $location;

    private $age;

    private $car;

    private $drivingLicence;

    private $state;
    
    private $phone;

    private $isOnline;
    
    private $bankName;

    private $accountID;
    
    private $stcPay;

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
     * Get the value of isOnline
     */ 
    public function getIsOnline()
    {
        return $this->isOnline;
    }

    /**
     * Set the value of isOnline
     *
     * @return  self
     */ 
    public function setIsOnline($isOnline)
    {
        $this->isOnline = $isOnline;

        return $this;
    }

    /**
     * Get the value of userID
     */ 
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * Set the value of userID
     *
     * @return  self
     */ 
    public function setUserID($userID)
    {
        $this->userID = $userID;

        return $this;
    }
}
