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

        $request = $this->autoMapping->map(stdClass::class,UserRegisterRequest::class,(object)$data);

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

        $request = $this->autoMapping->map(stdClass::class,UserProfileCreateRequest::class,(object)$data);

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

        $request = $this->autoMapping->map(stdClass::class,UserProfileUpdateRequest::class,(object)$data);
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

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("/captainprofile", name="captainprofileCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function captainprofileCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,CaptainProfileCreateRequest::class,(object)$data);

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
     * @param Request $request
     * @return JsonResponse
     */
    public function captainprofileUpdate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,CaptainProfileUpdateRequest::class,(object)$data);
        $request->setCaptainID($this->getUserId());

        $response = $this->userService->captainprofileUpdate($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/captainprofile", name="getCaptainprofileByID",methods={"GET"})
     * @return JsonResponse
     */
    public function getcaptainprofileByID()
    {
        $response = $this->userService->getcaptainprofileByID($this->getUserId());

        return $this->response($response,self::FETCH);
    }
}
