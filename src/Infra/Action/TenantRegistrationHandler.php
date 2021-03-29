<?php
declare(strict_types=1);

namespace App\Infra\Action;

use Doctrine\ORM\EntityManagerInterface;

class TenantRegistrationHandler
{
    public function __construct(
        private EntityManagerInterface $entityManager
    ) {}

    public function __invoke(TenantRegistration $message)
    {

    }
}