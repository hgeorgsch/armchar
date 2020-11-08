all: arm.ttl cieran.ttl

%.ttl: prefix.ttl %.include
	cat $^ > $@
