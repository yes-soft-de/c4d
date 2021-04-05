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
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

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

    /**
     * @Route("/notificationnewchat", name="notificationnewchat", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function notificationNewChat(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationTokenRequest::class,(object)$data);
        $request->setUserID($this->getUser()->getUsername());
        
        $response = $this->notificationService->notificationNewChat($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/notificationtoadmin", name="messageFromCaptainOrReprotToAdmin", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function notificationToAdmin(Request $request)
    {
        $response=[];
        $data = json_decode($request->getContent(), true);
      
        $request = $this->autoMapping->map(stdClass::class,NotificationTokenRequest::class,(object)$data);
       
        $request->setUserID($this->getUser()->getUsername());
       
        if ($this->isGranted('ROLE_OWNER')) {
             $response = $this->notificationService->updateNewMessageStatusInReport($request);
        }

        if ($this->isGranted('ROLE_CAPTAIN')) {
             $response = $this->notificationService->updateNewMessageStatusInCaptain($request);
        }
        return $this->response($response, self::CREATE);
    }
    
    /**
     * @Route("/notificationtocaptainfromadmin", name="notificationToCaptainFromAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function notificationToCaptainFromAdmin(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationTokenRequest::class,(object)$data);
        
        $response = $this->notificationService->notificationToCaptainFromAdmin($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/notificationtoreportfromadmin", name="notificationToReportFromAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function notificationToReportFromAdmin(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationTokenRequest::class,(object)$data);
        
        $response = $this->notificationService->notificationToReportFromAdmin($request);

        return $this->response($response, self::CREATE);
    }
}
