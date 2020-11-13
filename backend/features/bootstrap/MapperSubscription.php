<?php


class MapperSubscription
{
    /**
     * @var ObjectSubscription $subscription
     */
    private $subscription;

    public function __construct()
    {
    }

    public function setSubscription($ownerID, $packageID, $status)
    {
        $this->subscription = new ObjectSubscription();

        $this->subscription->setOwnerID($ownerID);
        $this->subscription->setPackageID($packageID);
        $this->subscription->setStatus($status);
    }

    /**
     * @return ObjectSubscription
     */
    public function getSubscription(): ObjectSubscription
    {
        return $this->subscription;
    }

    /**
     * @return array
     */
    public function getSubscriptionAsArray(): array
    {
        return ["ownerID"=>$this->subscription->getOwnerID(),
            "packageID"=>$this->subscription->getPackageID(),
            "startDate"=>$this->subscription->getStartDate(),
            "endDate"=>$this->subscription->getEndDate(),
            "status"=>$this->subscription->getStatus()
        ];
    }
}