#! /bin/bash
cd fuseki
docker-compose run --rm --name gnserver --service-ports fuseki --file=/fuseki/databases/geonames.ttl /geonames
cd ..
