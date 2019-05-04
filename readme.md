# Docker - LAB 1
## Introduction to Docker
[Docker Documentation](https://docs.docker.com/)

### Sample of how deploying a Web App to Tomcat on Docker


```script
Building the image (on local docker)
 $ docker build -t mt-app .
 
Running the image of your Tomcat application
 $ docker run -p 80:8080 mt-app

In order to check the log files produced by your App
 $ docker container ls <-- TO GET IMAGE_APP_ID
 $ docker exec -it <IMAGE_APP_ID> ls -latr /var/share/nbd-rest/logs
 ```
