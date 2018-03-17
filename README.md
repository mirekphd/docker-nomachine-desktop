# Description
A large collection of data science libraries from Kaggle Kernels to perform server-side modeling with a graphical Desktop (Lubuntu/LXDE + NoMachine/NX server) but with all available free software for Python 3 and R: using not only terminal/CLI apps accessible via SSH (python/iPython, R) or browser-based apps (Jupyter Notebook Server, RStudio Server Free) but also classic "local" IDEs (Spyder, RStudio).

# Build
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

# Usage
```
docker run -d -p 4001:4000 -p 23:22 --name docker-nomachine-desktop -e PASSWORD=test -e USER=test --cap-add=SYS_PTRACE mirekphd/docker-nomachine-desktop
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
docker exec -it docker-nomachine-desktop bash
```

