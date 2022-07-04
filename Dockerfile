FROM sameersbn/squid:latest

RUN sed -i "s/http_access deny all/http_access allow all/" /etc/squid/squid.conf

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
