all: arm.ttl cieran.ttl

arm.ttl: prefix.ttl arm.include vf.include
	cat $^ > $@

%.ttl: prefix.ttl %.include
	cat $^ > $@
