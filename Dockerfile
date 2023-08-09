FROM --platform=linux/x86_64 eclipse-temurin:17-jdk-alpine
VOLUME /tmp
COPY build/libs/api-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]


#HEALTHCHECK CMD curl --fail http://localhost:80/healthz || exit