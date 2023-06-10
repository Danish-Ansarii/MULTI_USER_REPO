FROM UBUNTU:22.04
RUN apt update && apt install openjdk-11-jdk wget -y 
RUN  wget https://referenceapplicationskhaja.s3.us-west-2.amazonaws.com/spring-petclinic-2.4.2.jar
WORKDIR /
CMD ["java", "-jar", "spring-petclinic-2.4.2.jar"]
