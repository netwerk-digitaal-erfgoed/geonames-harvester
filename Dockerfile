FROM eclipse-temurin:17
WORKDIR /app
RUN mkdir bin
RUN curl -L https://github.com/RMLio/rmlmapper-java/releases/download/v5.0.0/rmlmapper-5.0.0-r362-all.jar -o bin/rmlmapper.jar
RUN apt-get update && apt-get install zip -y && rm -rf /var/lib/apt/lists/*
COPY . .
