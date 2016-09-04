#
# Dockerfile for a jmeter client.
# A container from this image will be ready to run a jmeter client.
#
# Usage:
#  docker run -d \
#             -v <absolute path on host>:/logs \
#             -v <absolute path on host>:/data \
#             -v <absolute path on host>:/scripts \
#             <docker image> -n \
#                            -LDEBUG # <-- ok, this is optional.
#                            -t /scripts/<script file name>
#                            -l /logs/<output jtl file name>
#                            -R<server IP addresses>
#
# TODO - The current recipe demands that the jmeter.properties used by jmeter-server image and
#        the one used by *this* image be in lock step; at least as far as the ports are concerned.
#        That seems icky.  Fix it, yo!
# TODO - Can't seem to get around hard coded JMeter version number in ENTRYPOINT.  Variable does
#        not get expanded (probably because it is in a string literal).



FROM fedora

MAINTAINER dizer.oh@gmail.com

ENV JDK_VERSION 1.8.0
ENV JMETER_VERSION 2.13

# Install  JDK
RUN sudo yum install java-$JDK_VERSION-openjdk-devel.x86_64 && rm -rf /var/cache/yum

# Install JMeter
RUN cd /var/lib && \
  curl http://psg.mtu.edu/pub/apache/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz -o /var/lib/jmeter-$JMETER_VERSION.tgz && \
  tar xf jmeter-$JMETER_VERSION.tgz && \
  rm -f jmeter-$JMETER_VERSION.tgz

# Use a predefined configuration.  This sets the contract for connecting to jmeter servers.
ADD jmeter.properties /var/lib/apache-jmeter-$JMETER_VERSION/bin/


# Add the JMeter folder in docker image
# ADD target/jmeter /var/lib/jmeter/


#Replace ApacheJMeter_core-2.13.jar withe the custom jar ApacheJMeter_core.jar to get the custom counters for grafana
RUN rm -f /var/lib/jmeter/lib/ext/ApacheJMeter_core-$JMETER_VERSION.jar
ADD ApacheJMeter_core.jar /var/lib/jmeter/lib/ext

#Add user.properties for creating a database in grafana
ADD user.properties /var/lib/jmeter/bin

  
# Create mount point for script, data, log and report files for jmeter-master or slave
VOLUME ["/scripts"]
VOLUME ["/data"]
VOLUME ["/logs"]
VOLUME [ "/reports" ]

# Expose jmeter-server's port (specified in jmeter.properties.)  HTTPS port -443, influxdb - 8083 8086 8088 8091,  graphite port-2003
EXPOSE 1099 60000 443 8083 8086 8088 8091 2003

