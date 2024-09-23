FROM eclipse-temurin:17
LABEL org.opencontainers.image.source = "https://github.com/netwerk-digitaal-erfgoed/geonames-harvester"
WORKDIR /app
RUN mkdir bin
RUN curl -L https://github.com/carml/carml-jar/raw/nde/carml-jar-jena-1.4.0-SNAPSHOT-0.4.10.jar -o bin/carml.jar
RUN apt-get update && apt-get install zip -y && rm -rf /var/lib/apt/lists/*
COPY . .
