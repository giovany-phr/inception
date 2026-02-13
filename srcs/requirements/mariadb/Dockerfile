FROM    debian:bullseye

RUN     apt update -y && apt upgrade -y

#tini = handle zombie processes
RUN     apt-get install mariadb-server tini -y

COPY    tools/script.sh .
RUN     chmod +x script.sh

EXPOSE  3306

RUN     chown -R mysql:mysql /var/lib/mysql
RUN     chmod 750 /var/lib/mysql


ENTRYPOINT ["tini", "--", "./script.sh"]

#listen from all IPs
CMD ["mysqld", "--bind-address=0.0.0.0"]