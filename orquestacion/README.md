# Orquestación del proyecto de preguntas localizadas “Prelo”

## Definición de la arquitectura.

Se van a levantar 2 máquinas virtuales. La primera "remoteAzureTony
", contendrá los servidores rest. La segunda "remoteAzureTonyBD
", contendrá las bases de datos. 
El sistema operativo elegido para ambas es: Ubuntu LTS, ya que se han consultado benchmarks entre debían, centos y Ubuntu como servidores LAMP y son todos similares. Así que se Utilizará Ubuntu LTS 16.4 por afinidad con el mismo.

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
Vagrant.configure("2") do |config|
  config.vm.define "remoteAzureTony" do |serviceObject|
    serviceObject.vm.box = 'azure'

    serviceObject.ssh.private_key_path = '~/.ssh/id_rsa'

    serviceObject.vm.provider :azure do |azure, override|
      #Set a territory
      azure.location="westeurope"

      azure.resource_group_name="remoteAzureTonyVNET"
      azure.vm_name="remoteAzureTony"

      azure.vm_image_urn="Canonical:UbuntuServer:16.04-LTS:latest"

      azure.tenant_id = ENV['AZURE_TENANT_ID']
      azure.client_id = ENV['AZURE_CLIENT_ID']
      azure.client_secret = ENV['AZURE_CLIENT_SECRET']
      azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']
    end
  end

  config.vm.define "remoteAzureTonyBD" do |serviceImage|
    serviceImage.vm.box = 'azure'

    serviceImage.ssh.private_key_path = '~/.ssh/id_rsa'

    serviceImage.vm.provider :azure do |azure, override|
      #Set a territory
      azure.location="westeurope"

      azure.resource_group_name="remoteAzureTonyVNET"
      azure.vm_name="remoteAzureTonyBD"

      azure.vm_image_urn="Canonical:UbuntuServer:16.04-LTS:latest"

      azure.tenant_id = ENV['AZURE_TENANT_ID']
      azure.client_id = ENV['AZURE_CLIENT_ID']
      azure.client_secret = ENV['AZURE_CLIENT_SECRET']
      azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']
    end
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

Tal y como se ha hecho anteriormente, para provisionar las máquinas virtuales se deberá. Más información en este [enlace](https://github.com/tonyESP/MII_CC_Proyecto/tree/master/provision/chef-solo)
