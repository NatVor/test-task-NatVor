# test-task-NatVor


## docker-compose-prod

version: '3.8'

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
