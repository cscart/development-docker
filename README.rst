***************
CS-Cart Sandbox
***************

.. contents::
   :local:

==============
English Manual
==============

A Docker-based pre-configured environment for CS-Cart development.

-------------
Prerequisites
-------------

#. `Docker <https://docs.docker.com/install/#supported-platforms>`_

#. `Docker Compose <https://docs.docker.com/compose/install/>`_

----------------
How to Set It Up
----------------

++++++++++++++++++++++++++++++++++++++++++++
Step 1. Copy and Prepare File with Variables
++++++++++++++++++++++++++++++++++++++++++++

* **For using locally with self-signed certificates:**

  .. code-block:: bash

      $ cp compose/.env.local .env
   
* **For using with a wildcard certificate** (implemented for Selectel and Cloudflare only): 

  .. code-block:: bash

      $ cp compose/.env.local .env

+++++++++++++++++++++++++++++++++++++
Step 2. Make Changes to the .ENV File
+++++++++++++++++++++++++++++++++++++

**Important notes:**

#. Don't change the values that are already specified by default.

#. Directories for volumes will be created with correct permissions automatically on first launch.

#. Names of directories with CS-Cart instances in the ``CSCART_VOLUMES`` directory must contain only letters and numbers: ``[a-zA-Z0-9]``. Otherwise SEO and storefronts in subdirectories will not work.

**What changes to make:**

