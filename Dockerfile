# syntax=docker/dockerfile:experimental
FROM bellsoft/liberica-openjdk-alpine-musl:17 AS build
WORKDIR /workspace/app

COPY . /workspace/app
RUN --mount=type=cache,target=/root/.gradle ./gradlew clean build
RUN mkdir -p build/dependency && (cd build/dependency; jar -xf ../libs/*-SNAPSHOT.jar)

FROM bellsoft/liberica-openjdk-alpine-musl:17
VOLUME /tmp
ARG DEPENDENCY=/workspace/app/build/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","click.passwordpusher.api.PasswordpusherapiApplication", "--server.port=80"]

HEALTHCHECK CMD curl --fail http://localhost:80/status || exit