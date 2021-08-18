# Syntax: docker/dockerfile
FROM centos:7 as centos7 
RUN yum -y update && yum clean all 
 
# Install Ngnix 
RUN yum -y install epel-release && yum -y install nginx 
 
# Copy the nginx configuration file from the current directory 
COPY ./nginx.conf /etc/nginx/nginx.conf 

# Copy the html file from the current directory 
COPY ./index.html /data/www/index.html 

# Get the timestamp of time when the file was created
RUN echo "<h1>Welcome</h1> <p> <b>File Creation date: </b>$(stat -c%y /data/www/index.html | \
          cut -c 1-10)</p>" >> /data/www/index.html 
RUN echo "<p><b>File Timestamps: </b>$(stat /data/www/index.html | \
          tail -n+5 | head -3 | cut -d ' ' -f 1,3 | cut -c 1-16 )</p>" >> /data/www/index.html 

VOLUME [ "/data/www" ] 

EXPOSE 80 

# Execute just after running the container
ENTRYPOINT ["nginx", "-g", "daemon off;"] 
 
RUN echo '[DOCKER] Build completed!'

