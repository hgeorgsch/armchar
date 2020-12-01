
[ -> table(arm:hasVis) ]
[ -> table(arm:hasEquipment) ]
[ -> table(arm:hasWeapon) ]
[ retainvis:
   ( ?char arm:hasAdvancement ?adv )
   ( ?adv arm:advanceFromCharacter ?cs1 )
   ( ?adv arm:advanceToCharacter ?cs2 )
   ->
   [ ( ?cs2 arm:hasVis ?item ) 
     <-
        ( ?cs1 arm:hasVis ?item )
        noValue( ?adv arm:usedVis ?item )
       ]
]
[ retainvis:
   ( ?char arm:hasAdvancement ?adv )
   ( ?adv arm:advanceFromCharacter ?cs1 )
   ( ?adv arm:advanceToCharacter ?cs2 )
   ->
   [ ( ?cs2 arm:hasEquipment ?item ) 
     <-
        ( ?cs1 arm:hasVis ?item )
        noValue( ?adv arm:lostEquipment ?item )
       ]
]
[ retainvis:
   ( ?char arm:hasAdvancement ?adv )
   ( ?adv arm:advanceFromCharacter ?cs1 )
   ( ?adv arm:advanceToCharacter ?cs2 )
   ->
   [ ( ?cs2 arm:hasWeapon ?item ) 
     <-
        ( ?cs1 arm:hasVis ?item )
        noValue( ?adv arm:lostWeapon ?item )
       ]
]
