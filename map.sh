#! /bin/bash
DATA_DIR="$PWD/data"
BIN_DIR="$PWD/bin"
CONFIG_DIR="$PWD/config"
OUTPUT_DIR="$DATA_DIR"
cd $DATA_DIR
echo "Running the RMLmapper to convert geonames data to RDF, be patient..."
java -jar $BIN_DIR/carml.jar map -m $CONFIG_DIR/geonames.ttl -r . -o $OUTPUT_DIR/geonames.nt
