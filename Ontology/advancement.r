# Identify Character Sheets of an Advancement
<- table(arm:advanceFromCharacterSheet)  .
<- table(arm:advanceToCharacterSheet) .
[ advancecharsheet1:
  ( ?adv rdf:type arm:CharacterAdvancement )
  ( ?adv  arm:advanceCharacter ?char ) 
  ( ?adv  arm:atSeasonTime ?time ) 
  ( ?time  arm:isPrecedingSeasonOf ?nexttime ) 
  -> 
     [ ( ?oldcs arm:isCharacter ?char )
       <- makeInstance( ?adv, arm:advanceFromCharacterSheet, ?oldcs ) ]
     [ ( ?oldcs arm:atSeasonTime ?time )
       <- makeInstance( ?adv, arm:advanceFromCharacterSheet, ?oldcs ) ]
     [ ( ?newcs arm:isCharacter ?char )
       <- makeInstance( ?adv, arm:advanceToCharacterSheet, ?newcs ) ]
     [ ( ?newcs arm:atSeasonTime ?newtime )
       <- makeInstance( ?adv, arm:advanceToCharacterSheet, ?newcs ) ]
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

