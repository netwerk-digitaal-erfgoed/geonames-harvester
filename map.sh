#! /bin/bash
DATA_DIR="$PWD/data"
BIN_DIR="$PWD/bin"
CONFIG_DIR="$PWD/config"
OUTPUT_DIR="$PWD/fuseki/databases"
cd $DATA_DIR
echo "Running the RMLmapper to convert geonames data to RDF, be patient..."
java -jar $BIN_DIR/rmlmapper.jar -m $CONFIG_DIR/geonames.rml -o $OUTPUT_DIR/geonames.nt
cd ..
# This RML mapping creates triples with empty object values.
# The following sed command remove every line with a "". pattern.
sed -i '/\"\"./d' $OUTPUT_DIR/geonames.nt
