# Description
A starter Python 3 and R environment for data science tasks performed on the server-side using a wide array of development tools for Python 3 and R: 
- command-line tools (such as python3 / ipython, R), accessible via SSH clients or _docker exec_ command,
- browser-based editors using web servers (Jupyter Notebook, RStudio Server (free), and H2O Flow), accessible via a web browser,
- classic GUI-based IDEs (Spyder and RStudio), designed for local use and thus requiring a graphical Desktop (here: Lubuntu/LXDE - a lightweight alternative to the standard Unity desktop), accessible inside the container through a desktop server (here: the NoMachine server, based on NX, a protocol superior to VNC).


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

# Defining servers login data using Docker environment variables
- USER: the SSH/NoMachine user login
- PASSWORD: the SSH/NoMachine password

# Creating a new image container and executing the container
```
docker run -d --rm -p 4001:4000 -p 23:22 --name docker-nomachine-desktop -e PASSWORD=test -e USER=test --cap-add=sys_nice mirekphd/docker-nomachine-desktop
```
## Used docker run options
- the -d option will run the container in the background (returning control to the shell at the cost of hiding errors messages displayed inside the container)
- the -rm option will remove the docker image to release memory without trace after the container is stopped (caution: potential data loss of all data stored inside the container)
- the -p option sets up port forwarding: contenerized SSH and NX servers use their standard ports, but non-standard ports are exposed outside the contained (here incremented by one); these exposed ports were defined in the Dockerfile
- the -e option defines environmental variables PASSWORD and USER
- the --cap-add option grants additional priviledges to the container and manages quotas (e.g. memory and CPU quotas, CPU pinning), see [Limit a container's resources](https://docs.docker.com/config/containers/resource_constraints/) for details

# Connecting to the container (from the server ssh or NoMachine client)

## SSH / MobaXterm (command-line tools only)
- IP: localhost
- port: 23 (as defined by EXPOSE in the Dockerfile)
- user: test 
- password: test 
- (note that all connection details except the IP can be changed in the Dockerfile)
- example connection:
```
ssh test@localhost -p 23	
```

## Directly via docker exec command (command-line tools only)
```
docker exec -it docker-nomachine-desktop bash
```

## NoMachine (all tools: command-line and GUI)

### client installation
[Download NoMachine client](https://www.nomachine.com/download) and install it on the statistical server running Docker machine

### connection details
- IP: localhost
- port: 4001 (as defined by EXPOSE in the Dockerfile)
- user: test
- password: test
- protocol: NX
- (note that all connection details except the IP can be changed in the Dockerfile)




