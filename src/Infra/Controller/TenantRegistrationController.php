<?php

declare(strict_types=1);

namespace App\Infra\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Messenger\MessageBusInterface;
use Symfony\Component\Routing\Annotation\Route;

class TenantRegistrationController
{
    public function __construct(private MessageBusInterface $messageBus)
    {
    }

    /**
     * @Route("/tenant", name="display_tenant", methods={"GET"})
     */
    public function register(): Response
    {
        return new Response('<span>Test</span>');
    }
}
