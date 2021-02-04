<?php

namespace App\Controller;
use App\AutoMapping;
use App\Request\BranchesCreateRequest;
use App\Request\BranchesUpdateRequest;
use App\Request\BranchesDeleteRequest;
use App\Service\BranchesService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;


class BranchesController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $branchesService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, BranchesService $branchesService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->branchesService = $branchesService;
    }
    
    /**
     * @Route("branches", name="createBranches", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, BranchesCreateRequest::class, (object)$data);

        $request->setOwnerID($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
            $result = $this->branchesService->create($request);
            

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("branches", name="updateBranches", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, BranchesUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->branchesService->update($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("branches", name="getBranchesByUserId", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     */
    public function getBranchesByUserId()
    {
        $result = $this->branchesService->getBranchesByUserId($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("branche", name="updateIsActiveBranche", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     */
    public function updateIsActiveBranche(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, BranchesDeleteRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->branchesService->updateIsActiveBranche($request);

        return $this->response($result, self::UPDATE);
    }
}
