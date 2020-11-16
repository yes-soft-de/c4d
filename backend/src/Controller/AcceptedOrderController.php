<?php

namespace App\Controller;

use App\AutoMapping;
use App\Service\AcceptedOrderService;
use App\Request\AcceptedOrderCreateRequest;
use App\Request\GetByIdRequest;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use stdClass;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class AcceptedOrderController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $acceptedOrderService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AcceptedOrderService $acceptedOrderService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->acceptedOrderService = $acceptedOrderService;
    }

    /**
     * @Route("/acceptedOrder", name="createAcceptedOrder", methods={"POST"})
     * @IsGranted("ROLE_CAPTAIN")
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AcceptedOrderCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->acceptedOrderService->create($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/acceptedOrder/{ID}", name="GetOrderStatusForCaptain", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function acceptedOrder($ID)
    {
        $result = $this->acceptedOrderService->acceptedOrder($this->getUserId(), $ID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/totalEarn", name="GetTotalEarnForCaptain", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function totalEarn()
    {
        $result = $this->acceptedOrderService->totalEarn($this->getUserId());

        return $this->response($result, self::FETCH);
    }
}
