#!/bin/bash

# Домен вашого веб-сервера
DOMAIN="example.com"

# Електронна адреса для реєстрації в Let's Encrypt
EMAIL="admin@example.com"

# Виконуємо Certbot для отримання сертифікатів
docker run --rm \
  -v /etc/letsencrypt:/etc/letsencrypt \
  -v /var/lib/letsencrypt:/var/lib/letsencrypt \
  -v /var/log/letsencrypt:/var/log/letsencrypt \
  certbot/certbot certonly \
  --non-interactive \
  --agree-tos \
  --email "$EMAIL" \
  --webroot -w /usr/share/nginx/html \
  -d "$DOMAIN"

echo "Certificate for $DOMAIN has been obtained successfully!"
