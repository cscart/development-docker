*******************************
CS-Cart Development Environment
*******************************

.. contents::
   :local:

==============
English manual
==============

Docker-based development environment:

* PHP versions: 8.0, 7.4, 7.3 and 5.6.
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

        $ mkdir -p app/www

#. Clone CS-Cart repository or unpack the distribution archive into the ``app/www`` directory.
#. Enable the default application config for nginx:

    .. code-block:: bash

        $ cp config/nginx/app.conf.example config/nginx/app.conf

#. Run application containers:

    .. code-block:: bash

        $ make -f Makefile run

------------------------------------------------
Connecting to a database in a docker environment
------------------------------------------------

#. First, you need to enter the container to perform operations from it.
#. Take the name of the container from the Makefile (for example, "cli-7.4").
#. Execute the command:
      .. code block :: bash

          $ sudo make <container name>

#. Connect to the database using the mysql console client:
      .. code block :: bash

          $ mysql -hmysql5.7 -uroot -proot 

-----------------------------------
Working with different PHP versions
-----------------------------------

PHP 7.4 is used by default.

To use the specific PHP version for your requests, add the following prefix to the domain you request:

* ``php5.6.`` for PHP 5.6.
* ``php7.3.`` for PHP 7.3.
* ``php7.4.`` for PHP 7.4.
* ``php8.0.`` for PHP 8.0.

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

xDebug 3 is already configured for PHP7 and PHP8 containers. All you have to do is to uncomment the extension installation in the ``config/php*/Dockerfile`` files.

You can read about configuring PHPStorm to work with Docker and xDebug 3 in the `"Debugging PHP" <https://thecodingmachine.io/configuring-xdebug-phpstorm-docker>`_ article.

==================
Русская инструкция
==================

Среда для разработки на базе Docker:

* Версии PHP: 8.0, 7.4, 7.3 и 5.6.
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

--------------------------------------------
Подключение к базе данных в docker-окружении
--------------------------------------------

#. Для начала нужно войти в контейнер для выполнения операций из него.
#. Имя контейнера берём из Makefile (например, "cli-7.4").
#. Выполняем команду:
    .. code-block:: bash

        $ sudo make <имя контейнера>

#. Подключаемся к БД с помощью консольного клиента mysql:
    .. code-block:: bash

        $ mysql -hmysql5.7 -uroot -proot

-----------------------------
Работа с разными версиями PHP
-----------------------------

По умолчанию используется PHP 7.4.

Чтобы явно указать версию PHP для конкретного запроса, добавьте к домену следующую приставку:

* ``php5.6.`` для PHP 5.6.
* ``php7.3.`` для PHP 7.3.
* ``php7.4.`` для PHP 7.4.
* ``php8.0.`` для PHP 8.0.

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

xDebug уже настроен для использования в контейнерах с PHP7 и PHP8. Для его включения нужно раскомментировать установку модуля в ``config/php*/Dockerfile``.

О настройке PHPStorm для работы с Docker и xDebug 3 можно прочитать в статье `"PHP: Настраиваем отладку" <https://handynotes.ru/2020/12/phpstorm-php-8-docker-xdebug-3.html>`_.
