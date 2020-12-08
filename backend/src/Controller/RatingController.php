<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\RatingCreateRequest;
// use App\Request\RatingUpdateRequest;
use App\Service\RatingService;
use App\Service\SubscriptionService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class RatingController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $ratingService;
    private $subscriptionService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, RatingService $ratingService, SubscriptionService $subscriptionService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->ratingService = $ratingService;
        $this->subscriptionService = $subscriptionService;
    }

    /**
     * @Route("rating", name="createRating", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $status = $this->subscriptionService->subscriptionIsActive($this->getUserId());
        
        if ($status == 'active') {
            $data = json_decode($request->getContent(), true);

            $request = $this->autoMapping->map(stdClass::class, RatingCreateRequest::class, (object)$data);

            $request->setOwnerID($this->getUserId());

            $violations = $this->validator->validate($request);

            if (\count($violations) > 0) {
                $violationsString = (string) $violations;

                return new JsonResponse($violationsString, Response::HTTP_OK);
            }
            $result = $this->ratingService->create($request);
         }

        return $this->response($result, self::CREATE);
    }

}
