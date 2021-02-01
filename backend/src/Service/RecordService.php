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

    public function getRecordsWithcompletionTime($orderId)
    {
        $response=[];
        $records = $this->getRecordsByOrderId($orderId);
      
        foreach ($records as $rec) {
         
            $firstDate = $this->getFirstDate($rec['orderID']); 
            $lastDate = $this->getLastDate($rec['orderID']);
           
            if($firstDate[0]['date'] && $lastDate[0]['date']) {
                $state['completionTime'] = $this->subtractTowDates($firstDate[0]['date'], $lastDate[0]['date']);
            }
            
            $state['finalOrder'] = $lastDate[0]['state'] ;
            $orderStatus = $this->autoMapping->map('array', RecordResponse::class, $state);
            $record[] = $this->autoMapping->map('array', RecordResponse::class, $rec);

    } 
        if($firstDate && $lastDate) {
            $response['orderStatus'] = $orderStatus ;
            $response['record'] = $record ;
            }
        return  $response;
    }

    public  function subtractTowDates($firstDate, $lastDate) {
        
        $difference = $firstDate->diff($lastDate);
        
        return $this->format_interval($difference);
    }

    public function getFirstDate($orderId)
    {
        return $this->recordManager->getFirstDate($orderId);
    }

    public function getLastDate($orderId)
    {
        return $this->recordManager->getLastDate($orderId);
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
