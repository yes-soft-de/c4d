<?php

namespace App\Entity;

use App\Repository\AcceptedOrderEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * @ORM\Entity(repositoryClass=AcceptedOrderEntityRepository::class)
 */
class AcceptedOrderEntity
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
    private $orderID;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $captainID;

    /**
     * @Gedmo\Timestampable(on="create")
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $date;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $duration;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $state;

    /**
     * @ORM\Column(type="date", nullable=true)
     */
    private $dateOnly;

  
    public function getId(): ?int
    {
        return $this->id;
    }

    public function setId(int $id): self
    {
        $this->id = $id;

        return $this;
    }

    public function getOrderID(): ?string
    {
        return $this->orderID;
    }

    public function setOrderID(string $orderID): self
    {
        $this->orderID = $orderID;

        return $this;
    }

    public function getCaptainID(): ?string
    {
        return $this->captainID;
    }

    public function setCaptainID(string $captainID): self
    {
        $this->captainID = $captainID;

        return $this;
    }

    public function getDate()
    {
        return $this->date;
    }

    public function setDate($date): self
    {
        $this->date = $date;

        return $this;
    }

    public function getDuration()
    {
        return $this->duration;
    }

    public function setDuration($duration): self
    {
        $this->duration = new \DateTime($duration);

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

    public function getDateOnly()
    {
        return $this->dateOnly;
    }

    public function setDateOnly($dateOnly): self
    {
        $this->dateOnly = new \DateTime($dateOnly);

        return $this;
    }

}
