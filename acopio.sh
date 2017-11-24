#!/bin/bash

# Crea el grupo de recursos
az group create --name CCTony --location eastus

# Crea la máquina virtual en el grupo de recursos y gruarda la salida con la 
#  información de la máquina en el archivo tmpconexionfile
az vm create --resource-group CCTony --name clivm --image UbuntuLTS --generate-ssh-keys > tmpconexionfile

# Obtiene la ip de la máquina recien creada del archivo tmpconexionfile
ip=$(jq -r '.publicIpAddress' tmpconexionfile)

# Elimina el archivo tmpconexionfile
rm tmpconexionfile