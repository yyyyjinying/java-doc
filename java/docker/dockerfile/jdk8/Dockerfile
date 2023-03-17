FROM openjdk:8
WORKDIR /app
ADD demo-0.0.1-SNAPSHOT.jar /app/demo.jar
ENTRYPOINT ["java", "-jar"]
CMD ["demo.jar"]

docker build -t demo-01:v1
docker run -d -p 6060:6060 --name demo-01 demo-01:v1