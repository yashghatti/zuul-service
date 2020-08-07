FROM openjdk:slim
WORKDIR /etc/app
COPY build/libs/zuul-service.jar zuul.jar
ENTRYPOINT ["java","-jar","/etc/app/zuul.jar"]