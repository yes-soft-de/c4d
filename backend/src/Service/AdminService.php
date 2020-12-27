<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\UserEntity;
use App\Manager\AdminManager;
use App\Request\AdminCreateRequest;
use App\Response\AdminCreateResponse;

class AdminService
{
    private $autoMapping;
    private $adminManager;

    public function __construct(AutoMapping $autoMapping, AdminManager $adminManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminManager = $adminManager;
    }

    public function adminCreate(AdminCreateRequest $request)
    {
        $adminCreate = $this->adminManager->adminCreate($request);

        $response = $this->autoMapping->map(UserEntity::class, AdminCreateResponse::class, $adminCreate);

        return $response;
    }

    public function uuid()
    {
        $data = random_bytes(16);

        $data[0] = chr(ord('c') ); 
        $data[1] = chr(ord('4') ); 
        $data[2] = chr(ord('d') ); 
        $data[6] = chr(ord($data[6]) & 0x0f | 0x40);
        $data[8] = chr(ord($data[8]) & 0x3f | 0x80);
        dd(vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4)));
    }
}
