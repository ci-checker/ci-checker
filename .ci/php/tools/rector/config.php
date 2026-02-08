<?php

declare(strict_types=1);

use Rector\Config\RectorConfig;

define('PROJECT_DIR', $_ENV['PROJECT_DIR']);

return RectorConfig::configure()
    ->withPaths([
        PROJECT_DIR . '/src',
    ])
    ->withPreparedSets(
        deadCode: true,
        codeQuality: true,
        codingStyle: true,
        typeDeclarations: true,
        privatization: true,
        earlyReturn: true,
    );
