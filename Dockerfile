FROM sameersbn/squid:latest

EXPOSE 3128/tcp
ENTRYPOINT ["/bin/sh", "/sbin/entrypoint.sh"]
