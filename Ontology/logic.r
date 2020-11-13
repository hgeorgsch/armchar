

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
