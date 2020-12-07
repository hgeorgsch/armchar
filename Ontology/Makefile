TTL=arm.ttl cieran.ttl logic.rules resources.ttl contested.ttl basic.rules
all: $(TTL)
install: $(TTL)
	cp $(TTL) ../serverdata/
R=resources.include vf.include abilities.include personality.include grimoire.include
A=arm.include trait.include advancement.include spell.include ignore.include pyramid.include equipment.include 
L=logic.r advancement.r age.r castingscore.r subclass.r vf.r traitinherit.r

resources.ttl: prefix.ttl $R
arm.ttl: prefix.ttl $A

cieran.ttl: prefix.ttl cieran.include advcieran.include seasons.include 
logic.rules: prefix.ttl $L 
	cat $^ > $@
basic.rules: prefix.ttl basic.r
	cat $^ > $@

%.ttl: prefix.ttl %.include
	cat $^ > $@

clean:
	-rm $(TTL)

