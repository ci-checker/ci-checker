<?php

define('PROJECT_DIR', $_ENV['PROJECT_DIR']);

return (new PhpCsFixer\Config())
    ->setCacheFile('/tmp/php_cs.cache')
    ->setFinder(PhpCsFixer\Finder::create()->in(PROJECT_DIR . '/src'))
    ->setRules(
        [
            '@PSR1' => true,
            '@PSR2' => true,
        ]
    );
