# Orquestación del proyecto de preguntas localizadas “Prelo”

## Definición de la arquitectura.

Se van a levantar 2 máquinas virtuales. La primera "m1", contendrá los servidores rest. La segunda "m2", contendrá las bases de datos. 
El sistema operativo elegido para "m1": CentOS:7.3, ya que se han consultado benchmarks entre debían, centos y Ubuntu como servidores LAMP y centos salía ganando. 
El sistema operativo elegido para "m2": openSUSE Leap 42.2, porque al realizar una prueba de mostrar 20.000 registros de una base de datos en MySQL de prueba, entre openSUSE y centos 7.3, openSUSE tardo unos segundos menos.

### Descarguemos vagrant.

En el siguiente [enlace](https://www.vagrantup.com/docs/installation/) encontramos vagrant para nuestro sistema operativo. Es un archivo ".deb" por lo que lo instalaremos con la orden `$ dpkg -i nombre_archivo.deb`. Para este proyecto se ha decidido utilizar la última versión de vagrant, ya que es compatible con azure, es decir _Vagrant 2.0.1_.

### Utilizamos Vagrant

Solo tenemos que seguir los siguientes pasos:
- Necesitamos el cliente [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) el cual utilizamos en la sección de automatización, podemos consultar el siguiente [enlace](https://github.com/tonyESP/MII_CC_Proyecto/tree/master/automatizacion). 
- Ejecutamos el cliente `az login` y nos logeamos.
- Utilizamos el comando `az ad sp create-for-rbac` para crear un _Azure Active Directory Application_ con acceso al _Azure Resource Manager_. De aquí nos interesan los datos: *tenant*, *appId* y *password* que serán los que deberemos introducir en variables de entorno para ejecutar correctamente el archivo "Vagrantfile", como veremos más adelante.
- Finalmente ejecutamos `az account list --query "[?isDefault].id" -o tsv` para obtener la _Subscription Id_.
- The values `tenant`, `appId` and `password` map to the configuration values 
`azure.tenant_id`, `azure.client_id` and `azure.client_secret` in your Vagrant file or environment variables.

### El archivo vagrantFile.

```ruby
#Declaracion de variables
az_tenant_id = ENV['AZURE_TENANT_ID']
az_client_id = ENV['AZURE_CLIENT_ID']
az_client_secret = ENV['AZURE_CLIENT_SECRET']
az_subscription_id = ENV['AZURE_SUBSCRIPTION_ID']
ssh_file = '~/.ssh/id_rsa'

Vagrant.configure("2") do |config|
  config.vm.define "m1" do |m1|
    m1.vm.box = 'azure'

    m1.ssh.private_key_path = ssh_file

    m1.vm.provider :azure do |azure, override|
      #Set a territory
      azure.location="westeurope"

      azure.resource_group_name="Proyecto_VNET"
      azure.vm_name="m1"

      azure.vm_image_urn="OpenLogic:CentOS:7.3:latest"

      azure.tenant_id = az_tenant_id
      azure.client_id = az_client_id
      azure.client_secret = az_client_secret
      azure.subscription_id = az_subscription_id
    end
    config.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = "proyecto"
    end
  end 

  config.vm.define "m2" do |m2|
    m2.vm.box = 'azure'

    m2.ssh.private_key_path = ssh_file

    m2.vm.provider :azure do |azure, override|
      #Set a territory
      azure.location="westeurope"

      azure.resource_group_name="Proyecto_VNET"
      azure.vm_name="m2"

      azure.vm_image_urn="SUSE:openSUSE-Leap:42.2:latest"

      azure.tenant_id = az_tenant_id
      azure.client_id = az_client_id
      azure.client_secret = az_client_secret
      azure.subscription_id = az_subscription_id
    end
  end
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "proyecto"
  end
end
```

### Ejecutamos vagrant.

Solo queda ejecutar el archivo Vagrantfile y comprobar que todo está correcto. Para poder ejecutar correctamente la orquestación ejecutemos esta secuencia de comandos. Siendo el último, `vagrant up` el encargado de levantar las máquinas virtuales de forma remota.
```shell
$ vagrant box add azure https://github.com/azure/vagrant-azure/raw/v2.0/dummy.box --provider azure
$ vagrant plugin install vagrant-azure —plugin-version '2.0.0.pre6'
$ vagrant up --no-parallel
```

### Provisión.

Tal y como se ha hecho anteriormente, se utiliza Chef-solo para el provisionamiento. Más información en este [enlace](https://github.com/tonyESP/MII_CC_Proyecto/tree/master/provision/chef-solo)


![ejecucionvagrantfile](https://user-images.githubusercontent.com/6977775/34085887-deca85c2-e396-11e7-8822-a47878df7a58.PNG)