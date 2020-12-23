<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\SubscriptionCreateRequest;
use App\Request\SubscriptionUpdateRequest;
use App\Request\SubscriptionUpdateStateRequest;
use App\Service\SubscriptionService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class SubscriptionController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $subscriptionService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, SubscriptionService $subscriptionService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->subscriptionService = $subscriptionService;
    }

    /**
     * @Route("subscription", name="createSubscription", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SubscriptionCreateRequest::class, (object)$data);

        $request->setOwnerID($this->getUserId());

        if (!$request->getStatus()) {
            $request->setStatus('inactive');
            }

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->subscriptionService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("getActiveSubscription", name="getActiveSubscribedPackage", methods={"GET"})
     *  @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     */
    public function activeSubscription()
    {
        $result = $this->subscriptionService->activeSubscription($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("subscriptionUpdateState", name="SubscriptionUpdateState", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function subscriptionUpdateState(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, SubscriptionUpdateStateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->subscriptionService->subscriptionUpdateState($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("getSubscriptionsPending", name="getSubscriptionsPending", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getSubscriptionsPending()
    {
        $result = $this->subscriptionService->getSubscriptionsPending();

        return $this->response($result, self::FETCH);
    }
    
    /**
     * @Route("getSubscriptionById/{id}", name="getSubscriptionById", methods={"GET"})
     * @return JsonResponse
     */
    public function getSubscriptionById($id)
    {
        $result = $this->subscriptionService->getSubscriptionById($id);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/dashboardContracts", name="dashboardContracts",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function dashboardContracts()
    {
        $result = $this->subscriptionService->dashboardContracts();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/saveFinisheAuto/{ownerID}", name="saveFinisheAuto",methods={"GET"})
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function saveFinisheAuto($ownerID)
    {
        $result = $this->subscriptionService->saveFinisheAuto($ownerID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("subscripeNewUsers/{year}/{month}", name="getCountSubscripeNewUsersInThisMonth",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function subscripeNewUsers($year, $month)
    {
        $result = $this->subscriptionService->subscripeNewUsers($year, $month);

        return $this->response($result, self::FETCH);
    }
}
