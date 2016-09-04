#!/bin/bash
#!/bin/sh

function server_ips() {
        #
        # CAUTION: The logic here assumes that we want to use all
        # active jmeter servers.
        for pid in $(docker ps | grep ${SLAVE_IMAGE} | awk '{print $1}')
        do

          # Get the IP for the current pid
          x=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${pid})

                # Append to SERVER_IPS
                if [[ ! -z "${SERVER_IPS}" ]]; then
                        SERVER_IPS=${SERVER_IPS},
                fi
                SERVER_IPS=${SERVER_IPS}$x
        done
}

SLAVE_IMAGE='santosharakere/docker-grafana-statsd-elk'

SERVER_IPS=
server_ips

echo ${SERVER_IPS}
