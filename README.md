# Create the proxy

```Bash
RESOURCE_GROUP=<YOUR RESOURCE GROUP NAME>
PROXY_NAME=<YOUR PROXY LABEL>
LOCATION=<YOUR PROXY AZURE REGION LOCATION>
DOCKERHUB_USERNAME=<YOUR DOCKERHUB USERNAME>
DOCKERHUB_PASSWORD=<YOUR DOCKERHUB PASSWORD>

az group create -n $RESOURCE_GROUP

PROXY_FQDN=$(az container create -g $RESOURCE_GROUP --os-type Linux \
                                                    --cpu 1 \
                                                    --memory 1 \
                                                    -l $LOCATION \
                                                    -n aci-squidproxy \
                                                    --image sameersbn/squid \
                                                    --dns-name-label $PROXY_NAME \
                                                    --ports 3128 \
                                                    --query ipAddress.fqdn \
                                                    --gitrepo-url https://github.com/UnoSD/SquidProxyAci.git \
                                                    --gitrepo-dir ./ \
                                                    --gitrepo-mount-path /mnt/gitrepo \
                                                    --registry-username $DOCKERHUB_USERNAME \
                                                    --registry-password $DOCKERHUB_PASSWORD \
                                                    --registry-login-server index.docker.io \
                                                    -o tsv)

az container exec -g $RESOURCE_GROUP -n aci-squidproxy --exec-command "/mnt/gitrepo/SquidProxyAci/configure.sh"

ncat -zw 90 $PROXY_FQDN 3128 && notify-send -t 15000 -i messagebox_critical -e "Proxy created and ready $PROXY_FQDN"
```

# Set up proxy in the browser

Use FoxyProxy on Firefox or any equivalent using $PROXY_FQDN and 3128 as port
