<?php
declare(strict_types=1);

namespace App\Infra\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class TenantRegistrationController
{
    /**
     * @Route("/tenant")
     */
    public function register(): Response
    {
        echo 'test';
        return new Response(
            '<html><body>Here is a tenant !</body></html>'
        );
    }
}