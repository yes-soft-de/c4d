<?php

namespace App\Service;

use App\AutoMapping;
use App\Manager\PaymentCaptainManager;
use App\Entity\PaymentsCaptainEntity;
use App\Request\PaymentCaptainCreateRequest;
use App\Response\PaymentCaptainCreateResponse;
use App\Service\BankService;
use DateTime;

class PaymentCaptainService
{
    private $autoMapping;
    private $paymentManager;
    private $bankService;

    public function __construct(AutoMapping $autoMapping, PaymentCaptainManager $paymentManager, BankService $bankService)
    {
        $this->autoMapping = $autoMapping;
        $this->paymentManager = $paymentManager;
        $this->bankService = $bankService;
    }

    public function create(PaymentCaptainCreateRequest $request)
    {
        $item = $this->paymentManager->create($request);

        return $this->autoMapping->map(PaymentsCaptainEntity::class, PaymentCaptainCreateResponse::class, $item);
    }

    public function getpayments($captainId)
    {
       return $this->paymentManager->getpayments($captainId);
        }
    public function getSumAmount($captainId)
    {
       return $this->paymentManager->getSumAmount($captainId);
    }

    //     $response['nextPay'] = $nextPay;
    //     $response['sumPayments'] = $sumPayments;
    //     $response['totalAmountOfSubscriptions'] = $totalAmountOfSubscriptions;
    //     $response['currentTotal'] = $total;
    //     $response['bank'] = $bank;
       
    //     return $response;
    // }

    // public  function subtractTowDates($date) {
    //     $dateAfterMonth = date_modify(new DateTime('now'),'+1 month');

    //     $difference = $date->diff($dateAfterMonth);
        
    //     return $this->format_interval($difference);
    // }

    // function format_interval($interval) {
    //     $result = "";
    //     if ($interval->y) { $result .= $interval->format("%y years "); }
    //     if ($interval->m) { $result .= $interval->format("%m months "); }
    //     if ($interval->d) { $result .= $interval->format("%d days "); }
    //     if ($interval->h) { $result .= $interval->format("%h hours "); }
    //     if ($interval->i) { $result .= $interval->format("%i minutes "); }
    //     if ($interval->s) { $result .= $interval->format("%s seconds "); }
    
    //     return $result;
    // } 
}
