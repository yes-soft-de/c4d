<?php


namespace App\Controller;


use App\AutoMapping;
use App\Request\SubscriptionCreateRequest;
use App\Service\SubscriptionService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class SubscriptionController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $subscriptionService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator,
                                SubscriptionService $subscriptionService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->subscriptionService = $subscriptionService;
    }

    /**
     * @Route("subscription", name="createSubscription", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,SubscriptionCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->subscriptionService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("currentsubscriptions", name="getCurrentSubscribedPackages", methods={"GET"})
     * @return JsonResponse
     */
    public function getCurrentSubscribedPackages()
    {
        $result = $this->subscriptionService->getCurrentSubscriptions();

        return $this->response($result, self::FETCH);
    }
}