# CS-Cart Development Environment

## English manual

Docker-based development environment:

* PHP versions: 7.3, 7.4, 8.0, 8.1
* MySQL 5.7 database server.
* Nginx web server.

### Installation

* Install `git`, `docker` and `docker-compose`.
* Clone the environment repository:

```bash
git clone --recurse-submodules git@github.com:cscart/development-docker.git cs-cart-docker
cd cs-cart-docker
```

* If you do not have access to `https://github.com/cscart/cs-cart` repository, simple unpack the distribution archive into the ``app/www`` directory.
* Create own env file:
```bash
cp .env.example .env
```

* Run application containers:

```bash
docker-compose up -d
```

* Add new hosts files to /etc/hosts:

```
127.0.0.1 localhost php7.3.cs-cart.local php7.4.cs-cart.local php8.0.cs-cart.local php8.1.cs-cart.local
```

* Add via the [storefronts admin panel](http://php7.4.cs-cart.local:8100/admin.php?dispatch=companies.manage) new storefronts with the following URLs:
```
php7.3.cs-cart.local:8100
php8.0.cs-cart.local:8100
php8.1.cs-cart.local:8100
```

* After installation, CS-Cart is available at these links:

  * [http://localhost:8100](http://localhost:8100) - CS-Cart for PHP 7.4
  * [http://php7.3.cs-cart.local:8100](http://php7.3.cs-cart.local:8100) - CS-Cart for PHP 7.3 
  * [http://php8.0.cs-cart.local:8100](http://php8.0.cs-cart.local:8100) - CS-Cart for PHP 8.0
  * [http://php8.1.cs-cart.local:8100](http://php8.1.cs-cart.local:8100) - CS-Cart for PHP 8.1

## MySQL connection
        
* DB host: `localhost`
* Port: `3311`
* User: `root`
* Password: `root`

## Sending e-mails

PHP containers do not send actual e-mails when using the `mail()` function.

All sent emails will be caught and stored in the `app/log/sendmail` directory.

## Enabling xDebug for PHP containers

xDebug is already configured.

You can read about configuring PHPStorm to work with Docker and xDebug 3 in the [Debugging PHP](https://thecodingmachine.io/configuring-xdebug-phpstorm-docker) article.

## Русская инструкция

Среда для разработки на базе Docker:

* Версии PHP: 7.3, 7.4, 8.0, 8.1
* Сервер баз данных MySQL 5.7.
* Веб-сервер nginx.

### Установка

* Установите ``git``, ``docker`` and ``docker-compose``.
* Склонируйте репозиторий с окружением:

```bash
git clone --recurse-submodules git@github.com:cscart/development-docker.git cs-cart-docker
cd cs-cart-docker
```

* Если у вас нет доступа к `https://github.com/cscart/cs-cart` репозиторию, просто скачайте и распакуйте ваш CS-Cart в папку `app/www`.
* 
* Создайте свой env-файл:
```bash
cp .env.example .env
```
* Запустите контейнеры docker командой:

```bash
docker-compose up -d
```

* Чтобы работать с версиями, отличными от PHP 7.4, добавьте в /etc/hosts:

```
127.0.0.1 localhost php7.3.cs-cart.local php7.4.cs-cart.local php8.0.cs-cart.local php8.1.cs-cart.local
```

* И через [админку витрин](http://php7.4.cs-cart.local:8100/admin.php?dispatch=companies.manage) добавьте новые витрины со следующими адресами:
```
php7.3.cs-cart.local:8100
php8.0.cs-cart.local:8100
php8.1.cs-cart.local:8100
```

* После установки CS-Cart должен быть доступен по следующим адресам:

  * [http://localhost:8100](http://localhost:8100) - CS-Cart для PHP 7.4
  * [http://php7.3.cs-cart.local:8100](http://php7.3.cs-cart.local:8100) - CS-Cart для PHP 7.3
  * [http://php8.0.cs-cart.local:8100](http://php8.0.cs-cart.local:8100) - CS-Cart для PHP 8.0
  * [http://php8.1.cs-cart.local:8100](http://php8.1.cs-cart.local:8100) - CS-Cart для PHP 8.1


## Подключение к MySQL
К БД можно подключиться любым удобным клиентом MySQL:
* DB хост: `localhost`
* Порт: `3311`
* Имя БД: `cscart`
* Пользователь: `cscart`
* Пароль: `cscart`
* Пароль root: `developer`

## Отправка e-mail'ов

PHP по умолчанию не отправляют настоящих писем при вызове функции `mail()`.

Все исходящие e-mail'ы перехватываются и пишутся в папку `app/log/sendmail`.

## Поддержка xDebug для PHP

xDebug уже настроен для использования в контейнерах.

О настройке PHPStorm для работы с Docker и xDebug можно прочитать в статье [PHP: Настраиваем отладку](https://handynotes.ru/2020/12/phpstorm-php-8-docker-xdebug-3.html).
