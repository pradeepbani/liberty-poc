FROM icr.io/appcafe/open-liberty:full-java17-openj9-ubi

COPY --chown=1001:0 src/main/liberty/config/server.xml /config/
COPY --chown=1001:0 target/liberty-poc.war /config/dropins/

RUN configure.sh