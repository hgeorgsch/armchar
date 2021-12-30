#!/bin/sh
# This script creates a TDB database and loads the ontology.
# Note that using TDB is not necessarily the recommended solution.
# Persisting in flat files may be more efficient.

( cd Ontology ; make install )
JDIR=$HOME/prg/apache-jena-3.16.0/bin/
rm -rf tdb
mkdir -p tdb
# $JDIR/tdbloader2 --loc tdb Ontology/arm.ttl  Ontology/resources.ttl 
$JDIR/tdbloader2 --loc tdb Ontology/cieran.ttl Ontology/contested.ttl 

