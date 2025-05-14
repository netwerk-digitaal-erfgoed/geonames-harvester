FROM eclipse-temurin:21-jre
LABEL org.opencontainers.image.source="https://github.com/netwerk-digitaal-erfgoed/geonames-harvester"
ENV SPARQL_ANYTHING_VERSION=v1.0-DEV.15
ENV SPARQL_ANYTHING_JAR="sparql-anything-$SPARQL_ANYTHING_VERSION.jar"
WORKDIR /app
RUN mkdir bin

RUN apt-get update && apt-get install zip -y && rm -rf /var/lib/apt/lists/*
RUN curl -L https://github.com/SPARQL-Anything/sparql.anything/releases/download/$SPARQL_ANYTHING_VERSION/$SPARQL_ANYTHING_JAR -o bin/$SPARQL_ANYTHING_JAR
COPY . .
