<?php

namespace App\Controller;
use App\AutoMapping;
use App\Request\UpdateCreateRequest;
use App\Request\UpdateUpdateRequest;
use App\Service\UpdateService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;


class UpdateController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $updateService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, UpdateService $updateService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->updateService = $updateService;
    }

    /**
     * @Route("update", name="createupdate", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, updateCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
        $result = $this->updateService->create($request);
            

        return $this->response($result, self::CREATE);
    }

     /**
     * @Route("update", name="updateupdate", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, UpdateUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->updateService->update($request);

        return $this->response($result, self::UPDATE);
    }

     /**
     * @Route("update/{id}", name="getUpdateById", methods={"GET"})
     * @return JsonResponse
     */
    public function getUpdateById($id)
    {
        $result = $this->updateService->getUpdateById($id);

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("updateall", name="getUpdateAll", methods={"GET"})
     * @return JsonResponse
     */
    public function getUpdateAll()
    {
        $result = $this->updateService->getUpdateAll();

        return $this->response($result, self::FETCH);
    }

}
