<?php

// a helper function to lookup "env_FILE", "env", then fallback
if (!function_exists('getenv_docker')) {
    // https://github.com/docker-library/wordpress/issues/588 (WP-CLI will load this file 2x)
    function getenv_docker($env, $default) {
        if ($fileEnv = getenv($env . '_FILE')) {
            return rtrim(file_get_contents($fileEnv), "\r\n");
        }
        else if (($val = getenv($env)) !== false) {
            return $val;
        }
        else {
            return $default;
        }
    }
}

/*
 * Display PHP errors on the screen.
 */
error_reporting(E_ALL);
ini_set('display_errors', 'on');
//ini_set('display_startup_errors', true);

/*
 * MULTIVENDOR|ULTIMATE
 */
define('PRODUCT_EDITION', getenv_docker('CSCART_PRODUCT_EDITION', 'ULTIMATE'));
define('PRODUCT_BUILD', '');

/*
 * Turn on the Debug mode for the admin panel and the storefront
 * Use the Development mode to display errors
 */
// define('DEBUG_MODE', true);
define('DEVELOPMENT', true);

/*
 * Specify the host and path of your site for the development environment
 * If your url is http://localhost/store/cart
 * $config['http_host'] = $config['https_host'] = 'localhost';
 * $config['http_path'] = $config['https_path'] = '/store/cart';
 */
$config['http_host'] = $config['https_host'] = getenv_docker('CSCART_HOST', 'localhost');
$config['http_path'] = $config['https_path'] = getenv_docker('CSCART_PATH', '');

/*
 * Database connection options
 */
$config['db_host'] = getenv_docker('CSCART_DB_HOST', 'cscart');
$config['db_user'] = getenv_docker('CSCART_DB_USER','cscart');
$config['db_password'] = getenv_docker('CSCART_DB_PASSWORD','cscart');
$config['db_name'] = getenv_docker('CSCART_DB_NAME','cscart');

// Database tables prefix
$config['table_prefix'] = 'cscart_';

/*
 * Tweaks
 *
 * disable_block_cache - Used to disable block cache
 * api_allow_customer - Allow open API for unauthorized customers
 * disable_localizations - Disable Localizations functionality
 */
//$config['tweaks']['disable_block_cache'] = true;
//$config['tweaks']['api_allow_customer'] = true;
//$config['tweaks']['disable_localizations'] = true;

/* For unit tests
if (defined('UNIT_TESTS')) {
    $config['db_name'] = 'unit_tests';
}*/


/*
 * _tools/restore.php hook, executes after db was restored, allows to execute additional configuration
 *
function fn_rst_local_db_complete()
{
    // Enable trial mode
    fn_rst_db_query("REPLACE cscart_storage_data (data_key, data) VALUES('store_mode', 'trial');");
    // Enable themes rebuild cache automatically
    fn_rst_db_query("REPLACE INTO cscart_storage_data (`data_key`, `data`) VALUES ('dev_mode', 'a:1:{s:13:\"compile_check\";b:1;}');");
    // Enable secure connection in the administration panel
    fn_rst_db_query("UPDATE cscart_settings_objects SET value = 'Y' WHERE name = 'secure_admin' AND section_id = (SELECT section_id FROM cscart_settings_sections WHERE name = 'Security' AND type = 'CORE')");
    // Enable secure connection for the storefront
    fn_rst_db_query("UPDATE cscart_settings_objects SET value = 'Y' WHERE name = 'secure_storefront' AND section_id = (SELECT section_id FROM cscart_settings_sections WHERE name = 'Security' AND type = 'CORE')");
}
*/

/*
 * _tools/restore.php hook, executes after restore complete, allows to execute additional action
 *
function fn_rst_local_complete()
{
    // Install mailcatcher add-on
    fn_rst_execute_command("php admin.php --dispatch=addons.install --addon=mailcatcher -p");
}
*/

// Pre-fills sign in form with demo logins
if (AREA == 'A') {
    if (defined('ACCOUNT_TYPE') && ACCOUNT_TYPE == 'admin') {
        $config['demo_username'] = 'admin@example.com';
        $config['demo_password'] = 'admin';
    }
} else {
    $config['demo_username'] = 'customer@example.com';
    $config['demo_password'] = 'customer';
}

// Place your DEV server URL
define('SE_SERVICE_URL', getenv_docker('SEARCHANISE_SERVICE','https://searchserverapi.com') );