<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\TermsCaptainCreateRequest;
use App\Request\TermsCaptainUpdateRequest;
use App\Service\TermsCaptainService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class TermsCaptainController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $termsCaptainService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, TermsCaptainService $termsCaptainService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->termsCaptainService = $termsCaptainService;
    }
    
    /**
     * @Route("/termscaptain", name="createTermsCaptain", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
            $data = json_decode($request->getContent(), true);

            $request = $this->autoMapping->map(stdClass::class, TermsCaptainCreateRequest::class, (object)$data);

            $violations = $this->validator->validate($request);

            if (\count($violations) > 0) {
                $violationsString = (string) $violations;

                return new JsonResponse($violationsString, Response::HTTP_OK);
            }
            $result = $this->termsCaptainService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
      * @Route("/termscaptain", name="GetTermsCaptain", methods={"GET"})
      * @param                     Request $request
      * @return                    JsonResponse
      */
      public function getTermsCaptain()
      {
          $result = $this->termsCaptainService->getTermsCaptain();
  
          return $this->response($result, self::FETCH);
      }

    /**
      * @Route("/termscaptainbyid/{id}", name="GetTermsCaptainById", methods={"GET"})
      * @param                     Request $request
      * @return                    JsonResponse
      */
      public function getTermsCaptainById($id)
      {
          $result = $this->termsCaptainService->getTermsCaptainById($id);
  
          return $this->response($result, self::FETCH);
      }

      /**
     * @Route("/termscaptain", name="termsUpdate", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param                   Request $request
     * @return                  JsonResponse
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, TermsCaptainUpdateRequest::class, (object) $data);

        $response = $this->termsCaptainService->update($request);

        return $this->response($response, self::UPDATE);
    }
}
