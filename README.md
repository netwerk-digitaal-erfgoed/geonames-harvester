# Geonames-harvest

Simple download and transform scripts to download and convert geonames dumps into a basic RDF dataset. The output is suitable querying the data through the network-of-terms once loaded to sparql-endpoint. The transformation is RML based and requires at least the Java RML to be installed. See the [RML repo](https://github.com/RMLio/rmlmapper-java) for more information.

The script also requires the `sed` en `awk` tools for preprocessing. They are avaible in standard Linux distro's.

See the [Geonames download website](https://download.geonames.org/export/dump/) for detailed information on the geonames dumpfiles. Currently only the **NL** and **BE** country dumpfiles are processed.

An example of the created dataset can be found on [the NDE Dataplatform](https://data.netwerkdigitaalerfgoed.nl/NDE/geonames-nl-be).
