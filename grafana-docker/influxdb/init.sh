#!/bin/bash
set -e

STAMP="/.influxdb-setup-complete"

if [ -f ${STAMP} ]; then
  echo "influxdb already configured, nothing to do."
  exit 0
fi
echo "influxdb is about to start"
#chmod 777 /etc/init.d/*
#chown -R influxdb /var/run/influxdb/
#service influxdb start
/etc/init.d/influxdb start
echo "influxdb is started"
# wait for influxdb to respond to requests
until /opt/influxdb/influx -execute 'show databases'; do sleep 10; done
ut1=$(/opt/influxdb/influx -execute 'show databases' | grep 'jmeter')
echo "Runninf db is: $ut1"
if [[ $ut1 -eq 'jmeter' ]]; then
	echo 'jmeter databse already exists'
else
	/opt/influxdb/influx -execute 'create database jmeter'
	/opt/influxdb/influx -execute 'show databases'
fi
/etc/init.d/influxdb stop

touch ${STAMP}
