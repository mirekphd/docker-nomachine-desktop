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

# Creating a new image container and executing the container
```
docker run -d --rm -p 4001:4000 -p 23:22 --memory-reservation 8G --name docker-nomachine-desktop -e PASSWORD=test -e USER=test --cap-add=SYS_PTRACE --cap-add=sys_nice mirekphd/docker-nomachine-desktop
```
## Used docker run options
- the -d option will run the container in the background (returning control to the shell at the cost of hiding errors messages displayed inside the container)
- the -rm option will remove the docker image and other objects to release memory after the container is stopped (caution: potential data loss of the data stored inside the container)
- the -p option sets up port forwarding: contenerized SSH and NX servers use their standard ports, but non-standard ports are exposed outside the contained (here incremented by one); these exposed ports were defined in the Dockerfile
- the --memory-reservation option specifies the soft limit on the memory use, an indication of intended memory usage rather than a maximum cap (the container is still allowed to use as much memory as it needs); note that this can be later changed using _docker update_
- the -e option defines environmental variables USER and PASSWORD (USER: the SSH/NoMachine user login, PASSWORD: the SSH/NoMachine password)
- the --cap-add option grants additional priviledges to the container and manages quotas (e.g. memory and CPU quotas, CPU pinning), see [Limit a container's resources](https://docs.docker.com/config/containers/resource_constraints/) for details
- on Ubuntu 16.04 (and later), it is absolutely necessary to enable PTRACE capabilities required by NoMachine, because they are not provided by the default docker AppArmor profile - hence the --cap-add=SYS_PTRACE parameter (see [Build and Deploy NoMachine Desktops and Applications in Docker for Linux](https://www.nomachine.com/DT08M00100&dn=docker)

# Defining login credentials using environment variables
- the -e option of _docker run_ is used to define container's environmental variables USER and PASSWORD 
- USER: the SSH/NoMachine user login
- PASSWORD: the SSH/NoMachine password
- these credentials are needed only to allow an already authorised server user to execute applications inside the Docker container, so passing password in clear text - as argument of _docker run_ (as described above) is acceptable

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


# Cleaning up after work

- find out the names of all running containers:
```
docker ps
```
- stop the unwanted containers:
```
docker stop docker-nomachine-desktop
```
- if the -rm option was not supplied to _docker run_, we need to remove all unwanted objects: containers, networks, images and optionally (_--volumes_) also volumes (caution: they may contain unsaved data):
```
docker system prune [--volumes]
```




