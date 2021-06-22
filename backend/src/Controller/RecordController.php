<?php

namespace App\Controller;

use App\AutoMapping;
use App\Service\RecordService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class RecordController extends BaseController
{
    private $autoMapping;
    private $recordService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, RecordService $recordService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->recordService = $recordService;
    } 
    
    /**
      * @Route("/record/{orderId}/{IsCaptainArrived}", name="CreateRecord", methods={"POST"})
      * @param                     Request $request
      * @return                    JsonResponse
      */
      public function createRecord($orderId, $IsCaptainArrived)
      {
          if ($IsCaptainArrived == 1){
            $state = "captain arrived";
          }
          if ($IsCaptainArrived == 0){
            $state = "captain not arrived";
          }
          
          $response = $this->recordService->create($orderId, $state);
  
          return $this->response($response, self::CREATE);
      }

    /**
      * @Route("/record/{orderId}", name="GetRecordByOrderId", methods={"GET"})
      * @param                     Request $request
      * @return                    JsonResponse
      */
      public function getRecordByOrderId($orderId)
      {
          $result = $this->recordService->getRecordByOrderId($orderId);
  
          return $this->response($result, self::FETCH);
      }

    /**
      * @Route("/records/{orderId}", name="GetRecordsByOrderId", methods={"GET"})
      * @param                     Request $request
      * @return                    JsonResponse
      */
      public function getRecordsByOrderId($orderId)
      {
          $result = $this->recordService->getRecordsWithcompletionTime($orderId);
  
          return $this->response($result, self::FETCH);
      }
}
