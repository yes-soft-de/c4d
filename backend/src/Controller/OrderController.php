<?php

namespace App\Controller;

use App\AutoMapping;
use App\Service\OrderService;
use App\Service\UserService;
use App\Request\OrderCreateRequest;
use App\Request\OrderUpdateRequest;
use App\Request\DeleteRequest;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use stdClass;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class OrderController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $orderService;
    private $userService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, OrderService $orderService, UserService $userService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->orderService = $orderService;
        $this->userService = $userService;
    }
    /**
     * @Route("/order",         name="createOrder", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     */
    public function create(Request $request)
    {  
       $response ="this user inactive!!";
       $status = $this->userService->userIsActive('owner', $this->getUserId());
        if ($status == 'active') {
            $data = json_decode($request->getContent(), true);

            $request = $this->autoMapping->map(stdClass::class, OrderCreateRequest::class, (object)$data);
            $request->setOwnerID($this->getUserId());

            $violations = $this->validator->validate($request);
            if (\count($violations) > 0) {
                $violationsString = (string) $violations;

                return new JsonResponse($violationsString, Response::HTTP_OK);
            }

            $response = $this->orderService->create($request);
        }
        return $this->response($response, self::CREATE);
    }

     /**
      * @Route("/order/{orderId}", name="GetOrderByID", methods={"GET"})
      * @param                     Request $request
      * @return                    JsonResponse
      */
    public function getOrderById($orderId)
    {
        $result = $this->orderService->getOrderById($orderId);

        return $this->response($result, self::FETCH);
    }

     /**
      * @Route("/orders",        name="GetOrdersByOwnerID", methods={"GET"})
      * @IsGranted("ROLE_OWNER")
      * @return                  JsonResponse
      */
    public function getOrdersByOwnerID()
    {
        $result = $this->orderService->getOrdersByOwnerID($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/orderStatus/{orderId}", name="orderStatusForOwner", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @param                           Request $request
     * @return                          JsonResponse
     */
    public function orderStatus($orderId)
    {
        $result = $this->orderService->orderStatus($this->getUserId(), $orderId);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/closestOrders",   name="GetClosestOrdersToCaptainAndNoOtherCaptainTookIt", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @return                    JsonResponse
     */
    public function closestOrders()
    {
        $result ="this user inactive!!";
        $status = $this->userService->userIsActive('captain', $this->getUserId());
        
        if ($status == 'active') {

            $result = $this->orderService->closestOrders($this->getUserId());
         }

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/order",         name="orderUpdate", methods={"PUT"})
     * @param                   Request $request
     * @return                  JsonResponse
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateRequest::class, (object) $data);
        $request->setCaptainID($this->getUserId());

        $response = $this->orderService->update($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("order/{id}",     name="deleteOrder", methods={"DELETE"})
     * @IsGranted("ROLE_OWNER")
     * @param                   Request $request
     * @return                  JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('id'));

        $result = $this->orderService->delete($request);

        return $this->response($result, self::DELETE);
    }
}
