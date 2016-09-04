#!/bin/sh
# Sample shell script to read and act on properties
# source the properties:
. $1/majoris.properties
. ${PWD}/docker.properties

#Copy the files from results folder

#Capture the script location
CURR_DIR=${PWD}
cd ${1}
SCRIPT_DIR=${PWD}
cd ${CURR_DIR}

#Generate the standalone reports using docker image
docker run -v ${LOGDIR}:/logs -v ${REPDIR}:/reports -v ${SCRIPT_DIR}:/scripts ${MASTER_IMAGE} sh /reports/perfpagegraphs.sh /scripts

sh reports/genjmdownloads.sh $1 
sh reports/csv2htmlsynth.sh 
sh reports/csv2htmlaggr.sh 

ls -l reports/

echo "Successfull completed executing report generation"

echo "Cleanining up all the docker images"
#Cleanup all the docker images
sudo service docker stop
sudo rm -rf /var/lib/docker
sudo service docker start
