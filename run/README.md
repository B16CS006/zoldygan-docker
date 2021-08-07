# Makefile
Had created a `Makefile` so that we don't have to remmeber the complex commands we can just use make to do lots of thing like
- `make up`: to run all the container
- `make down`: to stop/rm all the container
- `make network-up`: to create the desired networks with proper subnet
- `make network-down`: to delete the networks
- `make <container>-up`: to start a some container
- `make <container>-down`: to stop/rm container

# update- 7 Aug 2021
Here we are only creating two network for now
- frontend
- backend

> You can use `make network-up` command to create these network in this current folder

### What the current situation
All the container are running on the backend network, nothing is running on frontend for now
- fpm: To server php files using nginx
- ludo: Application created by madhav using django
- nginx: To serve files at :80 and :443 port
- mysql: for database

There are few point to remember:
- Since all container are running on same network, they can talk to each using ip or even `container name` as well (use service name for docker-compose conatiners)
- `Port 80` of nginx container is mapped to the host machine so that we can direct traffic from outside world to it
- Django application are now accepting the connection only from from `ludo`, if you see nginx config then there we redirect traffic to `ludo:8001` if we use other then we would not get the website(not sure if localhost lies in this catagory)
