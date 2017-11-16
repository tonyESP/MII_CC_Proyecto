# *Provision* con chef-solo

## ¿Por que chef?
Al hacer los ejercicios del tema "Provisionamiento en infraestructuras virtuales" me ha gustado trabajar con el.

## Instalacion y uso de chef

1. Instalar chef.
>curl -L https://www.opscode.com/chef/install.sh | bash
2. Subir el contenido de este repositorio a:
>  ~/chef/
Podemos utilizar __SFTP__ para facilitar esta tarea.
El archivo __"README.MD"__ podemos obviarlo.
3. Ejecutamos chef-solo:
> sudo chef-solo -c ~/chef/solo.rb
4. Podemos ver el resultado:

![Resultado de ejecutar el provisionamiento](https://user-images.githubusercontent.com/6977775/32692916-21129682-c721-11e7-8866-3cb6eaf4da65.png)
