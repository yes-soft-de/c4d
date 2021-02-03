<?php

namespace App\Controller;

use App\AutoMapping;
use App\Service\OrderService;
use App\Request\OrderCreateRequest;
use App\Request\OrderUpdateRequest;
use App\Request\OrderUpdateStateByCaptainRequest;
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
   

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, OrderService $orderService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->orderService = $orderService;
    }
    /**
     * @Route("order",         name="createOrder", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     */
    public function create(Request $request)
    {  
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderCreateRequest::class, (object)$data);
        $request->setOwnerID($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;
            return new JsonResponse($violationsString, Response::HTTP_OK);
            }

            $response = $this->orderService->create($request);
      
        if (is_string($response)) {
            return $this->response($response, self::SUBSCRIBE_ERROR);
        }

        return $this->response($response, self::CREATE);
    }

     /**
      * @Route("/order/{orderId}", name="GetOrderByIDForAdmin", methods={"GET"})
      * @IsGranted("ROLE_ADMIN")
      * @param                     Request $request
      * @return                    JsonResponse
      */
    public function getOrderById($orderId)
    {
        $result = $this->orderService->getOrderById($orderId);

        return $this->response($result, self::FETCH);
    }

     /**
      * @Route("/orderById/{orderId}", name="GetOrderByID", methods={"GET"})
      * @param                     Request $request
      * @return                    JsonResponse
      */
    public function orderById($orderId)
    {
        $result = $this->orderService->orderById($orderId);

        return $this->response($result, self::FETCH);
    }

     /**
      * @Route("orders",        name="GetOrdersByOwnerID", methods={"GET"})
      * @IsGranted("ROLE_OWNER")
      * @return                  JsonResponse
      */
    public function getOrdersByOwnerID()
    {
        $result = $this->orderService->getOrdersByOwnerID($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/orderStatus/{orderId}", name="orderStatus", methods={"GET"})
     * @param                           Request $request
     * @return                          JsonResponse
     */
    public function orderStatus($orderId)
    {
        $result = $this->orderService->orderStatus($orderId);
       
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/closestOrders",   name="GetPendingOrdersForCaptain", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @return                    JsonResponse
     */
    public function closestOrders()
    {
        $response = $this->orderService->closestOrders($this->getUserId());
        
        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/getPendingOrders",   name="GetPendingOrders", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return                    JsonResponse
     */
    public function getPendingOrders()
    {    
         $result = $this->orderService->getPendingOrders();
        

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/order",         name="orderUpdate", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param                   Request $request
     * @return                  JsonResponse
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateRequest::class, (object) $data);
        $request->setOwnerID($this->getUserId());

        $response = $this->orderService->update($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/orderUpdateState",         name="orderUpdateStateByCaptain", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param                   Request $request
     * @return                  JsonResponse
     */
    public function orderUpdateStateByCaptain(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateStateByCaptainRequest::class, (object) $data);

        $response = $this->orderService->orderUpdateStateByCaptain($request);
      
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

     /**
      * @Route("/countAllOrders",        name="CountAllOrders", methods={"GET"})
      * @IsGranted("ROLE_ADMIN")
      * @return                  JsonResponse
      */
      public function countAllOrders()
      {
          $result = $this->orderService->countAllOrders();
  
          return $this->response($result, self::FETCH);
      }

    /**
     * @Route("/dashboardOrders", name="dashboardOrders",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function dashboardOrders()
    {
        $result = $this->orderService->dashboardOrders();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/getRecords",   name="getRecords", methods={"GET"})
     * @return                    JsonResponse
     */
    public function getRecords()
    {    
        if( $this->isGranted('ROLE_OWNER') ) {
         $result = $this->orderService->getRecords($this->getUserId(), 'ROLE_OWNER');
        }

        if( $this->isGranted('ROLE_CAPTAIN') ) {
         $result = $this->orderService->getRecords($this->getUserId(), 'ROLE_CAPTAIN');
        }
        
        return $this->response($result, self::FETCH);
    }

    /**
      * @Route("/getOrders",        name="getOrdersForAdmin", methods={"GET"})
      * @IsGranted("ROLE_ADMIN")
      * @return                  JsonResponse
      */
      public function getOrders()
      {
          $result = $this->orderService->getOrders();
  
          return $this->response($result, self::FETCH);
      }

     /**
     * @Route("/getAllOrdersAndCount/{year}/{month}/{userId}/{userType}", name="getAllOrdersAndCountInMonthForOwner",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function getAllOrdersAndCount($year, $month, $userId, $userType)
    {
        $result = $this->orderService->getAllOrdersAndCount($year, $month, $userId, $userType);

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("/getTopOwners", name="getTopOwnersInThisMonthAndCountOrdersForOwnerInDay",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function getTopOwners()
    {
        $result = $this->orderService->getTopOwners();

        return $this->response($result, self::FETCH);
    }
}
