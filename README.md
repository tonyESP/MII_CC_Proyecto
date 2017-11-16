# Preguntas Localizadas “Prelo”
Descripción del problema
Juego geolocalizado basado en resolver preguntas que otros usuarios “dejaran caer” sobre el mapa.
## Solución propuesta
Desarrollar un juego móvil en el cual al ir andando por la calle podamos ver y resolver preguntas o acertijos que otros usuarios han planteado. Esto proporcionara puntos que nos haran subir en diferentes rankings.
## Introducción descriptiva del proyecto
El proyecto consta de:
* Servidor de login. Posiblemente sea un servidor o servicio compartido. En php o pyton.
* Servidor de geo-etiquetas. Se probara el lenguaje de programacion Phyton.
* Servidor de juego, una api PHP.
* Base de datos Mysql.
* Aplicación Android.

# Arquitectura
Se utilizará una arquitectura basada en microservicios.

# Provisionamiento
Se ha decidido aprovisionar el servidor utilizando chef-solo.
Se provisionara: php, mysql, apache2, pyton3 y git.
Podemos encontrar una guia en:
https://github.com/tonyESP/MII_CC_Proyecto/blob/master/provision/chef-solo/README.md
# Licencia
Proyecto bajo licencia [GNU GLP V3](https://github.com/tonyESP/MII_CC_Proyecto/blob/master/LICENSE)
