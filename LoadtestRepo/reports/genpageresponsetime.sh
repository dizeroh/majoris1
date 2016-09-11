#!/bin/sh

#Source project properties
. $1/majoris.properties
echo "<a href=\"$jenkinsProjectUrl/lastBuild/performance/trendReport/?performanceReportPosition=$jmeter_resultsFile\">Click here to generate Page Response Time Graphs</a>" > reports/PageResponseTimeGraphs.html

