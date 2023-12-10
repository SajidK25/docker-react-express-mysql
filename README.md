## docker-react-express-mysql sample application

### React application with a NodeJS backend and a MariaDB database

Project structure:
```
.
├── backend
│   ├── Dockerfile
│   ...
├── db
│   └── password.txt
├── compose.yaml
├── frontend
│   ├── ...
│   └── Dockerfile
└── README.md
```

[_compose.yaml_](compose.yaml)
```
services:
  backend:
    build: backend
    ports:
      - 80:80
      - 9229:9229
      - 9230:9230
    ...
  db:
    image: mariadb:10.6.4-focal
    
    ...
  frontend:
    build: frontend
    ports:
    - 3000:3000
    ...
```
The compose file defines an application with three services `frontend`, `backend` and `db`.
When deploying the application, docker compose maps port 3000 of the frontend service container to port 3000 of the host as specified in the file.
Make sure port 3000 on the host is not already being in use.


## Deploy with docker compose

```
# To run docker containers on development environment
$ ./run_dev.sh  
OR

# To run docker containers on production environment
$ ./run_pord.sh 
```

## Expected result

Listing containers must show containers running and the port mapping as below:
```
$ docker ps
CONTAINER ID        IMAGE                          COMMAND                  CREATED             STATUS                   PORTS                                                  NAMES
f3e1183e709e        docker-react-express-mysql_frontend   "docker-entrypoint.s…"   8 minutes ago       Up 8 minutes             0.0.0.0:3000->3000/tcp                                 docker-react-express-mysqll_frontend_1
9422da53da76        docker-react-express-mysql_backend    "docker-entrypoint.s…"   8 minutes ago       Up 8 minutes (healthy)   0.0.0.0:80->80/tcp, 0.0.0.0:9229-9230->9229-9230/tcp   docker-react-express-mysql_backend_1
a434bce6d2be        mysql:8.0.19                   "docker-entrypoint.s…"   8 minutes ago       Up 8 minutes             3306/tcp, 33060/tcp                                    docker-react-express-mysql_db_1
```

After the application starts, navigate to `http://localhost:3000` in your web browser.

![page](./output.png)


The backend service container has the port 80 mapped to 80 on the host.
```
$ curl localhost:80
{"message":"Hello from MySQL 8.0.19"}
```

Stop and remove the containers
```
$ docker compose down
Stopping docker-react-express-mysql_frontend_1 ... done
Stopping docker-react-express-mysql_backend_1  ... done
Stopping docker-react-express-mysql_db_1       ... done
Removing docker-react-express-mysql_frontend_1 ... done
Removing docker-react-express-mysql_backend_1  ... done
Removing docker-react-express-mysql_db_1       ... done
Removing network docker-react-express-mysql_default

```
