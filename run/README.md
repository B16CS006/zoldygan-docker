sudo docker-compose -f /opt/docker/run/nginx.yml -f /opt/docker/run/networks.yml up -d
sudo docker-compose -f /opt/docker/run/ngrok.yml up -d

sudo docker-compose -f /opt/docker/run/php-fpm.yml -f /opt/docker/run/networks.yml up -d

sudo docker-compose -f /opt/docker/run/nginx.yml -f /opt/docker/run/ngrok.yml -f /opt/docker/run/networks.yml down
sudo docker-compose -f /opt/docker/run/nginx.yml -f /opt/docker/run/ngrok.yml -f /opt/docker/run/networks.yml up -d
