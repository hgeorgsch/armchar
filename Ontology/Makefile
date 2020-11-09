all: arm.ttl cieran.ttl logic.rules

arm.ttl: prefix.ttl arm.include 
	cat $^ > $@

arm.ttl: prefix.ttl resources.include vf.include abilities.include personality.include spell.include

%.ttl: prefix.ttl %.include
	cat $^ > $@
%.rules: prefix.ttl %.r
	cat $^ > $@
