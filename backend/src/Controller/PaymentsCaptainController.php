<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\PaymentCaptainCreateRequest;
use App\Service\PaymentCaptainService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;


class PaymentsCaptainController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $paymentService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, PaymentCaptainService $paymentService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->paymentService = $paymentService;
    }
    
    /**
     * @Route("/paymentcaptain", name="createpaymentCaptain", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
            $data = json_decode($request->getContent(), true);

            $request = $this->autoMapping->map(stdClass::class, PaymentCaptainCreateRequest::class, (object)$data);

            $violations = $this->validator->validate($request);

            if (\count($violations) > 0) {
                $violationsString = (string) $violations;

                return new JsonResponse($violationsString, Response::HTTP_OK);
            }
            $result = $this->paymentService->create($request);

        return $this->response($result, self::CREATE);
    }

     /**
      * @Route("/paymentscaptain", name="GetpaymentsForCaptain", methods={"GET"})
      * @IsGranted("ROLE_CAPTAIN")
      * @param                     Request $request
      * @return                    JsonResponse
      */
      public function getpaymentsForCaptain()
      {
          $result = $this->paymentService->getpayments($this->getUserId());
  
          return $this->response($result, self::FETCH);
      }
    
}
