<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\AdminCreateRequest;
use App\Service\AdminService;
use App\Service\NotificationService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class AdminController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $adminService;
    private $notificationService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator,
                                AdminService $adminService, NotificationService $notificationService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminService = $adminService;
        $this->notificationService = $notificationService;
    }

    /**
     * @Route("/createAdmin", name="adminCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function adminCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminService->adminCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/yazan", name="yazan", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function yazan()
    {
        $this->notificationService->notificationToCaptain(8);
    }
}
