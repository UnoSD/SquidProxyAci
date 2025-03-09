# Create the proxy

```Bash
az group create -n rg-proxy-dev-weu-001 --subscription <YOUR SUB>

az container create -g rg-proxy-dev-weu-001 --subscription <YOUR SUB> -n aci-squidproxy --image sameersbn/squid --dns-name-label <YOUR PROXY LABEL> --ports 3128 --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" --gitrepo-url https://github.com/UnoSD/SquidProxyAci.git --gitrepo-dir ./ --gitrepo-mount-path /mnt/gitrepo

az container exec -g rg-proxy-dev-weu-001 --subscription <YOUR SUB> -n aci-squidproxy --exec-command "/mnt/gitrepo/SquidProxyAci/configure.sh"

ncat -zw 90 <PROXY FQDN> 3128 && notify-send -t 15000 -i messagebox_critical -e "Proxy created and ready"
```
