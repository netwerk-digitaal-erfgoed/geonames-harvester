#!/bin/bash

# specify countries to download
country_files="NL BE"
cp config/headers-gn.txt geonames.txt
for cfile in $country_files; do
    mkdir temp
    cd temp
    wget "https://download.geonames.org/export/dump/$cfile.zip"
    unzip "$cfile.zip"
    cd ..
    cat "temp/$cfile.txt" >> geonames.txt
    rm -rf temp
done

# create foreign keys 'adm1' and 'adm2' for the admin1code and admin2code tables
# $9=country code, $11=admin1 code, $12=admin2 code
awk 'BEGIN{FS=OFS="\t"} {print $0, (NR>1 ? $9"."$11 : "adm1"),(NR>1 ? $9"."$11"."$12 : "adm2")}' geonames.txt > geonamesplus.txt
rm geonames.txt 

# download latest version of generic files
cp config/headers-feature-codes.txt feature-codes.txt
wget "https://download.geonames.org/export/dump/featureCodes_en.txt"
cat featureCodes_en.txt >> feature-codes.txt
rm featureCodes_en.txt

cp config/headers-admin1-codes.txt admin1-codes.txt
wget "https://download.geonames.org/export/dump/admin1CodesASCII.txt"
cat admin1CodesASCII.txt >> admin1-codes.txt
rm admin1CodesASCII.txt

cp config/headers-admin2-codes.txt admin2-codes.txt
wget "https://download.geonames.org/export/dump/admin2Codes.txt"
# remove double quotes that seem to appear within some strings
# to prevent RML from crashing
sed -i 's/"//g' admin2Codes.txt
cat admin2Codes.txt >> admin2-codes.txt
rm admin2Codes.txt
