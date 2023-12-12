## DOCKER BÁSICO (PHP e MYSQL)

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

index.php<br />
<b>
<?php phpinfo(); ?>
</b>


Dockerfile:<br />
Arquivo para criar imagens<br />
<b>
FROM php:7.2-apache<br />
RUN docker-php-ext-install mysqli<br />
RUN a2enmod rewrite<br />
</b>

docker-compose.yml<br />
Como vai utilizar essa imagem, arquivo do orquestrador, pode rodar o dockerfile ou pode rodar ele através docker-compose, organizará todos os containers<br /><br />

<b>
version: '3.3'<br />
<br />
services:<br />
  php:<br />
    build: .<br />
    ports:<br />
    - "80:80"<br />
    - "443:443"<br />
    volumes:<br />
    - ./www/:/var/www/html<br />
    links:<br />
    - db<br />
<br />
  db:<br />
    image: mysql:5.7<br />
    volumes:<br />
    - /var/lib/mysql<br />
    environment:<br />
    - MYSQL_ROOT_PASSWORD=myrootpass<br />
    - MYSQL_DATABASE=mydatabase<br />
</b>
<br /><br />

Na pasta raiz
```sh
docker-compose -f "docker-compose.yml" up -d --build
```

Botão direito mouse (Attach Shell)
```sh
mysql -u root -p
```

