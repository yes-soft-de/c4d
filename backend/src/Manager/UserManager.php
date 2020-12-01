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
use App\Request\CaptainProfileCreateRequest;
use App\Request\UserProfileUpdateRequest;
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
        $userRegister = $this->autoMapping->map(UserRegisterRequest::class, UserEntity::class, $request);

        $user = new UserEntity($request->getUserID());

        if ($request->getPassword()) {
            $userRegister->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
        }

        if ($request->getRoles() == null) {
            $request->setRoles(['user']);
        }
        $userRegister->setRoles($request->getRoles());

        $this->entityManager->persist($userRegister);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $userRegister;
    }

    public function userProfileCreate(UserProfileCreateRequest $request)
    {
        $userProfile = $this->getProfileByUserID($request->getUserID());
        if ($userProfile == null) {
            $userProfile = $this->autoMapping->map(UserProfileCreateRequest::class, UserProfileEntity::class, $request);

            $this->entityManager->persist($userProfile);
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $userProfile;
        }
        else {
            return 1;
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

    public function getProfileByUserID($userID)
    {
        return $this->profileRepository->getProfileByUSerID($userID);
    }

    public function getremainingOrders($userID)
    {
        $date = new \DateTime("Now");
        return $this->profileRepository->getremainingOrders($userID, $date);
    }

    public function captainprofileCreate(CaptainProfileCreateRequest $request)
    {
        $isCaptainProfile = $this->getcaptainprofileByID($request->getCaptainID());

        if ($isCaptainProfile == null) {

            $captainProfile = $this->autoMapping->map(CaptainProfileCreateRequest::class, CaptainProfileEntity::class, $request);
            $this->entityManager->persist($captainProfile);
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $captainProfile;
        }
        else {
            return 1;
        }
    }

    public function captainprofileUpdate(CaptainProfileUpdateRequest $request)
    {
        $item = $this->captainProRepository->getCaptainprofile($request->getCaptainID());

        if ($item) {
            $item = $this->autoMapping->mapToObject(CaptainProfileUpdateRequest::class, CaptainProfileEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function getcaptainprofileByID($userID)
    {
        return $this->captainProRepository->getCaptainprofileByUserID($userID);
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

    public function userIsActive($userType, $userID)
    {
        if ($userType == "owner") {
        return $this->profileRepository->userIsActive($userID);
        }
        if ($userType == "captain") {
        return $this->captainProRepository->userIsActive($userID);
        }
    }
}
