FROM payara/server-full

RUN mkdir -p /opt/payara/{tdb,serverdata}
# COPY myapplication.war $DEPLOY_DIR

