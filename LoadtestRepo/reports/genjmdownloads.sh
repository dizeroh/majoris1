#!/bin/bash
#use the project properties
. $1/project.properties
#logFile=$(echo $jmeter_resultsFile | awk -F '.' '{print $1".jmx.log"}')
logFile=jmeter.log
echo $logFile
cp ${logs_location}/$jmeter_resultsFile ${reports_location}reports/
cp ${logs_location}/$logFile ${reports_location}reports/ 
cp ${logs_location}/warmup_$jmeter_resultsFile ${reports_location}reports/
cp ${logs_location}/warmup_$logFile ${reports_location}reports/

echo "<html>" > ${reports_location}reports/jmeter-downloads.html
echo " <body>" >> ${reports_location}reports/jmeter-downloads.html
echo " <h1>JMeter Files:</h1>" >> ${reports_location}reports/jmeter-downloads.html
echo "  <table class=\"raw-jmeter-files\">" >> ${reports_location}reports/jmeter-downloads.html
echo "   <tbody>" >> ${reports_location}reports/jmeter-downloads.html
echo "   <tr><td><a href=\"./$jmeter_resultsFile\" target=\"mid\">JMeter Test Results File</a></td></tr>" >> ${reports_location}reports/jmeter-downloads.html
echo "   <tr><td><a href=\"./warmup_$jmeter_resultsFile\" target=\"mid\">JMeter Warmup Results File</a></td></tr>" >> ${reports_location}reports/jmeter-downloads.html
echo "   <tr><td><a href=\"./$logFile\" target=\"mid\">JMeter Test Log File</a></td></tr>" >> ${reports_location}reports/jmeter-downloads.html
echo "   <tr><td><a href=\"./warmup_$logFile\" target=\"mid\">JMeter Warmup Log File</a></td></tr>" >> ${reports_location}reports/jmeter-downloads.html
echo "   <tr><td><a href=\"images/SynthesisReportGui.csv\" target=\"mid\">Summary Report</a></td></tr>" >> ${reports_location}reports/jmeter-downloads.html
echo "   <tr><td><a href=\"images/AggregateReportGui.csv\" target=\"mid\">Aggregate Report</a></td></tr>" >> ${reports_location}reports/jmeter-downloads.html
echo "   </tbody>" >> ${reports_location}reports/jmeter-downloads.html
echo "  </table>" >> ${reports_location}reports/jmeter-downloads.html
echo " </body>" >> ${reports_location}reports/jmeter-downloads.html
echo "</html>" >> ${reports_location}reports/jmeter-downloads.html

