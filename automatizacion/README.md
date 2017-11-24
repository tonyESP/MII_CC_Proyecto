# Despliege.
Se ha decidido utilizar Azure para realizar el despliegue del proyecto. Veamos en este documento como hacerlo.
## Instalación de AZURE CLI
```
#!/bin/bash
#instalamos ansible
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install ansible

#instalamos jq (hara falta para el despliege)
> sudo apt-get install jq

#instalar pyton
> sudo apt-get install python

#instalamos __azure!__ **CLI!!**
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
     sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893
sudo apt-get install apt-transport-https
sudo apt-get update && sudo apt-get install azure-cli
```

## Utilizamos AZURE CLI para realizar el despliegue
Nos logeamos en azure con:
> az login
Nos dirá que entremos en una web, y pongamos una cadena de caracteres. Lo hacemos y estaremos logeados.
Ejecutamos el script [acopio.sh]( https://github.com/tonyESP/MII_CC_Proyecto/blob/master/acopio.sh).
# Descripción de acopio.sh
En él se crea un grupo de recursos:
> az group create --name CCTony --location eastus
Creamos la máquina virtual y guardamos su ip en la variable ipAddress.  La máquina se crea con los recursos mínimos, con nombre remoteAzureTony y con sistema operativo ubuntuLTS
> ipAddress=$(az vm create -g CCTony -n remoteAzureTony --image UbuntuLTS --generate-ssh-keys | jq -r '.publicIpAddress')

Si todo ha ido bien, mostrara los datos de la máquina y su ip.
```
echo Datos de la maquina creada:
echo -name : remoteAzureTony
echo -ip : $ipAddress
echo -------------------------
```
Es momento de abrir los puertos usuales.
```
az network nsg create --resource-group CCTony --location eastus --name remoteAzureTonyNSG
az network nsg rule create --resource-group CCTony --nsg-name remoteAzureTonyNSG --name remoteAzureTonyNSGRule80 --protocol tcp --priority 1000 --destination-port-range 80
az network nsg rule create --resource-group CCTony --nsg-name remoteAzureTonyNSG --name remoteAzureTonyNSGRule20 --protocol tcp --priority 999 --destination-port-range 20
az network nsg rule create --resource-group CCTony --nsg-name remoteAzureTonyNSG --name remoteAzureTonyNSGRule22 --protocol tcp --priority 998 --destination-port-range 22
```
Por ultimo mostramos la información para realizar el provisionamiento:
> echo https://github.com/tonyESP/MII_CC_Proyecto/tree/master/provision/chef-solo.
