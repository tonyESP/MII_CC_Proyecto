#!/bin/bash

# Crea el grupo de recursos
az group create --name CCTony --location eastus
#az group create --name group1 --location southcentralus

# Crea la máquina virtual en el grupo de recursos y gruarda la salida con la 
#  información de la máquina en el archivo tmpconexionfile
#az vm create --resource-group CCTony --name remoteAzureTony --image UbuntuLTS --generate-ssh-keys > tmpconexionfile
ipAddress=$(az vm create -g CCTony -n remoteAzureTony --image UbuntuLTS --generate-ssh-keys | jq -r '.publicIpAddress')

echo Maquina virtual creada
echo -name : remoteAzureTony
echo -ip : $ipAddress
echo -------------------------

# Abrimos los puertos usuales
az network nsg create --resource-group CCTony --location eastus --name remoteAzureTonyNSG
az network nsg rule create --resource-group CCTony --nsg-name remoteAzureTonyNSG --name remoteAzureTonyNSGRule80 --protocol tcp --priority 1000 --destination-port-range 80
az network nsg rule create --resource-group CCTony --nsg-name remoteAzureTonyNSG --name remoteAzureTonyNSGRule20 --protocol tcp --priority 999 --destination-port-range 20
az network nsg rule create --resource-group CCTony --nsg-name remoteAzureTonyNSG --name remoteAzureTonyNSGRule22 --protocol tcp --priority 998 --destination-port-range 22

#provision
echo Provisionar con chef-solo:
echo https://github.com/tonyESP/MII_CC_Proyecto/tree/master/provision/chef-solo