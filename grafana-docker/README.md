grafana-docker
=============
#Grafana Docker Resources

This project contains resources that will be used to build and deploy a grafana image in artifactory. Grafana settings, infludb configs, nginx settings, Docker file and supervisord.conf files

##Updating Resource Bundle

To update the grafana in artifactory managed archiva repo, update the project property (DOCKER_TAG=0.7) in the Jenkins  as appropriate and deploy to artifactory with the following job: https://jenkins1.prodwest.citrixsaassbe.net/jenkins/job/Loadtest/job/Framework/job/Deploy_Grafana_Docker_to_Artifactory

##Implementation Notes

Fetch the code from stash using jenkins git plugins. Use Jenkins Docker Build and Publish plugin to deploy the grafana docker im