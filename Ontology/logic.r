

[ seasonsequence1:
  ( ?s1 arm:isSeason ?o1 ) ( ?s2 arm:isSeason ?o2 )
  ( ?s1 arm:isYear ?y1 ) ( ?s2 arm:isYear ?y1 )
  ( ?o1 arm:precedes ?o2 ) 
  -> ( ?s1 arm:isPrecedingSeasonOf ?s2 ) ]

[ seasonsequence2: 
  ( ?s1 arm:isSeason arm:Autumn ) ( ?s2 arm:isSeason arm:Winter )
  ( ?s1 arm:isYear ?y1 ) addOne(?y1,?y2) ( ?s2 arm:isYear ?y2 )
  -> ( ?s1 arm:isPrecedingSeasonOf ?s2 ) ]

[ charsheet: ( ?c arm:isCharacter ?b ) ( ?b ?p ?o ) -> ( ?c ?p ?o ) ]

[ traitdescription:
  ( ?t a ?c ) ( ?c a arm:LeafTrait ) ( ?c arm:hasDescription ?d ) 
  -> ( ?t arm:hasGeneralDescription ?d ) ]
[ leaftraitdescription:
  ( ?c a arm:LeafTrait ) noValue( ?c, arm:hasDescription ) 
  ( ?c rdfs:subClassOf ?s ) ( ?s arm:hasDescription ?d ) 
  -> ( ?c arm:hasGeneralDescription ?d ) ]
