<?php

namespace App\Request;

class CaptainProfileUpdateByAdminRequest
{
    private $captainID;

    private $salary;

    private $status;

    private $bounce;
    
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
