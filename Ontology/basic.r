
[ newflaw: ( ?x arm:hasNewFlaw ?o ) -> ( ?x arm:hasFlaw ?o ) ]
[ newvirtue: ( ?x arm:hasNewVirtue ?o ) -> ( ?x arm:hasVirtue ?o ) ]
[ vfp:
  ( ?vc arm:grantsPTraitClass ?pc )
  ( ?v  rdf:type ?vc )
  ( ?v  rdf:type armr:minorFlaw )
  makeTemp( ?p ) 
  ->
  ( ?p rdf:type ?pc )
  ( ?p rdf:type arm:PersonalityTrait )
  ( ?v arm:grantsPTrait ?p )
  ( ?p arm:hasScore +3 )
  ]
[ vfpmajor:
  ( ?vc  arm:grantsPTraitClass ?pc )
  ( ?v  rdf:type ?vc )
  ( ?v  rdf:type armr:majorFlaw )
  makeTemp( ?p ) 
  ->
  ( ?p rdf:type ?pc )
  ( ?p rdf:type arm:PersonalityTrait )
  ( ?v arm:grantsPTrait ?p )
  ( ?p arm:hasScore +6 )
  ]
[ vfv:
  ( ?vc1  arm:grantsVirtueClass ?vc2 )
  ( ?v1  rdf:type ?vc1 )
  makeTemp( ?v2 ) 
  ->
  ( ?v2 rdf:type ?vc2 )
  ( ?v2 rdf:type arm:Virtue )
  ( ?v1 arm:grantsVirtue ?v2 )
  ( ?v2 arm:hasScore 0 )
  ]
[ vff:
  ( ?vc1  arm:grantsFlawClass ?vc2 )
  ( ?v1  rdf:type ?vc1 )
  makeTemp( ?v2 ) 
  ->
  ( ?v2 rdf:type ?vc2 )
  ( ?v2 rdf:type arm:Flaw )
  ( ?v1 arm:grantsFlaw ?v2 )
  ( ?v2 arm:hasScore 0 )
  ]

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
