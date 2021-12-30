
# Some ideas towards an ArM character generator

These ideas assume an RDF data model and logic inference rules
for the general reasoner in apache Jena.

An RDF document is a set of triplets, (subject, predicate, object).
A set of triplets can be seen to form a graph, where the subjects
form the nodes and the predicates form edge labels.  The objects
can be either nodes or primitive datatypes (int, string).  The triplet
can also be read as a statement, e.g. (Subject X) hasProperty (Object Y).

Nodes can be identified using URIs (which may or may not resolve to URLs).
It is possible to have blind nodes which do not have a URI.  The use of
URIs means that nodes can be identified across different documents, which
can then be seemlessly merged.

In human-readable files, the identifiers are typically written as 
pref:id, where the prefix (pref:) is short-hand and expands to a
URI prefix (e.g. http://example.com/pref/).  The prefixes are 
defined in a preamble.  In the code examples, we will use the
turtle format, which IMO is the most human-readable format.
Following a semicolon there is a new predicate and object, reusing
the subject.  Following a comma, there is a new object, reusing
subject and predicate.  Full stop terminates the triplet.

## A sample character

A base character definition could look like this.

```
@prefix armchar: <https://example.com/armchar/character/> .
@prefix : <https://example.com/armchar/character/cieran#> .

armchar:cieran a arm:Magus ; 
               arm:hasName "Cieran the Fletcher" ;
	       arm:hasGender "Male" ;
               arm:hasBirthYear 1192 ;
	       arm:hasPlayer "George" ;
               arm:hasOtherTrait [ a arm:Size ; arm:hasScore 0 ] ;
	       arm:hasProfession "Rusticus (magus ex Miscellanea)" ;
	       arm:hasNationality "Irish" ;
               arm:hasAlmaMater "Stonehenge" ;
               arm:hasSaga armchar:contestedlands .
```

Note that we identify a saga which may be defined in separate documents
at a later stage.  The special predicate `a` means "instance of class".

The properties described above are supposed to be constant throughout
the magus' life.  To handle variable traits, we define the character
at a given time.  For instance, we can have the character at birth
defined as:

```
:zero arm:isCharacter armchar:cieran ; a arm:CharacterSheet .

:zero arm:hasOtherTrait
  [ a arm:Decrepitude ; arm:hasTotalXP 0  ],
  [ a arm:Warping ; arm:hasTotalXP 0 ],
  [ a arm:Confidence ; arm:hasScore 1 ; arm:hasPoints 8 ] .

:zero arm:hasNewVirtue
    [ a armr:strongFaerieBlood ; arm:hasDetail "Ettin Blood, +1 to Stamina" ] .

:zero arm:hasPersonalityTrait 
    [ a armr:personality-meticulous ; arm:hasScore 3 ],
    [ a armr:personality-villager ; arm:hasScore 1 ] .

:zero arm:hasCharacteristic
    [ a armr:int ; arm:hasScore 3 ], [ a armr:per ; arm:hasScore -1 ],
    [ a armr:com ; arm:hasScore -1 ], [ a armr:pre ; arm:hasScore 0 ],
    [ a armr:str ; arm:hasScore 2 ], [ a armr:sta ; arm:hasScore 3 ],
    [ a armr:dex ; arm:hasScore 2 ], [ a armr:qik ; arm:hasScore -3 ] . 

:zero arm:hasAbility
   [ a armab:gaelic ; arm:hasSpeciality "Leinster" ; arm:hasTotalXP 75  ] .
```

The brackets create a blind node, in these cases an
anonymous instance of a class.  Doing it this ways means
that we can recognise the same trait in different characters.
Of course, we could define classes, such as for the personality
traits, in the character document, if they are unusual.

The ability given here at birth is the native language.  This is tricky.
Do we want to specify total XP at 75, contrary to RAW, or do we rather
want to specify the score, complying with RAW.

After birth, comes the advancement from early childhood, later life,
and apprenticeship.  The parentheses is syntactic sugar for RDF lists,
a linked list data structure defined as part of core RDF(S).

```
armchar:cieran  arm:hasPregameAdvancementList
( [ a arm:EarlyChildhoodAdvancement ; 
   arm:advanceTraitList (
   [ a armab:secondsight ; arm:hasSpeciality "Faerie Illusions" ]
   [ a armab:awareness ; arm:hasSpeciality "searching" ; arm:addedXP 15  ]
   [ a armab:brawl ; arm:hasSpeciality "Dodge" ;  arm:addedXP 15  ]
   [ a armab:arealore-munster ; arm:hasSpeciality "Hiding places" ;
     arm:addedXP 5  ]
   [ a armab:folkken ; arm:hasSpeciality "Villagers" ; arm:addedXP 5  ]
   [ a armab:stealth ; arm:hasSpeciality "Hiding" ; arm:addedXP 5  ] ) ;
  arm:advanceFromCharacterSheet :zero ;
  arm:advanceToCharacterSheet :early 
  ]
[ a arm:LaterLifeAdvancement ; 
  arm:advanceFromCharacterSheet :early ;
  arm:advanceToCharacterSheet :laterlife ;
  arm:advanceTraitList (
      [ a armab:bargain ;  arm:addedXP 5  ]
      [ a armab:conc ; arm:hasSpeciality "Spell Concentration" ;
        arm:addedXP 5  ]
      [ a armab:craft-cooking ; arm:addedXP 30  ]
      [ a armab:craft-fletching ; arm:addedXP 30  ]
      [ a armab:hermeslore ; arm:hasSpeciality "Hibernia" ;
        arm:addedXP 5  ]
  ) ]
[ a arm:ApprenticeshipAdvancement ; 
  arm:advanceFromCharacterSheet :laterlife ;
  arm:advanceToCharacterSheet :summer1217 ;
  arm:advanceTraitList (
      [ a armr:creo ; arm:addedXP 21 ]
      [ a armr:intellego ; arm:addedXP 0 ]
      [ a armr:muto ; arm:addedXP 0 ]
      [ a armr:perdo ; arm:addedXP 36 ]
      [ a armr:rego ; arm:addedXP 36 ]
      [ a armr:animal ; arm:addedXP 0 ]
      [ a armr:aquam ; arm:addedXP 0 ]
      [ a armr:auram ; arm:addedXP 0 ]
      [ a armr:corpus ; arm:addedXP 15 ]
      [ a armr:herbam ; arm:addedXP 0 ]
      [ a armr:ignem ; arm:addedXP 0 ]
      [ a armr:imaginem ; arm:addedXP 53 ]
      [ a armr:mentem ; arm:addedXP 1 ]
      [ a armr:terram ; arm:addedXP 15 ]
      [ a armr:vim ; arm:addedXP 3 ]
    [ a armab:artlib ; arm:addedXP 5 ; arm:hasSpeciality "rituals" ]
    [ a armab:philosophiae ; arm:addedXP 0 ; arm:hasSpeciality "rituals" ]
    [ a armab:latin ; arm:addedXP 30 ; arm:hasSpeciality "Hermetic Usage" ]
   [ a armab:parmamagica ; arm:addedXP 5 ; arm:hasSpeciality "Mentem" ]
   [ a armab:hermescode ; arm:addedXP 5 ; arm:hasSpeciality "Stonehenge" ]
   [ a armab:infernallore ; arm:addedXP 0 ; arm:hasSpeciality "Undead" ]
   [ a armab:magictheory ; arm:addedXP 30 ; arm:hasSpeciality "Spells" ]
   [ a armab:penetration ; arm:addedXP 5 ; arm:hasSpeciality "Rego" ]
   [ a armr:PeCo20Wound ; arm:hasTotalXP 5 ]
   [ a armr:ReCo5Spasms ; arm:hasTotalXP 5 ]
   [ a armr:CrIg15Lamp ; arm:hasTotalXP 5 ]
   [ a armr:PeIm20Veil ; arm:hasTotalXP 5 ]
   [ a armr:CrIm10Clarity ; arm:hasTotalXP 5 ]
   [ a armr:MuIm10Aura ; arm:hasTotalXP 5 ]
   [ a armr:PeMe10Trust ; arm:hasTotalXP 5 ]
   [ a armr:ReMe15Arrow ; arm:hasTotalXP 5 ]
   [ a armr:ReMe5Touch ; arm:hasTotalXP 5 ]
   [ a armr:PeTe20Obliteration  ; arm:hasTotalXP 5 ]
   [ a armr:PeTe20End  ; arm:hasTotalXP 5 ] 
   [ a armab:bows ; arm:addedXP 30 ; arm:hasSpeciality "Longbow" ]
   [ a armab:thrown ; arm:addedXP 5 ; arm:hasSpeciality "Dart" ]
   [ a armab:arealore-ireland ; arm:hasSpeciality "Legends" ;
     arm:addedXP 5  ]
  ) ] ) .
```

In-game advancement is similar:

```
armchar:cieran  arm:hasAdvancementList
( [ a arm:CharacterAdvancement ; arm:atSeasonTime arm:summer1217 ;
  arm:hasAdvancementDescription "Studies Herbam L6 Q21 +3" ;
  arm:advanceTraitList ( [ a armr:herbam ; arm:addedXP 21 ]  ) ;
  arm:awardsXP 21 ;
  arm:hasAdvancementType arm:Reading ;
  arm:advanceToCharacterSheet :autumn1217 
  ]
[ a arm:CharacterAdvancement ; arm:atSeasonTime arm:autumn1217 ;
  arm:hasAdvancementDescription "Studies Mentem L16 Q13 +3" ;
  arm:advanceTraitList ( [ a armr:mentem ; arm:addedXP 16 ] )   ;
  arm:awardsXP 16 ;
  arm:hasAdvancementType arm:Reading ;
  arm:advanceToCharacterSheet :winter1218 
  ] ) .
```

Note that the advancement is coded manually.  A more advance version
could draw the book from a covenant library document, apply the +3 from
book learner automatically, and derive the arm:addedXP property.

