# test-task-NatVor


## docker-compose-prod

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az --version





##version: '3.8'

services:
  web:
    build: ./docker
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./docker/nginx.conf:/etc/nginx/nginx.conf
      - ./docker/certbot:/etc/letsencrypt
    environment:
      - VIRTUAL_HOST=example.com
    depends_on:
      - db

  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: app_db
    ports:
      - "3306:3306"



worker_processes 1;

events {
    worker_connections 1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    server {
        listen 80;
        server_name example.com;

        location /.well-known/acme-challenge/ {
            root /usr/share/nginx/html;
        }

        location / {
            return 301 https://$host$request_uri;
        }
    }

    server {
        listen 443 ssl;
        server_name example.com;

        ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;

        location / {
            root /usr/share/nginx/html;
            index index.html;
        }
    }
}

