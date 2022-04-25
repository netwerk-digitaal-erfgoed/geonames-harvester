# Geonames-harvest

Simple download and transform scripts to download convert geonames dumps into a basic RDF dataset. The output is suitable for querying through the network-of-terms. The transformation is RML based and requires at least the Java RML to be installed. See the [RML repo](https://github.com/RMLio/rmlmapper-java) for more information.

The script also requires the `sed` en `awk` tools for preprocessing. They are avaible in standard Linux distro's.

See the [Geonames download website](https://download.geonames.org/export/dump/) for detailed information on the geonames dumpfiles. Currently only the **NL** and **BE** country dumpfiles are processed.