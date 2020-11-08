all: arm.ttl cieran.ttl logic.rules

arm.ttl: prefix.ttl arm.include vf.include abilities.include personality.include spell.include
	cat $^ > $@

%.ttl: prefix.ttl %.include
	cat $^ > $@
%.rules: prefix.ttl %.r
	cat $^ > $@
