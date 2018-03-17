# Description
A large collection of data science libraries from Kaggle Kernels to perform server-side modeling with a graphical Desktop (Lubuntu/LXDE + NoMachine/NX server) but with all available free software for Python 3 and R: using not only terminal/CLI apps accessible via SSH (python/iPython, R) or browser-based apps (Jupyter Notebook Server, RStudio Server Free) but also classic "local" IDEs (Spyder, RStudio).

# Building docker image
```
git clone https://github.com/mirekphd/docker-nomachine-desktop.git
cd docker-nomachine-desktop
docker build -t=mirekphd/docker-nomachine-desktop .
```
# Docker pull command
```
docker pull mirekphd/docker-nomachine-desktop
```

# Enviroment
USER -> SSH/NX Login user
PASSWORD -> User password

# Starting docker image
```
docker run -d -p 4001:4000 -p 23:22 --name docker-nomachine-desktop -e PASSWORD=test -e USER=test --cap-add=SYS_PTRACE mirekphd/docker-nomachine-desktop
```

# Connecting to the container

## SSH (CLI tools only)
IP: localhost
Port: 23
User: test
Password: test
Example:
```
ssh test@localhost -p 23	
```

## Directly via docker exec command (CLI tools only)
```
docker exec -it docker-nomachine-desktop bash
```

## NoMachine (all tools)

Download and Install a NoMachine client (server-side or PC): https://www.nomachine.com/download

IP: container IP
Port: 4001
User: test
Password: test

# Finding out IPs (by listening ports)
## Docker containers
- only running ones ("Up"):
docker ps
- latest one (including stopped):
docker ps -l
- all (including stopped)
docker ps -a 
## all system-wide ports
netstat --listen


