# docker-nomachine-desktop
A proof-of-concept for setting up a Desktop (Lubuntu - LXDE) on Docker to SSH or NX into the machine. Concept breaks away from micro-services.

# Build
```
git clone https://github.com/tristann9/docker-nomachine-desktop.git
cd docker-nomachine-desktop
docker build -t=tristann9/docker-nomachine-desktop .
```
# Docker pull command
```
docker pull tristann9/docker-nomachine-desktop
```

# Enviroment
USER -> SSH/NX Login user
PASSWORD -> User password

# Usage
```
docker run -d -p 4001:4000 -p 23:22 --name desktop -e PASSWORD=test -e USER=test --cap-add=SYS_PTRACE desktop
```

# Connect

## SSH
```
ssh test@localhost -p 23	
```
## NoMachine (NX)

Download and Install NoMachine client: https://www.nomachine.com/download

Host/IP: Container Host
Port: 4001
User: test
Password: test

## Directly via Docker
```
docker exec -it desktop bash
```

