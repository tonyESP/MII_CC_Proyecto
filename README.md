# Preguntas Localizadas “Prelo”

## Descripción del problema 
Juego geolocalizado basado en resolver preguntas que otros usuarios “dejaran caer” sobre el mapa.

## Solución propuesta

Desarrollar un juego móvil en el cual al ir andando por la calle podamos ver y resolver preguntas o acertijos que otros usuarios han planteado. Esto proporcionara puntos que nos haran subir en diferentes rankings.

## Introducción descriptiva del proyecto

El proyecto consta de:
1. Servidor de login. Posiblemente sea un servidor o servicio compartido. En php o pyton.
2. Servidor de geo-etiquetas. Se probara el lenguaje de programacion Phyton.
3. Servidor de juego, una api PHP.
4. Base de datos Mysql.
5. Aplicación Android.

# Arquitectura

Se utilizará una arquitectura basada en microservicios.

# Despliege

Para el despliege del proyecto se ha decidido utilizar una maquina virtual en Azure, con los recuros mas modestos. La imagen elegida es la de “UbuntuLTS”. Se desplegara en la región de azure “eastus”.

Se ha decidido utilzar “UbuntuLTS” o “Ubuntu Server Con Soporte Tecnico Extendido” sobre otras imágenes de sistemas operativos porque ya se ha trabajado en ella con anterioridad. Además, dispone de una amplia documentación, la mayoría mantenida por su gran comunidad.

Para desplegar de manera sencilla se recomienda el uso de este [script]( https://github.com/tonyESP/MII_CC_Proyecto/blob/master/acopio.sh).

La documentación de la automatización se puede encontrar en este [enlace](https://github.com/tonyESP/MII_CC_Proyecto/blob/master/automatizacion/README.md).

Despliegue:52.170.116.3

# Provisionamiento

Se ha decidido aprovisionar el servidor utilizando chef-solo.
Se provisionara: php, mysql, apache2, pyton3 y git.
Podemos encontrar una guia en:
https://github.com/tonyESP/MII_CC_Proyecto/blob/master/provision/chef-solo/README.md

# Licencia

Proyecto bajo licencia [GNU GLP V3](https://github.com/tonyESP/MII_CC_Proyecto/blob/master/LICENSE)

### Web del proyecto:

https://tonyesp.github.io/MII_CC_Proyecto/
