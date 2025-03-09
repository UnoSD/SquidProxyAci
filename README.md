# Create the proxy

```Bash
RESOURCE_GROUP=<YOUR RESOURCE GROUP NAME>
PROXY_NAME=<YOUR PROXY LABEL>
LOCATION=<YOUR PROXY AZURE REGION LOCATION>
DOCKERHUB_USERNAME=<YOUR DOCKERHUB USERNAME>
DOCKERHUB_PASSWORD=<YOUR DOCKERHUB PASSWORD>

az group create -n $RESOURCE_GROUP

az container create -g $RESOURCE_GROUP --os-type Linux --cpu 1 --memory 1 -l $LOCATION -n aci-squidproxy --image sameersbn/squid --dns-name-label $PROXY_NAME --ports 3128 --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" --gitrepo-url https://github.com/UnoSD/SquidProxyAci.git --gitrepo-dir ./ --gitrepo-mount-path /mnt/gitrepo --registry-username $DOCKERHUB_USERNAME --registry-password $DOCKERHUB_PASSWORD

az container exec -g $RESOURCE_GROUP -n aci-squidproxy --exec-command "/mnt/gitrepo/SquidProxyAci/configure.sh"

# GET PROXY FQDN

ncat -zw 90 <PROXY FQDN> 3128 && notify-send -t 15000 -i messagebox_critical -e "Proxy created and ready"
```
