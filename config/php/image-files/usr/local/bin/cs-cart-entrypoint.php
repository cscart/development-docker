#!/usr/bin/env php
<?php
require_once '/usr/local/share/docker-helpers.php';

$steps = [
    'cp /local_conf.php /app/www/local_conf.php',
];

if (getenv('CSCART_INSTALL') === 'yes') {
    $steps[] = 'cd /app/www/ && php _tools/restore.php && chmod -R 777 images';
}

runComposerCommands($steps);