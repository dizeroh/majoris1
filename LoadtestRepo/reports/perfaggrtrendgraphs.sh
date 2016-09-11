#!/bin/sh
# source the properties:
. $1/majoris.properties

echo $projectlocation
echo $jenkinsProjectUrl
#Change the project location to the base ${reports_location}/reports folder

#Generate png ${reports_location}/reports for the trend graphs
#Generating throughput graph
throughput="${reports_location}/reports/images/throughputGraph.png $jenkinsProjectUrl/performance/throughputGraph?width=$graphs_width_Pixels&height=$graphs_height_Pixels&performanceReportPosition=$jmeter_resultsFile"
curl -o $throughput
echo $throughput

#Generating respondingTimeGraphPerTestCaseMode graph
respondingtime="${reports_location}/reports/images/respondingTimeGraphPerTestCaseMode.png $jenkinsProjectUrl/performance/respondingTimeGraphPerTestCaseMode?width=$graphs_width_Pixels&height=$graphs_height_Pixels&performanceReportPosition=$jmeter_resultsFile"
curl -o $respondingtime
echo $respondingtime

#Generating throughput graph
errorsgraph="${reports_location}/reports/images/errorsGraph.png $jenkinsProjectUrl/performance/errorsGraph?width=$graphs_width_Pixels&height=$graphs_height_Pixels&performanceReportPosition=$jmeter_resultsFile"
curl -o $errorsgraph
echo $errorsgraph
