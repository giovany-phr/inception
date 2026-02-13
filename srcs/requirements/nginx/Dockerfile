FROM    debian:bullseye

RUN     apt update -y && apt upgrade -y

RUN     apt-get install -y nginx openssl

RUN     mkdir -p /etc/nginx/ssl
RUN     openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -out /etc/nginx/ssl/inception.crt \
        -keyout /etc/nginx/ssl/inception.key \
        -subj "/C=FR/ST=IDF/L=Paris/O=42school/OU=42student/CN=gpaupher.42.fr/UID=gpaupher"

COPY    conf/nginx.conf /etc/nginx/nginx.conf

# EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]