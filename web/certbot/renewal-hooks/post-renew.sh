#!/bin/bash

docker exec -it nginx-container-name nginx -s reload

echo "Nginx has been reloaded to apply the updated certificate."
