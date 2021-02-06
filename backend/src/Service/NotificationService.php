<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\NotificationTokenEntity;
use App\Manager\NotificationManager;
use App\Request\NotificationTokenRequest;
use App\Response\NotificationTokenResponse;
use Kreait\Firebase\Messaging;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;

class NotificationService
{
    private $messaging;
    private $notificationManager;
    private $autoMapping;
    const CAPTAIN_TOPIC = 'captain';
    const MESSAGE_CAPTAIN_NEW_ORDER = 'هناك طلب جديد، الرجاء تفقد قائمة الطلبات لديك';
    const MESSAGE_ORDER_UPDATE = 'هناك تحديث في حالة الطلبات';

    public function __construct(AutoMapping $autoMapping, Messaging $messaging, NotificationManager $notificationManager)
    {
        $this->messaging = $messaging;
        $this->notificationManager = $notificationManager;
        $this->autoMapping = $autoMapping;
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

    public function notificationTokenCreate(NotificationTokenRequest $request)
    {
        $userRegister = $this->notificationManager->notificationTokenCreate($request);

        return $this->autoMapping->map(NotificationTokenEntity::class,NotificationTokenResponse::class, $userRegister);
    }

    public function getNotificationTokenByUserID($userID)
    {
        return $this->notificationManager->getNotificationTokenByUserID($userID);
    }
}