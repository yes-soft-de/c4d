<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\UserProfileCreateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\CaptainProfileCreateRequest;
use App\Request\CaptainProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Service\UserService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class UserController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $userService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, UserService $userService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->userService = $userService;
    }

    /**
     * @Route("/user", name="userRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function userRegister(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserRegisterRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->userService->userRegister($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/userprofile", name="userProfileCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function userProfileCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserProfileCreateRequest::class, (object)$data);

        $request->setUserID($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->userService->userProfileCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/userprofile", name="updateUserProfile", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function updateUserProfile(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserProfileUpdateRequest::class, (object)$data);
        $request->setUserID($this->getUserId());

        $response = $this->userService->userProfileUpdate($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/userprofile", name="getUserProfileByID",methods={"GET"})
     * @return JsonResponse
     */
    public function getUserProfileByID()
    {
        $response = $this->userService->getUserProfileByUserID($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/remainingOrders", name="GetremainingOrdersSpecificOwner", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     */
    public function getremainingOrders()
    {
        $result = $this->userService->getremainingOrders($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/captainprofile", name="captainprofileCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function captainprofileCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainProfileCreateRequest::class, (object)$data);

        $request->setCaptainID($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->userService->captainprofileCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/captainprofile", name="captainprofileUpdate", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function captainprofileUpdate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainProfileUpdateRequest::class, (object)$data);
        $request->setCaptainID($this->getUserId());

        $response = $this->userService->captainprofileUpdate($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/captainprofile", name="getCaptainprofileByCaptainID",methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     *  @return JsonResponse
     */
    public function getcaptainprofileByCaptainID()
    {
        $response = $this->userService->getcaptainprofileByCaptainID($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/captainprofile/{id}", name="getCaptainprofileByID",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     *  @return JsonResponse
     */
    public function getCaptainprofileByID($id)
    {
        $response = $this->userService->getCaptainprofileByID($id);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/getUserInactive/{userType}", name="getOwnersOrCaptainsInactive",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     *  @return JsonResponse
     */
    public function getUserInactive($userType)
    {
        $response = $this->userService->getUserInactive($userType);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/getCaptinsActive", name="getCaptinActive",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     *  @return JsonResponse
     */
    public function getCaptinsActive()
    {
        $response = $this->userService->getCaptinsActive();

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/ongoingCaptains", name="ongoingCaptains",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function ongoingCaptains()
    {
        $result = $this->userService->ongoingCaptains();

        return $this->response($result, self::FETCH);
    }

    /**
     * 
     * @Route("/pendingCaptains", name="pendingCaptains",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function pendingCaptains()
    {
        $result = $this->userService->pendingCaptains();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/dayOfCaptains", name="dayOfCaptains", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function dayOfCaptains()
    {
        $result = $this->userService->dayOfCaptains();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/dashboardCaptains", name="dashboardCaptains",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function dashboardCaptains()
    {
        $result = $this->userService->dashboardCaptains();

        return $this->response($result, self::FETCH);
    }

}
