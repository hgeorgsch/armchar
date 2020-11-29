
### SEASONS

# Season Sequence
[ seasonsequence1:
  ( ?s1 arm:isSeason ?o1 ) ( ?s2 arm:isSeason ?o2 )
  ( ?s1 arm:isYear ?y1 ) ( ?s2 arm:isYear ?y1 )
  ( ?o1 arm:precedes ?o2 ) 
  -> ( ?s1 arm:isPrecedingSeasonOf ?s2 ) ]

[ seasonsequence2: 
  ( ?s1 arm:isSeason arm:Autumn ) 
  ( ?s1 arm:isYear ?y1 )
  sum(?y1,1,?y2)
  ( ?s2 arm:isYear ?y2  )
  ( ?s2 arm:isSeason arm:Winter )
  -> ( ?s1 arm:isPrecedingSeasonOf ?s2 ) ]

# Deduced timestamp on resources
[ seasonanyear: 
  ( ?r arm:atSeasonTime ?time )
  ( ?time arm:isSeason ?s )
  ( ?s rdfs:label ?season )
  ( ?time arm:isYear ?year )
  ->
  ( ?r arm:atSeason ?season )
  ( ?r arm:inYear ?year ) ]

[ seasonlabel:
  ( ?s rdf:type arm:SeasonTime )
  ( ?s arm:isSeason ?season ) ( ?s arm:isYear ?y )
  ( ?season rdfs:label ?st ) ( ?s arm:isYear ?y )
  strConcat(?st,?y,?l)
  -> ( ?s rdfs:label ?l ) ]

### SAGA

# Inverse properties, not inferred by the Micro OWL reasoner
[ covenantsaga:
  ( ?c arm:hasSaga ?s ) ( ?c rdf:type arm:Covenant ) 
  -> ( ?s arm:hasCovenant ?c ) ]
[ charactersaga:
  ( ?c arm:hasSaga ?s ) ( ?c rdf:type arm:BaseCharacter ) 
  -> ( ?s arm:hasCharacter ?c ) ]

# Infer covenant/saga/sg name 
[ covenantname:
  ( ?c arm:hasCovenant ?cov ) ( ?cov arm:hasName ?n ) 
  -> ( ?c arm:hasCovenantName ?n ) ]
[ addsg: ( ?c arm:hasSaga ?s ) ( ?s arm:hasSG ?sg ) -> ( ?c arm:hasSG ?sg ) ]
[ addsaga: 
  ( ?c rdf:type arm:Character ) ( ?c arm:hasSaga ?s ) ( ?s arm:hasTitle ?t ) 
  -> ( ?c arm:hasSagaTitle ?t ) ]

### CHARACTER

# Size Attribute (simpler than treating it as a trait)
[ addsize: 
  ( ?c rdf:type arm:Character ) ( ?c arm:hasOtherTrait ?s ) 
  ( ?s rdf:type arm:Size ) 
  ( ?s arm:hasScore ?size ) 
  -> ( ?c arm:hasSize ?size ) ]

# Character sheet inherits from the base character
[ charsheet: ( ?c rdf:type arm:CharacterSheet )
             ( ?c arm:isCharacter ?b ) ( ?b ?p ?o )
	     ( ?p rdfs:domain arm:GeneralCharacter )
             noValue(?p,rdf:type,arm:ignoredProperty)
	     -> ( ?c ?p ?o ) ]
[ charsheet: ( ?c rdf:type arm:CharacterSheet )
             ( ?c arm:isCharacter ?b ) ( ?b ?p ?o )
	     ( ?p rdfs:domain arm:Character )
             noValue(?p,rdf:type,arm:ignoredProperty)
	     -> ( ?c ?p ?o ) ]

### TRAITS

# Trait instances inherit properties from their class

[ addlabel: 
  ( ?t rdf:type arm:LeafTraitClass )
  ( ?s rdf:type ?t ) 
  ( ?t rdfs:label ?l ) 
  -> [ ( ?s rdfs:label ?l ) <- <- noValue( ?s,rdfs:label ) ]
  ]
[ addarmlabel: 
  ( ?t rdf:type arm:LeafTraitClass )
  ( ?s rdf:type ?t ) 
  ( ?t arm:hasLabel ?l ) 
  -> [ ( ?s arm:hasLabel ?l ) <- noValue( ?s,arm:hasLabel ) ]
      ]
#  rdfs:label should be replaced by arm:hasLabel in the turtle files
#  When that is done, this rule is obsolete
[ label:
  ( ?s rdf:type arm:Trait )
  ( ?s rdfs:label ?l )
  -> [ ( ?s arm:hasLabel ?l ) <- noValue( ?s,arm:hasLabel ) ]
  ]
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

# hasTrait (when subProperties are added after OWL reasoning)
[ hastrait:
  ( ?p rdfs:subPropertyOf arm:hasTrait ) 
  -> ( ?p rdf:type owl:ObjectProperty ) ]
