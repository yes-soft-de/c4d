<?php

namespace App\Entity;

use App\Repository\BankEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=BankEntityRepository::class)
 */
class BankEntity
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
    private $userID;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $bankName;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $accountID;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $stcPay;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserID(): ?string
    {
        return $this->userID;
    }

    public function setUserID(?string $userID): self
    {
        $this->userID = $userID;

        return $this;
    }

    public function getBankName(): ?string
    {
        return $this->bankName;
    }

    public function setBankName(?string $bankName): self
    {
        $this->bankName = $bankName;

        return $this;
    }

    public function getAccountID(): ?string
    {
        return $this->accountID;
    }

    public function setAccountID(string $accountID): self
    {
        $this->accountID = $accountID;

        return $this;
    }

    public function getStcPay(): ?string
    {
        return $this->stcPay;
    }

    public function setStcPay(?string $stcPay): self
    {
        $this->stcPay = $stcPay;

        return $this;
    }
}
