# Description
A collection of typical data science libraries to perform server-side data analysis and model training with a graphical Desktop (Lubuntu/LXDE + NoMachine) with 3 sets of code editors for Python 3 and R: 
- the archaic command-line tools (such as python3 / ipython, R), accessible via SSH clients or docker exec command,
- code editors with web servers (Jupyter Notebook Server, RStudio Server (free), and H2O Flow), accessible via a web browser from outside the container,
- classic, battle-tested GUI-based IDEs (Spyder and RStudio), designed for local use, but still accessible despite contenerization by connecting to a desktop server (NoMachine's NX protocol, superior to VNC) running inside the container.

# Automated builds in the Docker Hub

- if you have linked GitHub with the Docker Hub, than create an automated build in the Docker Hub for this Docker image (see [automated builds on Docker Hub](https://docs.docker.com/docker-hub/builds/)), so that simply changing the Dockerfile in GitHub repo will automatically build and push the image to the Docker Hub,

# Building and tagging the Docker image locally
- if you don't have automated builds configured in Docker Hub, or if your have cancelled a build in Docker Hub, then you need to build the image locally (possibly cloning the GitHub repo first):
```
git clone https://github.com/mirekphd/docker-nomachine-desktop.git
cd docker-nomachine-desktop
docker build --tag=mirekphd/docker-nomachine-desktop .
```

# Pushing the locally built image to the Docker Hub
- if automated build is not enabled or not up-to-date (it happens) then the manually built local image has to be pushed to the Docker Hub:
```
# (note: separate tagging step can be omitted if already done during building with the "--tag" option)
docker tag <your_image_id_SHA256_hash> mirephd/docker-nomachine-desktop
docker login
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

## SSH / MobaXterm (command-line tools only)
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

### client installation
[Download NoMachine client](https://www.nomachine.com/download) and install it on the statistical server running Docker machine and/or on the local machine (thin client) 

### connection details
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


