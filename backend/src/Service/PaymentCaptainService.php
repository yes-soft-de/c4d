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
}
