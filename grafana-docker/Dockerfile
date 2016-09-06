FROM fedora:23

MAINTAINER Srinivasa Bittla <srinivasa.bittla@citrix.com>

# package installation
RUN dnf update -qy && \
 dnf install -qy https://s3.amazonaws.com/influxdb/influxdb-0.9.4-1.x86_64.rpm && \ 
 dnf install -qy https://grafanarel.s3.amazonaws.com/builds/grafana-2.1.3-1.x86_64.rpm && \
 dnf install -qy nginx && \
 dnf install -qy supervisor && \
 dnf install -qy cronie && \
 dnf install -qy nmap-ncat 


# influxdb
ADD ./influxdb/init.sh /init-influxdb.sh
ADD ./influxdb/influxdb.conf /etc/opt/influxdb/influxdb.conf
RUN bash /init-influxdb.sh

# grafana
ADD ./grafana/init.sh /init-grafana.sh
RUN bash /init-grafana.sh
ADD ./grafana/grafana.ini /etc/grafana/grafana.ini

# nginx config
ADD ./nginx/nginx.conf /etc/nginx/nginx.conf

# supervisord
ADD ./supervisord.conf /etc/supervisord.d/supervisord.conf


# import grafana dashboard
ADD ./grafana/loadtest-dashboard.json /var/lib/grafana/dashboards/loadtest-dashboard.json

# expose ports for nginx (grafana) - 80,  influxdb ports for jmeter - 
EXPOSE  80 2003 8086 8083



# expose influxdb data for creating a data volume container
VOLUME /var/opt/influxdb/

# run
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.d/supervisord.conf"]
