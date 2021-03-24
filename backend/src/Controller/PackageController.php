<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\PackageCreateRequest;
use App\Request\PackageUpdateStateRequest;
use App\Service\PackageService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class PackageController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $packageService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, PackageService $packageService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->packageService = $packageService;
    }

    /**
     * @Route("package", name="createPackage", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, PackageCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->packageService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("packages", name="getPackagesUserCompatible", methods={"GET"})
     * @return JsonResponse
     */
    public function getPackages()
    {
        $result = $this->packageService->getPackages();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("getAllpackages", name="getAllPackages", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getAllpackages()
    {
        $result = $this->packageService->getAllpackages();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("getpackageById/{id}", name="getpackageById", methods={"GET"})
     * @return JsonResponse
     */
    public function getpackagesById($id)
    {
        $result = $this->packageService->getpackagesById($id);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("package", name="updatePackage", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, PackageUpdateStateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->packageService->update($request);

        return $this->response($result, self::UPDATE);
    }
}
