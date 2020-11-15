[ advancecharsheet:
  ( ?adv rdf:type arm:TraitAdvancement )
  ( ?adv arm:advanceCharacter ?bc )
  ( ?adv arm:atSeasonTime ?time )
  ( ?cs arm:isCharacter ?bc )
  ( ?cs arm:atSeasonTime ?time )
  -> ( ?adv  arm:advanceCharacterSheet ?cs ) ]

[ nextcharactersheet:
  ( ?cs rdf:type arm:CharacterSheet )
  ( ?cs arm:isCharacter ?c )
  ( ?cs arm:atSeasonTime ?time )
  ( ?time arm:isPrecedingSeasonOf ?nt )
  -> makeInstance(?cs, arm:hasNextCharacterSheet, arm:CharacterSheet, ?x)	
  ( ?x arm:atSeasonTime ?nt )
  ( ?x arm:isCharacter ?c )
  ]

[ advancedtrait:
   ( ?adv rdf:type arm:hasTraitAdvancement )
   ( ?adv  arm:advanceCharacterSheet ?cs ) 
   ( ?adv  arm:advanceTrait ?tc )
   ( ?cs  arm:hasTrait ?trait )
   ( ?trait  rdf:type ?tc )
   -> ( ?trait arm:isAdvancedBy ?adv ) ]

[ noadvancetrait:
   ( ?cs   rdf:type arm:charactersheet )
   ( ?cs   arm:hastrait ?trait ) 
   ( ?cs   ?p ?trait ) 
   ( ?cs   arm:hasnextcharacter ?nc ) 
   novalue( ?trait arm:isadvancedby ?adv ) 
   -> ( ?nc ?p ?trait )
]
[ noadvancetrait:
   ( ?cs   rdf:type arm:charactersheet )
   ( ?cs   arm:hastrait ?trait ) 
   ( ?cs   ?p ?trait ) 
   ( ?cs   arm:hasnextcharacter ?nc ) 
   ( ?trait arm:isadvancedby ?adv ) 
   -> [
       makeInstance( ?nc, ?p, ?nt ) ->
	  [ ( ?trait arm:hasTotalXP ?xp )
            ( ?adv arm:withXP ?xxp )
            -> ( ?nc arm:hasTotalXP sum(?xp,?xxp ) ) ]
	  [ ( ?adv arm:assignSpeciality ?spec )
            -> ( ?nc arm:hasSpeciality ?spec ) ]
	  [ noValue( ?adv, arm:assignSpeciality  )
            ( ?trait arm:hasSpeciality ?spec ) 
            -> ( ?nc arm:hasSpeciality ?spec ) ]
]   
]

[ advancedtrait:
   ( ?adv rdf:type arm:hasTraitAdvancement )
   ( ?adv  arm:advanceCharacterSheet ?cs ) 
   ( ?adv  arm:advanceTrait ?tc )
   ( ?c  arm:hasTrait ?trait )
   ( ?trait  rdf:type ?tc )
   -> ( ?trait arm:isAdvancedBy ?adv ) 
]

# Three alternatives.
# 1. Trait copied
# 2. Trait improved
# 3. Trait created
