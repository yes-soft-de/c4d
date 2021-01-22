<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\SettingEntity;
use App\Repository\SettingEntityRepository;
use App\Request\SettingRequest;
use Doctrine\ORM\EntityManagerInterface;

class SettingManager
{

    private $autoMapping;
    private $entityManager;
    private $settingRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, SettingEntityRepository $settingRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->settingRepository = $settingRepository;
    }

    public function getSetting()
    {
        return $this->settingRepository->getSetting();
    }

    public function updateSetting(SettingRequest $request)
    {
        $setting = $this->settingRepository->getSetting();

        if ($setting)
        {
            $setting = $this->autoMapping->mapToObject(SettingRequest::class,
                SettingEntity::class, $request, $setting);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $setting;
        }
    }

    public function createSetting(SettingRequest $request)
    {
        $setting = $this->autoMapping->map(SettingRequest::class, SettingEntity::class, $request);

        $this->entityManager->persist($setting);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $setting;
    }


}