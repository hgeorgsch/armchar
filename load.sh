#!/bin/sh
# This is made for testing.
# It downloads JSON files from the server for validation.
# A side effect is that it forces the server to load the data files
# and infer the derived graphs, which may be useful when the server
# is restarted.

# curl http://localhost:8080/armchar/Advancement/cieran > adv.json
curl http://localhost:8080/armchar/Advancement/framed/cieran > framed.json
curl http://localhost:8080/armchar/Advancement/unframed/cieran > unframed.json
curl http://localhost:8080/armchar/Character/cieran > cieran.json
curl http://localhost:8080/armchar/Character/cieran/1217/Summer > summer1217.json
curl http://localhost:8080/armchar/dump/jsonld-inf > dump.json

