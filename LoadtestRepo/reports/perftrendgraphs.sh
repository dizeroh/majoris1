#!/bin/bash

#Source project properties
. $1/majoris.properties

count=1
echo "<html>" > reports/PerformanceTrendGraphs.html
echo "<head>" >> reports/PerformanceTrendGraphs.html
echo "<title>Performance trend graphs for each page</title>" >> reports/PerformanceTrendGraphs.html
echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"commonstyle.css\">" >> reports/PerformanceTrendGraphs.html
echo "</head>" >> reports/PerformanceTrendGraphs.html
echo "<body>" >> reports/PerformanceTrendGraphs.html
echo "<h1><b>Performance trend graphs for each page</b></h1>" >> reports/PerformanceTrendGraphs.html
echo "<div class=\"images\">" >> reports/PerformanceTrendGraphs.html

length=$(cat reports/images/SynthesisReportGui.csv | wc -l)
while read line
do
	if  [ $count != 1 ] && [ `expr $length` -ne $count ]
	then
		#Fetch the page name
		pageHeader=$(echo $line | awk -F '[,]' '{print $1;}')
		echo $pageHeader
		#Generate a header to add part of the URL 
		pageRequester=$(echo $pageHeader | sed 's/\ /%20/g' | sed 's/\//_/g')
		echo $pageRequester
		#create a name for the image
		pageName=$(echo $pageHeader | sed 's/\ /-/g'|sed 's/\//-/g' | sed 's/\?/-/g' | sed 's/\=/-/g' | sed 's/\&/-/g' | sed 's/\*/-/g')
		echo $pageName
		#generate graph
		trendImage="reports/images/Trend-$pageName.png $jenkinsProjectUrl/lastBuild/performance/respondingTimeGraph?width=$graphs_width_Pixels&height=$graphs_height_Pixels&performanceReportPosition=$jmeter_resultsFile&summarizerTrendUri=$pageRequester"
		echo $trendImage
	
		curl -o $trendImage		
		#Add images and their headings in html page
		echo "<h3>$pageHeader</h3>" >> reports/PerformanceTrendGraphs.html
		echo "<img src=\"images/Trend-$pageName.png\" tooltip=\"$pageHeader\"/>" >> reports/PerformanceTrendGraphs.html 
	fi	
	((count++))
done < reports/images/SynthesisReportGui.csv
echo "</div>" >> reports/PerformanceTrendGraphs.html
echo "</body>" >> reports/PerformanceTrendGraphs.html
echo "</html>" >> reports/PerformanceTrendGraphs.html
#awk -F '[,]' '{for(i=1;i<12;i++) {print $i;}}' SynthesisReportGui.csv > reports/PerformanceTrendGraphs.html
