<?php

namespace App\Entity;

use App\Repository\SubscriptionEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * @ORM\Entity(repositoryClass=SubscriptionEntityRepository::class)
 */
class SubscriptionEntity
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
     * @ORM\Column(type="integer")
     */
    private $packageID;

    /**
     * @Gedmo\Timestampable(on="create")
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $startDate;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $endDate;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $status;

    /**
     * @ORM\Column(type="text", nullable=true)
     */
    private $note;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $isFuture;

    // /**
    //  * @ORM\Column(type="boolean", nullable=true)
    //  */
    // private $pay;


    public function getId(): ?int
    {
        return $this->id;
    }

    public function setId(int $id): self
    {
        $this->id = $id;

        return $this;
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

    public function getPackageID(): ?int
    {
        return $this->packageID;
    }

    public function setPackageID(int $packageID): self
    {
        $this->packageID = $packageID;

        return $this;
    }

    public function getStartDate(): ?\DateTimeInterface
    {
        return $this->startDate;
    }

    public function setStartDate(?\DateTimeInterface $startDate): self
    {
        $this->startDate = $startDate;

        return $this;
    }

    public function getEndDate(): ?\DateTimeInterface
    {
        return $this->endDate;
    }

    public function setEndDate(?\DateTimeInterface $endDate): self
    {
        $this->endDate = $endDate;

        return $this;
    }

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(string $status): self
    {
        $this->status = $status;

        return $this;
    }

    public function getNote(): ?string
    {
        return $this->note;
    }

    public function setNote(?string $note): self
    {
        $this->note = $note;

        return $this;
    }

    public function getIsFuture(): ?bool
    {
        return $this->isFuture;
    }

    public function setIsFuture(?bool $isFuture): self
    {
        $this->isFuture = $isFuture;

        return $this;
    }
}
