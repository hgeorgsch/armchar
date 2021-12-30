
# Some ideas towards an ArM character generator

These ideas assume an RDF data model and logic inference rules
for the general reasoner in Apache Jena (a Java API).

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
sheet at a given time.  For instance, we can have the character at birth
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

## Inferring the character sheet at a given time

We want to deduce the character sheet at a given time from the
character at birth `:zero` and the various advancements made.
For this, we use the general reasoner of Apache Jena, which has its
own logic language to write inference rules.

Note the terminology.  We refer to a character as the character's
identity, independent of time.  A character sheet is a character
at a given time, with all the stats at that time.

Let's take a quick example first:

```
[ addsize: 
  ( ?c rdf:type arm:Character ) ( ?c arm:hasOtherTrait ?s ) 
  ( ?s rdf:type arm:Size ) 
  ( ?s arm:hasScore ?size ) 
  -> ( ?c arm:hasSize ?size ) ]
```

This should be read as, given that we have a character `c` of
type `arm:Character` and which has a trait `s` where `s` is of type
`arm:Size` and has the score `size`, we infer that `c` has size
`size`.  The identifier `addsize` is just a name for the rule and
can be ignored.

The character sheet should have all the properties of the character.
This is handled by this rule:

```
[ charsheet2: ( ?c rdf:type arm:CharacterSheet )
             ( ?c arm:isCharacter ?b ) ( ?b ?p ?o )
	     ( ?p rdfs:domain arm:Character )
             noValue(?p,rdf:type,arm:ignoredProperty)
	     -> ( ?c ?p ?o ) ]
```

The `noValue` clause is an implementation detail.  Properties marked
to be ignored in the schema are not copied.  This is to avoid generating
an excessive number of triplets.

Finally, let's take a more intesting example, deducing the ability score
given a sequence of advancements. 

```
[ artscore:
  ( ?s rdf:type arm:AccelleratedTrait )
  -> [ ( ?s arm:hasScore ?score ) <-
    ( ?s arm:hasTotalXP ?xp )
    ( ?e armpyramid:xp ?xp )
    ( ?e armpyramid:artScore ?score )
    ( ?e rdf:type armpyramid:xpTableEntry )
  ]
  [ ( ?s arm:hasXP ?rem ) <-
    ( ?s arm:hasTotalXP ?xp )
    ( ?e armpyramid:xp ?xp )
    ( ?e armpyramid:artRemainder ?rem )
    ( ?e rdf:type armpyramid:xpTableEntry )
 ]
 ]
[ abscore:
  ( ?s rdf:type arm:XPTrait )
  -> [ ( ?s arm:hasScore ?score ) <-
  ( ?s arm:hasTotalXP ?xp )
  ( ?e rdf:type armpyramid:xpTableEntry )
  ( ?e armpyramid:xp ?xp )
  ( ?e armpyramid:abScore ?score )
  ] [ ( ?s arm:hasXP ?rem ) <-
  ( ?s arm:hasTotalXP ?xp )
  ( ?e rdf:type armpyramid:xpTableEntry )
  ( ?e armpyramid:xp ?xp )
  ( ?e armpyramid:abRemainder ?rem )
	]
 ]
```

Apologies for badly chosen identifiers here.  The logic does not
need to distinguish between accellerated abilities and Hermetic arts,
so we refer instead to a class of traits with XP on the arts scale and
one with XP on the abilities scale.  An instance can be a member of
any number of classes (unless the classes are explicitly disjoint), so
we can still have Arts and Abilities classes orthogonally on the 
Accellerated/Difficult classes.

## An implementation in Jena

Jena support the following basic operations which we need.

1.  Load an RDF graph from a text file.  A number of different formats
    are supported, including the turtle format used here.  The result
    is an RDF graph stored internally in Jena.
2.  Multiple documents can be loaded and merged into a union graph.
    In particular, we load additional graphs specifying canon traits.
3.  The Jena inference engine can load a rule set as exemplified above,
    and apply it to an underlying RDF graph (the character).  The
    result is a virtual RDF graph containing all the inferred properties.
4.  The character sheet can be serialised in JSON-LD (or any RDF format).
    The export can be made complete or selective, and in particular, it
    is possible to define which properties to include in an RDF document,
    which can be loaded.
5.  Editing the character should change only the underlying graph
    (journal).  An updated character can be exported to a file (same
    as the import).  Working on the underlying graph, any inferences
    are excluded.


## A Web Services Architecture

One approach is to make separate web services for the character journal
and the character sheet.  The latter would be read only.

Separate Client components could then be made to edit the journal and to 
view the character sheet, each client communicating with its own web services.
This modularises the system into very small components.

Additional web services to manage covenants and sagas could pull data
from the first two services, without worrying about their internal logic.

## Caveats

1.  Some inferences can be difficult to code in the rules language,
    and may require superior skills in formal logic.
2.  Inferences may be computationally expensive.  This has to be tested,
    but it may require the inference graphs to be retained in memory to
    avoid recomputation.
3.  An open server may not be able to scale for hundreds of sagas, because
    of the large inference graphs created for each character.
    This is unlikely to be an issue for a single saga with a limited
    number of characters.
