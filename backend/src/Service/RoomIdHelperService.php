<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\RoomIdHelperEntity;
use App\Manager\RoomIdHelperManager;
use App\Request\RoomIdHelperCreateRequest;
use App\Response\RoomIdHelperResponse;
use Doctrine\DBAL\Types\ObjectType;

class RoomIdHelperService
{
    private $autoMapping;
    private $roomIdHelperManager;

    public function __construct(AutoMapping $autoMapping, RoomIdHelperManager $roomIdHelperManager)
    {
        $this->autoMapping = $autoMapping;
        $this->roomIdHelperManager = $roomIdHelperManager;
    }

    public function create($request)
    {   
        $item = $this->roomIdHelperManager->create($request);
        return $this->autoMapping->map(RoomIdHelperEntity::class, RoomIdHelperResponse::class, $item);
    }

    public function getByRoomID($roomID)
    {
        return $this->roomIdHelperManager->getByRoomID($roomID);
    }
}