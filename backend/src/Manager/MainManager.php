<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\UserEntity;
use App\Repository\UserEntityRepository;
use App\Request\UserUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class MainManager
{
    private $autoMapping;
    private $entityManager;
    private $userEntityRepository;
    private $encoder;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordEncoderInterface $encoder, UserEntityRepository $userEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->userEntityRepository = $userEntityRepository;
        $this->encoder = $encoder;
    }

    public function update(UserUpdateRequest $request)
    {
        $userEntity = $this->userEntityRepository->find($request->getId());
        
        if(!$userEntity)
        {
            return  $userEntity;
        }
        else
        {
            $userEntity = $this->autoMapping->mapToObject(UserUpdateRequest::class, UserEntity::class, 
            $request, $userEntity);

            $userEntity->setPassword($this->encoder->encodePassword($userEntity, $request->getPassword()));

            $this->entityManager->flush();
            $this->entityManager->clear();
            
            return $userEntity;
        }
    }

    public function findAll()
    {
        return $this->userEntityRepository->findAll();
    }


}