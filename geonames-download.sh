#!/bin/bash
CONFIG_DIR="$PWD/config"
DATA_DIR="./data"
if [ ! -d "$DATA_DIR" ]; then
    mkdir $DATA_DIR
fi

# specify countries to download
country_files="NL BE"
cp $CONFIG_DIR/headers-gn.txt $DATA_DIR/geonames.txt
for cfile in $country_files; do
    mkdir temp
    cd temp
    curl -O "https://download.geonames.org/export/dump/$cfile.zip"
    unzip "$cfile.zip"
    cd ..
    cat "temp/$cfile.txt" >> $DATA_DIR/geonames.txt
    rm -rf temp
done

# create foreign keys 'adm1' and 'adm2' for the admin1code and admin2code tables
# $9=country code, $11=admin1 code, $12=admin2 code
awk 'BEGIN{FS=OFS="\t"} {print $0, (NR>1 ? $9"."$11 : "adm1"),(NR>1 ? $9"."$11"."$12 : "adm2")}' $DATA_DIR/geonames.txt > $DATA_DIR/geonamesplus.txt
rm $DATA_DIR/geonames.txt

# download latest version of generic files
cp $CONFIG_DIR/headers-feature-codes.txt $DATA_DIR/feature-codes.txt
curl -O "https://download.geonames.org/export/dump/featureCodes_en.txt"
cat featureCodes_en.txt >> $DATA_DIR/feature-codes.txt
rm featureCodes_en.txt

cp $CONFIG_DIR/headers-admin1-codes.txt $DATA_DIR/admin1-codes.txt
curl -O "https://download.geonames.org/export/dump/admin1CodesASCII.txt"
cat admin1CodesASCII.txt >> $DATA_DIR/admin1-codes.txt
rm admin1CodesASCII.txt

cp $CONFIG_DIR/headers-admin2-codes.txt $DATA_DIR/admin2-codes.txt
curl -O "https://download.geonames.org/export/dump/admin2Codes.txt"
# remove double quotes that seem to appear within some strings
# to prevent RML from crashing
sed -i 's/"//g' admin2Codes.txt
cat admin2Codes.txt >> $DATA_DIR/admin2-codes.txt
rm admin2Codes.txt
