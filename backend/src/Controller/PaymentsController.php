<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\PaymentCreateRequest;
use App\Service\PaymentService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class PaymentsController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $paymentService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, PaymentService $paymentService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->paymentService = $paymentService;
    }
    
    /**
     * @Route("/payment", name="createpayment", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
            $data = json_decode($request->getContent(), true);

            $request = $this->autoMapping->map(stdClass::class, PaymentCreateRequest::class, (object)$data);

            $violations = $this->validator->validate($request);

            if (\count($violations) > 0) {
                $violationsString = (string) $violations;

                return new JsonResponse($violationsString, Response::HTTP_OK);
            }
            $result = $this->paymentService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/paymentsOfOwner/{ownerId}", name="paymentsOfOwner",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function paymentsOfOwner($ownerId)
    {
        $result = $this->paymentService->getpaymentsForOwner($ownerId,"admin");

        return $this->response($result, self::FETCH);
    }


    /**
      * @Route("/payments", name="GetpaymentsForOwner", methods={"GET"})
      * @IsGranted("ROLE_OWNER")
      * @param                     Request $request
      * @return                    JsonResponse
      */
      public function getpaymentsForOwner()
      {
          $result = $this->paymentService->getpaymentsForOwner($this->getUserId());
  
          return $this->response($result, self::FETCH);
      }

     
}
