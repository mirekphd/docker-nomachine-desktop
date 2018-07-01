#!/bin/sh

# groupadd -r $USER -g 433 \
# && useradd -u 431 -r -g $USER -d /home/$USER -s /bin/bash -c "$USER" $USER \
# && adduser $USER sudo \
# && mkdir /home/$USER \
# && chown -R $USER:$USER /home/$USER \
# && echo $USER':'$PASSWORD | chpasswd

# sudo /etc/init.d/ssh restart
sudo /etc/NX/nxserver --startup

# start logging (essential to run the server, even in detached mode)
# sudo tail -f /usr/NX/var/log/nxserver.log
# tail -f /home/nomachine/log/nxserver.log
tail -f /tmp/nxserver.log

