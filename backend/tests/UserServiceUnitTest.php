<?php

namespace App\Tests;

use App\AutoMapping;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use App\Entity\CaptainProfileEntity;
use App\Manager\UserManager;
use App\Request\UserProfileCreateRequest;
use App\Request\CaptainProfileCreateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\CaptainProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Response\UserProfileCreateResponse;
use App\Response\UserProfileResponse;
use App\Response\UserRegisterResponse;
// use App\Response\RemainingOrdersResponse;
use App\Response\CaptainProfileCreateResponse;
use App\Service\UserService;
use App\Tests\fixtures\UserProvider;
use PHPUnit\Framework\TestCase;

class UserServiceUnitTest extends TestCase
{
    private $mockManager;
    private $autoMapping;

    protected function setUp()
    {
        $this->mockManager = $this->createMock(UserManager::class);
        $this->autoMapping = new AutoMapping();
    }

    /**
     * @dataProvider register
     */
    public function testuserRegisterWithDataProvider($expected, $actual)
    {
        $response = new UserRegisterResponse();
        $response->userID = $expected;
        $response->roles = ['user'];
        $response->password = $expected;
        $response->createDate = $expected;
        $response->email = $expected;

        $entity = new UserEntity($response->userID);
        $entity->setUserID($actual);
        $entity->setRoles(['user']);
        $entity->setPassword($actual);
        $entity->setCreateDate($actual);
        $entity->setEmail($actual);

        $request = new UserRegisterRequest();

        $this->mockManager
            ->method('userRegister')
            ->willReturn($entity);

        $service = new UserService($this->autoMapping, $this->mockManager);
        $this->assertIsObject($service->userRegister($request));
    }

    public function register()
    {
        $result = new UserProvider();
        return $result->register();
    }

    /**
     * @dataProvider userProfileCreate
     */
    public function testUserProfileCreate($expected, $actual)
    {
        $response = new UserProfileCreateResponse();
        $response->userName = $expected;
        $response->location = $expected;
        $response->story = $expected;
        $response->image = $expected;

        $entity = new UserProfileEntity();
        $entity->setUserID($actual);
        $entity->setUserName($actual);
        $entity->setLocation($actual);
        $entity->setStory($actual);
        $entity->setImage($actual);

        $request = new UserProfileCreateRequest();

        $this->mockManager
            ->method('userProfileCreate')
            ->willReturn($entity);

        $service = new UserService($this->autoMapping, $this->mockManager);
        $this->assertEquals($response, $service->userProfileCreate($request));
    }

    public function userProfileCreate()
    {
        $result = new UserProvider();
        return $result->userProfileCreate();
    }

    /**
     * @dataProvider userProfileUpdate
     */
    public function testUserProfileUpdate($expected, $actual)
    {
        $response = new UserProfileResponse();
        $response->userName = $expected;
        $response->location = $expected;
        $response->story = $expected;
        $response->image = $expected;

        $entity = new UserProfileEntity();
        $entity->setUserID($actual);
        $entity->setUserName($actual);
        $entity->setLocation($actual);
        $entity->setStory($actual);
        $entity->setImage($actual);

        $request = new UserProfileUpdateRequest();

        $this->mockManager
            ->method('userProfileUpdate')
            ->willReturn($entity);

        $service = new UserService($this->autoMapping, $this->mockManager);
        $this->assertEquals($response, $service->userProfileUpdate($request));
    }

    public function userProfileUpdate()
    {
        $result = new UserProvider();
        return $result->userProfileUpdate();
    }

    /**
     * @dataProvider getUserProfileByUserID
     */
    public function testgetUserProfileByUserID($expected, $actual)
    {
        $response = new UserProfileResponse();
        $response->userID = $expected;
        $response->userName = $expected;
        $response->location = $expected;
        $response->story = $expected;
        $response->image = $expected;

        $entity = new UserProfileEntity();
        $entity->setUserID($actual);
        $entity->setUserName($actual);
        $entity->setLocation($actual);
        $entity->setStory($actual);
        $entity->setImage($actual);

        $this->mockManager
            ->method('getProfileByUserID')
            ->willReturn($entity);

        $service = new UserService($this->autoMapping, $this->mockManager);
        $this->assertIsArray($service->getUserProfileByUserID($response->userID));
    }

    public function getUserProfileByUserID()
    {
        $result = new UserProvider();
        return $result->getUserProfileByUserID();
    }

     /**
     * @dataProvider captainprofileCreate
     */
    public function testCaptainprofileCreate($expected, $actual)
    {
        $response = new CaptainProfileCreateResponse();
        $response->captainID = $expected;
        $response->name = $expected;
        $response->image = $expected;
        $response->location = $expected;
        $response->age = $expected;
        $response->car = $expected;
        $response->drivingLicence = $expected;

        $entity = new CaptainProfileEntity();
        $entity->setCaptainID($actual);
        $entity->setName($actual);
        $entity->setImage($actual);
        $entity->setLocation($actual);
        $entity->setAge($actual);
        $entity->setCar($actual);
        $entity->setDrivingLicence($actual);

        $request = new CaptainProfileCreateRequest();

        $this->mockManager
            ->method('captainprofileCreate')
            ->willReturn($entity);

        $service = new UserService($this->autoMapping, $this->mockManager);
        $this->assertEquals($response, $service->captainprofileCreate($request));
    }

    public function captainprofileCreate()
    {
        $result = new UserProvider();
        return $result->captainprofileCreate();
    }

    /**
     * @dataProvider captainprofileUpdate
     */
    public function testCaptainprofileUpdate($expected, $actual)
    {
        $response = new CaptainProfileCreateResponse();
        $response->captainID = $expected;
        $response->name = $expected;
        $response->image = $expected;
        $response->location = $expected;
        $response->age = $expected;
        $response->car = $expected;
        $response->drivingLicence = $expected;

        $entity = new CaptainProfileEntity();
        $entity->setCaptainID($actual);
        $entity->setName($actual);
        $entity->setImage($actual);
        $entity->setLocation($actual);
        $entity->setAge($actual);
        $entity->setCar($actual);
        $entity->setDrivingLicence($actual);

        $request = new CaptainProfileUpdateRequest();

        $this->mockManager
            ->method('captainprofileUpdate')
            ->willReturn($entity);

        $service = new UserService($this->autoMapping, $this->mockManager);
        $this->assertEquals($response, $service->captainprofileUpdate($request));
    }

    public function captainprofileUpdate()
    {
        $result = new UserProvider();
        return $result->captainprofileUpdate();
    }
    /**
     * @dataProvider getcaptainprofileByID
     */
    public function testgetcaptainprofileByID($expected, $actual)
    {
        $response = new CaptainProfileCreateResponse();
        $response->captainID = $expected;
        $response->name = $expected;
        $response->image = $expected;
        $response->location = $expected;
        $response->age = $expected;
        $response->car = $expected;
        $response->drivingLicence = $expected;

        $entity = new CaptainProfileEntity();
        $entity->setCaptainID($actual);
        $entity->setName($actual);
        $entity->setImage($actual);
        $entity->setLocation($actual);
        $entity->setAge($actual);
        $entity->setCar($actual);
        $entity->setDrivingLicence($actual);


        $this->mockManager
            ->method('getcaptainprofileByID')
            ->willReturn($entity);

        $service = new UserService($this->autoMapping, $this->mockManager);
        $this->assertIsArray($service->getcaptainprofileByID($response->captainID));
    }

    public function getcaptainprofileByID()
    {
        $result = new UserProvider();
        return $result->getcaptainprofileByID();
    }
}
