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

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, RecordService $recordService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->recordService = $recordService;
    }    
}
