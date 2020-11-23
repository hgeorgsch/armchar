[ subclass:
  ( ?s rdf:type arm:Trait ) ( ?s rdf:type ?t1 ) ( ?t1 rdfs:subClassOf ?t2 ) 
  -> ( ?s rdf:type ?t2 ) ]
### [ formclass:
###   ( ?s rdf:type arm:FormClass ) -> ( ?s rdfs:subClassOf arm:Form ) ]
### [ techclass:
###   ( ?s rdf:type arm:TechClass ) -> ( ?s rdfs:subClassOf arm:Tech ) ]
