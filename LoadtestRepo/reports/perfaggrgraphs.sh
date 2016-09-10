#!/bin/sh
#call project properties
. $1/project.properties

#Aggregate graph names
array=( ThreadsStateOverTime TimesVsThreads TransactionsPerSecond )
#Generate Aggregate Graphs
for aggGraph in "${array[@]}"
do
        echo "Aggregate Graph - ${aggGraph}"
        java -jar ${JMTR_PATH}/lib/ext/CMDRunner.jar --tool Reporter --generate-png ${reports_location}reports/images/Aggr-${aggGraph}.png --input-jtl  ${logs_location}/${jmeter_resultsFile} --plugin-type ${aggGraph} --width $graphs_width_Pixels --height $graphs_height_Pixels --aggregate-rows yes --paint-gradient no --paint-zeroing yes --paint-markers yes
done

#Independent graph names
array=( ThreadsStateOverTime BytesThroughputOverTime HitsPerSecond LatenciesOverTime ResponseCodesPerSecond ResponseTimesDistribution ResponseTimesOverTime ResponseTimesPercentiles ThroughputVsThreads TimesVsThreads TransactionsPerSecond PageDataExtractorOverTime )

#Independent graph generation
for graphName in "${array[@]}"
do
        echo "Graph - ${graphName}"
        java -jar ${JMTR_PATH}/lib/ext/CMDRunner.jar --tool Reporter --generate-png ${reports_location}reports/images/${graphName}.png --input-jtl  ${logs_location}/${jmeter_resultsFile} --plugin-type ${graphName} --width $graphs_width_Pixels --height $graphs_height_Pixels --aggregate-rows no --paint-gradient no --paint-zeroing yes --paint-markers yes
done

#Generate csv reports
array=( AggregateReport SynthesisReport )

for csvReport in "${array[@]}"
do
        echo "CSV report - ${csvReport}"
        java -jar ${JMTR_PATH}/lib/ext/CMDRunner.jar --tool Reporter --generate-csv ${reports_location}reports/images/${csvReport}Gui.csv --input-jtl  ${logs_location}/${jmeter_resultsFile} --plugin-type ${csvReport}
done
