## DOCKER BÁSICO

https://www.youtube.com/watch?v=97jWpWp4Pnc

https://hub.docker.com/


```sh
mkdir www
```
<br />
Criar 3 arquivos (pasta raiz, no GIT BASH):<br />

```sh
touch Dockerfile docker-compose.yml www/index.php
```

index.php

```sh
<?php phpinfo(); ?>
```


Dockerfile:<br />
Arquivo para criar imagens<br />

```sh
FROM php:7.2-apache
RUN docker-php-ext-install mysqli
RUN a2enmod rewrite
```


<b>Como vai utilizar essa imagem, arquivo do orquestrador, pode rodar o dockerfile ou pode rodar ele através docker-compose, organizará todos os containers</b><br />

<b>docker-compose.yml</b><br />

### (PHP e MYSQL)
* Na pasta raiz (/basic/php_mysql/)

```sh
docker-compose -f "docker-compose.yml" up -d --build
```

```sh
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
```

http://localhost/


### (WORDPRESS e PHPMYADMIN)
* Na pasta raiz (/basic/wordpress_phpmyadmin/)

```sh
docker-compose -f "docker-compose.yml" up -d --build
```

```sh
version: '3.3'

services:
   wordpress_db:
     image: mysql:5.7
     volumes:
       - db_data:/var/lib/mysql
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: myrootpass
       MYSQL_DATABASE: wordpress
       MYSQL_USER: wordpress
       MYSQL_PASSWORD: wordpress

   wordpress:
     depends_on:
       - wordpress_db
     image: wordpress:latest
     ports:
       - "80:80"
       - "443:443"
     restart: always
     environment:
       WORDPRESS_DB_HOST: wordpress_db:3306
       WORDPRESS_DB_USER: wordpress
       WORDPRESS_DB_PASSWORD: wordpress

   phpmyadmin:
    depends_on:
      - wordpress_db
    image: phpmyadmin/phpmyadmin:latest
    restart: always
    ports:
      - 88:80
    environment:
      PMA_HOST: wordpress_db:3306
      MYSQL_ROOT_PASSWORD: myrootpass

volumes:
    db_data:
```

Na pasta raiz

```sh
docker-compose -f "docker-compose.yml" up -d --build
```


Wordpress: http://localhost/

PhpMyAdmin: http://localhost:88/ <br />
Usuário: wordpress <br />
Senha: wordpress<br />

<br /><br />

Botão direito mouse (Attach Shell)
```sh
mysql -u root -p
```

