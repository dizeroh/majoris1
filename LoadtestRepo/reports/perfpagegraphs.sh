#!/bin/bash

#Source project properties
. $1/majoris.properties

JMTR_PATH=/var/lib/jmeter

#Generate Page Aggregate Graphs
#Aggregate graph names
array=( ThreadsStateOverTime TimesVsThreads TransactionsPerSecond )
#Generate Aggregate Graphs
for aggGraph in "${array[@]}"
do
        echo "Aggregate Graph - ${aggGraph}"
        java -jar ${JMTR_PATH}/lib/ext/CMDRunner.jar --tool Reporter --generate-png /reports/images/Aggr-${aggGraph}.png --input-jtl  /logs/${jmeter_resultsFile} --plugin-type ${aggGraph} --width $graphs_width_Pixels --height $graphs_height_Pixels --aggregate-rows yes --paint-gradient no --paint-zeroing yes --paint-markers yes
done

#Independent graph names
array=( ThreadsStateOverTime BytesThroughputOverTime HitsPerSecond LatenciesOverTime ResponseCodesPerSecond ResponseTimesDistribution ResponseTimesOverTime ResponseTimesPercentiles ThroughputVsThreads TimesVsThreads TransactionsPerSecond PageDataExtractorOverTime )

#Independent graph generation
for graphName in "${array[@]}"
do
        echo "Graph - ${graphName}"
        java -jar ${JMTR_PATH}/lib/ext/CMDRunner.jar --tool Reporter --generate-png /reports/images/${graphName}.png --input-jtl  /logs/${jmeter_resultsFile} --plugin-type ${graphName} --width $graphs_width_Pixels --height $graphs_height_Pixels --aggregate-rows no --paint-gradient no --paint-zeroing yes --paint-markers yes
done

#Generate csv reports
array=( AggregateReport SynthesisReport )

for csvReport in "${array[@]}"
do
        echo "CSV report - ${csvReport}"
        java -jar ${JMTR_PATH}/lib/ext/CMDRunner.jar --tool Reporter --generate-csv /reports/images/${csvReport}Gui.csv --input-jtl  /logs/${jmeter_resultsFile} --plugin-type ${csvReport}
done

#Generate page graphs and throughput graphs
#Generate PageThroughput graphs

count=1
echo "<html>" > reports/PageThroughputGraphs.html
echo "<head>" >> reports/PageThroughputGraphs.html
echo "<title>Performance graphs for each page</title>" >> reports/PageThroughputGraphs.html
echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"commonstyle.css\">" >> reports/PageThroughputGraphs.html
echo "</head>" >> reports/PageThroughputGraphs.html
echo "<body>" >> reports/PageThroughputGraphs.html
echo "<h1><b>Performance page throughput (transactions/sec) graphs for each page</b></h1>" >> reports/PageThroughputGraphs.html
echo "<div class=\"images\">" >> reports/PageThroughputGraphs.html

length=$(cat reports/images/SynthesisReportGui.csv | wc -l)
echo "Length is: $length"
while read line
do
        if  [ $count != 1 ]
        then
                #Fetch the page name
                pageHeader=$(echo $line | awk -F '[,]' '{print $1;}')
                echo $pageHeader
                if [ "$pageHeader" != "TOTAL" ]
                then

                        #Generate a header to add part of the URL
                        pageRequester=$(echo $pageHeader | sed 's/\ /%20/g' | sed 's/\//_/g')
                        echo $pageRequester
                        #create a name for the image
                        pageName=$(echo $pageHeader | sed 's/\ //g'|sed 's/\//-/g'  | sed 's/\?/-/g' | sed 's/\=/-/g' | sed 's/\&/-/g' | sed 's/\*/-/g')
                        echo $pageName
                        cat logs/${jmeter_resultsFile} | grep "${pageHeader}" > logs/temp_${jmeter_resultsFile}
                        #generate throughput graphs
                        java -jar ${JMTR_PATH}/lib/ext/CMDRunner.jar --tool Reporter --generate-png /reports/images/Throughput-${pageName}.png --input-jtl  /logs/temp_${jmeter_resultsFile} --plugin-type TransactionsPerSecond --width $graphs_width_Pixels --height $graphs_height_Pixels --aggregate-rows no --paint-gradient no --paint-zeroing yes --paint-markers yes

                        #generate page response time graphs
                        java -jar ${JMTR_PATH}/lib/ext/CMDRunner.jar --tool Reporter --generate-png /reports/images/Page-${pageName}.png --input-jtl  /logs/temp_${jmeter_resultsFile} --plugin-type ResponseTimesOverTime --width $graphs_width_Pixels --height $graphs_height_Pixels --aggregate-rows no --paint-gradient no --paint-zeroing yes --paint-markers yes

                        #Add images and their headings in html page
                        echo "<h3>$pageHeader</h3>" >> reports/PageThroughputGraphs.html
                        echo "<img src=\"images/Throughput-$pageName.png\" tooltip=\"$pageHeader\"/>" >> reports/PageThroughputGraphs.html
                        echo "<br>" >> reports/PageThroughputGraphs.html
                fi
        fi
        ((count++))
