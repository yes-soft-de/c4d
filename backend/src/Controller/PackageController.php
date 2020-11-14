<?php


namespace App\Controller;


use App\AutoMapping;
use App\Request\PackageCreateRequest;
use App\Request\PackageUpdateRequest;
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

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator,
                                PackageService $packageService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->packageService = $packageService;
    }

    /**
     * @Route("package", name="createPackage", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,PackageCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->packageService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("packages", name="getPackages", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     */
    public function getPackages()
    {
        $result = $this->packageService->getPackages($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("activepackages", name="getActivePackages", methods={"GET"})
     * @return JsonResponse
     */
    public function getActivePackages()
    {
        $result = $this->packageService->getActivePackages();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("package", name="updatePackage", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, PackageUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->packageService->update($request);

        return $this->response($result, self::UPDATE);
    }
}