# testingDocker-Compose

Pasos para crear la maquina en azure y desplegar el docker compose del repositorio: 
 - az login
 - lanzar el script "setup_vm_azure". No introducir ninguna letra mayuscula ni caracter extraño. La contraseña debe tener mas de 6 caracteres con: mayusculas, minusculas y numeros.
 - anotamos el DNS que nos proporciona como ultima linea el script. **Nota:** estos campos los deberemos guardar para mas adelante.
 - conectarnos por ssh:
``` bash
ssh azureuser@mypublicdns.eastus.cloudapp.azure.com
docker-compose --version
```
 - Verificar que tenemos instalado docker-compose en la 
version 1.18.0".
 - Clonamos el repositorio y ejecutamos __$ docker-compose up__
 - Acceder al servicio mediante el navegador "ip:3000/apidoc". Se mostrará la la documentación de la api rest.

Veamos como funciona el framework que se ha instalado:
> ![seleccion_090](https://user-images.githubusercontent.com/6977775/35769610-c8223594-090d-11e8-9109-54d76721e2e3.png)


Apuntes: [enlace.](http://jj.github.io/CC/documentos/temas/Contenedores)
Guia node: [enlace.](https://nodejs.org/en/docs/guides/nodejs-docker-webapp)
Guia docker-compose: [enlace.](https://jsitech1.gitbooks.io/meet-docker/content/docker_compose.html)
Guia docker-compose en azure: [enlace.](https://docs.microsoft.com/es-es/azure/virtual-machines/linux/docker-compose-quickstart)
