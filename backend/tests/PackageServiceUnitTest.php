<?php

namespace App\Tests;

use App\AutoMapping;
use App\Entity\PackageEntity;
use App\Manager\PackageManager;
use App\Service\PackageService;
use App\Request\PackageCreateRequest;
use App\Request\PackageUpdateRequest;
use App\Response\PackageResponse;
use App\Tests\fixtures\PackageProvider;
use PHPUnit\Framework\TestCase;

class PackageServiceUnitTest extends TestCase
{
    private $mockManager;
    private $autoMapping;

    protected function setUp()
    {
        $this->mockManager = $this->createMock(PackageManager::class);
        $this->autoMapping = new AutoMapping();
    }

    /**
     * @dataProvider create
     */
    public function testCreate($expected, $actual)
    {
        $response = new PackageResponse();
        $response->name = $expected;
        $response->cost = $expected;
        $response->note = $expected;
        $response->carCount = $expected;
        $response->city = $expected;
        $response->orderCount = $expected;
        $response->status = $expected;
        $response->branch = $expected;

        $entity = new PackageEntity();
        $entity->setName($actual);
        $entity->setCost($actual);
        $entity->setNote($actual);
        $entity->setCarCount($actual);
        $entity->setCity($actual);
        $entity->setOrderCount($actual);
        $entity->setStatus($actual);
        $entity->setBranch($actual);

        $request = new PackageCreateRequest();

        $this->mockManager
            ->method('create')
            ->willReturn($entity);

        $service = new PackageService($this->autoMapping, $this->mockManager);

        $this->assertEquals($response, $service->create($request));
    }

    public function create()
    {
        $result = new PackageProvider();
        return $result->create();
    }

    /**
     * @dataProvider GetPackages
     */
    public function testGetPackages($expected, $actual)
    {
        $response = new PackageResponse();
        $response->name = $expected;
        $response->cost = $expected;
        $response->note = $expected;
        $response->carCount = $expected;
        $response->city = $expected;
        $response->orderCount = $expected;
        $response->status = $expected;
        $response->branch = $expected;

        $entity = new PackageEntity();
        $entity->setName($actual);
        $entity->setCost($actual);
        $entity->setNote($actual);
        $entity->setCarCount($actual);
        $entity->setCity($actual);
        $entity->setOrderCount($actual);
        $entity->setStatus($actual);
        $entity->setBranch($actual);


        $this->mockManager
            ->method('getPackages')
            ->willReturn($entity);

        $service = new PackageService($this->autoMapping, $this->mockManager);

        $this->assertIsArray($service->getPackages($actual));
    }

    public function getPackages()
    {
        $result = new PackageProvider();
        return $result->getPackages();
    }

    /**
     * @dataProvider GetActivePackages
     */
    public function testGetActivePackages($expected, $actual)
    {
        $response = new PackageResponse();
        $response->name = $expected;
        $response->cost = $expected;
        $response->note = $expected;
        $response->carCount = $expected;
        $response->city = $expected;
        $response->orderCount = $expected;
        $response->status = $expected;
        $response->branch = $expected;

        $entity = new PackageEntity();
        $entity->setName($actual);
        $entity->setCost($actual);
        $entity->setNote($actual);
        $entity->setCarCount($actual);
        $entity->setCity($actual);
        $entity->setOrderCount($actual);
        $entity->setStatus($actual);
        $entity->setBranch($actual);


        $this->mockManager
            ->method('getActivePackages')
            ->willReturn($entity);

        $service = new PackageService($this->autoMapping, $this->mockManager);

        $this->assertIsObject($service->getActivePackages());
    }

    public function getActivePackages()
    {
        $result = new PackageProvider();
        return $result->getActivePackages();
    }

    /**
     * @dataProvider update
     */
    public function testUpdate($expected, $actual)
    {
        $response = new PackageResponse();
        // $response->id = $expected;
        $response->name = $expected;
        $response->cost = $expected;
        $response->note = $expected;
        $response->carCount = $expected;
        $response->city = $expected;
        $response->orderCount = $expected;
        $response->status = $expected;
        $response->branch = $expected;

        $entity = new PackageEntity();
        $entity->setName($actual);
        $entity->setCost($actual);
        $entity->setNote($actual);
        $entity->setCarCount($actual);
        $entity->setCity($actual);
        $entity->setOrderCount($actual);
        $entity->setStatus($actual);
        $entity->setBranch($actual);

        $request = new PackageUpdateRequest();

        $this->mockManager
            ->method('update')
            ->willReturn($entity);

        $service = new PackageService($this->autoMapping, $this->mockManager);

        $this->assertEquals($response, $service->update($request));
    }

    public function update()
    {
        $result = new PackageProvider();
        return $result->update();
    }
}
