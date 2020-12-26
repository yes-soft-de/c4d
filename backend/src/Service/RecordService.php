<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\RecordEntity;
use App\Entity\AcceptedOrderEntity;
use App\Manager\RecordManager;
use App\Response\RecordResponse;
use stdClass;

class RecordService
{
    private $autoMapping;
    private $recordManager;

    public function __construct(AutoMapping $autoMapping, RecordManager $recordManager)
    {
        $this->autoMapping = $autoMapping;
        $this->recordManager = $recordManager;
    }

    public function create($orderID, $state)
    {
        $record['orderID'] = $orderID;
        $record['state'] = $state;
        $result = $this->recordManager->create($record);

        return $this->autoMapping->map(RecordEntity::class, RecordResponse::class, $result);
    }
    
    public function getrecordByOrderId($orderId)
    {
        return $this->recordManager->getrecordByOrderId($orderId);
    }
}
