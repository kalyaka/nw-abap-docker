# nw-abap-docker

# build
docker build -t nwabap:752 .

# run on host
docker run -p 3300:3300 -p 3200:3200 -h nw75vm --name nw752dev -v /host/sapdb:/sapdb -v /host/sapmnt:/sapmnt -v /host/usr_sap:/usr/sap -v /host/home:/home -it nwabap:752 /bin/bash

# run on container
/usr/sbin/uuidd
su - npladm
startsap db
startsap r3
