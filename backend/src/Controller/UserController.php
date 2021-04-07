<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\UserProfileCreateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\CaptainProfileCreateRequest;
use App\Request\CaptainProfileUpdateRequest;
use App\Request\CaptainProfileUpdateByAdminRequest;
use App\Request\userProfileUpdateByAdminRequest;
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
     * @IsGranted("ROLE_OWNER")
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
     * @IsGranted("ROLE_OWNER")
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
     * @Route("/userProfileUpdateByAdmin", name="userProfileUpdateByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function userProfileUpdateByAdmin(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, userProfileUpdateByAdminRequest::class, (object)$data);

        $response = $this->userService->userProfileUpdateByAdmin($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/userprofileByID/{id}", name="getUserProfileByID",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getUserProfileByID($id)
    {
        $response = $this->userService->getUserProfileByID($id);

        return $this->response($response, self::FETCH);
    }

   /**
     * @Route("/userprofilebyuserid/{userId}", name="getUserProfileByID",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getUserProfile($userId)
    {
        $response = $this->userService->getUserProfileByUserID($userId);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/userprofile", name="getUserProfileByUserId",methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     */
    public function getUserProfileByUserID()
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
        $response = $this->userService->getremainingOrders($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/captainprofile", name="captainprofileCreate", methods={"POST"})
     * @IsGranted("ROLE_CAPTAIN")
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
        $request->setUserID($this->getUserId());
        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->userService->captainprofileUpdate($request);

        return $this->response($response, self::UPDATE);
    }
  
    /**
     * @Route("/captainprofileUpdateByAdmin", name="captainprofileUpdateByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function captainprofileUpdateByAdmin(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainProfileUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->userService->captainprofileUpdateByAdmin($request);

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
     * @Route("/captainprofile/{captainProfileId}", name="getCaptainprofileBycaptainProfileId",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     *  @return JsonResponse
     */
    public function getCaptainprofileByID($captainProfileId)
    {
        $response = $this->userService->getCaptainprofileByID($captainProfileId);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/captainprofileStateDayOff/{captainProfileId}", name="getCaptainprofileBycaptainProfileIdStateDayOff",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     *  @return JsonResponse
     */
    public function getCaptainprofileByIDStateDayOff($captainProfileId)
    {
        $response = $this->userService->getCaptainprofileByIDStateDayOff($captainProfileId);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/getUserInactive/{userType}", name="getOwnerOrCaptainPending",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     *  @return JsonResponse
     */
    public function getUserInactive($userType)
    {
        $response = $this->userService->getUserInactive($userType);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/getCaptainsState/{state}", name="getCaptainsState",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     *  @return JsonResponse
     */
    public function getCaptainsState($state)
    {
        $response = $this->userService->getCaptainsState($state);

        return $this->response($response, self::FETCH);
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

    /**
     * @Route("/getDayOfCaptains", name="getDayOfCaptains",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function getDayOfCaptains()
    {
        $result = $this->userService->getDayOfCaptains();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/totalBounceCaptain/{captainProfileId}", name="TotalBounceCaptain",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function totalBounceCaptain($captainProfileId)
    {
        $result = $this->userService->totalBounceCaptain($captainProfileId,'admin');

        return $this->response($result, self::FETCH);
    }

     /**
     * @Route("/getUsers/{userType}", name="getUsers",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getUsers($userType)
    {
        $response = $this->userService->getUsers($userType);

        return $this->response($response, self::FETCH);
    }
     /**
     * @Route("/getAllUsers/{userType}", name="getAllUsers",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getAllUsers($userType)
    {
        $response = $this->userService->getAllUsers($userType);

        return $this->response($response, self::FETCH);
    }

     /**
     * @Route("/captainmybalance", name="getCaptainMyBalance",methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     *  @return JsonResponse
     */
    public function getCaptainMybalance()
    {
        $response = $this->userService->getCaptainMybalance($this->getUserId());

        return $this->response($response, self::FETCH);
    }

     /**
     * @Route("/remainingcaptain", name="TheRemainingCaptainHasABoost",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function remainingcaptain()
    {
        $response = $this->userService->remainingcaptain();

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/captainupdatenewmessagestatus", name="captainUpdateNewMessageStatus", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function captainUpdateNewMessageStatus(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,CaptainProfileUpdateByAdminRequest::class,(object)$data);
        
        $response = $this->userService->update($request,false);

        return $this->response($response, self::CREATE);
    }
}
