#!/bin/bash
count=0
echo "<html>" > reports/SynthesisReportGui.html
echo "<head>" >> reports/SynthesisReportGui.html
echo "<title>Summary Report</title>" >> reports/SynthesisReportGui.html
echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"commonstyle.css\">" >> reports/SynthesisReportGui.html
echo "</head>" >> reports/SynthesisReportGui.html
echo "<body>" >> reports/SynthesisReportGui.html
echo "<h1><b>Summary Report</b></h1>" >> reports/SynthesisReportGui.html
echo "<table border=5 bordercolor=cyan>" >> reports/SynthesisReportGui.html

col_header="Label,# Samples,Average,Min,Max,90%Line,StdDev,Error %,Throughput/sec,KB/sec,Avg. Bytes"
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
		echo "<tr>" >> reports/SynthesisReportGui.html
		echo $col_header | awk -F '[,]' '{for(i=1;i<12;i++) 
		if (i==1)
			print "\t<th height=\"30\">"$i"</th>";
		else
			print "\t<th height=30 width=100>"$i"</th>";
		}' >> reports/SynthesisReportGui.html

	else
		echo "<tr class=\"$cls\">" >> reports/SynthesisReportGui.html
		#echo $line | awk -F '[,]' '{for(i=1;i<12;i++) {print "\t<td>"$i"</td>";}}' >> reports/SynthesisReportGui.html 
		echo $line | awk -F '[,]' '{for(i=1;i<12;i++)
			if (i==1)
				print "\t<td>",$i,"</td>"; 
			else if (i==7 || i == 9 || i==10 || i==11) 
				printf "\t<td width=100>%3.2f",$i,"</td>"; 
			else if (i==8)
				printf "\t<td width=100>%3.2f",$i*100,"</td>";
			else 
				print "\t<td width=100>",$i,"</td>"; 
			 }' >> reports/SynthesisReportGui.html
	fi
	echo "</tr>" >> reports/SynthesisReportGui.html	
	((count++))
done < reports/images/SynthesisReportGui.csv
echo "</table>" >> reports/SynthesisReportGui.html
echo "</body>" >> reports/SynthesisReportGui.html
echo "</html>" >> reports/SynthesisReportGui.html
#awk -F '[,]' '{for(i=1;i<12;i++) {print $i;}}' SynthesisReportGui.csv > reports/SynthesisReportGui.html
