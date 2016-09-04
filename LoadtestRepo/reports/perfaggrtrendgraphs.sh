#!/bin/sh
# source the properties:
. $1/majoris.properties

echo $projectlocation
echo $jenkinsProjectUrl
#Change the project location to the base reports folder

#Generate png reports for the trend graphs
#Generating throughput graph
throughput="reports/images/throughputGraph.png $jenkinsProjectUrl/performance/throughputGraph?width=$graphs_width_Pixels&height=$graphs_height_Pixels&performanceReportPosition=$jmeter_resultsFile"
curl -o $throughput
echo $throughput

#Generating respondingTimeGraphPerTestCaseMode graph
respondingtime="reports/images/respondingTimeGraphPerTestCaseMode.png $jenkinsProjectUrl/performance/respondingTimeGraphPerTestCaseMode?width=$graphs_width_Pixels&height=$graphs_height_Pixels&performanceReportPosition=$jmeter_resultsFile"
curl -o $respondingtime
echo $respondingtime

#Generating throughput graph
errorsgraph="reports/images/errorsGraph.png $jenkinsProjectUrl/performance/errorsGraph?width=$graphs_width_Pixels&height=$graphs_height_Pixels&performanceReportPosition=$jmeter_resultsFile"
curl -o $errorsgraph
echo $errorsgraph