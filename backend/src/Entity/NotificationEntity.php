<?php

namespace App\Entity;

use App\Repository\NotificationEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=NotificationEntityRepository::class)
 */
class NotificationEntity
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
    private $userIDOne;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $userIDTwo;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $swapItemIDOne;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $swapItemIDTwo;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $swapID;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $message;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $date;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserIDOne(): ?string
    {
        return $this->userIDOne;
    }

    public function setUserIDOne(?string $userIDOne): self
    {
        $this->userIDOne = $userIDOne;

        return $this;
    }

    public function getUserIDTwo(): ?string
    {
        return $this->userIDTwo;
    }

    public function setUserIDTwo(?string $userIDTwo): self
    {
        $this->userIDTwo = $userIDTwo;

        return $this;
    }

    public function getSwapItemIDOne(): ?int
    {
        return $this->swapItemIDOne;
    }

    public function setSwapItemIDOne(?int $swapItemIDOne): self
    {
        $this->swapItemIDOne = $swapItemIDOne;

        return $this;
    }

    public function getSwapItemIDTwo(): ?int
    {
        return $this->swapItemIDTwo;
    }

    public function setSwapItemIDTwo(?int $swapItemIDTwo): self
    {
        $this->swapItemIDTwo = $swapItemIDTwo;

        return $this;
    }

    public function getSwapID(): ?int
    {
        return $this->swapID;
    }

    public function setSwapID(int $swapID): self
    {
        $this->swapID = $swapID;

        return $this;
    }

    public function getMessage(): ?string
    {
        return $this->message;
    }

    public function setMessage(?string $message): self
    {
        $this->message = $message;

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
