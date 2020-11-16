
# Identify Character Sheets of an Advancement
# This seems to cause an error
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
