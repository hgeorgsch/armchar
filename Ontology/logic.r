

[ seasonsequence1:
  ( ?s1 arm:isSeason ?o1 ) ( ?s2 arm:isSeason ?o2 )
  ( ?s1 arm:isYear ?y1 ) ( ?s2 arm:isYear ?y1 )
  ( ?o1 arm:precedes ?o2 ) 
  -> ( ?s1 arm:isPrecedingSeasonOf ?s2 ) ]

[ seasonsequence2: 
  ( ?s1 arm:isSeason arm:Autumn ) ( ?s2 arm:isSeason arm:Winter )
  ( ?s1 arm:isYear ?y1 ) addOne(?y1,?y2) ( ?s2 arm:isYear ?y2 )
  -> ( ?s1 arm:isPrecedingSeasonOf ?s2 ) ]

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

[ addlabel: 
  ( ?t rdf:type arm:LeafTraitClass )
  ( ?s rdf:type ?t ) 
  noValue( ?s,rdfs:label )
  ( ?t rdfs:label ?l ) 
  -> ( ?s rdfs:label ?l ) ]
[ addid1: 
  ( ?t rdf:type arm:LeafTraitClass )
  ( ?s rdf:type ?t ) 
  ( ?t arm:hasID ?l ) 
  -> ( ?s arm:hasID ?l ) ]
[ addid2: 
  ( ?s rdf:type arm:Trait ) 
  noValue( ?s,arm:hasID )
  ( ?s rdfs:label ?l ) 
  -> ( ?s arm:hasID ?l ) ]

[ addorder: 
  ( ?t rdf:type arm:LeafTraitClass )
  ( ?s rdf:type ?t ) 
  noValue( ?s,arm:hasOrder )
  ( ?t arm:hasOrder ?l ) 
  -> ( ?s arm:hasOrder ?l ) ]

[ charsheet: ( ?c arm:isCharacter ?b ) ( ?b ?p ?o ) -> ( ?c ?p ?o ) ]

[ traitlabel:
  ( ?t rdf:type ?c ) ( ?c rdf:type arm:LeafTrait ) ( ?c rdfs:label ?d ) 
  -> ( ?t arm:hasLabel ?d ) ]
[ traitdescription:
  ( ?t rdf:type ?c ) ( ?c rdf:type arm:LeafTrait ) ( ?c arm:hasDescription ?d ) 
  -> ( ?t arm:hasGeneralDescription ?d ) ]
[ leaftraitdescription:
  ( ?c rdf:type arm:LeafTrait ) noValue( ?c, arm:hasDescription ) 
  ( ?c rdfs:subClassOf ?s ) ( ?s arm:hasDescription ?d ) 
  -> ( ?c arm:hasDescription ?d ) ]

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
