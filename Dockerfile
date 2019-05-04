# Using Apache Tomcat Alpine as a parent image (more info here: https://hub.docker.com/_/tomcat)
# This image is based on the popular Alpine Linux project, available in the alpine official image.
# Alpine Linux is much smaller than most distribution base images (~5MB)
FROM tomcat:8.0-alpine

LABEL maintainer="jmayomartin@gmail.com"

# Setting a particular JVM option for your application server environment.
ENV JAVA_OPTS="-DMWA_ENV=DEV"

# Adding the sample webapp and placing it in the folder /usr/local/tomcat/webapps/ on the container.
# According to the Tomcat documentation, the War should be placed under CATALINA_BASE/webapps.
# From the Tomcat image documentation, we know that the default path CATALINA_BASE corresponds to /usr/local/tomcat on the container.
# The War file will be automatically expanded and deployed. 
ADD nbd-rest.war /usr/local/tomcat/webapps/

# Adding extra files(in this sample a utility zip file used by the webapp) into the container.
ADD nbd-rest.zip /var/share/nimplatform/

# Set the working directory to /var/share/nimplatform/
WORKDIR /var/share/nimplatform/

# Uncompress the previous utility zip file and removing it after decompression.
RUN unzip ./nbd-rest.zip  && rm ./nbd-rest.zip

#The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime.
EXPOSE 8080

# The CMD instruction specifies what to run when the container (not the image) is run.
# In our case, TomCat server is started by running the shell script that starts the web container.
# There can only be one CMD instruction in a Dockerfile.
# Don’t confuse RUN with CMD. RUN actually runs a command at build time.
CMD ["catalina.sh", "run"]