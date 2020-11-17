
# Seasons

[ seasonsequence1:
  ( ?s1 arm:isSeason ?o1 ) ( ?s2 arm:isSeason ?o2 )
  ( ?s1 arm:isYear ?y1 ) ( ?s2 arm:isYear ?y1 )
  ( ?o1 arm:precedes ?o2 ) 
  -> ( ?s1 arm:isPrecedingSeasonOf ?s2 ) ]

[ seasonsequence2: 
  ( ?s1 arm:isSeason arm:Autumn ) ( ?s2 arm:isSeason arm:Winter )
  ( ?s1 arm:isYear ?y1 ) ( ?s2 arm:isYear addOne(?y1)  )
  -> ( ?s1 arm:isPrecedingSeasonOf ?s2 ) ]

[ seasonanyear: 
  ( ?r arm:atSeasonTime ?time )
  ( ?time arm:isSeason ?season )
  ( ?time arm:isYear ?year )
  ->
  ( ?r arm:atSeason ?season )
  ( ?r arm:inYear ?year ) ]

# Base Character

[ addsg: 
  ( ?c rdf:type arm:Character ) ( ?c arm:hasSaga ?s ) ( ?s arm:hasSG ?sg ) 
  -> ( ?c arm:hasSG ?sg ) ]
[ addsaga: 
  ( ?c rdf:type arm:Character ) ( ?c arm:hasSaga ?s ) ( ?s arm:hasTitle ?t ) 
  -> ( ?c arm:hasSagaTitle ?t ) ]
[ addsize: 
  ( ?c rdf:type arm:Character ) ( ?c arm:hasOtherTrait ?s ) 
  ( ?s rdf:type arm:Size ) 
  ( ?s arm:hasScore ?size ) 
  -> ( ?c arm:hasSize ?size ) ]

# Character sheet inherits from the base character
[ charsheet: ( ?c arm:isCharacter ?b ) ( ?b ?p ?o ) -> ( ?c ?p ?o ) ]

# Trait instances inherit properties from their class

[ addlabel: 
  ( ?t rdf:type arm:LeafTraitClass )
  ( ?s rdf:type ?t ) 
  noValue( ?s,rdfs:label )
  ( ?t rdfs:label ?l ) 
  -> ( ?s rdfs:label ?l ) ]
[ addorder: 
  ( ?t rdf:type arm:LeafTraitClass )
  ( ?s rdf:type ?t ) 
  noValue( ?s,arm:hasOrder )
  ( ?t arm:hasOrder ?l ) 
  -> ( ?s arm:hasOrder ?l ) ]
[ traitdescription:
  ( ?t rdf:type ?c ) ( ?c rdf:type arm:LeafTraitClass ) 
  ( ?c arm:hasDescription ?d ) 
  -> ( ?t arm:hasGeneralDescription ?d ) ]
# TODO: spelldescription should be a special case of leaftraitdescription
[ spelldescription:
  ( ?t rdf:type ?c ) ( ?c rdf:type arm:SpellClass ) 
  ( ?c arm:hasDescription ?d ) 
  -> ( ?t arm:hasGeneralDescription ?d ) ]
[ leaftraitdescription:
  ( ?c rdf:type arm:LeafTraitClass ) noValue( ?c, arm:hasDescription ) 
  ( ?c rdfs:subClassOf ?s ) ( ?s arm:hasDescription ?d ) 
  -> ( ?c arm:hasDescription ?d ) ]

# Abilities and Arts (XP)

[ artscore:
  ( ?s arm:hasTotalXP ?xp )
  ( ?s rdf:type arm:AccelleratedTrait )
  ( ?e rdf:type armpyramid:xpTableEntry )
  ( ?e armpyramid:xp ?xp )
  ( ?e armpyramid:artScore ?score )
  ( ?e armpyramid:artRemainder ?rem )
  ->
     ( ?s arm:hasScore ?score )
     ( ?s arm:hasXP ?rem )
 ]
[ abscore:
  ( ?s arm:hasTotalXP ?xp )
  ( ?s rdf:type arm:XPTrait )
  ( ?e rdf:type armpyramid:xpTableEntry )
  ( ?e armpyramid:xp ?xp )
  ( ?e armpyramid:abScore ?score )
  ( ?e armpyramid:abRemainder ?rem )
  ->
     ( ?s arm:hasScore ?score )
     ( ?s arm:hasXP ?rem )
 ]

# Virtues and Flaws
[ majorvirtuescore:
   ( ?v rdf:type armr:majorVirtue )
   noValue(?v,arm:hasScore)
   -> ( ?v arm:hasScore '+3'^^xsd:int ) ]
[ minorvirtuescore:
   ( ?v rdf:type armr:minorVirtue )
   noValue(?v,arm:hasScore)
   -> ( ?v arm:hasScore '+1'^^xsd:int ) ]
[ freevirtuescore:
   ( ?v rdf:type armr:freeVirtue )
   noValue(?v,arm:hasScore)
   -> ( ?v arm:hasScore '0'^^xsd:int ) ]
[ majorflawscore:
   ( ?v rdf:type armr:majorFlaw )
   noValue(?v,arm:hasScore)
   -> ( ?v arm:hasScore '-3'^^xsd:int ) ]
[ minorflawscore:
   ( ?v rdf:type armr:minorFlaw )
   noValue(?v,arm:hasScore)
   -> ( ?v arm:hasScore '-1'^^xsd:int ) ]

# Spells

[ spellstats:
   ( ?s rdf:type ?t )
   ( ?t rdf:type arm:SpellClass )
   ( ?t ?p ?o )
   ( ?p rdf:type arm:TraitProperty )
   -> ( ?s ?p ?o ) ]

[ spellrange:
   ( ?s rdf:type arm:Spell ) ( ?s arm:hasRange ?o ) ( ?o rdfs:label ?st )
   -> ( ?s arm:hasRangeString ?st ) ]
[ spellduration:
   ( ?s rdf:type arm:Spell ) ( ?s arm:hasDuration ?o ) ( ?o rdfs:label ?st )
   -> ( ?s arm:hasDurationString ?st ) ]
[ spelltarget:
   ( ?s rdf:type arm:Spell ) ( ?s arm:hasTarget ?o ) ( ?o rdfs:label ?st )
   -> ( ?s arm:hasTargetString ?st ) ]
[ spelltech:
   ( ?s rdf:type arm:Spell ) ( ?s arm:hasTechnique ?o ) ( ?o rdfs:label ?st )
   -> ( ?s arm:hasTechniqueString ?st ) ]
[ spellform:
   ( ?s rdf:type arm:Spell ) ( ?s arm:hasForm ?o ) ( ?o rdfs:label ?st )
   -> ( ?s arm:hasFormString ?st ) ]
