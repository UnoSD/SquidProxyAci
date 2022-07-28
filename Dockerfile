FROM sameersbn/squid:latest

COPY squid.conf /etc/squid/squid.conf

EXPOSE 3128/tcp

#ENTRYPOINT ["/bin/sh", "/sbin/entrypoint.sh"]
