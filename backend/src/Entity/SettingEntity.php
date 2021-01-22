<?php

namespace App\Entity;

use App\Repository\SettingEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=SettingEntityRepository::class)
 */
class SettingEntity
{
    /**
     * @ORM\Id()
     * @ORM\GeneratedValue()
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $uploadSubFolder;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUploadSubFolder(): ?string
    {
        return $this->uploadSubFolder;
    }

    public function setUploadSubFolder(?string $uploadSubFolder): self
    {
        $this->uploadSubFolder = $uploadSubFolder;

        return $this;
    }
}
