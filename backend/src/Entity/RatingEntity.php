<?php

namespace App\Entity;

use App\Repository\RatingEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=RatingEntityRepository::class)
 */
class RatingEntity
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
    private $ownerID;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $captainID;

    /**
     * @ORM\Column(type="string", length=100)
     */
    private $type;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $orderID;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getOwnerID(): ?string
    {
        return $this->ownerID;
    }

    public function setOwnerID(string $ownerID): self
    {
        $this->ownerID = $ownerID;

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

    public function getType(): ?string
    {
        return $this->type;
    }

    public function setType(string $type): self
    {
        $this->type = $type;

        return $this;
    }

    public function getOrderID(): ?string
    {
        return $this->orderID;
    }

    public function setOrderID(?string $orderID): self
    {
        $this->orderID = $orderID;

        return $this;
    }
}
