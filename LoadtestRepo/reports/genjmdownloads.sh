#!/bin/bash
#use the project properties
. $1/majoris.properties
#logFile=$(echo $jmeter_resultsFile | awk -F '.' '{print $1".jmx.log"}')
logFile=jmeter.log
echo $logFile
cp logs/client/$jmeter_resultsFile reports/
cp logs/client/$logFile reports/ 
cp logs/client/warmup_$jmeter_resultsFile reports/
cp logs/client/warmup_$logFile reports/

echo "<html>" > reports/jmeter-downloads.html
echo " <body>" >> reports/jmeter-downloads.html
echo " <h1>JMeter Files:</h1>" >> reports/jmeter-downloads.html
echo "  <table class=\"raw-jmeter-files\">" >> reports/jmeter-downloads.html
echo "   <tbody>" >> reports/jmeter-downloads.html
echo "   <tr><td><a href=\"./$jmeter_resultsFile\" target=\"mid\">JMeter Test Results File</a></td></tr>" >> reports/jmeter-downloads.html
echo "   <tr><td><a href=\"./warmup_$jmeter_resultsFile\" target=\"mid\">JMeter Warmup Results File</a></td></tr>" >> reports/jmeter-downloads.html
echo "   <tr><td><a href=\"./$logFile\" target=\"mid\">JMeter Test Log File</a></td></tr>" >> reports/jmeter-downloads.html
echo "   <tr><td><a href=\"./warmup_$logFile\" target=\"mid\">JMeter Warmup Log File</a></td></tr>" >> reports/jmeter-downloads.html
echo "   <tr><td><a href=\"images/SynthesisReportGui.csv\" target=\"mid\">Summary Report</a></td></tr>" >> reports/jmeter-downloads.html
echo "   <tr><td><a href=\"images/AggregateReportGui.csv\" target=\"mid\">Aggregate Report</a></td></tr>" >> reports/jmeter-downloads.html
echo "   </tbody>" >> reports/jmeter-downloads.html
echo "  </table>" >> reports/jmeter-downloads.html
echo " </body>" >> reports/jmeter-downloads.html
echo "</html>" >> reports/jmeter-downloads.html

