<?php

declare(strict_types=1);

namespace App\Infra\Action;

class TenantRegistration
{
    public function __construct(
        public string $name,
        public string $email,
        public int $age,
        public string $address,
    ) {
    }
}
