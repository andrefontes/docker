https://www.youtube.com/watch?v=97jWpWp4Pnc

https://hub.docker.com/


mkdir www

Criar 3 arquivos (pasta raiz, no GIT BASH):
```sh
touch Dockerfile docker-compose.yml www/index.php
```

index.php
<?php phpinfo(); ?>


Dockerfile:
Arquivo para criar imagens
FROM php:7.2-apache
RUN docker-php-ext-install mysqli
RUN a2enmod rewrite

docker-compose.yml
Como vai utilizar essa imagem, arquivo do orquestrador, pode rodar o dockerfile ou pode rodar ele através docker-compose, organizará todos os containers
version: '3.3'

services:
  php:
    build: .
    ports:
    - "80:80"
    - "443:443"
    volumes:
    - ./www/:/var/www/html
    links:
    - db

  db:
    image: mysql:5.7
    volumes:
    - /var/lib/mysql
    environment:
    - MYSQL_ROOT_PASSWORD=myrootpass
    - MYSQL_DATABASE=mydatabase

Na pasta raiz
```sh
docker-compose -f "docker-compose.yml" up -d --build
```

Botao direito mouse (Attach Shell)
```sh
mysql -u root -p
```

