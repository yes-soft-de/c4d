<?php

namespace App\Controller;
use App\AutoMapping;
use App\Request\BankCreateRequest;
use App\Request\BankUpdateRequest;
use App\Service\BankService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;


class BankController extends BaseController
{
        private $autoMapping;
        private $validator;
        private $bankService;
    
        public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, BankService $bankService)
        {
            parent::__construct($serializer);
            $this->autoMapping = $autoMapping;
            $this->validator = $validator;
            $this->bankService = $bankService;
        }

     /**
     * @Route("bankaccount", name="createBankAccount", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, BankCreateRequest::class, (object)$data);

        $request->setUserID($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
            $result = $this->bankService->create($request);
            

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("bankaccount", name="updateBankAccount", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, BankUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->bankService->update($request);

        return $this->response($result, self::UPDATE);
    }

     /**
     * @Route("bankaccountbyuserid", name="getBankAccountByUserId", methods={"GET"})
     * @return JsonResponse
     */
    public function getAccountByUserId()
    {
        $result = $this->bankService->getAccountByUserId($this->getUserId());

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("bankaccount/{userID}", name="getBankAccountByUserIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getAccount($userID)
    {
        $result = $this->bankService->getAccount($userID);

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("bankaccounts", name="getBankAccountsForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getAccounts()
    {
        $result = $this->bankService->getAccounts();

        return $this->response($result, self::FETCH);
    }
}
