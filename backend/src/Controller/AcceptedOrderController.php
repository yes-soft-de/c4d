<?php

namespace App\Controller;

use App\AutoMapping;
use App\Service\AcceptedOrderService;
use App\Service\UserService;
use App\Request\AcceptedOrderCreateRequest;
use App\Request\AcceptedOrderUpdateRequest;
use App\Request\AcceptedOrderUpdateStateByCaptainRequest;
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
    private $userService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AcceptedOrderService $acceptedOrderService, UserService $userService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->acceptedOrderService = $acceptedOrderService;
        $this->userService = $userService;
    }

    /**
     * @Route("/acceptedOrder",   name="createAcceptedOrder", methods={"POST"})
     * @IsGranted("ROLE_CAPTAIN")
     */
    public function create(Request $request)
    {   
        // $response ="this captain inactive!!";
        // $status = $this->userService->captainIsActive($this->getUserId());
        
        // if ($status == 'active') {
            $data = json_decode($request->getContent(), true);

            $request = $this->autoMapping->map(stdClass::class, AcceptedOrderCreateRequest::class, (object)$data);

            $request->setCaptainID($this->getUserId());

            $violations = $this->validator->validate($request);
            if (\count($violations) > 0) {
                $violationsString = (string) $violations;

                return new JsonResponse($violationsString, Response::HTTP_OK);
            }

            $response = $this->acceptedOrderService->create($request);
            if (is_string($response)) {
                return $this->response($response, self::ACCEPTED_ERROR);
            }
        // }

        return $this->response($response, self::CREATE);
    }

    // /**
    //  * @Route("/getOrderStatusForCaptain/{orderId}", name="GetOrderStatusForCaptain", methods={"GET"})
    //  * @IsGranted("ROLE_CAPTAIN")
    //  * @param                                     Request $request
    //  * @return                                    JsonResponse
    //  */
    // public function getOrderStatusForCaptain($orderId)
    // {
    //     $result = $this->acceptedOrderService->getOrderStatusForCaptain($this->getUserId(), $orderId);

    //     return $this->response($result, self::FETCH);
    // }

    /**
     * @Route("acceptedOrder", name="updateAcceptedOrder", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, AcceptedOrderUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->acceptedOrderService->update($request);

        return $this->response($result, self::UPDATE);
    }

       /**
      * @Route("/getAcceptedOrder",        name="getAcceptedOrderByCaptainId", methods={"GET"})
      * @IsGranted("ROLE_CAPTAIN")
      * @return                  JsonResponse
      */
      public function getAcceptedOrderByCaptainId()
      {
          $result = $this->acceptedOrderService->getAcceptedOrderByCaptainId($this->getUserId());
  
          return $this->response($result, self::FETCH);
      }
    
    /**
     * @Route("/getTop5Captains", name="GetTop5Captains",methods={"GET"})
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function getTop5Captains()
    {
        $result = $this->acceptedOrderService->getTop5Captains();

        return $this->response($result, self::FETCH);
    }

    // /**
    //  * @Route("/getAllOrdersAndCountForCaptain/{year}/{month}/{ownerId}", name="getAllOrdersAndCountInMonthForCaptain",methods={"GET"})
    //  * @IsGranted("ROLE_ADMIN")
    //  * @param                                     Request $request
    //  * @return                                    JsonResponse
    //  */
    // public function getAllOrdersAndCount($year, $month, $ownerId)
    // {
    //     $result = $this->orderService->getAllOrders($year, $month, $ownerId);

    //     return $this->response($result, self::FETCH);
    // }

     /**
     * @Route("/topCaptains", name="getTopCaptainsInThisMonth",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function getTopCaptainsInThisMonth()
    {
        $result = $this->acceptedOrderService->getTopCaptainsInThisMonth();

        return $this->response($result, self::FETCH);
    }
}
