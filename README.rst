*******************************
CS-Cart Development Environment
*******************************

.. contents::
   :local:

==============
English manual
==============

Docker-based development environment:

* PHP versions: 7.4, 7.3 and 5.6.
* MySQL 5.7 database server.
* nginx web server.

------------
Installation
------------

#. Install ``git``, ``docker`` and ``docker-compose``.
#. Clone the environment repository:

    .. code-block:: bash

        $ git clone git@github.com:cscart/development-docker.git ~/srv
        $ cd ~/srv

#. Create the directory to store CS-Cart files:

    .. code-block:: bash

        $ mkdir -p app/www app/log/nginx

#. Clone CS-Cart repository or unpack the distribution archive into the ``app/www`` directory
#. Setup the correct permissions for the installation:

    .. code-block:: bash

        $ chmod 777 -R app/www/images app/www/design app/www/var
   
#. Enable the default application config for nginx:

    .. code-block:: bash

        $ cp config/nginx/app.conf.example config/nginx/app.conf

#. Run application containers:

    .. code-block:: bash

        $ make -f Makefile run

#. Access the now running site on http://localhost and enter the required details.  
   Note when entering the MySQL address enter ``mysql5.7``, the username is ``root`` and the password is ``root``.

-----------------------------------
Working with different PHP versions
-----------------------------------

PHP 7.4 is used by default.

To use the specific PHP version for your requests, add the following prefix to the domain you request:

* ``php5.6.`` for PHP 5.6.
* ``php7.3.`` for PHP 7.3.
* ``php7.4.`` for PHP 7.4.

---------------
Sending e-mails
---------------

PHP containers do not send actual e-mails when using the ``mail()`` function.

All sent emails will be caught and stored in the ``app/log/sendmail`` directory.

----------------------------------
Working with multiple applications
----------------------------------

See comments in the ``config/nginx/app.conf.example`` file if you need to host multiple PHP applications inside single Docker PHP container.

----------------------------------
Enabling xDebug for PHP containers
----------------------------------

See comments in the ``config/php*/Dockerfile`` files.

==================
Русская инструкция
==================

Среда для разработки на базе Docker:

* Версии PHP: 7.4, 7.3 and 5.6.
* Сервер баз данных MySQL 5.7.
* Веб-сервер nginx.

---------
Установка
---------

#. Установите ``git``, ``docker`` and ``docker-compose``.
#. Склонируйте репозиторий с окружением:

    .. code-block:: bash

        $ git clone git@github.com:cscart/development-docker.git ~/srv
        $ cd ~/srv

#. Создайте папку для файлов CS-Cart:

    .. code-block:: bash

        $ mkdir -p app/www

#. Склонируйте репозиторий CS-Cart или распакуйте дистрибутив в папку ``app/www``.
#. Включите приложение со стандартным конфигом nginx:

    .. code-block:: bash

        $ cp config/nginx/app.conf.example config/nginx/app.conf

#. Запустите контейнеры приложения:

    .. code-block:: bash

        $ make -f Makefile run

-----------------------------
Работа с разными версиями PHP
-----------------------------

По умолчанию используется PHP 7.4.

Чтобы явно указать версию PHP для конкретного запроса, добавьте к домену следующую приставку:

* ``php5.6.`` для PHP 5.6.
* ``php7.3.`` для PHP 7.3.
* ``php7.4.`` для PHP 7.4.

------------------
Отправка e-mail'ов
------------------

PHP по умолчанию не отправляют настоящих писем при вызове функции ``mail()``.

Все исходящие e-mail'ы перехватываются и пишутся в папку ``app/log/sendmail``.

---------------------------------
Работа с несколькими приложениями
---------------------------------

См. комментарии в файле ``config/nginx/app.conf.example``.

------------------------
Поддержка xDebug для PHP
------------------------

См. комментарии в файлах ``config/php*/Dockerfile``.
