FROM jenkins:2.60.3

## TO-DO Copy the custom plugins

USER root
# Update Ubuntu and install git, curl and mysql-server
#RUN apt-get -y update && apt-get -y dist-upgrade && apt-get install -y git curl && rm -rf /var/lib/apt/lists/*
#RUN apt-get -y update && apt-get -y dist-upgrade && apt-get install -y netcat && rm -rf /var/lib/apt/lists/*
#RUN apt-get install -y netcat

#Install Ansibel
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  #apt-get -y upgrade && \
  apt-get install -y software-properties-common && \
  apt-get install -y python-pip python-boto python-dev libffi-dev && \
#  apt-get install -y build-essential && \

#  apt-get install -y  curl git  unzip vim wget && \
  pip install ansible 

# Install Sonar Scanner

#RUN wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.0.3.778-linux.zip

COPY sonar-scanner-cli-3.0.3.778-linux.zip .
RUN unzip sonar-scanner-cli-3.0.3.778-linux
RUN mv sonar-scanner-3.0.3.778-linux /opt/sonar-scanner

COPY apache-maven-3.5.2-bin.zip .
RUN unzip apache-maven-3.5.2-bin.zip
RUN mv apache-maven-3.5.2 /opt/apache-maven

ENV PATH="/opt/apache-maven/bin:${PATH}"
#RUN chmod 777 /opt/apache-maven/bin


#RUN mkdir -p /var/jenkins_home/jobs/DemoSuccessV2
#RUN mkdir -p /var/jenkins_home/jobs/Rollback_DEV
#RUN mkdir -p /var/jenkins_home/jobs/SIT_Deploy

#COPY jenkins-jobs/DemoSuccessV2.xml  /var/jenkins_home/jobs/DemoSuccessV2/config.xml
#COPY jenkins-jobs/Rollback_DEV.xml /var/jenkins_home/jobs/Rollback_DEV/config.xml
#COPY jenkins-jobs/SIT_Deploy.xml /var/jenkins_home/jobs/SIT_Deploy/config.xml





# TO-DO - Start the sonar Scanner Server -during startup
#Implement SonarQube server as a service 
#RUN cp /opt/sonar/bin/linux-x86-64/sonar.sh /etc/init.d/sonar
#RUN echo  "SONAR_HOME=/opt/sonar" >> /etc/init.d/sonar
#RUN echo "PLATFORM=linux-x86-64" >> /etc/init.d/sonar
#docker run -p 8080:8080 -p 50000:50000 jenkins-test


# Update the Sonar Scanner to point to Sonar Server
#RUN sed -i 's/\#sonar/sonar/g' /opt/sonar-scanner/conf/sonar-scanner.properties && \
# sed -i 's/localhost/servicevalsonarqube/g' /opt/sonar-scanner/conf/sonar-scanner.properties && \
# echo "sonar.projectKey=Projects" >> /opt/sonar-scanner/conf/sonar-scanner.properties && \
# echo "sonar.projectName=IIBCodeReivewUsingSonar" >> /opt/sonar-scanner/conf/sonar-scanner.properties && \
# echo "sonar.projectVersion=1.0" >> /opt/sonar-scanner/conf/sonar-scanner.properties && \
# 
# echo "sonar.modules=esql-module,messageflow-module" >> /opt/sonar-scanner/conf/sonar-scanner.properties && \
 
# echo "esql-module.sonar.language=esql" >> /opt/sonar-scanner/conf/sonar-scanner.properties && \
# echo "esql-module.sonar.projectBaseDir=/var/lib/jenkins/jobs/IIBCodeReview/workspace" >> /opt/sonar-scanner/conf/sonar-scanner.properties && \
# echo "esql-module.sonar.sources=Projects" >> /opt/sonar-scanner/conf/sonar-scanner.properties && \
 
# echo "messageflow-module.sonar.language=msgflow" >> /opt/sonar-scanner/conf/sonar-scanner.properties && \
# echo "messageflow-module.sonar.projectBaseDir=/var/lib/jenkins/jobs/IIBCodeReview/workspace" >> /opt/sonar-scanner/conf/sonar-scanner.properties


#RUN /usr/local/bin/install-plugins.sh sonar 

#COPY start-sonar.sh /usr/local/bin/start-sonar.sh
#RUN chmod +x /usr/local/bin/start-sonar.sh

#COPY wait-script.sh /usr/local/bin/wait-script.sh
#RUN chmod +x /usr/local/bin/wait-script.sh
#RUN /usr/local/bin/wait-script.sh



# TO-DO : Copy the Jenkins Service Validator JAR file to Jenkins Job folder
# TO-DO : Copy the Jenkins Code Coverage JAR file to Jenkins Job folder

#ENTRYPOINT [/opt/sonar-scanner/bin/sonar-scanner]
#CMD ["/usr/local/bin/wait-script.sh"]
#CMD ["/opt/sonar-scanner/bin/sonar-scanner"]

USER jenkins
# Add Jenkins plugins
#COPY plugins.txt /usr/share/jenkins/plugins.txt
#RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt



