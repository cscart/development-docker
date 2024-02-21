*******************************
CS-Cart Development Environment
*******************************

.. contents::
   :local:

==============
English manual
==============

Docker-based development environment:

* PHP versions: 8.2, 8.1, 8.0, 7.4 and 7.3.
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

----------------
MySQL connection
----------------
        
* DB host: mysql5.7.
* User: root.
* Password: root. 


-----------------------------------
Working with different PHP versions
-----------------------------------

PHP 7.4 is used by default.

To use the specific PHP version for your requests, add the following prefix to the domain you request:

* ``php7.3.`` for PHP 7.3.
* ``php7.4.`` for PHP 7.4.
* ``php8.0.`` for PHP 8.0.
* ``php8.1.`` for PHP 8.1.
* ``php8.2.`` for PHP 8.2.

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

------------------------
Configuring the Docker subnet
------------------------

Docker-compose creates a subnet with addresses by default 172.18.[0-255].[0-255].

If you run docker locally with a default subnet, then resources using the same addresses will be unavailable - the response will be returned by the local subnet, not the required resource.

To fix the problem, you need to change the address of the docker subnet.

In the docker-compose file.bml shows an example of replacing addresses with 10.10.[0-255].[0-255].

Uncomment the lines in docker-compose.yml and run the following commands:

    .. code-block:: bash

        $ docker network rm $(docker network ls -q)
        $ docker-compose down && docker-compose up -d

==================
Русская инструкция
==================

Среда для разработки на базе Docker:

* Версии PHP: 8.2, 8.1, 8.0, 7.4 и 7.3.
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

-------------------
Подключение к MySQL
-------------------
        
* Хост БД: mysql5.7.
* Пользователь: root.
* Пароль: root.

-----------------------------
Работа с разными версиями PHP
-----------------------------

По умолчанию используется PHP 7.4.

Чтобы явно указать версию PHP для конкретного запроса, добавьте к домену следующую приставку:

* ``php7.3.`` для PHP 7.3.
* ``php7.4.`` для PHP 7.4.
* ``php8.0.`` для PHP 8.0.
* ``php8.1.`` для PHP 8.1.
* ``php8.2.`` для PHP 8.2.

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

------------------------
Настройка подсети докера
------------------------

Docker-compose по умолчанию создаёт подсеть с адресами 172.18.[0-255].[0-255]. 

Если локально запустить докер с дефолтной подсетью, то ресурсы, использующие такие же адреса, будут недоступны - ответ возвращать будет локальная подсеть, а не требуемый ресурс.

Чтобы исправить проблему, нужно изменить адрес подсети докера. 

В файле docker-compose.yml приведён пример замены адресов на 10.10.[0-255].[0-255].

Раскомментируйте строки в docker-compose.yml и выполните следующие команды:

    .. code-block:: bash

        $ docker network rm $(docker network ls -q)
        $ docker-compose down && docker-compose up -d
