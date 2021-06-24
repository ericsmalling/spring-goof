FROM maven:3-openjdk-8 as build
#FROM openjdk:8-buster

#RUN apt-get update -y && apt-get install -y maven

COPY pom.xml /tmp/code/pom.xml
COPY src /tmp/code/src
WORKDIR /tmp/code
RUN --mount=type=cache,target=/root/.m2 mvn package

FROM openjdk:8-buster
COPY --from=build /tmp/code/target/spring-goof-0.0.1-SNAPSHOT.jar /app.jar
WORKDIR /

CMD ["java","-jar","/app.jar"]