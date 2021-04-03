<?php

namespace App\Entity;

use App\Repository\RoomIdHelperEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=RoomIdHelperEntityRepository::class)
 */
class RoomIdHelperEntity
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
    private $captainID;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $ownerID;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $roomID;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCaptainID(): ?string
    {
        return $this->captainID;
    }

    public function setCaptainID(?string $captainID): self
    {
        $this->captainID = $captainID;

        return $this;
    }

    public function getOwnerID(): ?string
    {
        return $this->ownerID;
    }

    public function setOwnerID(?string $ownerID): self
    {
        $this->ownerID = $ownerID;

        return $this;
    }

    public function getRoomID(): ?string
    {
        return $this->roomID;
    }

    public function setRoomID(?string $roomID): self
    {
        $this->roomID = $roomID;

        return $this;
    }
}
