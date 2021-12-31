# armchar

There is a [client](https://github.com/hgeorgsch/armchar-client) to go with this project.
Note that this is but a rudimentary prototype, particularly the client.

## Quick start

All the commands should be run from the project root.
First, we need to build the ontology files:

```sh
( cd Ontology ; make install )
```

The second step is to initialise the TDB database. You need to
have the Jena library available and use its tdbloader2 script.
Run the following commands from the project root.

```sh
JDIR=$HOME/prg/apache-jena-3.16.0/bin/
rm -rf tdb
mkdir -p tdb
$JDIR/tdbloader2 --loc tdb Ontology/cieran.ttl Ontology/contested.ttl 
```

Finally, we build and start the web server.
This requires docker.  Depending on the docker installation, you may
or may not need to change the permissions and ownership of the tdb
directory.

```
mvn install || exit
mkdir -p payara
cp target/armchar-1.0-SNAPSHOT.war payara/armchar.war
docker build -t armchar .
docker run --name armchar -p 8080:8080 -v `pwd`/payara:/opt/payara/deployments -v `pwd`/serverdata:/opt/payara/serverdata  -v `pwd`/tdb:/opt/payara/tdb  armchar
```

The server takes a while to start.  You can test it by downloading
character data, for instance,

```sh
curl http://localhost:8080/armchar/Character/cieran/1217/Summer > summer1217.json
```

Note that it takes a couple of minutes to initialise.
This is a one-time cost, however, as the inference graph is built.
