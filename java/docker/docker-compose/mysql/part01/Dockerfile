FROM openjdk:8-jdk-alpine
ENV app=/app
WORKDIR $app
ADD ./target/demo-consumer-1.0-SNAPSHOT.jar $app/demo-consumer-test.jar
ADD ./logs $app/logs
RUN ["sh", "-c", "echo hello"]
EXPOSE 8088
ENTRYPOINT ["java", "-Dspring.profiles.active=test", "-jar"]
CMD ["demo-consumer-test.jar"]

# docker run --name test -d -p 8088:8088 -v /Users/yyyyjinying/demo-file/git/backend/dubbo/dubbo-spring-boot-study/demo-consumer/mm:/app/logs test:v1