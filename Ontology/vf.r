
[ vfp:
  ( ?vc  arm:grantsPTraitClass ?pc )
  ( ?v  rdf:type ?vc )
  ( ?v  rdf:type armr:minorFlaw )
  makeTemp( ?p ) 
  ->
  ( ?p rdf:type ?pc )
  ( ?p rdf:type arm:Flaw )
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
  ( ?p rdf:type arm:Flaw )
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
[ vfability:
  ( ?vclass  arm:grantsAbilityClass ?abclass )
  ( ?v  rdf:type ?vclass )
  makeTemp( ?ab ) 
  ->
  ( ?ab rdf:type ?abclass )
  ( ?ab rdf:type arm:Ability )
  ( ?v arm:grantsAbility ?ab )
  ( ?ab arm:hasTotalXP 5 )
  ]
[ advancevfgrant:
  ( ?v  arm:grantsTrait ?ab )
  ( ?adv  rdf:type arm:CharacterAdvancement )
  ( ?adv  arm:advanceTrait ?v )
  ->
  ( ?adv arm:advanceTrait ?ab )
  ]
[ chargenvfgrant:
  ( ?v  arm:grantsTrait ?ab )
  ( ?cs  arm:hasNewVirtue ?v )
  ->
  ( ?cs arm:hasTrait ?ab )
  ]
[ chargenvfgrantv:
  ( ?v  arm:grantsVirtue ?ab )
  ( ?cs  arm:hasNewVirtue ?v )
  ->
  ( ?cs arm:hasVirtue ?ab )
  ( ?cs arm:hasNewVirtue ?ab )
  ]

[ chargenvfgrantf:
  ( ?v  arm:grantsFlaw ?ab )
  ( ?cs  arm:hasNewFlaw ?v )
  ->
  ( ?cs arm:hasFlaw ?ab )
  ( ?cs arm:hasNewFlaw ?ab )
  ]

