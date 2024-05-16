# LEMP - Docker Compose

This docker compose structure was created to setting up a local environment for applications built with PHP MYSQL and NGINX, for example Laravel projects.

## Steps

- Clone this repository on the desired directory.
- Inside the "src" directory copy all your project files and directories. (All the files that are inside this directory will be ignore by git).
- If you will work on a Laravel project configure or update all the necessary files before running the next commands.
- Run "docker-compose build" to verify all is working as expected.
- Run "docker-compose up -d" to generate and start the containers.
- Run "docker-compose down" to stop and remove the containers.
