<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use App\Entity\CaptainProfileEntity;
use App\Repository\UserEntityRepository;
use App\Repository\UserProfileEntityRepository;
use App\Repository\CaptainProfileEntityRepository;
use App\Request\UserProfileCreateRequest;
use App\Request\userProfileUpdateByAdminRequest;
use App\Request\CaptainProfileCreateRequest;
use App\Request\VacationsCreateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\CaptainProfileUpdateByAdminRequest;
use App\Request\CaptainProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class UserManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userRepository;
    private $captainProRepository;
    private $profileRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordEncoderInterface $encoder, UserEntityRepository $userRepository, CaptainProfileEntityRepository $captainProRepository, UserProfileEntityRepository $profileRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
        $this->captainProRepository = $captainProRepository;
        $this->profileRepository = $profileRepository;
    }

    public function userRegister(UserRegisterRequest $request)
    {
        $userProfile = $this->getUserByUserID($request->getUserID());
        if ($userProfile == null) {

        $userRegister = $this->autoMapping->map(UserRegisterRequest::class, UserEntity::class, $request);

        $user = new UserEntity($request->getUserID());

        if ($request->getPassword()) {
            $userRegister->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
        }

        $userRegister->setRoles($request->getRoles());

        $this->entityManager->persist($userRegister);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $userRegister;
    }
    else {
        return true;
    }
    }

    public function getUserByUserID($userID)
    {
        return $this->userRepository->getUserByUserID($userID);
    }

    public function userProfileCreate(UserProfileCreateRequest $request, $uuid)
    {
        $request->setUuid($uuid);
        $userProfile = $this->getUserProfileByUserID($request->getUserID());
        if ($userProfile == null) {
            $userProfile = $this->autoMapping->map(UserProfileCreateRequest::class, UserProfileEntity::class, $request);

            $userProfile->setStatus('inactive');
            $userProfile->setFree(false);

            $this->entityManager->persist($userProfile);
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $userProfile;
        }
        else {
            return true;
        }
    }

    public function userProfileUpdate(UserProfileUpdateRequest $request)
    {
        $item = $this->profileRepository->getUserProfile($request->getUserID());

        if ($item) {
            $item = $this->autoMapping->mapToObject(UserProfileUpdateRequest::class, UserProfileEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function userProfileUpdateByAdmin(userProfileUpdateByAdminRequest $request)
    {
        $item = $this->profileRepository->find($request->getId());

        if ($item) {
            $item = $this->autoMapping->mapToObject(userProfileUpdateByAdminRequest::class, UserProfileEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function getUserProfileByID($id)
    {
        return $this->profileRepository->getUserProfileByID($id);
    }

    public function getUserProfileByUserID($userID)
    {
        return $this->profileRepository->getUserProfileByUserID($userID);
    }

    public function getremainingOrders($userID)
    {
        return $this->profileRepository->getremainingOrders($userID);
    }

    public function captainprofileCreate(CaptainProfileCreateRequest $request, $uuid)
    {
        $request->setUuid($uuid);
        $isCaptainProfile = $this->captainProRepository->getcaptainprofileByCaptainID($request->getCaptainID());

        if ($isCaptainProfile == null) {

            $captainProfile = $this->autoMapping->map(CaptainProfileCreateRequest::class, CaptainProfileEntity::class, $request);
            
            //change this to inactive
            $captainProfile->setStatus('active');

            $captainProfile->setIsOnline('active');
            
            $this->entityManager->persist($captainProfile);
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $captainProfile;
        }
        else {
            return true;
        }
    }

    public function captainprofileUpdate(CaptainProfileUpdateRequest $request)
    {
        $item = $this->captainProRepository->getByCaptainIDForUpdate($request->getUserID());
        if ($item) {
            $item = $this->autoMapping->mapToObject(CaptainProfileUpdateRequest::class, CaptainProfileEntity::class, $request, $item);
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function captainprofileUpdateByAdmin(CaptainProfileUpdateByAdminRequest $request)
    {
        $item = $this->captainProRepository->getByCaptainIDForUpdate($request->getCaptainID());
        if ($item) {
            $item = $this->autoMapping->mapToObject(CaptainProfileUpdateByAdminRequest::class, CaptainProfileEntity::class, $request, $item);
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function captainvacationbyadmin(VacationsCreateRequest $request)
    {  
        $item = $this->captainProRepository->getByCaptainIDForUpdate($request->getCaptainId());
        
        if ($item) {
            $item = $this->autoMapping->mapToObject(VacationsCreateRequest::class, CaptainProfileEntity::class, $request, $item);
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function getcaptainprofileByCaptainID($captainID)
    {
        return $this->captainProRepository->getcaptainprofileByCaptainID($captainID);
    }
    
    public function getCaptainprofileByID($captainProfileId)
    {
        return $this->captainProRepository->getCaptainprofileByID($captainProfileId);
    }

    public function getCaptainprofileByIDStateDayOff($captainProfileId)
    {
        return $this->captainProRepository->getCaptainprofileByIDStateDayOff($captainProfileId);
    }

    public function getUserInactive($userType)
    {
        if ($userType == "owner") {
            return $this->profileRepository->getUserInactive();
        }
        if ($userType == "captain") {
            return $this->captainProRepository->getUserInactive();
        }
    }

    public function captainIsActive($captainID)
    {
        return $this->captainProRepository->captainIsActive($captainID);
    }

    public function getCaptainsState($state)
    {
        return $this->captainProRepository->getCaptainsState($state);
    }

    public function countpendingCaptains()
    {
        return $this->captainProRepository->countpendingCaptains();
    }
   
    public function countOngoingCaptains()
    {
        return $this->captainProRepository->countOngoingCaptains();
    }
   
    public function countDayOfCaptains()
    {
        return $this->captainProRepository->countDayOfCaptains();
    }
   
    public function getDayOfCaptains()
    {
        return $this->captainProRepository->getDayOfCaptains();
    }

    public function totalBounceCaptain($id)
    {
        return $this->captainProRepository->totalBounceCaptain($id);
    }

    public function getOwners()
    {
        return $this->profileRepository->getOwners();
    }

    public function getCaptains($userID)
    {
        return $this->captainProRepository->getCaptains($userID);
    }

    public function getAllOwners()
    {
        return $this->profileRepository->getAllOwners();
    }
    
    public function getAllCaptains()
    {
        return $this->captainProRepository->getAllCaptains();
    }

    public function getcaptainByUuid($uuid)
    {
        return $this->captainProRepository->getcaptainByUuid($uuid);
    }

    public function update($request, $NewMessageStatus)
    {
        if ($request) {
           
            $entity = $this->captainProRepository->find($request->getId());
        
            if (!$entity) {
                return null;
            }
            $entity->setNewMessageStatus($NewMessageStatus);
        
            $entity = $this->autoMapping->mapToObject(CaptainProfileEntity::class, CaptainProfileEntity::class, $entity, $entity);
          
            $this->entityManager->flush();

            return $entity;
        }
        return null;
    }
}
