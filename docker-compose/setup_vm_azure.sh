#!/bin/bash

echo cree un grupo de recursos para su entorno de Docker, en la ubicación eastus:
az group create --name grupohito6 --location eastus


echo  crear una maquina virtual con el script de docker-compose de azure:
az group deployment create --resource-group grupoHito6 \
    --template-uri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/docker-simple-on-ubuntu/azuredeploy.json

echo Para ver detalles de la máquina virtual, incluido el nombre DNS, use az vm show:
az vm show \
    --resource-group grupoHito6 \
    --name myDockerVM \
    --show-details \
    --query [fqdns] \
    --output tsv