* **For local use:**

  * ``CSCART_VOLUMES`` - the path to the directory with СS-Cart instances (the directory will be created automatically if it doesn't exist).

  * ``MYSQL_LOGS`` - the path to the directory with MySQL logs (the directory will be created automatically if it doesn't exist).

  * ``MYSQL_DATA`` - the path to the directory with MySQL databases (the directory will be created automatically if it doesn't exist).

  * ``MYSQL_CONF`` - the path to the directory with MySQL config files (the directory will be created automatically if it doesn't exist).

  * ``MYSQL_RPASS`` - root password for MySQL database server.

* **For a wildcard certificate by Selectel:**

  * ``DNS_API=dns_selectel`` - the type of DNS provider for getting the wildcard certificate.

  * ``SL_Key=******`` - Selectel API key.

  * ``CSCART_VOLUMES`` - the path to the directory with СS-Cart instances (the directory will be created automatically if it doesn't exist).

  * ``MYSQL_LOGS`` - the path to the directory with MySQL logs (the directory will be created automatically if it doesn't exist).

  * ``MYSQL_DATA`` - the path to the directory with MySQL databases (the directory will be created automatically if it doesn't exist).

  * ``MYSQL_CONF`` - the path to the directory with MySQL config files (the directory will be created automatically if it doesn't exist).

  * ``MYSQL_RPASS`` - root password for MySQL database server.

  * ``DOMAIN`` - the domain for which we'll be getting the wildcard certificate.

  * ``PHP56_ADDRESS`` - a subdomain for PHP 5.6.

  * ``PHP70_ADDRESS`` - a subdomain for PHP 7.0.

  * ``PHP71_ADDRESS`` - a subdomain for PHP 7.1.

  * ``PHP72_ADDRESS`` - a subdomain for PHP 7.2.

* **For a wildcard certificate by Cloudflare:**

  * ``DNS_API=dns_selectel`` - the type of DNS provider for getting the wildcard certificate.

  * ``CF_Key=******`` - Cloudflare API key.

  * ``CF_Email`` - Cloudflare login (the email address associated with the account).

  * ``CSCART_VOLUMES`` - the path to the directory with СS-Cart instances (the directory will be created automatically if it doesn't exist).

  * ``MYSQL_LOGS`` - the path to the directory with MySQL logs (the directory will be created automatically if it doesn't exist).

  * ``MYSQL_DATA`` - the path to the directory with MySQL databases (the directory will be created automatically if it doesn't exist).

  * ``MYSQL_CONF`` - the path to the directory with MySQL config files (the directory will be created automatically if it doesn't exist).

  * ``MYSQL_RPASS`` - root password for MySQL database server.

  * ``DOMAIN`` - the domain for which we'll be getting the wildcard certificate.

  * ``PHP56_ADDRESS`` - a subdomain for PHP 5.6.

  * ``PHP70_ADDRESS`` - a subdomain for PHP 7.0.

  * ``PHP71_ADDRESS`` - a subdomain for PHP 7.1.

  * ``PHP72_ADDRESS`` - a subdomain for PHP 7.2.

  * ``SMTP_PASS`` - a password for the SMTP server.

  * ``SMTP_USER`` - a username on the SMTP server.

  * ``MAXMAILSIZE`` - `message_size_limit <http://www.postfix.org/postconf.5.html#message_size_limit>`_, the maximum size of the message.

++++++++++++++++++++++++++
Step 3. Launch Environment
++++++++++++++++++++++++++

* **For local use with self-signed certificates:**

  .. code-block:: bash

      sudo ./launcher local

  Make sure to add the following entries to */etc/hosts*:

  .. code-block:: bash

      sudo echo -e '127.0.0.1  php56.cs-cart.local\n127.0.0.1  php70.cs-cart.local\n127.0.0.1  php71.cs-cart.local\n127.0.0.1  php72.cs-cart.local\n' >> /etc/hosts

* **For a wildcard certificate (only by Selectel or Cloudflare):**

  .. code-block:: bash

      sudo ./launcher external

------------------
Access Credentials
------------------

* **For local use with self-signed certificates:**

  * ``php56.cs-cart.local`` - nginx + php-fpm 5.6

  * ``php70.cs-cart.local`` - nginx + php-fpm 7.0

  * ``php71.cs-cart.local`` - nginx + php-fpm 7.1

  * ``php72.cs-cart.local`` - nginx + php-fpm 7.2

  `Adminer <https://www.adminer.org>`_ will be available on port ``8080`` for working with the database server:

  * ``database`` - the address of the database server.

  * ``root`` - user name; the password is the value of the ``${MYSQL_RPASS}`` variable in the ENV file.

* **If a wildcard certificate by Selectel or Cloudflare is used instead**, then the addresses are the values of the variables in the ENV file:

  * ``PHP56_ADDRESS`` - a subdomain for PHP 5.6 - nginx + php-fpm 5.6

  * ``PHP70_ADDRESS`` - a subdomain for 7.0 - nginx + php-fpm 7.0

  * ``PHP71_ADDRESS`` - a subdomain for PHP 7.1 - nginx + php-fpm 7.1

  * ``PHP72_ADDRESS`` - a subdomain for PHP 7.2 - nginx + php-fpm 7.2

  **Important:** `Adminer <https://www.adminer.org>`_ will be available on port ``8080`` for working with the database server. **Use a firewall** to prevent unauthorized access.

  * ``database`` - the address of the database server.

  * ``root`` - user name; the password is the value of the ``${MYSQL_RPASS}`` variable in the ENV file.

To send emails from CS-Cart instances, go to **Settings → E-mails** in the CS-Cart admin panel and specify the following settings:

* **Method of sending e-mails** - choose the *via SMTP server* variant.

* **SMTP host** - enter ``postfix``.

* **SMTP username** - the value of the ``SMTP_USER`` variable.

* **SMTP password** - the value of the ``SMTP_PASS`` variable.

* **Use encrypted connection** - choose *None*.

* **Use SMTP authentication** - tick the checkbox.

==================
Русская инструкция
==================

Готовое окружение для разработки CS-Cart на основе Docker.

----------------
Необходимый софт
----------------

#. `Docker <https://docs.docker.com/install/#supported-platforms>`_

#. `Docker Compose <https://docs.docker.com/compose/install/>`_

-------------
Как запустить
-------------

++++++++++++++++++++++++++++++++++++++++++
Шаг 1. Копируем и готовим файла переменных
++++++++++++++++++++++++++++++++++++++++++

* **Если используем локально c самоподписанными сертификатами:**

  .. code-block:: bash

      $ cp compose/.env.local .env

* **Если хотим получить wildcard-сертификат** (реализовано лишь для Selectel и Cloudflare):

  .. code-block:: bash

      $ cp compose/.env.external .env

+++++++++++++++++++++++++++++++++++
Шаг 2. Вносим изменения в файл .env
+++++++++++++++++++++++++++++++++++

**Важные моменты:**

#. Заполненные значения оставляем без изменений.

#. Папки для волумов будут созданы автоматически с правильными правами при первом запуске. 

#. Имена папок с экземплярами CS-Cart в директории ``CSCART_VOLUMES`` должны содержать лишь буквы и цифры: ``[a-zA-Z0-9]``. В противном случае, не будет работать SEO и вложенные витрины.

**Какие изменения вносить:**

* **Локальное использование:**

  * ``CSCART_VOLUMES`` - путь до папки с экземплярами СS-Cart (будет создана автоматически, если не существует);

  * ``MYSQL_LOGS`` - путь до папки с логами MySQL (будет создана автоматически, если не существует);

  * ``MYSQL_DATA`` - путь до папки с базами данных MySQL (будет создана автоматически, если не существует);

  * ``MYSQL_CONF`` - путь до папки с конфигурационными файлами MySQL (будет создана автоматически, если не существует);

  * ``MYSQL_RPASS`` - root-пароль для сервера баз данных MySQL.

* **Wildcard-сертификат через Selectel:**

  * ``DNS_API=dns_selectel`` - тип DNS-провайдера для получения wildcard-сертификата;

  * ``SL_Key=******`` - API-ключ для Selectel;

  * ``CSCART_VOLUMES`` - путь до папки с экземплярами CS-Cart (будет создана автоматически, если не существует);

  * ``MYSQL_LOGS`` - путь до папки с логами MySQL (будет создана автоматически, если не существует);

  * ``MYSQL_DATA`` - путь до папки с базами данных MySQL (будет создана автоматически, если не существует);

  * ``MYSQL_CONF`` - путь до папки с конфигурационными файлами MySQL (будет создана автоматически, если не существует);

  * ``MYSQL_RPASS`` - root-пароль для сервера баз данных MySQL;

  * ``DOMAIN`` - домен, для которого будем получать wildcard-сертификат;

  * ``PHP56_ADDRESS`` - поддомен для PHP 5.6;

  * ``PHP70_ADDRESS`` - поддомен для PHP 7.0;

  * ``PHP71_ADDRESS`` - поддомен для PHP 7.1;

  * ``PHP72_ADDRESS`` - поддомен для PHP 7.2.

* **Wildcard-сертификат через Cloudflare:**

  * ``DNS_API=dns_selectel`` - тип DNS провайдера для получения wildcard-сертификата;

  * ``CF_Key=******`` - API-ключ для Cloudflare;

  * ``CF_Email`` - логин для Cloudflare (email-адрес, на который зарегистрирована учетная запись);

  * ``CSCART_VOLUMES`` - путь до папки с экземплярами CS-Cart (будет создана автоматически, если не существует);

  * ``MYSQL_LOGS`` - путь до папки с логами MySQL (будет создана автоматически, если не существует);

  * ``MYSQL_DATA`` - путь до папки с базами данных MySQL (будет создана автоматически, если не существует);

  * ``MYSQL_CONF`` - путь до папки с конфигурационными файлами MySQL (будет создана автоматически, если не существует);

  * ``MYSQL_RPASS`` - root-пароль для сервера баз данных MySQL;

  * ``DOMAIN`` - домен, для которого будем получать wildcard-сертификат;

  * ``PHP56_ADDRESS`` - поддомен для PHP 5.6;

  * ``PHP70_ADDRESS`` - поддомен для PHP 7.0;

  * ``PHP71_ADDRESS`` - поддомен для PHP 7.1;

  * ``PHP72_ADDRESS`` - поддомен для PHP 7.2;

  * ``SMTP_PASS`` - пароль для авторизации на SMTP-сервере;

  * ``SMTP_USER`` - имя пользователя для авторизации на SMTP-сервере;

  * ``MAXMAILSIZE`` - `message_size_limit <http://www.postfix.org/postconf.5.html#message_size_limit>`_, максимальный размер сообщения.

++++++++++++++++++++++++++
Шаг 3. Запускаем окружение
++++++++++++++++++++++++++

* **Если используем локально c самоподписанными сертификатами:**

  .. code-block:: bash

      sudo ./launcher local

  Также необходимо внести записи в файл */etc/hosts*:

  .. code-block:: bash

      sudo echo -e '127.0.0.1  php56.cs-cart.local\n127.0.0.1  php70.cs-cart.local\n127.0.0.1  php71.cs-cart.local\n127.0.0.1  php72.cs-cart.local\n' >> /etc/hosts

* **Если хотим получить wildcard-сертификат** (реализовано лишь для Selectel и Cloudflare):

  .. code-block:: bash

      sudo ./launcher external

-------
Доступы
-------

* **Если используем локально c самоподписанными сертификатами:**

  * ``php56.cs-cart.local`` - nginx + php-fpm 5.6;

  * ``php70.cs-cart.local`` - nginx + php-fpm 7.0;

  * ``php71.cs-cart.local`` - nginx + php-fpm 7.1;

  * ``php72.cs-cart.local`` - nginx + php-fpm 7.2.

  Также на ``8080`` порту будет доступен `Adminer <https://www.adminer.org>`_ для работы с сервером баз данных:

  * ``database`` - адрес сервера баз данных;

  * ``root`` - имя пользователя; паролю соответствует значение переменной ``${MYSQL_RPASS}`` в env-файле.

* **Если используем вариант с wildcard сертификатом** (реализовано лишь для Selectel и Cloudflare), то адресами являются значения переменных в env-файле:

  * ``PHP56_ADDRESS`` - поддомен для PHP 5.6 - nginx + php-fpm 5.6;

  * ``PHP70_ADDRESS`` - поддомен для PHP 7.0 - nginx + php-fpm 7.0;

  * ``PHP71_ADDRESS`` - поддомен для PHP 7.1 - nginx + php-fpm 7.1;

  * ``PHP72_ADDRESS`` - поддомен для PHP 7.2 - nginx + php-fpm 7.2.

  **Важно:** на ``8080`` порту будет доступен `Adminer <https://www.adminer.org>`_ для работы с сервером баз данных. **Используйте файервол** для предотвращения несанкционированного доступа.

  * ``database`` - адрес сервера баз данных;

  * ``root`` - имя пользователя; паролю соответствует значение переменной ``${MYSQL_RPASS}`` в env-файле. 

Чтобы отправлять электронные письма через экземпляры CS-Cart, перейдите в меню **Настройки → Электронная почта** в админке CS-Cart и задайте такие настройки:

* **Способ отправки почты** - выберите вариант *Отправка через SMTP сервер*;

* **SMTP сервер** - введите ``postfix``;

* **Имя пользователя для SMTP** - значение переменной ``SMTP_USER``;

* **Пароль для SMTP сервера** - значение переменной ``SMTP_PASS``;

* **Шифрованное соединение** - выберите вариант *Не использовать*;

* **Использовать SMTP аутентификацию** - поставьте галочку.
