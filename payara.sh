mvn install
docker stop armchar
docker rm armchar
cp target/armchar-1.0-SNAPSHOT.war payara/armchar.war
docker run --name armchar -p 4848:4848 -p 8080:8080 -v `pwd`/payara:/opt/payara/deployments payara/server-full

