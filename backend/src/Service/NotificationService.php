<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\NotificationTokenEntity;
use App\Manager\NotificationManager;
use App\Service\RoomIdHelperService;
use App\Service\ReportService;
use App\Service\UserService;
use App\Request\NotificationTokenRequest;
use App\Response\NotificationTokenResponse;
use Kreait\Firebase\Messaging;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;

class NotificationService
{
    private $messaging;
    private $notificationManager;
    private $roomIdHelperService;
    private $reportService;
    private $userService;
    private $autoMapping;

    const CAPTAIN_TOPIC = 'captains';
    const MESSAGE_CAPTAIN_NEW_ORDER = 'هناك طلب جديد، الرجاء تفقد قائمة الطلبات لديك';
    const MESSAGE_ORDER_UPDATE = 'هناك تحديث في حالة الطلبات';
    const MESSAGE_NEW_CHAT = 'لديك رسالة جديدة';
    const MESSAGE_NEW_CHAT_FROM_ADMIN = 'لديك رسالة جديدة من الإدارة';

    public function __construct(AutoMapping $autoMapping, Messaging $messaging, NotificationManager $notificationManager, RoomIdHelperService $roomIdHelperService, ReportService $reportService, UserService $userService)
    {
        $this->messaging = $messaging;
        $this->notificationManager = $notificationManager;
        $this->autoMapping = $autoMapping;
        $this->roomIdHelperService = $roomIdHelperService;
        $this->reportService = $reportService;
        $this->userService = $userService;
    }

    public function notificationToCaptain()
    {
        $message = CloudMessage::withTarget('topic', $this::CAPTAIN_TOPIC)
            ->withNotification(Notification::create('C4D', $this::MESSAGE_CAPTAIN_NEW_ORDER));

        $this->messaging->send($message);
    }

    public function notificationOrderUpdate($request)
    {
        $devicesToken = [];
        $userTokenOne = $this->getNotificationTokenByUserID($request->getUserIdOne());
        $devicesToken[] = $userTokenOne;
        $userTokenTwo = $this->getNotificationTokenByUserID($request->getUserIdTwo());
        $devicesToken[] = $userTokenTwo;

        $message = CloudMessage::new()
            ->withNotification(Notification::create('C4D', $this::MESSAGE_ORDER_UPDATE));

        $this->messaging->sendMulticast($message, $devicesToken);
    }

    public function notificationNewChat($request)
    {

        $item = $this->roomIdHelperService->getByRoomID($request->getRoomID());
        if($item) {
            $devicesToken = [];
            $userTokenOne = $this->getNotificationTokenByUserID($item['captainID']);
            $devicesToken[] = $userTokenOne;
            $userTokenTwo = $this->getNotificationTokenByUserID($item['ownerID']);
            $devicesToken[] = $userTokenTwo;

            $message = CloudMessage::new()
                ->withNotification(Notification::create('C4D', $this::MESSAGE_NEW_CHAT));

            $this->messaging->sendMulticast($message, $devicesToken);   
        }    
    }

    public function updateNewMessageStatusInReport($request)
    {  
        $response=[];
        //NewMessageStatus = true
        $item = $this->reportService->update($request,true);
        if($item) {
            $response[] =  $this->autoMapping->map('array', NotificationTokenResponse::class, $item);
        }
        return $response;
    }

    public function updateNewMessageStatusInCaptain($request)
    {
        $response=[];
        //NewMessageStatus = true
        $item = $this->userService->update($request,true);
        if($item) {
            $response[] =  $this->autoMapping->map('array', NotificationTokenResponse::class, $item);
        }
        return $response;
    }

    public function notificationToCaptainFromAdmin($request)
    {
        $response=[];
        $item = $this->getCaptainUuid($request->getRoomID());
       
        if($item) {
            $devicesToken = [];
            $userTokenOne = $this->getNotificationTokenByUserID($item[0]['captainID']);
            $devicesToken[] = $userTokenOne;
            $message = CloudMessage::new()
                ->withNotification(Notification::create('C4D', $this::MESSAGE_NEW_CHAT_FROM_ADMIN));

            $this->messaging->sendMulticast($message, $devicesToken); 
            $this->messaging->sendMulticast($message, $devicesToken);  
            $response[]= $this->autoMapping->map('array',NotificationTokenResponse::class, $devicesToken);
        }
        return $response;       
    }

    public function notificationToReportFromAdmin($request)
    {
        $response=[];
        $item = $this->getByReprotUuid($request->getRoomID());
       
        if($item) {
            $devicesToken = [];
            $userTokenOne = $this->getNotificationTokenByUserID($item[0]['userId']);
            $devicesToken[] = $userTokenOne;
            $message = CloudMessage::new()
                ->withNotification(Notification::create('C4D', $this::MESSAGE_NEW_CHAT_FROM_ADMIN));

            $this->messaging->sendMulticast($message, $devicesToken);  
            $response[]= $this->autoMapping->map('array',NotificationTokenResponse::class, $devicesToken);
        } 
        return $response;    
    }

    public function notificationTokenCreate(NotificationTokenRequest $request)
    {
        $userRegister = $this->notificationManager->notificationTokenCreate($request);

        return $this->autoMapping->map(NotificationTokenEntity::class,NotificationTokenResponse::class, $userRegister);
    }

    public function getNotificationTokenByUserID($userID)
    {
        return $this->notificationManager->getNotificationTokenByUserID($userID);
    }

    public function getByReprotUuid($uuid)
    {
        return $this->notificationManager->getByReprotUuid($uuid);
    }

    public function getCaptainUuid($uuid)
    {
        return $this->notificationManager->getCaptainUuid($uuid);
    }
}