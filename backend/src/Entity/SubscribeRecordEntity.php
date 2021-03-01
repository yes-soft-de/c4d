<?php

namespace App\Entity;

use App\Repository\SubscribeRecordEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=SubscribeRecordEntityRepository::class)
 */
class SubscribeRecordEntity
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $ownerId;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $subscribeId;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $packageId;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $date;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getOwnerId(): ?string
    {
        return $this->ownerId;
    }

    public function setOwnerId(?string $ownerId): self
    {
        $this->ownerId = $ownerId;

        return $this;
    }

    public function getSubscribeId(): ?int
    {
        return $this->subscribeId;
    }

    public function setSubscribeId(?int $subscribeId): self
    {
        $this->subscribeId = $subscribeId;

        return $this;
    }

    public function getPackageId(): ?int
    {
        return $this->packageId;
    }

    public function setPackageId(?int $packageId): self
    {
        $this->packageId = $packageId;

        return $this;
    }

    public function getDate(): ?\DateTimeInterface
    {
        return $this->date;
    }

    public function setDate(?\DateTimeInterface $date): self
    {
        $this->date = $date;

        return $this;
    }
}
