if [[ "$#" -ne 3 ]]; then
	echo "Run the test script as:"
	echo "runJMeterCould.sh <JMeter Script path> <number of JMeter Slaves> <grafana enabled - yes/no?>"
	exit 1
fi

. ${1}/majoris.properties

echo "grafana enabled choice is : ${3}"

rm -rf logs.bak
chmod 777 driver.sh
./driver.sh -s ${1}/${test_script} -d ${1}/data -n ${2} -p ${1}/majoris.properties -j /var/lib/jmeter/bin -g ${3}
