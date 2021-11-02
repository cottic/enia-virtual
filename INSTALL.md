# ENIA VIRTUAL INSTALL

## Sistema principal

### Servidor de mensajeria instantánea MATRIX 
Documentación: https://matrix.org/docs/spec/

Despliegue: [docker-compose.yaml](https://github.com/cottic/enia-virtual/blob/master/docker-compose.yaml)

Procedimiento simplificado de configuración en base a:
- copiar los archivos de configuración (homeserver.yaml, etc a /synapse-admin)
- crear la base de datos y el usaurio en POSTGREST en refencia al archivo de configuración homeserver.yaml)

> La base de datos PostgreSQL es de alta disponibilidad

### Bridge Telegram <--> Matrix
Repositorio: https://github.com/mautrix/telegram

Despliegue:
```yaml
version: "3.3"
services:
  mautrix-telegram:
      container_name: mautrix-telegram
      image: dock.mau.dev/tulir/mautrix-telegram:v0.7.0
      restart: unless-stopped
      ports:
      - "29317:29317"
      volumes:
      - .:/data
```

Procedimiento simplificado de configuración en base a:
- Copar los archivos de configuracion (config.yaml y registration.yaml)

### Servicio de bot
Despliegue:
```yaml
version: '3.3'
services:
  maubot:
    image: dock.mau.dev/maubot/maubot:169aece027246d46c1b29bcb7e76e74dd59d0609-standalone
    ports:
      - "29316:29316"
    volumes:
      - $PWD:/data:z|
```
Procedimiento simplificado de configuración en base a:
- Copar los archivos de configuracion (config.yaml)

Documentación: https://matrix.org/docs/projects/sdk/maubot/

Después de desplegar configurar maubot, ingresar en la interfaz de administración web a traves de http://NOMBREDEDOMINIO.COM:29316/_matrix/maubot.

El inicio de sesión en la interfaz se habilita desde la configuración del archivo config.yaml.
En el mismo incorporar al usuario enia:
```yaml
#List of administrator users. Plaintext passwords will be bcrypted on startup. Set empty password
# to prevent normal login. Root is a special user that can't have a password and will always exist.
admins:
  root: ''
  enia: 'password'
```

El usuario root no puede tener una contraseña, por lo que se debe utilizar un nombre de usuario diferente para iniciar sesión.

#### Subiendo Plugins
El primer paso es cargar el plugin de eniabot

https://github.com/cottic/eniabot/raw/main/cottic2.maubot.eniabot-1.1.65.mbp

Una vez que tenga el archivo .mbp, haga clic en el botón + junto al encabezado "Plugins" y suelte el archivo .mbp en el cuadro de carga.

#### Creando Clients
Para crear un cliente, haga clic en el botón + junto al encabezado "Clients" y complete el formulario.

El menú desplegable de HomeServer obtiene valores de la sección registration_secrets del archivo config.yaml

```yaml
registration_secrets:
   NOMBREDEDOMINIO.COM:
     # Client-server API URL
     url: https://NOMBREDEDOMINIO.COM
     # registration_shared_secret from synapse config
     secret: ***************************************
```

#### Creando Instances
Las instancias son la forma en que los plugins se vinculan a los clientes. Después de haber subido un plugin y creado un cliente, simplemente haga clic en el botón + junto al encabezado "Instancias", elija su cliente y complemento en los menús desplegables correspondientes, designe un ID de instancia y haga clic en "Crear".

Se deben crear las siguientes instancias:
@bot:matrix.codigoi.com.ar
@enia:matrix.codigoi.com.ar

### API Tableros, API datos extra usaurios, Bridge WhatsApp y LOG
PHP_VERSION=7.3

