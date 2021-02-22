#!/bin/bash

sed -i "s/http_access deny all/http_access allow all/" /etc/squid/squid.conf

kill -s HUP $(pgrep squid)
