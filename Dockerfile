# syntax=docker/dockerfile:experimental
FROM bellsoft/liberica-openjdk-alpine-musl:17 AS build
RUN mkdir /app

COPY app.jar app/app.jar
WORKDIR /app

ENTRYPOINT ["java","-jar","app.jar", "--server.port=80"]
#
#
#HEALTHCHECK CMD curl --fail http://localhost:80/status || exit