
. ${1}/majoris.properties # default jmeter and docker.properties included in multiAgentProject.properties
#sh ${reports_location}docker.properties

if [ "$#" -ne 1 ]
then
        echo "Your project.properties location is not passed as an argument. Your reports will not be generated. Please modify your \"Execute shell\"  in jenkins as \"sh reportgenerator.sh <JMeterScripts and Property Location folder path from stash repository>\""
        exit;
fi

#cd target/jmeter/lib/ext/
echo "java -jar CMDRunner.jar --tool Reporter --generate-png ../../../reports/images/Aggr-ThreadsStateOverTime.png --input-jtl  ../../results/$jmeter_resultsFile --plugin-type ThreadsStateOverTime --width $graphs_width_Pixels --height $graphs_height_Pixels --aggregate-rows yes --paint-gradient no --paint-zeroing yes --paint-markers yes"
#java -jar CMDRunner.jar --tool Reporter --generate-png ../../../reports/images/Aggr-ThreadsStateOverTime.png --input-jtl  ../../results/$jmeter_resultsFile --plugin-type ThreadsStateOverTime --width $graphs_width_Pixels --height $graphs_height_Pixels --aggregate-rows yes --paint-gradient no --paint-zeroing yes --paint-markers yes

#The belo graph is already included as part of pagegraphs
#docker run -v ${LOGDIR}:${logs_location} -v ${REPDIR}:/reports ${MASTER_IMAGE} java -jar ${JMTR_PATH}/lib/ext/CMDRunner.jar --tool Reporter --generate-png /reports/images/Aggr-ThreadsStateOverTime.png --input-jtl  ${logs_location}/${jmeter_resultsFile} --plugin-type ThreadsStateOverTime --width $graphs_width_Pixels --height $graphs_height_Pixels --aggregate-rows yes --paint-gradient no --paint-zeroing yes --paint-markers yes

#Generates graphs using CMRRunner plugin. No need to have jenkins plguin
sh ${reports_location}reports/reportgenerator.sh $1 

#Generate graphs through jmeter-jenkins plugin. This portion of the code works only when you run the test from jenkins.
sh ${reports_location}reports/perfaggrtrendgraphs.sh $1
sh ${reports_location}reports/perftrendgraphs.sh $1
#sh ${reports_location}reports/perfpagegraphs.sh $1 #This graph disabled. Because perfpagegraphs.sh covers page graphs, throughput graphs and aggregate graphs.
#sh ${reports_location}reports/genpageresponsetime.sh $1 #this code is disabled because, perfpagegraphs.sh will generate all the required graphs
#copy all the files to the reports section to get onto Jenkins node
cp -rf ${reports_location}reports/* /reports
