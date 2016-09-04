#!/bin/bash
count=0
echo "<html>" > reports/AggregateReportGui.html
echo "<head>" >> reports/AggregateReportGui.html
echo "<title>Aggregate Report</title>" >> reports/AggregateReportGui.html
echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"commonstyle.css\">" >> reports/AggregateReportGui.html
echo "</head>" >> reports/AggregateReportGui.html
echo "<body>" >> reports/AggregateReportGui.html
echo "<h1><b>Aggregate Report</b></h1>" >> reports/AggregateReportGui.html
echo "<table border=5 bordercolor=cyan>" >> reports/AggregateReportGui.html

col_header="Label,# Samples,Average,Median,90%Line,Min,Max,Error %,Throughput/sec,KB/Sec,StdDev"
while read line
do
	#echo "Line count is:$count, line is : $line"
        if [ `expr $count % 2` -eq 0 ]
	then
        	cls="d0"
        else
                cls="d1"
	fi
	
	if [ $count == 0 ]
	then
		echo "<tr>" >> reports/AggregateReportGui.html
		echo $col_header | awk -F '[,]' '{for(i=1;i<12;i++) 
			if (i==1)
				print "\t<th height=30>",$i,"</th>";
			else
				print "\t<th width=100>",$i,"</th>";
                }' >> reports/AggregateReportGui.html
	else
		echo "<tr class=\"$cls\">" >> reports/AggregateReportGui.html
		echo $line | awk -F '[,]' '{for(i=1;i<12;i++)
			if (i==1)
				print "\t<td>",$i,"</td>";
			else if (i == 9 || i==10 || i==11) 
				printf "\t<td width=100>%3.2f",$i,"</td>";
			else if (i==8)
				printf "\t<td width=100>%3.2f",$i*100,"</td>";
			else 
				print "\t<td width=100>",$i,"</td>";
			 }' >> reports/AggregateReportGui.html
	fi
	echo "</tr>" >> reports/AggregateReportGui.html	
	((count++))
done < reports/images/AggregateReportGui.csv
echo "</table>" >> reports/AggregateReportGui.html
echo "</body>" >> reports/AggregateReportGui.html
echo "</html>" >> reports/AggregateReportGui.html
#awk -F '[,]' '{for(i=1;i<12;i++) {print $i;}}' AggregateReportGui.csv > reports/AggregateReportGui.html
