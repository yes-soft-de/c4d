<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\NotificationTokenRequest;
use App\Service\NotificationService;
use stdClass;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

use Symfony\Component\Routing\Annotation\Route;
class NotificationController extends BaseController
{
    private $autoMapping;
    private $notificationService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, NotificationService $notificationService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->notificationService = $notificationService;
    }

    /**
     * @Route("/notificationtoken", name="notificationtoken", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function createNotificationToken(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationTokenRequest::class,(object)$data);
        $request->setUserID($this->getUser()->getUsername());

        $response = $this->notificationService->notificationTokenCreate($request);

        return $this->response($response, self::CREATE);
    }
}