done < reports/images/SynthesisReportGui.csv
echo "</div>" >> reports/PageThroughputGraphs.html
echo "</body>" >> reports/PageThroughputGraphs.html
echo "</html>" >> reports/PageThroughputGraphs.html

#Generate PageResponeTime html file
count=1
echo "<html>" > reports/PageResponseTimeGraphs.html
echo "<head>" >> reports/PageResponseTimeGraphs.html
echo "<title>Performance graphs for each page</title>" >> reports/PageResponseTimeGraphs.html
echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"commonstyle.css\">" >> reports/PageResponseTimeGraphs.html
echo "</head>" >> reports/PageResponseTimeGraphs.html
echo "<body>" >> reports/PageResponseTimeGraphs.html
echo "<h1><b>Performance graphs for each page</b></h1>" >> reports/PageResponseTimeGraphs.html
echo "<div class=\"images\">" >> reports/PageResponseTimeGraphs.html

length=$(cat reports/images/SynthesisReportGui.csv | wc -l)
echo "Length is: $length"
while read line
do
		if  [ $count != 1 ] 
		then
			#Fetch the page name
			pageHeader=$(echo $line | awk -F '[,]' '{print $1;}')
			echo $pageHeader
                if [ "$pageHeader" != "TOTAL" ]
                then    
		
					#Generate a header to add part of the URL 
					pageRequester=$(echo $pageHeader | sed 's/\ /%20/g' | sed 's/\//_/g')
					echo $pageRequester
					#create a name for the image
					pageName=$(echo $pageHeader | sed 's/\ //g'|sed 's/\//-/g'  | sed 's/\?/-/g' | sed 's/\=/-/g' | sed 's/\&/-/g' | sed 's/\*/-/g')
					echo $pageName
					#generate graph with jenkins
					#trendImage="reports/images/Page-$pageName.png $jenkinsProjectUrl/lastBuild/performance/trendReport/respondingTimeGraph?width=$graphs_width_Pixels&height=$graphs_height_Pixels&performanceReportPosition=$jmeter_resultsFile&summarizerTrendUri=$pageRequester"
					#echo $trendImage
					#curl -o $trendImage
				
					#Add images and their headings in html page
					echo "<h3>$pageHeader</h3>" >> reports/PageResponseTimeGraphs.html
					echo "<img src=\"images/Page-$pageName.png\" tooltip=\"$pageHeader\"/>" >> reports/PageResponseTimeGraphs.html 
					echo "<br>" >> reports/PageResponseTimeGraphs.html
				fi
		fi	
		((count++))
done < reports/images/SynthesisReportGui.csv
echo "</div>" >> reports/PageResponseTimeGraphs.html
echo "</body>" >> reports/PageResponseTimeGraphs.html
echo "</html>" >> reports/PageResponseTimeGraphs.html
#awk -F '[,]' '{for(i=1;i<12;i++) {print $i;}}' SynthesisReportGui.csv > reports/PageResponseTimeGraphs.html
