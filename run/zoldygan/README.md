sudo docker-compose -f networks.yml -f mysql.yml up -d

mysql -h 192.168.1.38 -p -P 13306 -u root
