# Docker
This directory is for managing the docker container running on this system

###### About the directory structure
- data/
 - To store the data, mounts, etc
- config/
 - If any docker docker require some config file, which we don't want to share with other then we can use this folder
- run/
 - This folder store docker-compose yml file or some sort of script to run the docker instnace
- dockerfile/
 - To store all the dockerfile