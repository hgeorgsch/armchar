
# Trait instances inherit properties from their class
[ addarmlabel: 
  ( ?t rdf:type arm:LeafTraitClass )
  ( ?s rdf:type ?t ) 
  ( ?t ?p ?l ) 
  ( ?p rdf:type arm:TraitProperty ) 
  -> [ ( ?s arm:hasLabel ?l ) <- noValue( ?s,arm:hasLabel ) ]
      ]
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
