<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\PaymentsEntity;
use App\Manager\PaymentManager;
use App\Request\PaymentCreateRequest;
use App\Response\PaymentCreateResponse;
use App\Service\SubscriptionService;
use App\Service\BankService;
use DateTime;
class PaymentService
{
    private $autoMapping;
    private $paymentManager;
    private $subscriptionService;
    private $bankService;

    public function __construct(AutoMapping $autoMapping, PaymentManager $paymentManager, SubscriptionService $subscriptionService, BankService $bankService)
    {
        $this->autoMapping = $autoMapping;
        $this->paymentManager = $paymentManager;
        $this->subscriptionService = $subscriptionService;
        $this->bankService = $bankService;
    }

    public function create(PaymentCreateRequest $request)
    {
        $item = $this->paymentManager->create($request);

        return $this->autoMapping->map(PaymentsEntity::class, PaymentCreateResponse::class, $item);
    }

    public function getpaymentsForOwner($ownerId, $admin='null')
    {
       $response = [];

       $totalAmountOfSubscriptions= $this->subscriptionService->totalAmountOfSubscriptions($ownerId);
       $bank= $this->bankService->getAccount($ownerId);
       
        $items = $this->paymentManager->getpaymentsForOwner($ownerId);
      
        $sumPayments = $this->paymentManager->getSumAmount($ownerId);
       
        $NewAmount = $this->paymentManager->getNewAmount($ownerId);
        $nextPay = null;
        if ($NewAmount){
            $nextPay = $this->subtractTowDates($NewAmount[0]['date']);
        }
        $sumPayments = $sumPayments[0]['sumPayments'];
       
        

        $total = $sumPayments - $totalAmountOfSubscriptions;
        
        if ($admin == "admin"){$total = $totalAmountOfSubscriptions - $sumPayments;}
        
        foreach ($items as $item) {  
            $response[]=  $this->autoMapping->map('array', PaymentCreateResponse::class, $item);  
        }
        
      $arr['payments'] = $response;
      $arr['nextPay'] = $nextPay;
      $arr['sumPayments'] = $sumPayments;
      $arr['totalAmountOfSubscriptions'] = $totalAmountOfSubscriptions;
      $arr['currentTotal'] = $total;
      $arr['bank']= $bank;
      return $arr;
    }

    public  function subtractTowDates($date) {
      
        $d =$date->format('y-m-d');
        $dateAfterMonth = date_modify(new DateTime($d),'+ 1month');
        $now = new DateTime('now');
        $difference =  $now->diff($dateAfterMonth);
        
        if($now < $dateAfterMonth) {
            return $this->format_interval($difference);
        }
        if($now >= $dateAfterMonth) {
            return "it is time for payment";
        }
        // return $this->format_interval($difference);
    }

    function format_interval($interval) {
        $result = "";
        if ($interval->y) { $result .= $interval->format("%y years "); }
        if ($interval->m) { $result .= $interval->format("%m months "); }
        if ($interval->d) { $result .= $interval->format("%d days "); }
        if ($interval->h) { $result .= $interval->format("%h hours "); }
        if ($interval->i) { $result .= $interval->format("%i minutes "); }
        if ($interval->s) { $result .= $interval->format("%s seconds "); }
    
        return $result;
    } 
}
