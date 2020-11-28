[ vfability:
  ( ?vclass  arm:grantsAbilityClass ?abclass )
  ( ?v  rdf:type ?vclass )
  makeTemp( ?ab ) 
  ->
  ( ?ab rdf:type ?abclass )
  ( ?ab rdf:type arm:Ability )
  ( ?p rdf:type arm:Trait )
  ( ?v arm:grantsAbility ?ab )
  ( ?v arm:grantsTrait ?p )
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
  ( ?cs  arm:hasNewVirtue ?v )
  ( ?cs  rdf:type arm:CharacterSheet )
  ( ?v  arm:grantsTrait ?ab )
  ->
  ( ?cs arm:hasTrait ?ab )
  ]
[ chargenvfgrantv:
  ( ?cs  arm:hasNewVirtue ?v )
  ( ?cs  rdf:type arm:CharacterSheet )
  ( ?v  arm:grantsVirtue ?ab )
  ->
  ( ?cs arm:hasVirtue ?ab )
  ( ?cs arm:hasNewVirtue ?ab )
  ]

[ chargenvfgrantf:
  ( ?cs  arm:hasNewFlaw ?v )
  ( ?cs  rdf:type arm:CharacterSheet )
  ( ?v  arm:grantsFlaw ?ab )
  ->
  ( ?cs arm:hasFlaw ?ab )
  ( ?cs arm:hasNewFlaw ?ab )
  ]

