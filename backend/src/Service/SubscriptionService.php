<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Manager\SubscriptionManager;
use App\Request\SubscriptionCreateRequest;
use App\Request\SubscriptionNextRequest;
use App\Response\SubscriptionResponse;
use App\Response\SubscriptionByIdResponse;
use App\Response\MySubscriptionsResponse;
use App\Response\RemainingOrdersResponse;
use dateTime;
use Symfony\Component\Validator\Constraints\Length;

class SubscriptionService
{
    private $autoMapping;
    private $subscriptionManager;

    public function __construct(AutoMapping $autoMapping, SubscriptionManager $subscriptionManager)
    {
        $this->autoMapping = $autoMapping;
        $this->subscriptionManager = $subscriptionManager;
    }

    public function create(SubscriptionCreateRequest $request)
    {
        $subscriptionResult = $this->subscriptionManager->create($request);

        return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscriptionResult);
    }
    
    public function nxetSubscription(SubscriptionNextRequest $request)
    {
       $SubscriptionCurrent = $this->getSubscriptionCurrent($request->getOwnerID());
       
       $status = $this->subscriptionIsActive($request->getOwnerID(), $SubscriptionCurrent['id']);
        $subscriptionResult = $this->subscriptionManager->nxetSubscription($request, $status);
        
        return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscriptionResult);
    }

    public function getSubscriptionForOwner($ownerID)
    {
       $response = [];
       $currentSubscription = $this->getSubscriptionCurrent($ownerID);
       $this->saveFinisheAuto($ownerID, $currentSubscription['id']);
       $subscriptions = $this->subscriptionManager->getSubscriptionForOwner($ownerID);
      
        foreach ($subscriptions as $subscription) {
            $this->subscriptionIsActive($ownerID, $currentSubscription['id']);
            if ($currentSubscription['id'] == $subscription['id']) {$current = "yes";}
            else{$current = "no";}
            $subscription['isCurrent'] = $current;
            $response[] = $this->autoMapping->map("array", MySubscriptionsResponse::class, $subscription);
        }
        return $response;
    }
  
    public function subscriptionUpdateState($request)
    {
        $result = $this->subscriptionManager->subscriptionUpdateState($request);

        return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $result);
    }

    public function updateFinishe($id, $status)
    {
        $result = $this->subscriptionManager->updateFinishe($id, $status);

        return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $result);
    }

    public function changeIsFutureToFalse($id)
    {
        $result = $this->subscriptionManager->changeIsFutureToFalse($id);

        return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $result);
    }

    public function getSubscriptionsPending()
    {
        $response = [];
        $items = $this->subscriptionManager->getSubscriptionsPending();
       
        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', SubscriptionByIdResponse::class, $item);
        }
        return $response;
    }
    
    public function getSubscriptionById($id)
    {
        $response = [];
        $items = $this->subscriptionManager->getSubscriptionById($id);
      
        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', SubscriptionByIdResponse::class, $item);
        }
        return $response;
    }

    public function subscriptionIsActive($ownerID, $subscribeId)
    {
        $this->saveFinisheAuto($ownerID, $subscribeId);
    
        $item = $this->subscriptionManager->subscriptionIsActive($ownerID, $subscribeId);
        if ($item) {
          return  $item['status'];
        }

        return $item ;
     }

    // check subscription , if time is finishe or order count is finishe, change status value to 'finished'
    public function saveFinisheAuto($ownerID, $subscribeId)
    {
        $response = [];
        //Get full information for the current subscription
        $remainingOrdersOfPackage = $this->subscriptionManager->getRemainingOrders($ownerID, $subscribeId);
        if ($remainingOrdersOfPackage['subscriptionEndDate']) {
   
            $endDate =date_timestamp_get($remainingOrdersOfPackage['subscriptionEndDate']);
            
            $now =date_timestamp_get(new DateTime("now"));

            if ( $endDate <= $now)  {

                $this->updateFinishe($remainingOrdersOfPackage['subscriptionID'], 'date finished');
                if($this->getNextSubscription($ownerID)) {
                    $this->changeIsFutureToFalse($this->getNextSubscription($ownerID));
                    }
                $response[] = ["subscripe finished, date is finished"];
            }

            if ($remainingOrdersOfPackage['remainingOrders'] == 0)  {
        
                $this->updateFinishe($remainingOrdersOfPackage['subscriptionID'], 'orders finished');
                if($this->getNextSubscription($ownerID)) {
                $this->changeIsFutureToFalse($this->getNextSubscription($ownerID));
                }
                $response[] = ["subscripe finished, count Orders is finished"];
            }
            
        }
        $response = $this->autoMapping->map('array', RemainingOrdersResponse::class, $remainingOrdersOfPackage);
        $subscribeStauts = $this->subscriptionManager->subscriptionIsActive($ownerID, $subscribeId);
        
        if ($subscribeStauts['status']) {
            $response->subscriptionstatus = $subscribeStauts['status'];
        }
        return $response;
     }

    public function subscripeNewUsers($year, $month)
    {
       
        $fromDate =new \DateTime($year . '-' . $month . '-01'); 
        $toDate = new \DateTime($fromDate->format('Y-m-d') . ' 1 month');

        return $this->subscriptionManager->subscripeNewUsers($fromDate, $toDate);       
     }

    public function dashboardContracts($year, $month)
    {
        $response = [];

        $response[] = $this->subscriptionManager->countpendingContracts();
        $response[] = $this->subscriptionManager->countDoneContracts();
        $response[] = $this->subscripeNewUsers($year, $month);

        $subscriptionsPending = $this->subscriptionManager->getSubscriptionsPending();
       
        foreach ($subscriptionsPending as $item) {
            $response[] = $this->autoMapping->map('array', SubscriptionByIdResponse::class, $item);
        }
        
        return $response;
    }

    public function getSubscriptionCurrent($ownerID)
    {
        return $this->subscriptionManager->getSubscriptionCurrent($ownerID);
    }

    public function getNextSubscription($ownerID)
    {
        return $this->subscriptionManager->getNextSubscription($ownerID);
    }

    public function packagebalance($ownerID)
    {
        $subscribe = $this->getSubscriptionCurrent($ownerID);
        if ($subscribe) {
            return $this->saveFinisheAuto($ownerID, $subscribe['id']);
        }

    }

    public function totalAmountOfSubscriptions($ownerID)
    {
        $items = $this->subscriptionManager->totalAmountOfSubscriptions($ownerID);
        foreach($items as $item)
        {
            if (isset($result[$item['totalAmountOfSubscriptions']]))
            {
                $result[$item['totalAmountOfSubscriptions']] += $item['totalAmountOfSubscriptions'];
            }
            else
            {
                $result[$item['totalAmountOfSubscriptions']] = $item['totalAmountOfSubscriptions'];
            }
        }
            return array_sum($result);
    }  
}
