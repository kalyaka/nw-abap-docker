FROM opensuse:latest

ENV LANG=en_US.UTF-8

RUN zypper --non-interactive install --replacefiles which hostname expect net-tools iputils wget vim iproute2 unrar tar uuidd tcsh less
#RUN zypper refresh && zypper --non-interactive up

# uuidd is needed by nw abap
RUN mkdir /run/uuidd && chown uuidd /var/run/uuidd && /usr/sbin/uuidd

COPY sapinit /etc/init.d/sapinit
RUN chmod a+x /etc/init.d/sapinit

COPY services /tmp/
COPY group /tmp/
COPY passwd /tmp/
COPY sdb /tmp/
RUN cat /tmp/services >> /etc/services
RUN cat /tmp/group >> /etc/group
RUN cat /tmp/passwd >> /etc/passwd
RUN cp /tmp/sdb /etc/opt/sdb

RUN mkdir /sapdb /sapmnt /usr/sap
RUN rm -rf /var/cache/zypp/* /tmp/*
RUN mkdir /var/lib/sdb
RUN chown sdb /var/lib/sdb
RUN chmod u+s /usr/bin/ping

# Important ports to be exposed (TCP):
# HTTP
EXPOSE 8000
# HTTPS
EXPOSE 44300
# ABAP in Eclipse
EXPOSE 3300
# SAP GUI
EXPOSE 3200
