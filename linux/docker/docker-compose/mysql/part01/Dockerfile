FROM openjdk:8
ENV app=/app
WORKDIR $app
ADD springboot-03-mybatis-plus-0.0.1-SNAPSHOT.jar $app/demo.jar
ENTRYPOINT ["java", "-jar"]
CMD ["demo.jar"]
