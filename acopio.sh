#!/bin/bash

# Crea el grupo de recursos
az group create --name CCTony --location eastus

# Creamos la maquina virtual con este comando, con el grupo de recursos anterior.
ipAddress=$(az vm create -g CCTony -n remoteAzureTony --image UbuntuLTS --generate-ssh-keys | jq -r '.publicIpAddress')

echo Datos de la maquina creada:
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