JDIR=$HOME/prg/apache-jena-3.16.0/bin/
rm -rf tdb
mkdir -p tdb
# $JDIR/tdbloader2 --loc tdb Ontology/arm.ttl  Ontology/resources.ttl 
$JDIR/tdbloader2 --loc tdb Ontology/cieran.ttl 

