#! /bin/bash
DATA_DIR="$PWD/data"
BIN_DIR="$PWD/bin"
CONFIG_DIR="$PWD/config"
FUSEKI_DB="$PWD/fuseki/databases"
cd $DATA_DIR
echo "Running the RMLmapper to convert geonames data to RDF, be patiend..."
java -jar $BIN_DIR/rmlmapper.jar -m $CONFIG_DIR/geonames.rml -o $FUSEKI_DB/geonames.nt
cd ..
# This RML mapping creates triples with empty object values.
# The following sed command remove every line with a "". pattern. 
sed -i '/\"\"./d' $FUSEKI_DB/geonames.nt