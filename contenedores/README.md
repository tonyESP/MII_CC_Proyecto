## Crear el archivo Dockerfile.

El Archivo Dokerfile, se deberemos ubicarlo en la raíz del repositorio. 

```Dockerfile
FROM debian:stable
MAINTAINER Antonio Manuel Jiménez Martínez <homomagnus@gmail.com>

RUN apt-get update && apt-get -y install apache2 && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN /usr/sbin/a2dismod 'mpm_*' && /usr/sbin/a2enmod mpm_prefork
RUN apt-get update && apt-get -y install php php-mysql libapache2-mod-php && apt-get clean && rm -r /var/lib/apt/lists/*

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN /usr/sbin/a2ensite default-ssl
RUN /usr/sbin/a2enmod ssl

EXPOSE 80
EXPOSE 443

RUN rm /var/www/html/index.html
COPY contenedores/index.php /var/www/html/
COPY contenedores/index.php /var/www/html/status/

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
```

## Enlazar Github con Dockerhub

- Deberemos crearnos una cuenta en docker hub.
- Crear un nuevo repositorio desde el creador automático.

![Dockerhub](https://user-images.githubusercontent.com/6977775/34750542-d8df7de8-f5a7-11e7-9119-7cd6758eea47.png)

- Elegir el repositorio de git del proyecto en cuestion (en este caso el de la asignatura).

- "Activar" la supervision del repositorio. En la pestaña, "Build Settings" elegimos la rama del proyecto donde tengamos el archivo "Dockerfile" en este caso, la rama master. Y pulsamos sobre el boton "Trigger". Finalmente, sobre "Save Changes".


![Activamos la supervision.](https://user-images.githubusercontent.com/6977775/34750700-d357206e-f5a8-11e7-9cfd-14bd1fa4ea86.png)

- Esperamos hasta tener todo listo. Lo observaremos en la pestaña "Build Details". Si hemos cometido algún error, no importa, lo corregimos en github y dockerhub se actualiza solo.

![imagen](https://user-images.githubusercontent.com/6977775/34750773-3de09f5a-f5a9-11e7-98b0-8ac7ec82092a.png)

## Crear el contenedor en Azure

Deberemos ejecutar los siguientes comandos:
```bash
# creamos un nombre de usuario / contraseña
az webapp deployment user set --user-name tonyesp --password $key

# Creamos un grupo de recursos
az group create --name MII_CC --location "West Europe"

# Creamos un plan, (con la maquina más pequeña de azure, la S1)
az appservice plan create --name MII_CC_Plan --resource-group MII_CC --sku S1 --is-linux

# Creamos el contenedor enlazándolo con el dockerhub correspondiente.
az webapp create --resource-group MII_CC --plan MII_CC_Plan --name servicioTony --deployment-container-image-name tonyesp/dockertesting
```

Veamos el resultado:
![imagen](https://user-images.githubusercontent.com/6977775/34750968-353cd390-f5aa-11e7-9692-74fd908701f6.png)
![imagen](https://user-images.githubusercontent.com/6977775/34751009-76d64d90-f5aa-11e7-87cd-9ea6c7f8e291.png)
