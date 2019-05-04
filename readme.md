# Docker - LAB 1
## Introduction to Docker
[Docker Documentation](https://docs.docker.com/)

### Sample of how deploying a Web App to Tomcat on Docker


```script
// Building the image from the Dockerfile (on your local docker)
 $ docker build -t mt-app .
 
// Create a container from previous image, then running (your Tomcat application) 
// and expose the 8080 internal port to the external localhost:80
 $ docker run -p 80:8080 mt-app

// In order to check the log files produced by your App
 $ docker container ls <-- TO GET IMAGE_APP_ID
 $ docker exec -it <IMAGE_APP_ID> ls -latr /var/share/nbd-rest/logs
 ```
