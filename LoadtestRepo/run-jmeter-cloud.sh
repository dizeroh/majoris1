if [[ "$#" -ne 3 ]]; then
	echo "Run the test script as:"
	echo "runJMeterCould.sh <JMeter Script path> <number of JMeter Slaves> <grafana enabled - yes/no?>"
	exit 1
fi


. ${1}/project.properties

cp ${1}/project.properties .
echo "grafana enabled choice is : ${3}"

rm -rf logs.bak
chmod 777 driver.sh
./driver.sh -p ${1}/project.properties  -n ${2} -j ${JMTR_PATH} -g ${3}
