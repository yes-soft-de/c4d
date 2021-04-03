<?php


namespace App\Request;


use DateTime;

class NotificationTokenRequest
{
    private $userID;

    private $token;

    private $date;

    private $roomID;


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
     * Get the value of roomID
     */ 
    public function getRoomID()
    {
        return $this->roomID;
    }

    /**
     * Set the value of roomID
     *
     * @return  self
     */ 
    public function setRoomID($roomID)
    {
        $this->roomID = $roomID;

        return $this;
    }
}