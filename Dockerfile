# FROM ubuntu:22.04
# RUN apt update && apt install openjdk-11-jdk wget -y 
# RUN  wget https://referenceapplicationskhaja.s3.us-west-2.amazonaws.com/spring-petclinic-2.4.2.jar
# WORKDIR /
# CMD ["java", "-jar", "spring-petclinic-2.4.2.jar"]

FROM ubuntu:22.04
RUN apt-get update && apt-get install -y \
    apache2 \
    zip \
    unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip photogenic.zip
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic photogenic.zip
CMD ["apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80