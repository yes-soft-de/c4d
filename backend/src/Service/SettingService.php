<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\SettingEntity;
use App\Manager\SettingManager;
use App\Request\SettingRequest;
use App\Response\SettingResponse;

class SettingService
{

    private $autoMapping;
    private $settingManager;

    public function __construct(AutoMapping $autoMapping, SettingManager $settingManager)
    {
        $this->autoMapping = $autoMapping;
        $this->settingManager = $settingManager;
    }

    public function getSetting()
    {
        $setting = $this->settingManager->getSetting();

        $response = $this->autoMapping->map(SettingEntity::class,SettingResponse::class, $setting);

        return $response;
    }

    public function saveSetting(SettingRequest $request)
    {
        $this->settingManager->updateSetting($request);
    }

    public function createSetting(SettingRequest $request)
    {
        $result = $this->settingManager->createSetting($request);

        $response = $this->autoMapping->map('array',SettingResponse::class, $result);

        return $response;
    }
}