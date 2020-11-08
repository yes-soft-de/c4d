<?php

namespace App\Controller;

use App\AutoMapping;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\DateTimeNormalizer;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;
use Symfony\Component\Serializer\SerializerInterface;

class BaseController extends AbstractController
{
    private $serializer;
    private $statusCode;

    public function __construct(SerializerInterface $serializer)
    {
        $this->serializer = $serializer;
    }
    const STATE_OK = 200;
    const CREATE = ["created ","201"];
    const UPDATE=["updated","204"];
    const DELETE=["deleted","401"];
    const FETCH=["fetched","200"];
    //const NOTFOUND=["Not found", "404"];


    public function getUserId()
    {
        $userID = 0;

        if ($this->getUser())
        {
            $userID = $this->getUser()->getUsername();
        }

        return $userID;
    }

    /**
     * @return mixed
     */
    public function getStatusCode()
    {
        return $this->statusCode;
    }

    /**
     * @param mixed $statusCode
     */
    public function setStatusCode($statusCode): void
    {
        $this->statusCode = $statusCode;
    }

    /**
     * Returns a JSON response
     *
     * @param array $data
     * @param array $headers
     *
     * @return JsonResponse
     */

    public function respond($data, $headers = [])
    {
        return new JsonResponse($data, self::STATE_OK, $headers);
    }

    /**
     * Sets an error message and returns a JSON response
     * @param string $errors
     * @param array $headers
     * @return JsonResponse
     */
    public function respondWithErrors($errors, $headers = [])
    {
        $data = [
            'errors' => $errors,
        ];

        return new JsonResponse($data, $this->getStatusCode(), $headers);
    }

    /**
     * Returns a 401 Unauthorized http response
     *
     * @param string $message
     *
     * @return JsonResponse
     */
    public function respondUnauthorized($message = 'Not authorized!')
    {
        $this->setStatusCode(401)->respondWithErrors($message);
    }

    /**
     * @param string $message
     * @return JsonResponse
     */
    public function respondNotFound($message = 'Not found!')
    {
        $data = [
            'Error' => $message,
        ];

        $this->setStatusCode(404);

        return new JsonResponse($data, $this->getStatusCode());
    }
    public function response($result, $status) :jsonResponse
    {
        if($result!=null) {
            $encoders = [new JsonEncoder()];
            $normalizers = [new ObjectNormalizer()];
            $this->serializer = new Serializer($normalizers, $encoders);
            $result = $this->serializer->serialize($result, "json", [
                'enable_max_depth' => true]);
            $response = new jsonResponse(["status_code" => $status[1],
                    "msg" => $status[0] . " " . "Successfully.",
                    "Data" => json_decode($result)
                ]
                , Response::HTTP_OK);
            $response->headers->set('Access-Control-Allow-Headers', 'X-Header-One,X-Header-Two');
            $response->headers->set('Access-Control-Allow-Origin', '*');
            $response->headers->set('Access-Control-Allow-Methods', 'PUT');
            return $response;
        }
        else
        {
            $response = new JsonResponse(["status_code"=>"404",
                 "msg"=>"Data not found!"],
             Response::HTTP_NOT_FOUND);

            return $response;
        }
    }
}
