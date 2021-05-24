<?php


namespace App\Request;


class SendNotificationRequest
{
    private $userIdOne;

    private $userIdTwo;

    private $message;

    private $orderID;

    /**
     * @return mixed
     */
    public function getMessage()
    {
        return $this->message;
    }

    /**
     * @param mixed $message
     */
    public function setMessage($message): void
    {
        $this->message = $message;
    }

    /**
     * @return mixed
     */
    public function getUserIdOne()
    {
        return $this->userIdOne;
    }

    /**
     * @param mixed $userIdOne
     */
    public function setUserIdOne($userIdOne): void
    {
        $this->userIdOne = $userIdOne;
    }

    /**
     * @return mixed
     */
    public function getUserIdTwo()
    {
        return $this->userIdTwo;
    }

    /**
     * @param mixed $userIdTwo
     */
    public function setUserIdTwo($userIdTwo): void
    {
        $this->userIdTwo = $userIdTwo;
    }

    /**
     * @return mixed
     */
    public function getOrderID()
    {
        return $this->orderID;
    }

    /**
     * @param mixed $orderID
     */
    public function setOrderID($orderID): void
    {
        $this->orderID = $orderID;
    }


}