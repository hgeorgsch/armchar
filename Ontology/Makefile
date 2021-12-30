TTL=arm.ttl cieran.ttl logic.rules resources.ttl contested.ttl basic.rules
all: $(TTL)
install: $(TTL)
	cp $(TTL) ../serverdata/
R=Resources/resources.include Resources/vf.include Resources/abilities.include Resources/personality.include Resources/grimoire.include Resources/weapons.include
A=ArM/arm.include ArM/trait.include ArM/advancement.include ArM/spell.include ArM/ignore.include ArM/pyramid.include ArM/equipment.include ArM/lists.include
L=Rules/logic.r Rules/advancement.r Rules/age.r Rules/castingscore.r Rules/subclass.r Rules/vf.r Rules/traitinherit.r Rules/equipment.r

resources.ttl: prefix.ttl $R
arm.ttl: prefix.ttl $A

cieran.ttl: prefix.ttl Character/cieran.include Character/advcieran.include seasons.include 
logic.rules: prefix.ttl $L 
	cat $^ > $@
basic.rules: prefix.ttl Rules/basic.r
	cat $^ > $@

%.ttl: prefix.ttl %.include
	cat $^ > $@

clean:
	-rm $(TTL)

