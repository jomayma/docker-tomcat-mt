FROM tomcat:8.0-alpine
LABEL maintainer="jmayomartin@gmail.com"

ENV JAVA_OPTS="-DMWA_ENV=DEV"

ADD nbd-rest.war /usr/local/tomcat/webapps/

ADD nbd-rest.zip /var/share/nimplatform/

WORKDIR /var/share/nimplatform/

RUN unzip ./nbd-rest.zip  && rm ./nbd-rest.zip

EXPOSE 8080
CMD ["catalina.sh", "run"]