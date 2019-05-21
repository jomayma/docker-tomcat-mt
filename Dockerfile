# Using Apache Tomcat Alpine as a parent image (more info here: https://hub.docker.com/_/tomcat)
# This image is based on the popular Alpine Linux project, available in the alpine official image.
# Alpine Linux is much smaller than most distribution base images (~5MB)
FROM tomcat:7-alpine

LABEL maintainer="jmayomartin@gmail.com"

# Setting a particular JVM option for your application server environment.
ENV JAVA_OPTS="-DMWA_ENV=DEV"

# Adding the sample webapp and placing it in the folder /usr/local/tomcat/webapps/ on the container.
# According to the Tomcat documentation, the War should be placed under CATALINA_BASE/webapps.
# From the Tomcat image documentation, we know that the default path CATALINA_BASE corresponds to /usr/local/tomcat on the container.
# The War file will be automatically expanded and deployed. 
# it not works on openshift
#ADD nbd-rest.war /usr/local/tomcat/webapps/

#COPY nbd-rest.war /usr/local/tomcat/webapps/nbd-rest/
#WORKDIR /usr/local/tomcat/webapps/nbd-rest/
#RUN unzip -q ./nbd-rest.war && \
#  rm /usr/local/tomcat/webapps/nbd-rest/nbd-rest.war

# Adding extra files(in this sample a utility zip file used by the webapp) into the container.
#COPY nbd-rest.zip /var/share/nimplatform/

# Set the working directory to /var/share/nimplatform/
#WORKDIR /var/share/nimplatform/

# Uncompress the previous utility zip file and removing it after decompression.
#RUN unzip -q ./nbd-rest.zip  && rm ./nbd-rest.zip

COPY nbd-rest.war nbd-rest.zip /tmp/

##Adding to your Dockerfile directory and file permissions to allow users in the root group to access them in the built image
# /var/share for App and /usr/local/tomcat for Tomcat deployment
WORKDIR /usr/local/tomcat/webapps/nbd-rest/
WORKDIR /var/share/nimplatform/
RUN unzip -q /tmp/nbd-rest.war -d /usr/local/tomcat/webapps/nbd-rest/ && \
    unzip -q /tmp/nbd-rest.zip -d /var/share/nimplatform/ && \
    rm /tmp/nbd-rest.zip && \
    rm /tmp/nbd-rest.war && \
    chgrp -R 0 /var/share && \
    chmod -R g=u /var/share && \
    chgrp -R 0 /usr/local/tomcat && \
    chmod -R g=u /usr/local/tomcat

### Containers should NOT run as root as a good practice
USER 10001

#The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime.
EXPOSE 8080

# The CMD instruction specifies what to run when the container (not the image) is run.
# In our case, TomCat server is started by running the shell script that starts the web container.
# There can only be one CMD instruction in a Dockerfile.
# Don’t confuse RUN with CMD. RUN actually runs a command at build time.
CMD ["catalina.sh", "run"]