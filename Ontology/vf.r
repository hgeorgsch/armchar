
[ vfvf:
  ( ?vc1  arm:grantsVirtueClass ?vc2 )
  ( ?v1  rdf:type ?vc1 )
  makeTemp( ?v2 ) 
  ->
  ( ?v2 rdf:type ?vc2 )
  ( ?v1 arm:grantsVirtue ?v2 )
  ]
[ vfability:
  ( ?vclass  arm:grantsAbilityClass ?abclass )
  ( ?v  rdf:type ?vclass )
  makeTemp( ?ab ) 
  ->
  ( ?ab rdf:type ?abclass )
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
  ( ?cs arm:hasNewVirtue ?ab )
  ( ?cs arm:hasVirtue ?ab )
  ]
