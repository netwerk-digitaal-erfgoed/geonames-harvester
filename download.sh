#!/bin/sh
CONFIG_DIR="$PWD/config"
DATA_DIR="$PWD/data"
CHUNK_SIZE=1000000
mkdir -p $DATA_DIR

# specify countries to download
#country_files="NL BE DE "
country_files="allCountries"
rm -rf $DATA_DIR/geonames.csv temp
for cfile in $country_files; do
    mkdir temp
    cd temp
    printf "\nDownloading $cfile... "
    curl -sSO "https://download.geonames.org/export/dump/$cfile.zip"
    unzip "$cfile.zip"
    cat "$cfile.txt" >> $DATA_DIR/geonames.csv
    rm -rf temp
done

# create foreign keys 'adm1' and 'adm2' for the admin1code and admin2code tables
# $9=country code, $11=admin1 code, $12=admin2 code
# Explicit NONE so we don't need OPTIONAL joins, which speeds up the mapping process.
printf "\nCreating foreign keys... "
awk 'BEGIN{FS=OFS="\t"} {print $0, $9"."$11, ($12 != "" ? $9"."$11"."$12 : "NONE" )}' $DATA_DIR/geonames.csv > $DATA_DIR/geonamesplus.csv
rm $DATA_DIR/geonames.csv

## Cut into chunks.
printf "\nChunking...\n"
rm -rf $DATA_DIR/geonames_*
split -l $CHUNK_SIZE $DATA_DIR/geonamesplus.csv $DATA_DIR/geonames_

# Add header row to each chunk.
for f in $DATA_DIR/geonames_*; do
    echo $f
    csvfile="${f}.csv"
    cat $CONFIG_DIR/headers-gn.csv > $csvfile
    cat $f >> $csvfile
    rm $f
done

printf "\nDownload supporting files... "
cp $CONFIG_DIR/headers-admin1-codes.csv $DATA_DIR/admin1-codes.csv
curl -sS "https://download.geonames.org/export/dump/admin1CodesASCII.txt" >> $DATA_DIR/admin1-codes.csv

cp $CONFIG_DIR/headers-admin2-codes.csv $DATA_DIR/admin2-codes.csv
curl -sS "https://download.geonames.org/export/dump/admin2Codes.txt" >> $DATA_DIR/admin2-codes.csv
