# Identify the Base Character of an Advancement
[ advancecharsheet1:
  ( ?adv rdf:type arm:TraitAdvancement )
  ( ?adv arm:advanceFromCharacterSheet ?cs )
  ( ?cs arm:isCharacter ?bc )
  -> ( ?adv  arm:advanceCharacter ?cs ) ]

# Character Sheet points to next season Character Sheet
[ nextcharactersheet:
  ( ?adv rdf:type arm:CharacterAdvancement )
  ( ?adv arm:advanceFromCharacterSheet ?cs1 )
  ( ?adv arm:advanceToCharacterSheet ?cs2 )
  -> 
  ( ?cs1 arm:hasNextCharacter ?cs2 )
  ]

# Trait instance points to its advancement
[ advancedtrait:
   ( ?adv rdf:type arm:hasTraitAdvancement )
   ( ?adv  arm:advanceCharacterSheet ?cs ) 
   ( ?adv  arm:advanceTrait ?tc )
   ( ?cs  arm:hasTrait ?trait )
   ( ?trait  rdf:type ?tc )
   -> ( ?trait arm:isAdvancedBy ?adv ) ]

# Three alternatives.
# 1. Trait copied (noadvancetrait)
# 2. Trait improved
# 3. Trait created

# Traits without Advancement are carried forward
[ noadvancetrait:
   ( ?cs   rdf:type arm:CharacterSheet )
   ( ?cs   arm:hasTrait ?trait ) 
   ( ?cs   ?p ?trait ) 
   ( ?cs   arm:hasNextCharacter ?nc ) 
   noValue( ?trait arm:isaDvancedBy ?adv ) 
   -> ( ?nc ?p ?trait )
]

# TODO: New trait instances upon advancement
# Note that we will need backward rules to create new traits.
[ advancetrait1:
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

[ advancedtrait2:
   ( ?adv rdf:type arm:hasTraitAdvancement )
   ( ?adv  arm:advanceCharacterSheet ?cs ) 
   ( ?adv  arm:advanceTrait ?tc )
   ( ?c  arm:hasTrait ?trait )
   ( ?trait  rdf:type ?tc )
   -> ( ?trait arm:isAdvancedBy ?adv ) 
]

