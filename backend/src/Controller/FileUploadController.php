<?php

namespace App\Controller;

use App\Request\UploadImageRequest;
use App\Service\UploadFileService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class FileUploadController extends AbstractController
{
    private $uploadFile;
    private $validator;
    /**
     * @var ParameterBagInterface
     */
    private $params;

    public function __construct(UploadFileService $uploadFile, ValidatorInterface $validator, ParameterBagInterface $params)
    {
        $this->uploadFile = $uploadFile;
        $this->validator = $validator;
        $this->params = $params;
    }

    /**
     * @Route("/uploadfile", name="imageUpload", methods={"POST"})
     * @param Request $request
     * @return jsonResponse
     */
    public function imageUpload(Request $request)
    {
        $uploadedFile = $request->files->get('image');

        if ($uploadedFile)
        {
            $imageUploadRequest = new UploadImageRequest;
            $imageUploadRequest->setUploadedFile($uploadedFile);

            $violations = $this->validator->validate($imageUploadRequest);
            if (count($violations) > 0)
            {
                $violationsString = (string) $violations;

                return new JsonResponse($violationsString, Response::HTTP_OK);
            }

            $filePath = $this->uploadFile->uploadImage($uploadedFile, null);

            return new JsonResponse($filePath, Response::HTTP_OK);
        }

    }

}
