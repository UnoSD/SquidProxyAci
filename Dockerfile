FROM sameersbn/squid:latest

EXPOSE 3128/tcp
ENTRYPOINT ["/bin/sh", "-c", "sed -i 's/http_access deny all/http_access allow all/' /etc/squid/squid.conf && /sbin/entrypoint.sh"]
