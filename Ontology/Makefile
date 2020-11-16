A=arm.ttl cieran.ttl logic.rules resources.ttl contested.ttl
all: $A
install: $A
	cp $A ../serverdata/

resources.ttl: prefix.ttl resources.include vf.include abilities.include personality.include grimoire.include
arm.ttl: prefix.ttl arm.include trait.include advancement.include spell.include ignore.include pyramid.include

%.ttl: prefix.ttl %.include
	cat $^ > $@
logic.rules: prefix.ttl logic.r advancement.r
	cat $^ > $@
clean:
	-rm $A
