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

    public function getRecordsByOrderId($orderId)
    {
        return $this->recordManager->getRecordsByOrderId($orderId);
    }
    
    // for generate uuid
    public function uuid()
    {
        $data = random_bytes(16);

        $data[0] = chr(ord('c') ); 
        $data[1] = chr(ord('4') ); 
        $data[2] = chr(ord('d') ); 
        $data[6] = chr(ord($data[6]) & 0x0f | 0x40);
        $data[8] = chr(ord($data[8]) & 0x3f | 0x80);
        return  vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
    }
}
