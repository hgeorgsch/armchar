A=arm.ttl cieran.ttl logic.rules resources.ttl
all: $A
install: $A
	cp $A ../serverdata/

resources.ttl: prefix.ttl resources.include vf.include abilities.include personality.include 
arm.ttl: prefix.ttl arm.include spell.include

%.ttl: prefix.ttl %.include
	cat $^ > $@
%.rules: prefix.ttl %.r
	cat $^ > $@
clean:
	-rm $A
