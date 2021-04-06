<?php

declare(strict_types=1);

namespace App\Domain\Tenant\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity()
 * @ORM\Table(name="tenant")
 */
class Tenant
{
    /**
     * @ORM\Id()
     * @ORM\GeneratedValue()
     * @ORM\Column(name="id", type="integer", nullable=false)
     */
    private ?int $id;

    /**
     * @ORM\Column(name="first_name", type="string", nullable=false)
     */
    private string $firstName;

    /**
     * @ORM\Column(name="last_name", type="string", nullable=false)
     */
    private string $lastName;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function setId(?int $id): Tenant
    {
        $this->id = $id;

        return $this;
    }

    public function getFirstName(): string
    {
        return $this->firstName;
    }

    public function setFirstName(string $firstName): Tenant
    {
        $this->firstName = $firstName;

        return $this;
    }

    public function getLastName(): string
    {
        return $this->lastName;
    }

    public function setLastName(string $lastName): Tenant
    {
        $this->lastName = $lastName;

        return $this;
    }
}
