<?php

namespace App\Controller;
use App\AutoMapping;
use App\Request\companyInfoCreateRequest;
use App\Request\companyInfoUpdateRequest;
use App\Service\CompanyInfoService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;


class CompanyInfoController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $companyInfoService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, CompanyInfoService $companyInfoService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->companyInfoService = $companyInfoService;
    }

    /**
     * @Route("companyinfo", name="createCompanyInfo", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, companyInfoCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
        $result = $this->companyInfoService->create($request);
            

        return $this->response($result, self::CREATE);
    }

     /**
     * @Route("companyinfo", name="updateCompanyInfo", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, companyInfoUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->companyInfoService->update($request);

        return $this->response($result, self::UPDATE);
    }

     /**
     * @Route("companyinfo/{id}", name="getcompanyinfoById", methods={"GET"})
     * @return JsonResponse
     */
    public function getcompanyinfoById($id)
    {
        $result = $this->companyInfoService->getcompanyinfoById($id);

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("companyinfoall", name="getcompanyinfoAll", methods={"GET"})
     * @return JsonResponse
     */
    public function getcompanyinfoAll()
    {
        $result = $this->companyInfoService->getcompanyinfoAll();

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("companyinfoforuser", name="getcompanyinfoAllforUser", methods={"GET"})
     * @return JsonResponse
     */
    public function getcompanyinfoAllForUser()
    {
        if ($this->isGranted('ROLE_OWNER')) {
             $result = $this->companyInfoService->getcompanyinfoAllOwner($this->getUserId());
        }

        if ($this->isGranted('ROLE_CAPTAIN')) {
             $result = $this->companyInfoService->getcompanyinfoAllCaptain($this->getUserId());
        }
        return $this->response($result, self::FETCH);
    }
}
