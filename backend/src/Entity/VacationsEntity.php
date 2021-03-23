<?php

namespace App\Entity;

use App\Repository\VacationsEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use DateTime;
/**
 * @ORM\Entity(repositoryClass=VacationsEntityRepository::class)
 */
class VacationsEntity
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $captainId;

    /**
     * @ORM\Column(type="date", nullable=true)
     */
    private $startDate;

    /**
     * @ORM\Column(type="date", nullable=true)
     */
    private $endDate;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $state;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCaptainId(): ?string
    {
        return $this->captainId;
    }

    public function setCaptainId(string $captainId): self
    {
        $this->captainId = $captainId;

        return $this;
    }

    public function getStartDate()
    {
        return $this->startDate;
    }

    public function setStartDate($startDate): self
    {
        $this->startDate = new DateTime($startDate);

        return $this;
    }

    public function getEndDate()
    {
        return $this->endDate;
    }

    public function setEndDate($endDate): self
    {
        $this->endDate = new DateTime($endDate);

        return $this;
    }

    public function getState(): ?string
    {
        return $this->state;
    }

    public function setState(?string $state): self
    {
        $this->state = $state;

        return $this;
    }
}