Despliegue:
```yaml
version: '3'
services:
    web:
        image: nginx:alpine
        volumes:
            - "./etc/nginx/default.conf:/etc/nginx/conf.d/default.conf"
            - "./etc/ssl:/etc/ssl"
            - "./web:/var/www/html"
            - "./etc/nginx/default.template.conf:/etc/nginx/conf.d/default.template"
        ports:
            - "8000:80"
            - "3000:443"
        environment:
            - NGINX_HOST=${NGINX_HOST}
        command: /bin/sh -c "envsubst '$$NGINX_HOST' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
        restart: always
        depends_on:
            - php
            - mysqldb
    php:
        image: nanoninja/php-fpm:${PHP_VERSION}
        restart: always
        volumes:
            - "./etc/php/php.ini:/usr/local/etc/php/conf.d/php.ini"
            - "./web:/var/www/html"
    composer:
        image: "composer"
        volumes:
            - "./web/app:/app"
        command: install
    myadmin:
        image: phpmyadmin/phpmyadmin
        container_name: phpmyadmin
        ports:
            - "8080:80"
        environment:
            - PMA_ARBITRARY=1
            - PMA_HOST=${MYSQL_HOST}
        restart: always
        depends_on:
            - mysqldb
    mysqldb:
        image: mysql:${MYSQL_VERSION}
        container_name: ${MYSQL_HOST}
        restart: always
        env_file:
            - ".env"
        environment:
            - MYSQL_DATABASE=${MYSQL_DATABASE}
            - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
            - MYSQL_USER=${MYSQL_USER}
            - MYSQL_PASSWORD=${MYSQL_PASSWORD}
        ports:
            - "8989:3306"
        volumes:
            - "./data/db/mysql:/var/lib/mysql"
```

#### Script de creación de bases de datos

```sql
CREATE DATABASE c1tableros_enia;

GRANT ALL PRIVILEGES ON c1tableros_enia.* TO 'c1tableros_enia'@localhost IDENTIFIED BY 'tablerosENIA2020';

CREATE TABLE `users` (
  `id` varchar(200) CHARACTER SET utf8 NOT NULL,
  `content` varchar(2000) CHARACTER SET utf8 NOT NULL,
  `departament` varchar(256) NOT NULL,
  `school` varchar(256) NOT NULL,
  `workcalendars` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
```

**Repositorio**: https://github.com/cottic/enia-api-tableros

### Panel de administración de usuarios

1. Requerimientos: git, yarn, nodejs
2. Bajarse el cddigo: git clone https://github.com/cottic/synapse-admin.git
3. Ir al directorio: cd synapse-admin
4. Bajarse las dependencias: yarn install
5. Compilar la app: yarn build
6. Copiar al directoria de publicación synapse-admin/build/

**Repositorio:** https://github.com/cottic/synapse-admin

### Gateway de notificaciones
**Repositorio:** https://gitlab.com/famedly/libraries/famedly-push-gateway.git

```
cd famedly-push-gateway
npm install

Editar config.json y los detalles de los mensajes de famedlyPushGateway.js.

Run it with
```
node famedlyPushGateway.js


### Cliente de mensajería
**Repositorio:** https://github.com/cottic/enia-virtual

#### Despliegue del código en base a los proyectos en flutter:
 - WEB
   https://flutter.dev/docs/deployment/web

 - APP Android
   https://flutter.dev/docs/deployment/android

 - APP IOS
   https://flutter.dev/docs/deployment/ios

### ENV FILE


```
HOMESERVER='NOMBREDEDOMINIO.COM';
APISERVER='NOMBREDEDOMINIO.COM';
MAINGROUP='!HYkJsTHlawQWyzwLYK:NOMBREDEDOMINIO.COM';
SECONDGROUP='!POwBopuroioZAsSpNy:NOMBREDEDOMINIO.COM';
VERSION='Versión 2.0.10 (25/10/2021)';
```

## Integración a redes de mensajería externa

### WhatsAPP API
**Documentacion:** https://developers.facebook.com/docs/whatsapp/?locale=es_ES

**Webhook para setear URL de envio de mensajes:** https://docs.360dialog.com/whatsapp-api/whatsapp-api/webhook

### Telegram API
**Documentación:** https://core.telegram.org/bots/a



