
# Character Sheet points to next season Character Sheet
[ nextcharactersheet:
  ( ?adv rdf:type arm:CharacterAdvancement )
  ( ?adv arm:advanceFromCharacterSheet ?cs1 )
  ( ?adv arm:advanceToCharacterSheet ?cs2 )
  ->
  ( ?cs1 arm:hasNextCharacter ?cs2 )
  ]

# Trait instance points to its predecessor from before advancement
[ advancedtrait:
   ( ?adv rdf:type arm:CharacterAdvancement )
   ( ?adv  arm:advanceFromCharacterSheet ?cs ) 
   ( ?adv  arm:advanceTrait ?trait )
   ( ?trait  rdf:type ?tc )
   ( ?cs  arm:hasTrait ?oldtrait )
   ( ?oldtrait  rdf:type ?tc )
   -> ( ?trait arm:advancedFromTrait ?oldtrait ) ]

# Three alternatives.
# 1. Trait copied (noadvancetrait)
# 2. Trait improved
# 3. Trait created

# Traits without Advancement are carried forward
[ noadvancetrait:
   ( ?cs   rdf:type arm:CharacterSheet )
   ( ?cs   arm:hasTrait ?oldtrait ) 
   ( ?cs   arm:hasNextCharacter ?nc ) 
   ( ?cs   ?p ?oldtrait ) 
   noValue( ?trait arm:advancedFromTrait ?oldtrait ) 
   -> ( ?nc ?p ?oldtrait ) ]

# 2-3. Traits from the CharacterAdvancement are added to the new charactersheet
[ advancementtrait:
   ( ?cs   rdf:type arm:CharacterSheet )
   ( ?cs   arm:hasTrait ?oldtrait ) 
   ( ?cs   arm:hasNextCharacter ?nc ) 
   ( ?cs   ?p ?oldtrait ) 
   -> 
   ( ?nc ?p ?trait )
]        

# 2. Traits which already existed are updated
[ advancetraitXP:
   ( ?trait arm:advancedFromTrait ?oldtrait  )
   ( ?trait arm:addedXP ?xp2 ) 
   ( ?oldtrait arm:hasTotalXP ?xp1 ) 
   -> (  ?trait arm:hasTotalXP sum(?xp1,?xp2 ) ) ]
[ advancetraitSpec:
   ( ?trait arm:advancedFromTrait ?oldtrait  )
   noValue( ?trait arm:hasSpeciality ?spec ) 
   ( ?oldtrait arm:hasSpeciality ?oldspec ) 
   ->
   ( ?trait arm:hasSpeciality ?oldspec ) ]

# 3. Convert addedXP to TotalXP when there was no prior trait.
[ newtraitXP:
   ( ?trait arm:addedXP ?xp ) 
   noValue( ?trait, arm:advancedFromTrait   )
   noValue( ?trait, arm:hasTotalXP  ) 
   -> (  ?trait arm:hasTotalXP ?xp ) ]

[ fixhasAbility:
  ( ?c arm:hasTrait ?t ) ( ?t rdf:type arm:Ability )
  -> ( ?c arm:hasAbility ?t ) ]
[ fixhasSpell:
  ( ?c arm:hasTrait ?t ) ( ?t rdf:type arm:Spell )
  -> ( ?c arm:hasSpell ?t ) ]
[ fixhasArt:
  ( ?c arm:hasTrait ?t ) ( ?t rdf:type arm:Art )
  -> ( ?c arm:hasArt ?t ) ]
[ fixhasPersonalityTrait:
  ( ?c arm:hasTrait ?t ) ( ?t rdf:type arm:PersonalityTrait )
  -> ( ?c arm:hasPersonalityTrait ?t ) ]
[ fixhasOtherTrait:
  ( ?c arm:hasTrait ?t ) ( ?t rdf:type arm:OtherTrait )
  -> ( ?c arm:hasOtherTrait ?t ) ]
[ fixhasReputation:
  ( ?c arm:hasTrait ?t ) ( ?t rdf:type arm:Reputation )
  -> ( ?c arm:hasReputation ?t ) ]
[ fixhasVirtue:
  ( ?c arm:hasTrait ?t ) ( ?t rdf:type arm:Virtue )
  -> ( ?c arm:hasVirtue ?t ) ]
[ fixhasFlaw:
  ( ?c arm:hasTrait ?t ) ( ?t rdf:type arm:Flaw )
  -> ( ?c arm:hasFlaw ?t ) ]
[ fixhasCharacteristic:
  ( ?c arm:hasTrait ?t ) ( ?t rdf:type arm:Characteristic )
  -> ( ?c arm:hasCharacteristic ?t ) ]
