# Description
A large collection of data science libraries from Kaggle Kernels to perform server-side modeling with a graphical Desktop (Lubuntu/LXDE + NoMachine) but with all available free software for Python 3 and R: using not only command-line tools accessible via SSH (such as python/iPython, R) or browser-based apps (Jupyter Notebook Server, RStudio Server free edition) but also classic "local" IDEs (Spyder, RStudio).

# Building and tagging the docker image
```
git clone https://github.com/mirekphd/docker-nomachine-desktop.git
cd docker-nomachine-desktop
docker login
docker build --tag=mirekphd/docker-nomachine-desktop .
```

# Pushing the image to the Docker Hub
- if you have linked Git Hub with the Docker Hub (see [automated builds on Docker Hub](https://docs.docker.com/docker-hub/builds/)), than building of the Docker image in your local Git repo (using _docker build_ above) will have automatically pushed the image to Docker Hub.
- otherwise use _docker push_ like this:
```
docker login
# (tag only if tagging not yet done with "build --tag":)
# docker tag <your_image_id_SHA256_hash> mirephd/docker-nomachine-desktop
docker push mirekphd/docker-nomachine-desktop
```


# Pulling the image from the Docker Hub
- on your deployment server execute _docker pull:_
```
docker pull mirekphd/docker-nomachine-desktop
```

# Enviroment
- USER -> SSH/NX Login user
- PASSWORD -> User password

# Creating a new image container and executing the container
```
docker run -d -p 4001 -p 23 --name docker-nomachine-desktop -e PASSWORD=test -e USER=test --cap-add=SYS_PTRACE mirekphd/docker-nomachine-desktop
```

# Connecting to the container

## SSH (command-line tools only)
- IP: container IP (see next section)
- port: 23
- user: test 
- password: test 
- (note that all connection details except the IP can be changed in the Dockerfile and pushed to your own Docker Hub)
- example:
```
ssh test@localhost -p 23	
```

## Directly via docker exec command (command-line tools only)
```
docker exec -it docker-nomachine-desktop bash
```

## NoMachine (all tools: command-line and GUI)

Download and Install a NoMachine client (for the remote server running Docker engine or for the local PC): 
https://www.nomachine.com/download

- IP: container IP (see next section)
- port: 4001
- user: test
- password: test
- (note that all connection details except the IP can be changed in the Dockerfile and pushed to your own Docker Hub)

# Finding out IPs (by listening ports)
## Docker containers
- only running ones ("Up"):
```
docker ps
```
- latest one (including stopped):
```
docker ps -l
```
- all (including stopped):
```
docker ps -a 
```
## All system-wide listening ports
```
netstat --listen
```


