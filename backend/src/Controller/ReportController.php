<?php


namespace App\Controller;
use App\AutoMapping;
use App\Request\ReportCreateRequest;
use App\Service\ReportService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

class ReportController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $reportService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, ReportService $reportService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->reportService = $reportService;
    }
    
    /**
     * @Route("report", name="createReport", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ReportCreateRequest::class, (object)$data);

        $request->setUserID($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
            $result = $this->reportService->create($request);
            

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("reports", name="getreportsForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getReports()
    {
        $result = $this->reportService->getReports();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("report/{id}", name="getReportById", methods={"GET"})
     * @return JsonResponse
     */
    public function getReport($id)
    {
        $result = $this->reportService->getReport($id);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("reportupdatenewmessagestatus/{id}", name="reportUpdateNewMeessageStatus", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function reportUpdateNewMeessageStatus($id)
    {
        $result = $this->reportService->reportUpdateNewMeessageStatus($id);

        return $this->response($result, self::FETCH);
    }
}
