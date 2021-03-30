<?php


namespace App\Request;


use DateTime;

class NotificationTokenRequest
{
    private $userID;

    private $token;

    private $date;

    private $userID2;

    public function getDate():?\DateTime
    {
        try
        {
            return new DateTime((string)$this->date);
        }
        catch (\Exception $e)
        {
        }
    }

    public function setDate(\DateTime $date): self
    {
        try
        {
            $this->date = new \DateTime((string)$date);
        }
        catch (\Exception $e)
        {
        }

        return $this;
    }

    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }

    /**
     * @return mixed
     */
    public function getToken()
    {
        return $this->token;
    }

    /**
     * @param mixed $token
     */
    public function setToken($token): void
    {
        $this->token = $token;
    }



    /**
     * Get the value of userID2
     */ 
    public function getUserID2()
    {
        return $this->userID2;
    }

    /**
     * Set the value of userID2
     *
     * @return  self
     */ 
    public function setUserID2($userID2)
    {
        $this->userID2 = $userID2;

        return $this;
    }
}