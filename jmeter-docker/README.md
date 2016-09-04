jmeter-docker
=============
#JMeter Docker Resources

This project contains resources that will be used to build and deploy a jmeter-docker image in artifactory. JMeter property files, Docker file, a project.properties file.

##Updating Resource Bundle

To update the jmeter in artifactory managed archiva repo, update the project version in the POM as appropriate and deploy to artifactory with the following job: https://jenkins1.prodwest.citrixsaassbe.net/jenkins/job/Loadtest/job/Framework/job/Deploy_JMeter_Docker_to_Artifactory/

##Implementation Notes

The performance-test-framework POM is parent to this project (it distributionManagement config specified in parent POM when deploying artifacts).
The maven-remote-resources-plugin is used to bundle the project resourcse and it is used in the performance-test-framework POM to unpack the artifact.
The parent POM unpacks these shared resources in the target directory and they are accessible to other steps in the build at ${project.build.directory}/maven-shared-archive-resources/