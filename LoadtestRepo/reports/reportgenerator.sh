#!/bin/bash
# Sample shell script to read and act on properties
# source the properties:

. $1/majoris.properties
#. ${reports_location}docker.properties

#Copy the files from results folder

#Capture the script location
CURR_DIR=${PWD}
cd ${1}
SCRIPT_DIR=${PWD}
cd ${CURR_DIR}

#Generate the standalone reports using docker image
#docker run -v ${LOGDIR}:${logs_location} -v ${REPDIR}:/reports -v ${SCRIPT_DIR}:/scripts ${MASTER_IMAGE} sh /reports/perfpagegraphs.sh /scripts

chmod 777 ${reports_location}reports/perfpagegraphs.sh
.${reports_location}reports/perfpagegraphs.sh $1
sh ${reports_location}reports/genjmdownloads.sh $1 
#sh ${reports_location}reports/csv2htmlsynth.sh $1 # Synthesis report got exception. So removed.
chmod 777 ${reports_location}reports/csv2htmlaggr.sh
.${reports_location}reports/csv2htmlaggr.sh $1 #to make count++ work properly changed the files to run with . command

ls -l reports/

echo "Successfull completed executing report generation"

echo "Cleanining up all the docker images"
#Cleanup all the docker images
#sudo service docker stop
#sudo rm -rf /var/lib/docker
#sudo service docker start
