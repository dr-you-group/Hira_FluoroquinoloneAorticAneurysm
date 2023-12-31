CREATE TABLE #Codesets (
  codeset_id int NOT NULL,
  concept_id bigint NOT NULL
)
;

INSERT INTO #Codesets (codeset_id, concept_id)
SELECT 0 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (1721543,35198003,1747032,19041153,1592954,1716721,923081,19050750,1712549,35197938,36878831,40161662,43009030,1743222,35834909,35198165,1789276,1797513,1742253,1716903,35197897,19027679,1733765,1707800)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (1721543,35198003,1747032,19041153,1592954,1716721,923081,19050750,1712549,35197938,36878831,40161662,43009030,1743222,35834909,35198165,1789276,1797513,1742253,1716903,35197897,19027679,1733765,1707800)
  and c.invalid_reason is null

) I
LEFT JOIN
(
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (42613186,2909524,40161667,40028718,40028720,35860696,35858962,40059607,35861002,40001157,40059318,40057467,40066892,40066893,43695029,40069651,35851732,42961482,42479725,40028359,42629035,43258666,40028361,40160496,35605255,35860990,35144130,40069655,42965658,36269500,35857832,35857838,35860698,35862078,35862084,2052955,43678347,35154779,35141912,35861725,35851383,35851392,35856292)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (42613186,2909524,40161667,40028718,40028720,35860696,35858962,40059607,35861002,40001157,40059318,40057467,40066892,40066893,43695029,40069651,35851732,42961482,42479725,40028359,42629035,43258666,40028361,40160496,35605255,35860990,35144130,40069655,42965658,36269500,35857832,35857838,35860698,35862078,35862084,2052955,43678347,35154779,35141912,35861725,35851383,35851392,35856292)
  and c.invalid_reason is null

) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 1 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (262,9201)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (262,9201)
  and c.invalid_reason is null

) I
) C UNION ALL 
SELECT 2 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (81902)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (81902)
  and c.invalid_reason is null

) I
) C
;

with primary_events (event_id, person_id, start_date, end_date, op_start_date, op_end_date, visit_occurrence_id) as
(
-- Begin Primary Events
select P.ordinal as event_id, P.person_id, P.start_date, P.end_date, op_start_date, op_end_date, cast(P.visit_occurrence_id as bigint) as visit_occurrence_id
FROM
(
  select E.person_id, E.start_date, E.end_date,
         row_number() OVER (PARTITION BY E.person_id ORDER BY E.sort_date ASC) ordinal,
         OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date, cast(E.visit_occurrence_id as bigint) as visit_occurrence_id
  FROM 
  (
  -- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.drug_exposure_start_date as start_date,
       COALESCE(C.DRUG_EXPOSURE_END_DATE, DATEADD(day,C.DAYS_SUPPLY,DRUG_EXPOSURE_START_DATE), DATEADD(day,1,C.DRUG_EXPOSURE_START_DATE)) as end_date,
       C.visit_occurrence_id,C.drug_exposure_start_date as sort_date
from 
(
  select de.* 
  FROM @cdm_database_schema.DRUG_EXPOSURE de
	where (drug_source_value like '%647201110%'
          or drug_source_value like '%645302660%'
          or drug_source_value like '%671701970%'
          or drug_source_value like '%644308860%'
          or drug_source_value like '%653102630%'
          or drug_source_value like '%658602980%'
          or drug_source_value like '%641100230%'
          or drug_source_value like '%640006650%'
          or drug_source_value like '%643506700%'
          or drug_source_value like '%53600550%'
          or drug_source_value like '%53300520%'
          or drug_source_value like '%57700460%'
          or drug_source_value like '%58800750%'
          or drug_source_value like '%623006000%'
          or drug_source_value like '%625200380%'
          or drug_source_value like '%643104640%'
          or drug_source_value like '%643802680%'
          or drug_source_value like '%642900260%'
          or drug_source_value like '%643504840%'
          or drug_source_value like '%649002220%'
          or drug_source_value like '%650204850%'
          or drug_source_value like '%647303720%'
          or drug_source_value like '%649605330%'
          or drug_source_value like '%661604850%'
          or drug_source_value like '%661305340%'
          or drug_source_value like '%657304170%'
          or drug_source_value like '%670102390%'
          or drug_source_value like '%670608150%'
          or drug_source_value like '%665002700%'
          or drug_source_value like '%694001320%'
          or drug_source_value like '%645401860%'
          or drug_source_value like '%649505100%'
          or drug_source_value like '%55101030%'
          or drug_source_value like '%53600560%'
          or drug_source_value like '%53300510%'
          or drug_source_value like '%57000850%'
          or drug_source_value like '%623005690%'
          or drug_source_value like '%625200270%'
          or drug_source_value like '%628801410%'
          or drug_source_value like '%58800990%'
          or drug_source_value like '%643104650%'
          or drug_source_value like '%646204140%'
          or drug_source_value like '%648603120%'
          or drug_source_value like '%649103410%'
          or drug_source_value like '%650204860%'
          or drug_source_value like '%647303730%'
          or drug_source_value like '%661305130%'
          or drug_source_value like '%658604180%'
          or drug_source_value like '%657304180%'
          or drug_source_value like '%658106410%'
          or drug_source_value like '%669907180%'
          or drug_source_value like '%670608160%'
          or drug_source_value like '%678601810%'
          or drug_source_value like '%673400040%'
          or drug_source_value like '%690300780%'
          or drug_source_value like '%643504270%'
          or drug_source_value like '%642900270%'
          or drug_source_value like '%645401870%'
          or drug_source_value like '%660702470%'
          or drug_source_value like '%643703970%'
          or drug_source_value like '%670303910%'
          or drug_source_value like '%55100970%'
          or drug_source_value like '%53300890%'
          or drug_source_value like '%57000410%'
          or drug_source_value like '%53601160%'
          or drug_source_value like '%641106100%'
          or drug_source_value like '%622804140%'
          or drug_source_value like '%628900970%'
          or drug_source_value like '%59000710%'
          or drug_source_value like '%629700820%'
          or drug_source_value like '%640903210%'
          or drug_source_value like '%642301630%'
          or drug_source_value like '%643200590%'
          or drug_source_value like '%647200950%'
          or drug_source_value like '%644700940%'
          or drug_source_value like '%645209690%'
          or drug_source_value like '%645602070%'
          or drug_source_value like '%644603440%'
          or drug_source_value like '%647803930%'
          or drug_source_value like '%646201140%'
          or drug_source_value like '%649000410%'
          or drug_source_value like '%649102400%'
          or drug_source_value like '%650205150%'
          or drug_source_value like '%650300880%'
          or drug_source_value like '%648601820%'
          or drug_source_value like '%654700380%'
          or drug_source_value like '%653801430%'
          or drug_source_value like '%652601290%'
          or drug_source_value like '%693900960%'
          or drug_source_value like '%654300960%'
          or drug_source_value like '%651201180%'
          or drug_source_value like '%656700970%'
          or drug_source_value like '%657500460%'
          or drug_source_value like '%661605130%'
          or drug_source_value like '%661901880%'
          or drug_source_value like '%658603020%'
          or drug_source_value like '%662504120%'
          or drug_source_value like '%658200640%'
          or drug_source_value like '%657306750%'
          or drug_source_value like '%656001060%'
          or drug_source_value like '%657805000%'
          or drug_source_value like '%661306280%'
          or drug_source_value like '%669902830%'
          or drug_source_value like '%669800690%'
          or drug_source_value like '%670606950%'
          or drug_source_value like '%669502320%'
          or drug_source_value like '%665000470%'
          or drug_source_value like '%670104220%'
          or drug_source_value like '%673400140%'
          or drug_source_value like '%696600300%'
          or drug_source_value like '%693201640%'
          or drug_source_value like '%679801410%'
          or drug_source_value like '%680500560%'
          or drug_source_value like '%698400120%'
          or drug_source_value like '%678900910%'
          or drug_source_value like '%678600890%'
          or drug_source_value like '%694205700%'
          or drug_source_value like '%689000520%'
          or drug_source_value like '%697100740%'
          or drug_source_value like '%674401130%'
          or drug_source_value like '%641104830%'
          or drug_source_value like '%641601750%'
          or drug_source_value like '%640000660%'
          or drug_source_value like '%643100260%'
          or drug_source_value like '%643702190%'
          or drug_source_value like '%642900900%'
          or drug_source_value like '%642702110%'
          or drug_source_value like '%644301980%'
          or drug_source_value like '%644802330%'
          or drug_source_value like '%647802260%'
          or drug_source_value like '%648503260%'
          or drug_source_value like '%649503750%'
          or drug_source_value like '%651500850%'
          or drug_source_value like '%653003190%'
          or drug_source_value like '%663600410%'
          or drug_source_value like '%694000300%'
          or drug_source_value like '%671700650%'
          or drug_source_value like '%641105090%'
          or drug_source_value like '%641100170%'
          or drug_source_value like '%657300180%'
          or drug_source_value like '%647201270%'
          or drug_source_value like '%656700410%'
          or drug_source_value like '%645401490%'
          or drug_source_value like '%649100210%'
          or drug_source_value like '%694001020%'
          or drug_source_value like '%674400920%'
          or drug_source_value like '%642900910%'
          or drug_source_value like '%644301990%'
          or drug_source_value like '%656700980%'
          or drug_source_value like '%53601480%'
          or drug_source_value like '%55101330%'
          or drug_source_value like '%57000790%'
          or drug_source_value like '%621801830%'
          or drug_source_value like '%628800670%'
          or drug_source_value like '%622803250%'
          or drug_source_value like '%642307750%'
          or drug_source_value like '%643104580%'
          or drug_source_value like '%644806060%'
          or drug_source_value like '%647201260%'
          or drug_source_value like '%649602320%'
          or drug_source_value like '%646200420%'
          or drug_source_value like '%650205300%'
          or drug_source_value like '%649102580%'
          or drug_source_value like '%648200040%'
          or drug_source_value like '%652604240%'
          or drug_source_value like '%652904310%'
          or drug_source_value like '%653801540%'
          or drug_source_value like '%654001910%'
          or drug_source_value like '%654303500%'
          or drug_source_value like '%656700400%'
          or drug_source_value like '%661306110%'
          or drug_source_value like '%658200880%'
          or drug_source_value like '%658603370%'
          or drug_source_value like '%669902910%'
          or drug_source_value like '%670401370%'
          or drug_source_value like '%684500980%'
          or drug_source_value like '%698504050%'
          or drug_source_value like '%693900900%'
          or drug_source_value like '%674400610%'
          or drug_source_value like '%690301000%'
          or drug_source_value like '%640901220%'
          or drug_source_value like '%644000850%'
          or drug_source_value like '%642700900%'
          or drug_source_value like '%643501960%'
          or drug_source_value like '%642901320%'
          or drug_source_value like '%645401480%'
          or drug_source_value like '%645900910%'
          or drug_source_value like '%651200900%'
          or drug_source_value like '%648504110%'
          or drug_source_value like '%649401910%'
          or drug_source_value like '%649801410%'
          or drug_source_value like '%649501940%'
          or drug_source_value like '%655902560%'
          or drug_source_value like '%661901200%'
          or drug_source_value like '%657300220%'
          or drug_source_value like '%663601350%'
          or drug_source_value like '%660701750%'
          or drug_source_value like '%670101050%'
          or drug_source_value like '%671701990%'
          or drug_source_value like '%57600150%'
          or drug_source_value like '%55101040%'
          or drug_source_value like '%57000320%'
          or drug_source_value like '%623005700%'
          or drug_source_value like '%628900090%'
          or drug_source_value like '%625501010%'
          or drug_source_value like '%641801390%'
          or drug_source_value like '%625200620%'
          or drug_source_value like '%628800150%'
          or drug_source_value like '%622802180%'
          or drug_source_value like '%59600410%'
          or drug_source_value like '%59000750%'
          or drug_source_value like '%641605650%'
          or drug_source_value like '%642307890%'
          or drug_source_value like '%643701070%'
          or drug_source_value like '%642100260%'
          or drug_source_value like '%643103770%'
          or drug_source_value like '%644101270%'
          or drug_source_value like '%645601660%'
          or drug_source_value like '%647205110%'
          or drug_source_value like '%644502900%'
          or drug_source_value like '%646000430%'
          or drug_source_value like '%649102240%'
          or drug_source_value like '%647303690%'
          or drug_source_value like '%653402580%'
          or drug_source_value like '%654001570%'
          or drug_source_value like '%653000420%'
          or drug_source_value like '%652600630%'
          or drug_source_value like '%651601790%'
          or drug_source_value like '%661604410%'
          or drug_source_value like '%658602800%'
          or drug_source_value like '%661900300%'
          or drug_source_value like '%661305490%'
          or drug_source_value like '%658106420%'
          or drug_source_value like '%658501710%'
          or drug_source_value like '%657202460%'
          or drug_source_value like '%656000190%'
          or drug_source_value like '%657400900%'
          or drug_source_value like '%662500740%'
          or drug_source_value like '%657805030%'
          or drug_source_value like '%669501440%'
          or drug_source_value like '%669901050%'
          or drug_source_value like '%670100250%'
          or drug_source_value like '%670606450%'
          or drug_source_value like '%670501730%'
          or drug_source_value like '%665002690%'
          or drug_source_value like '%693902320%'
          or drug_source_value like '%698000600%'
          or drug_source_value like '%698503180%'
          or drug_source_value like '%696602070%'
          or drug_source_value like '%678601690%'
          or drug_source_value like '%693200730%'
          or drug_source_value like '%690300960%'
          or drug_source_value like '%640900260%'
          or drug_source_value like '%641700130%'
          or drug_source_value like '%643200110%'
          or drug_source_value like '%643500540%'
          or drug_source_value like '%644300840%'
          or drug_source_value like '%642900250%'
          or drug_source_value like '%645200570%'
          or drug_source_value like '%645401470%'
          or drug_source_value like '%646200110%'
          or drug_source_value like '%648100470%'
          or drug_source_value like '%645901240%'
          or drug_source_value like '%649400410%'
          or drug_source_value like '%649800460%'
          or drug_source_value like '%648506360%'
          or drug_source_value like '%651200250%'
          or drug_source_value like '%655900820%'
          or drug_source_value like '%652900310%'
          or drug_source_value like '%657300510%'
          or drug_source_value like '%660701110%'
          or drug_source_value like '%670000160%'
          or drug_source_value like '%671802730%'
          or drug_source_value like '%669802320%'
          or drug_source_value like '%641100160%'
          or drug_source_value like '%668901110%'
          or drug_source_value like '%669800770%'
          or drug_source_value like '%A27803951%'
          or drug_source_value like '%A00802771%'
          or drug_source_value like '%642706340%'
          or drug_source_value like '%53601480%'
          or drug_source_value like '%55101330%'
          or drug_source_value like '%57000790%'
          or drug_source_value like '%621801830%'
          or drug_source_value like '%628800670%'
          or drug_source_value like '%622803250%'
          or drug_source_value like '%642307750%'
          or drug_source_value like '%643104580%'
          or drug_source_value like '%644806060%'
          or drug_source_value like '%647201260%'
          or drug_source_value like '%647201270%'
          or drug_source_value like '%649602320%'
          or drug_source_value like '%646200420%'
          or drug_source_value like '%650205300%'
          or drug_source_value like '%649102580%'
          or drug_source_value like '%648200040%'
          or drug_source_value like '%652604240%'
          or drug_source_value like '%652904310%'
          or drug_source_value like '%653801540%'
          or drug_source_value like '%654001910%'
          or drug_source_value like '%654303500%'
          or drug_source_value like '%656700400%'
          or drug_source_value like '%656700410%'
          or drug_source_value like '%661306110%'
          or drug_source_value like '%658200880%'
          or drug_source_value like '%658603370%'
          or drug_source_value like '%669902910%'
          or drug_source_value like '%670401370%'
          or drug_source_value like '%684500980%'
          or drug_source_value like '%698504050%'
          or drug_source_value like '%693900900%'
          or drug_source_value like '%674400610%'
          or drug_source_value like '%690301000%'
          or drug_source_value like '%641903040%'
          or drug_source_value like '%643701860%'
          or drug_source_value like '%644304680%'
          or drug_source_value like '%648102010%'
          or drug_source_value like '%645301760%'
          or drug_source_value like '%649700760%'
          or drug_source_value like '%648504120%'
          or drug_source_value like '%649000420%'
          or drug_source_value like '%649602330%'
          or drug_source_value like '%650101260%'
          or drug_source_value like '%653102790%'
          or drug_source_value like '%652104960%'
          or drug_source_value like '%658001840%'
          or drug_source_value like '%663300660%'
          or drug_source_value like '%656601820%'
          or drug_source_value like '%656601830%'
          or drug_source_value like '%671800800%'
          or drug_source_value like '%674101530%'
          or drug_source_value like '%671900290%'
          or drug_source_value like '%683601560%'
          or drug_source_value like '%670601690%'
          or drug_source_value like '%670000840%'
          or drug_source_value like '%698000850%'
          or drug_source_value like '%698000900%'
          or drug_source_value like '%A01304781%'
          or drug_source_value like '%699801670%'
          or drug_source_value like '%A03602111%'
          or drug_source_value like '%A06650701%'
          or drug_source_value like '%A05703451%'
          or drug_source_value like '%A18250471%'
          or drug_source_value like '%A13353881%'
          or drug_source_value like '%A16602311%'
          or drug_source_value like '%A12802401%'
          or drug_source_value like '%A18400021%'
          or drug_source_value like '%A18450231%'
          or drug_source_value like '%A08401921%'
          or drug_source_value like '%A15252221%'
          or drug_source_value like '%A19252961%'
          or drug_source_value like '%A50600121%'
          or drug_source_value like '%A50600131%'
          or drug_source_value like '%A78850721%'
          or drug_source_value like '%A22550221%'
          or drug_source_value like '%A31050081%'
          or drug_source_value like '%A31802211%'
          or drug_source_value like '%A25002631%'
          or drug_source_value like '%A36700081%'
          or drug_source_value like '%A20703311%'
          or drug_source_value like '%A60350391%'
          or drug_source_value like '%A34850281%'
          or drug_source_value like '%A22450021%'
          or drug_source_value like '%A28301341%'
          or drug_source_value like '%55100970%'
          or drug_source_value like '%53300890%'
          or drug_source_value like '%57000410%'
          or drug_source_value like '%53601160%'
          or drug_source_value like '%641100160%'
          or drug_source_value like '%641100170%'
          or drug_source_value like '%641105090%'
          or drug_source_value like '%641106100%'
          or drug_source_value like '%622804140%'
          or drug_source_value like '%628900970%'
          or drug_source_value like '%59000710%'
          or drug_source_value like '%629700820%'
          or drug_source_value like '%640903210%'
          or drug_source_value like '%642301630%'
          or drug_source_value like '%643200590%'
          or drug_source_value like '%647200950%'
          or drug_source_value like '%645209690%'
          or drug_source_value like '%644700940%'
          or drug_source_value like '%645602070%'
          or drug_source_value like '%644603440%'
          or drug_source_value like '%647803930%'
          or drug_source_value like '%646201140%'
          or drug_source_value like '%649000410%'
          or drug_source_value like '%649102400%'
          or drug_source_value like '%650205150%'
          or drug_source_value like '%650300880%'
          or drug_source_value like '%648601820%'
          or drug_source_value like '%654700380%'
          or drug_source_value like '%653801430%'
          or drug_source_value like '%652601290%'
          or drug_source_value like '%693900960%'
          or drug_source_value like '%654300960%'
          or drug_source_value like '%651201180%'
          or drug_source_value like '%656700970%'
          or drug_source_value like '%657500460%'
          or drug_source_value like '%661605130%'
          or drug_source_value like '%661901880%'
          or drug_source_value like '%658603020%'
          or drug_source_value like '%662504120%'
          or drug_source_value like '%658200640%'
          or drug_source_value like '%657306750%'
          or drug_source_value like '%656001060%'
          or drug_source_value like '%657805000%'
          or drug_source_value like '%661306280%'
          or drug_source_value like '%669902830%'
          or drug_source_value like '%669800690%'
          or drug_source_value like '%670606950%'
          or drug_source_value like '%669502320%'
          or drug_source_value like '%665000470%'
          or drug_source_value like '%670104220%'
          or drug_source_value like '%673400140%'
          or drug_source_value like '%694001020%'
          or drug_source_value like '%689000520%'
          or drug_source_value like '%696600300%'
          or drug_source_value like '%693201640%'
          or drug_source_value like '%679801410%'
          or drug_source_value like '%680500560%'
          or drug_source_value like '%698400120%'
          or drug_source_value like '%678900910%'
          or drug_source_value like '%674400920%'
          or drug_source_value like '%678600890%'
          or drug_source_value like '%694205700%'
          or drug_source_value like '%697100740%'
          or drug_source_value like '%674401130%'
          or drug_source_value like '%644100410%'
          or drug_source_value like '%647500360%'
          or drug_source_value like '%646004260%'
          or drug_source_value like '%649602290%'
          or drug_source_value like '%654802170%'
          or drug_source_value like '%658107560%'
          or drug_source_value like '%660702980%'
          or drug_source_value like '%656601040%'
          or drug_source_value like '%663300790%'
          or drug_source_value like '%667100140%'
          or drug_source_value like '%668900650%'
          or drug_source_value like '%680000170%'
          or drug_source_value like '%671900920%'
          or drug_source_value like '%690300620%'
          or drug_source_value like '%673200600%'
          or drug_source_value like '%670602710%'
          or drug_source_value like '%698000740%'
          or drug_source_value like '%699903380%'
          or drug_source_value like '%A02550781%'
          or drug_source_value like '%A06650581%'
          or drug_source_value like '%A05703801%'
          or drug_source_value like '%A19640231%'
          or drug_source_value like '%A08652001%'
          or drug_source_value like '%A12251401%'
          or drug_source_value like '%A12602071%'
          or drug_source_value like '%A08851391%'
          or drug_source_value like '%A07206121%'
          or drug_source_value like '%A50600111%'
          or drug_source_value like '%A50700861%'
          or drug_source_value like '%A33290051%'
          or drug_source_value like '%A27852321%'
          or drug_source_value like '%A21950991%'
          or drug_source_value like '%A20650131%'
          or drug_source_value like '%A20703291%'
          or drug_source_value like '%A82851331%'
          or drug_source_value like '%A34850041%'
          or drug_source_value like '%644304430%'
          or drug_source_value like '%656601140%'
          or drug_source_value like '%A08851411%'
          or drug_source_value like '%645700450%'
          or drug_source_value like '%689100890%'
          or drug_source_value like '%657300180%'
          or drug_source_value like '%643701910%'
          or drug_source_value like '%643302720%'
          or drug_source_value like '%647801590%'
          or drug_source_value like '%649700600%'
          or drug_source_value like '%651500110%'
          or drug_source_value like '%653002720%'
          or drug_source_value like '%656600990%'
          or drug_source_value like '%656601000%'
          or drug_source_value like '%670602870%'
          or drug_source_value like '%A08801891%'
          or drug_source_value like '%A18450171%'
          or drug_source_value like '%A12650991%'
          or drug_source_value like '%A08850031%'
          or drug_source_value like '%A29550871%'
          or drug_source_value like '%A25001561%'
          or drug_source_value like '%A25001571%'
          or drug_source_value like '%A31000901%'
          or drug_source_value like '%647201110%'
          or drug_source_value like '%645302650%'
          or drug_source_value like '%645302660%'
          or drug_source_value like '%671701970%'
          or drug_source_value like '%670304020%'
          or drug_source_value like '%654501510%'
          or drug_source_value like '%654300730%'
          or drug_source_value like '%656202670%'
          or drug_source_value like '%670300320%'
          or drug_source_value like '%670300330%'
          or drug_source_value like '%669901100%'
          or drug_source_value like '%698500320%'
          or drug_source_value like '%696600230%'
          or drug_source_value like '%A04704241%'
          or drug_source_value like '%A04704411%'
          or drug_source_value like '%A18701951%'
          or drug_source_value like '%A50600551%'
          or drug_source_value like '%A25803331%'
          or drug_source_value like '%A22502871%'
          or drug_source_value like '%A37803071%'
          or drug_source_value like '%A37803181%'
          or drug_source_value like '%A82800081%'
          or drug_source_value like '%A78800191%'
          or drug_source_value like '%643300700%'
          or drug_source_value like '%645700820%'
          or drug_source_value like '%644301810%'
          or drug_source_value like '%645700970%'
          or drug_source_value like '%57600150%'
          or drug_source_value like '%55101030%'
          or drug_source_value like '%55101040%'
          or drug_source_value like '%57000320%'
          or drug_source_value like '%53600550%'
          or drug_source_value like '%53600560%'
          or drug_source_value like '%53300510%'
          or drug_source_value like '%53300520%'
          or drug_source_value like '%57700460%'
          or drug_source_value like '%57000850%'
          or drug_source_value like '%623005690%'
          or drug_source_value like '%623005700%'
          or drug_source_value like '%625200270%'
          or drug_source_value like '%628801410%'
          or drug_source_value like '%58800750%'
          or drug_source_value like '%58800990%'
          or drug_source_value like '%641801390%'
          or drug_source_value like '%625501010%'
          or drug_source_value like '%628900090%'
          or drug_source_value like '%623006000%'
          or drug_source_value like '%625200620%'
          or drug_source_value like '%628800150%'
          or drug_source_value like '%622802180%'
          or drug_source_value like '%59600410%'
          or drug_source_value like '%59000750%'
          or drug_source_value like '%625200380%'
          or drug_source_value like '%641605650%'
          or drug_source_value like '%642307890%'
          or drug_source_value like '%643104640%'
          or drug_source_value like '%643104650%'
          or drug_source_value like '%643701070%'
          or drug_source_value like '%643802680%'
          or drug_source_value like '%642900260%'
          or drug_source_value like '%643504840%'
          or drug_source_value like '%642100260%'
          or drug_source_value like '%643103770%'
          or drug_source_value like '%644101270%'
          or drug_source_value like '%645601660%'
          or drug_source_value like '%646204140%'
          or drug_source_value like '%647205110%'
          or drug_source_value like '%644502900%'
          or drug_source_value like '%646000430%'
          or drug_source_value like '%648603120%'
          or drug_source_value like '%649103410%'
          or drug_source_value like '%649002220%'
          or drug_source_value like '%650204850%'
          or drug_source_value like '%650204860%'
          or drug_source_value like '%649102240%'
          or drug_source_value like '%647303690%'
          or drug_source_value like '%647303720%'
          or drug_source_value like '%647303730%'
          or drug_source_value like '%649605330%'
          or drug_source_value like '%653402580%'
          or drug_source_value like '%654001570%'
          or drug_source_value like '%653000420%'
          or drug_source_value like '%652600630%'
          or drug_source_value like '%651601790%'
          or drug_source_value like '%661604410%'
          or drug_source_value like '%661604850%'
          or drug_source_value like '%661305130%'
          or drug_source_value like '%661305340%'
          or drug_source_value like '%658602800%'
          or drug_source_value like '%658604180%'
          or drug_source_value like '%661900300%'
          or drug_source_value like '%657304170%'
          or drug_source_value like '%657304180%'
          or drug_source_value like '%661305490%'
          or drug_source_value like '%658106410%'
          or drug_source_value like '%658106420%'
          or drug_source_value like '%658501710%'
          or drug_source_value like '%657202460%'
          or drug_source_value like '%656000190%'
          or drug_source_value like '%657400900%'
          or drug_source_value like '%662500740%'
          or drug_source_value like '%657805030%'
          or drug_source_value like '%669501440%'
          or drug_source_value like '%669901050%'
          or drug_source_value like '%670100250%'
          or drug_source_value like '%670606450%'
          or drug_source_value like '%670102390%'
          or drug_source_value like '%670501730%'
          or drug_source_value like '%669907180%'
          or drug_source_value like '%670608150%'
          or drug_source_value like '%665002690%'
          or drug_source_value like '%665002700%'
          or drug_source_value like '%670608160%'
          or drug_source_value like '%698000600%'
          or drug_source_value like '%693902320%'
          or drug_source_value like '%698503180%'
          or drug_source_value like '%694001320%'
          or drug_source_value like '%696602070%'
          or drug_source_value like '%678601690%'
          or drug_source_value like '%678601810%'
          or drug_source_value like '%693200730%'
          or drug_source_value like '%673400040%'
          or drug_source_value like '%690300780%'
          or drug_source_value like '%690300960%'
          or drug_source_value like '%629700020%'
          or drug_source_value like '%640903410%'
          or drug_source_value like '%54000770%'
          or drug_source_value like '%622802930%'
          or drug_source_value like '%642706100%'
          or drug_source_value like '%644602810%'
          or drug_source_value like '%645209450%'
          or drug_source_value like '%648603110%'
          or drug_source_value like '%650204500%'
          or drug_source_value like '%651202670%'
          or drug_source_value like '%647204910%'
          or drug_source_value like '%647204920%'
          or drug_source_value like '%650101190%'
          or drug_source_value like '%652903180%'
          or drug_source_value like '%652104700%'
          or drug_source_value like '%652104710%'
          or drug_source_value like '%652104720%'
          or drug_source_value like '%655602380%'
          or drug_source_value like '%654301540%'
          or drug_source_value like '%654701540%'
          or drug_source_value like '%652900320%'
          or drug_source_value like '%656600410%'
          or drug_source_value like '%663600330%'
          or drug_source_value like '%669907030%'
          or drug_source_value like '%670000170%'
          or drug_source_value like '%670000180%'
          or drug_source_value like '%690300760%'
          or drug_source_value like '%678600430%'
          or drug_source_value like '%678600730%'
          or drug_source_value like '%671704330%'
          or drug_source_value like '%694205420%'
          or drug_source_value like '%694205430%'
          or drug_source_value like '%699903340%'
          or drug_source_value like '%A03551021%'
          or drug_source_value like '%A06501841%'
          or drug_source_value like '%A05652841%'
          or drug_source_value like '%696601320%'
          or drug_source_value like '%A06751051%'
          or drug_source_value like '%A11152081%'
          or drug_source_value like '%A21451681%'
          or drug_source_value like '%A66351661%'
          or drug_source_value like '%A21455291%'
          or drug_source_value like '%A21457871%'
          or drug_source_value like '%A21950332%'
          or drug_source_value like '%A22695661%'
          or drug_source_value like '%A23053141%'
          or drug_source_value like '%A35103801%'
          or drug_source_value like '%A28301981%'
          or drug_source_value like '%644308860%'
          or drug_source_value like '%653102630%'
          or drug_source_value like '%658602980%'
          or drug_source_value like '%645103910%'
          or drug_source_value like '%645604420%'
          or drug_source_value like '%670304020%'
          or drug_source_value like '%645302650%'
          or drug_source_value like '%643302730%'
          or drug_source_value like '%644903930%'
          or drug_source_value like '%644701880%'
)
) C


-- End Drug Exposure Criteria

  ) E
	JOIN @cdm_database_schema.observation_period OP on E.person_id = OP.person_id and E.start_date >=  OP.observation_period_start_date and E.start_date <= op.observation_period_end_date
  WHERE DATEADD(day,0,OP.OBSERVATION_PERIOD_START_DATE) <= E.START_DATE AND DATEADD(day,0,E.START_DATE) <= OP.OBSERVATION_PERIOD_END_DATE
) P

-- End Primary Events

)
SELECT event_id, person_id, start_date, end_date, op_start_date, op_end_date, visit_occurrence_id
INTO #qualified_events
FROM 
(
  select pe.event_id, pe.person_id, pe.start_date, pe.end_date, pe.op_start_date, pe.op_end_date, row_number() over (partition by pe.person_id order by pe.start_date ASC) as ordinal, cast(pe.visit_occurrence_id as bigint) as visit_occurrence_id
  FROM primary_events pe
  
) QE

;

--- Inclusion Rule Inserts

select 0 as inclusion_rule_id, person_id, event_id
INTO #Inclusion_0
FROM 
(
  select pe.person_id, pe.event_id
  FROM #qualified_events pe
  
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM #qualified_events E
  INNER JOIN
  (
    -- Begin Correlated Criteria
select 0 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM #qualified_events P
JOIN (
  -- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.condition_start_date as start_date, COALESCE(C.condition_end_date, DATEADD(day,1,C.condition_start_date)) as end_date,
  C.visit_occurrence_id, C.condition_start_date as sort_date
FROM 
(
  SELECT co.* 
  FROM @cdm_database_schema.CONDITION_OCCURRENCE co
  JOIN #Codesets codesets on ((co.condition_concept_id = codesets.concept_id and codesets.codeset_id = 2))
) C


-- End Condition Occurrence Criteria

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= DATEADD(day,-7,P.START_DATE) AND A.START_DATE <= DATEADD(day,0,P.START_DATE) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id AND AC.event_id = pe.event_id
) Results
;

select 1 as inclusion_rule_id, person_id, event_id
INTO #Inclusion_1
FROM 
(
  select pe.person_id, pe.event_id
  FROM #qualified_events pe
  
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM #qualified_events E
  INNER JOIN
  (
    -- Begin Correlated Criteria
select 0 as index_id, p.person_id, p.event_id
from #qualified_events p
LEFT JOIN (
SELECT p.person_id, p.event_id 
FROM #qualified_events P
JOIN (
  -- Begin Visit Occurrence Criteria
select C.person_id, C.visit_occurrence_id as event_id, C.visit_start_date as start_date, C.visit_end_date as end_date,
       C.visit_occurrence_id, C.visit_start_date as sort_date
from 
(
  select vo.* 
  FROM @cdm_database_schema.VISIT_OCCURRENCE vo
JOIN #Codesets codesets on ((vo.visit_concept_id = codesets.concept_id and codesets.codeset_id = 1))
) C


-- End Visit Occurrence Criteria

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= DATEADD(day,-7,P.START_DATE) AND A.START_DATE <= DATEADD(day,0,P.START_DATE) ) cc on p.person_id = cc.person_id and p.event_id = cc.event_id
GROUP BY p.person_id, p.event_id
HAVING COUNT(cc.event_id) = 0
-- End Correlated Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id AND AC.event_id = pe.event_id
) Results
;

SELECT inclusion_rule_id, person_id, event_id
INTO #inclusion_events
FROM (select inclusion_rule_id, person_id, event_id from #Inclusion_0
UNION ALL
select inclusion_rule_id, person_id, event_id from #Inclusion_1) I;
TRUNCATE TABLE #Inclusion_0;
DROP TABLE #Inclusion_0;

TRUNCATE TABLE #Inclusion_1;
DROP TABLE #Inclusion_1;


with cteIncludedEvents(event_id, person_id, start_date, end_date, op_start_date, op_end_date, ordinal) as
(
  SELECT event_id, person_id, start_date, end_date, op_start_date, op_end_date, row_number() over (partition by person_id order by start_date ASC) as ordinal
  from
  (
    select Q.event_id, Q.person_id, Q.start_date, Q.end_date, Q.op_start_date, Q.op_end_date, SUM(coalesce(POWER(cast(2 as bigint), I.inclusion_rule_id), 0)) as inclusion_rule_mask
    from #qualified_events Q
    LEFT JOIN #inclusion_events I on I.person_id = Q.person_id and I.event_id = Q.event_id
    GROUP BY Q.event_id, Q.person_id, Q.start_date, Q.end_date, Q.op_start_date, Q.op_end_date
  ) MG -- matching groups
{2 != 0}?{
  -- the matching group with all bits set ( POWER(2,# of inclusion rules) - 1 = inclusion_rule_mask
  WHERE (MG.inclusion_rule_mask = POWER(cast(2 as bigint),2)-1)
}
)
select event_id, person_id, start_date, end_date, op_start_date, op_end_date
into #included_events
FROM cteIncludedEvents Results

;

-- custom era strategy

with ctePersons(person_id) as (
	select distinct person_id from #included_events
)

select person_id, drug_exposure_start_date, drug_exposure_end_date
INTO #drugTarget
FROM (
	select de.PERSON_ID, DRUG_EXPOSURE_START_DATE, COALESCE(DRUG_EXPOSURE_END_DATE, DATEADD(day,DAYS_SUPPLY,DRUG_EXPOSURE_START_DATE), DATEADD(day,1,DRUG_EXPOSURE_START_DATE)) as DRUG_EXPOSURE_END_DATE 
	FROM @cdm_database_schema.DRUG_EXPOSURE de
	JOIN ctePersons p on de.person_id = p.person_id
	where (drug_source_value like '%647201110%'
          or drug_source_value like '%645302660%'
          or drug_source_value like '%671701970%'
          or drug_source_value like '%644308860%'
          or drug_source_value like '%653102630%'
          or drug_source_value like '%658602980%'
          or drug_source_value like '%641100230%'
          or drug_source_value like '%640006650%'
          or drug_source_value like '%643506700%'
          or drug_source_value like '%53600550%'
          or drug_source_value like '%53300520%'
          or drug_source_value like '%57700460%'
          or drug_source_value like '%58800750%'
          or drug_source_value like '%623006000%'
          or drug_source_value like '%625200380%'
          or drug_source_value like '%643104640%'
          or drug_source_value like '%643802680%'
          or drug_source_value like '%642900260%'
          or drug_source_value like '%643504840%'
          or drug_source_value like '%649002220%'
          or drug_source_value like '%650204850%'
          or drug_source_value like '%647303720%'
          or drug_source_value like '%649605330%'
          or drug_source_value like '%661604850%'
          or drug_source_value like '%661305340%'
          or drug_source_value like '%657304170%'
          or drug_source_value like '%670102390%'
          or drug_source_value like '%670608150%'
          or drug_source_value like '%665002700%'
          or drug_source_value like '%694001320%'
          or drug_source_value like '%645401860%'
          or drug_source_value like '%649505100%'
          or drug_source_value like '%55101030%'
          or drug_source_value like '%53600560%'
          or drug_source_value like '%53300510%'
          or drug_source_value like '%57000850%'
          or drug_source_value like '%623005690%'
          or drug_source_value like '%625200270%'
          or drug_source_value like '%628801410%'
          or drug_source_value like '%58800990%'
          or drug_source_value like '%643104650%'
          or drug_source_value like '%646204140%'
          or drug_source_value like '%648603120%'
          or drug_source_value like '%649103410%'
          or drug_source_value like '%650204860%'
          or drug_source_value like '%647303730%'
          or drug_source_value like '%661305130%'
          or drug_source_value like '%658604180%'
          or drug_source_value like '%657304180%'
          or drug_source_value like '%658106410%'
          or drug_source_value like '%669907180%'
          or drug_source_value like '%670608160%'
          or drug_source_value like '%678601810%'
          or drug_source_value like '%673400040%'
          or drug_source_value like '%690300780%'
          or drug_source_value like '%643504270%'
          or drug_source_value like '%642900270%'
          or drug_source_value like '%645401870%'
          or drug_source_value like '%660702470%'
          or drug_source_value like '%643703970%'
          or drug_source_value like '%670303910%'
          or drug_source_value like '%55100970%'
          or drug_source_value like '%53300890%'
          or drug_source_value like '%57000410%'
          or drug_source_value like '%53601160%'
          or drug_source_value like '%641106100%'
          or drug_source_value like '%622804140%'
          or drug_source_value like '%628900970%'
          or drug_source_value like '%59000710%'
          or drug_source_value like '%629700820%'
          or drug_source_value like '%640903210%'
          or drug_source_value like '%642301630%'
          or drug_source_value like '%643200590%'
          or drug_source_value like '%647200950%'
          or drug_source_value like '%644700940%'
          or drug_source_value like '%645209690%'
          or drug_source_value like '%645602070%'
          or drug_source_value like '%644603440%'
          or drug_source_value like '%647803930%'
          or drug_source_value like '%646201140%'
          or drug_source_value like '%649000410%'
          or drug_source_value like '%649102400%'
          or drug_source_value like '%650205150%'
          or drug_source_value like '%650300880%'
          or drug_source_value like '%648601820%'
          or drug_source_value like '%654700380%'
          or drug_source_value like '%653801430%'
          or drug_source_value like '%652601290%'
          or drug_source_value like '%693900960%'
          or drug_source_value like '%654300960%'
          or drug_source_value like '%651201180%'
          or drug_source_value like '%656700970%'
          or drug_source_value like '%657500460%'
          or drug_source_value like '%661605130%'
          or drug_source_value like '%661901880%'
          or drug_source_value like '%658603020%'
          or drug_source_value like '%662504120%'
          or drug_source_value like '%658200640%'
          or drug_source_value like '%657306750%'
          or drug_source_value like '%656001060%'
          or drug_source_value like '%657805000%'
          or drug_source_value like '%661306280%'
          or drug_source_value like '%669902830%'
          or drug_source_value like '%669800690%'
          or drug_source_value like '%670606950%'
          or drug_source_value like '%669502320%'
          or drug_source_value like '%665000470%'
          or drug_source_value like '%670104220%'
          or drug_source_value like '%673400140%'
          or drug_source_value like '%696600300%'
          or drug_source_value like '%693201640%'
          or drug_source_value like '%679801410%'
          or drug_source_value like '%680500560%'
          or drug_source_value like '%698400120%'
          or drug_source_value like '%678900910%'
          or drug_source_value like '%678600890%'
          or drug_source_value like '%694205700%'
          or drug_source_value like '%689000520%'
          or drug_source_value like '%697100740%'
          or drug_source_value like '%674401130%'
          or drug_source_value like '%641104830%'
          or drug_source_value like '%641601750%'
          or drug_source_value like '%640000660%'
          or drug_source_value like '%643100260%'
          or drug_source_value like '%643702190%'
          or drug_source_value like '%642900900%'
          or drug_source_value like '%642702110%'
          or drug_source_value like '%644301980%'
          or drug_source_value like '%644802330%'
          or drug_source_value like '%647802260%'
          or drug_source_value like '%648503260%'
          or drug_source_value like '%649503750%'
          or drug_source_value like '%651500850%'
          or drug_source_value like '%653003190%'
          or drug_source_value like '%663600410%'
          or drug_source_value like '%694000300%'
          or drug_source_value like '%671700650%'
          or drug_source_value like '%641105090%'
          or drug_source_value like '%641100170%'
          or drug_source_value like '%657300180%'
          or drug_source_value like '%647201270%'
          or drug_source_value like '%656700410%'
          or drug_source_value like '%645401490%'
          or drug_source_value like '%649100210%'
          or drug_source_value like '%694001020%'
          or drug_source_value like '%674400920%'
          or drug_source_value like '%642900910%'
          or drug_source_value like '%644301990%'
          or drug_source_value like '%656700980%'
          or drug_source_value like '%53601480%'
          or drug_source_value like '%55101330%'
          or drug_source_value like '%57000790%'
          or drug_source_value like '%621801830%'
          or drug_source_value like '%628800670%'
          or drug_source_value like '%622803250%'
          or drug_source_value like '%642307750%'
          or drug_source_value like '%643104580%'
          or drug_source_value like '%644806060%'
          or drug_source_value like '%647201260%'
          or drug_source_value like '%649602320%'
          or drug_source_value like '%646200420%'
          or drug_source_value like '%650205300%'
          or drug_source_value like '%649102580%'
          or drug_source_value like '%648200040%'
          or drug_source_value like '%652604240%'
          or drug_source_value like '%652904310%'
          or drug_source_value like '%653801540%'
          or drug_source_value like '%654001910%'
          or drug_source_value like '%654303500%'
          or drug_source_value like '%656700400%'
          or drug_source_value like '%661306110%'
          or drug_source_value like '%658200880%'
          or drug_source_value like '%658603370%'
          or drug_source_value like '%669902910%'
          or drug_source_value like '%670401370%'
          or drug_source_value like '%684500980%'
          or drug_source_value like '%698504050%'
          or drug_source_value like '%693900900%'
          or drug_source_value like '%674400610%'
          or drug_source_value like '%690301000%'
          or drug_source_value like '%640901220%'
          or drug_source_value like '%644000850%'
          or drug_source_value like '%642700900%'
          or drug_source_value like '%643501960%'
          or drug_source_value like '%642901320%'
          or drug_source_value like '%645401480%'
          or drug_source_value like '%645900910%'
          or drug_source_value like '%651200900%'
          or drug_source_value like '%648504110%'
          or drug_source_value like '%649401910%'
          or drug_source_value like '%649801410%'
          or drug_source_value like '%649501940%'
          or drug_source_value like '%655902560%'
          or drug_source_value like '%661901200%'
          or drug_source_value like '%657300220%'
          or drug_source_value like '%663601350%'
          or drug_source_value like '%660701750%'
          or drug_source_value like '%670101050%'
          or drug_source_value like '%671701990%'
          or drug_source_value like '%57600150%'
          or drug_source_value like '%55101040%'
          or drug_source_value like '%57000320%'
          or drug_source_value like '%623005700%'
          or drug_source_value like '%628900090%'
          or drug_source_value like '%625501010%'
          or drug_source_value like '%641801390%'
          or drug_source_value like '%625200620%'
          or drug_source_value like '%628800150%'
          or drug_source_value like '%622802180%'
          or drug_source_value like '%59600410%'
          or drug_source_value like '%59000750%'
          or drug_source_value like '%641605650%'
          or drug_source_value like '%642307890%'
          or drug_source_value like '%643701070%'
          or drug_source_value like '%642100260%'
          or drug_source_value like '%643103770%'
          or drug_source_value like '%644101270%'
          or drug_source_value like '%645601660%'
          or drug_source_value like '%647205110%'
          or drug_source_value like '%644502900%'
          or drug_source_value like '%646000430%'
          or drug_source_value like '%649102240%'
          or drug_source_value like '%647303690%'
          or drug_source_value like '%653402580%'
          or drug_source_value like '%654001570%'
          or drug_source_value like '%653000420%'
          or drug_source_value like '%652600630%'
          or drug_source_value like '%651601790%'
          or drug_source_value like '%661604410%'
          or drug_source_value like '%658602800%'
          or drug_source_value like '%661900300%'
          or drug_source_value like '%661305490%'
          or drug_source_value like '%658106420%'
          or drug_source_value like '%658501710%'
          or drug_source_value like '%657202460%'
          or drug_source_value like '%656000190%'
          or drug_source_value like '%657400900%'
          or drug_source_value like '%662500740%'
          or drug_source_value like '%657805030%'
          or drug_source_value like '%669501440%'
          or drug_source_value like '%669901050%'
          or drug_source_value like '%670100250%'
          or drug_source_value like '%670606450%'
          or drug_source_value like '%670501730%'
          or drug_source_value like '%665002690%'
          or drug_source_value like '%693902320%'
          or drug_source_value like '%698000600%'
          or drug_source_value like '%698503180%'
          or drug_source_value like '%696602070%'
          or drug_source_value like '%678601690%'
          or drug_source_value like '%693200730%'
          or drug_source_value like '%690300960%'
          or drug_source_value like '%640900260%'
          or drug_source_value like '%641700130%'
          or drug_source_value like '%643200110%'
          or drug_source_value like '%643500540%'
          or drug_source_value like '%644300840%'
          or drug_source_value like '%642900250%'
          or drug_source_value like '%645200570%'
          or drug_source_value like '%645401470%'
          or drug_source_value like '%646200110%'
          or drug_source_value like '%648100470%'
          or drug_source_value like '%645901240%'
          or drug_source_value like '%649400410%'
          or drug_source_value like '%649800460%'
          or drug_source_value like '%648506360%'
          or drug_source_value like '%651200250%'
          or drug_source_value like '%655900820%'
          or drug_source_value like '%652900310%'
          or drug_source_value like '%657300510%'
          or drug_source_value like '%660701110%'
          or drug_source_value like '%670000160%'
          or drug_source_value like '%671802730%'
          or drug_source_value like '%669802320%'
          or drug_source_value like '%641100160%'
          or drug_source_value like '%668901110%'
          or drug_source_value like '%669800770%'
          or drug_source_value like '%A27803951%'
          or drug_source_value like '%A00802771%'
          or drug_source_value like '%642706340%'
          or drug_source_value like '%53601480%'
          or drug_source_value like '%55101330%'
          or drug_source_value like '%57000790%'
          or drug_source_value like '%621801830%'
          or drug_source_value like '%628800670%'
          or drug_source_value like '%622803250%'
          or drug_source_value like '%642307750%'
          or drug_source_value like '%643104580%'
          or drug_source_value like '%644806060%'
          or drug_source_value like '%647201260%'
          or drug_source_value like '%647201270%'
          or drug_source_value like '%649602320%'
          or drug_source_value like '%646200420%'
          or drug_source_value like '%650205300%'
          or drug_source_value like '%649102580%'
          or drug_source_value like '%648200040%'
          or drug_source_value like '%652604240%'
          or drug_source_value like '%652904310%'
          or drug_source_value like '%653801540%'
          or drug_source_value like '%654001910%'
          or drug_source_value like '%654303500%'
          or drug_source_value like '%656700400%'
          or drug_source_value like '%656700410%'
          or drug_source_value like '%661306110%'
          or drug_source_value like '%658200880%'
          or drug_source_value like '%658603370%'
          or drug_source_value like '%669902910%'
          or drug_source_value like '%670401370%'
          or drug_source_value like '%684500980%'
          or drug_source_value like '%698504050%'
          or drug_source_value like '%693900900%'
          or drug_source_value like '%674400610%'
          or drug_source_value like '%690301000%'
          or drug_source_value like '%641903040%'
          or drug_source_value like '%643701860%'
          or drug_source_value like '%644304680%'
          or drug_source_value like '%648102010%'
          or drug_source_value like '%645301760%'
          or drug_source_value like '%649700760%'
          or drug_source_value like '%648504120%'
          or drug_source_value like '%649000420%'
          or drug_source_value like '%649602330%'
          or drug_source_value like '%650101260%'
          or drug_source_value like '%653102790%'
          or drug_source_value like '%652104960%'
          or drug_source_value like '%658001840%'
          or drug_source_value like '%663300660%'
          or drug_source_value like '%656601820%'
          or drug_source_value like '%656601830%'
          or drug_source_value like '%671800800%'
          or drug_source_value like '%674101530%'
          or drug_source_value like '%671900290%'
          or drug_source_value like '%683601560%'
          or drug_source_value like '%670601690%'
          or drug_source_value like '%670000840%'
          or drug_source_value like '%698000850%'
          or drug_source_value like '%698000900%'
          or drug_source_value like '%A01304781%'
          or drug_source_value like '%699801670%'
          or drug_source_value like '%A03602111%'
          or drug_source_value like '%A06650701%'
          or drug_source_value like '%A05703451%'
          or drug_source_value like '%A18250471%'
          or drug_source_value like '%A13353881%'
          or drug_source_value like '%A16602311%'
          or drug_source_value like '%A12802401%'
          or drug_source_value like '%A18400021%'
          or drug_source_value like '%A18450231%'
          or drug_source_value like '%A08401921%'
          or drug_source_value like '%A15252221%'
          or drug_source_value like '%A19252961%'
          or drug_source_value like '%A50600121%'
          or drug_source_value like '%A50600131%'
          or drug_source_value like '%A78850721%'
          or drug_source_value like '%A22550221%'
          or drug_source_value like '%A31050081%'
          or drug_source_value like '%A31802211%'
          or drug_source_value like '%A25002631%'
          or drug_source_value like '%A36700081%'
          or drug_source_value like '%A20703311%'
          or drug_source_value like '%A60350391%'
          or drug_source_value like '%A34850281%'
          or drug_source_value like '%A22450021%'
          or drug_source_value like '%A28301341%'
          or drug_source_value like '%55100970%'
          or drug_source_value like '%53300890%'
          or drug_source_value like '%57000410%'
          or drug_source_value like '%53601160%'
          or drug_source_value like '%641100160%'
          or drug_source_value like '%641100170%'
          or drug_source_value like '%641105090%'
          or drug_source_value like '%641106100%'
          or drug_source_value like '%622804140%'
          or drug_source_value like '%628900970%'
          or drug_source_value like '%59000710%'
          or drug_source_value like '%629700820%'
          or drug_source_value like '%640903210%'
          or drug_source_value like '%642301630%'
          or drug_source_value like '%643200590%'
          or drug_source_value like '%647200950%'
          or drug_source_value like '%645209690%'
          or drug_source_value like '%644700940%'
          or drug_source_value like '%645602070%'
          or drug_source_value like '%644603440%'
          or drug_source_value like '%647803930%'
          or drug_source_value like '%646201140%'
          or drug_source_value like '%649000410%'
          or drug_source_value like '%649102400%'
          or drug_source_value like '%650205150%'
          or drug_source_value like '%650300880%'
          or drug_source_value like '%648601820%'
          or drug_source_value like '%654700380%'
          or drug_source_value like '%653801430%'
          or drug_source_value like '%652601290%'
          or drug_source_value like '%693900960%'
          or drug_source_value like '%654300960%'
          or drug_source_value like '%651201180%'
          or drug_source_value like '%656700970%'
          or drug_source_value like '%657500460%'
          or drug_source_value like '%661605130%'
          or drug_source_value like '%661901880%'
          or drug_source_value like '%658603020%'
          or drug_source_value like '%662504120%'
          or drug_source_value like '%658200640%'
          or drug_source_value like '%657306750%'
          or drug_source_value like '%656001060%'
          or drug_source_value like '%657805000%'
          or drug_source_value like '%661306280%'
          or drug_source_value like '%669902830%'
          or drug_source_value like '%669800690%'
          or drug_source_value like '%670606950%'
          or drug_source_value like '%669502320%'
          or drug_source_value like '%665000470%'
          or drug_source_value like '%670104220%'
          or drug_source_value like '%673400140%'
          or drug_source_value like '%694001020%'
          or drug_source_value like '%689000520%'
          or drug_source_value like '%696600300%'
          or drug_source_value like '%693201640%'
          or drug_source_value like '%679801410%'
          or drug_source_value like '%680500560%'
          or drug_source_value like '%698400120%'
          or drug_source_value like '%678900910%'
          or drug_source_value like '%674400920%'
          or drug_source_value like '%678600890%'
          or drug_source_value like '%694205700%'
          or drug_source_value like '%697100740%'
          or drug_source_value like '%674401130%'
          or drug_source_value like '%644100410%'
          or drug_source_value like '%647500360%'
          or drug_source_value like '%646004260%'
          or drug_source_value like '%649602290%'
          or drug_source_value like '%654802170%'
          or drug_source_value like '%658107560%'
          or drug_source_value like '%660702980%'
          or drug_source_value like '%656601040%'
          or drug_source_value like '%663300790%'
          or drug_source_value like '%667100140%'
          or drug_source_value like '%668900650%'
          or drug_source_value like '%680000170%'
          or drug_source_value like '%671900920%'
          or drug_source_value like '%690300620%'
          or drug_source_value like '%673200600%'
          or drug_source_value like '%670602710%'
          or drug_source_value like '%698000740%'
          or drug_source_value like '%699903380%'
          or drug_source_value like '%A02550781%'
          or drug_source_value like '%A06650581%'
          or drug_source_value like '%A05703801%'
          or drug_source_value like '%A19640231%'
          or drug_source_value like '%A08652001%'
          or drug_source_value like '%A12251401%'
          or drug_source_value like '%A12602071%'
          or drug_source_value like '%A08851391%'
          or drug_source_value like '%A07206121%'
          or drug_source_value like '%A50600111%'
          or drug_source_value like '%A50700861%'
          or drug_source_value like '%A33290051%'
          or drug_source_value like '%A27852321%'
          or drug_source_value like '%A21950991%'
          or drug_source_value like '%A20650131%'
          or drug_source_value like '%A20703291%'
          or drug_source_value like '%A82851331%'
          or drug_source_value like '%A34850041%'
          or drug_source_value like '%644304430%'
          or drug_source_value like '%656601140%'
          or drug_source_value like '%A08851411%'
          or drug_source_value like '%645700450%'
          or drug_source_value like '%689100890%'
          or drug_source_value like '%657300180%'
          or drug_source_value like '%643701910%'
          or drug_source_value like '%643302720%'
          or drug_source_value like '%647801590%'
          or drug_source_value like '%649700600%'
          or drug_source_value like '%651500110%'
          or drug_source_value like '%653002720%'
          or drug_source_value like '%656600990%'
          or drug_source_value like '%656601000%'
          or drug_source_value like '%670602870%'
          or drug_source_value like '%A08801891%'
          or drug_source_value like '%A18450171%'
          or drug_source_value like '%A12650991%'
          or drug_source_value like '%A08850031%'
          or drug_source_value like '%A29550871%'
          or drug_source_value like '%A25001561%'
          or drug_source_value like '%A25001571%'
          or drug_source_value like '%A31000901%'
          or drug_source_value like '%647201110%'
          or drug_source_value like '%645302650%'
          or drug_source_value like '%645302660%'
          or drug_source_value like '%671701970%'
          or drug_source_value like '%670304020%'
          or drug_source_value like '%654501510%'
          or drug_source_value like '%654300730%'
          or drug_source_value like '%656202670%'
          or drug_source_value like '%670300320%'
          or drug_source_value like '%670300330%'
          or drug_source_value like '%669901100%'
          or drug_source_value like '%698500320%'
          or drug_source_value like '%696600230%'
          or drug_source_value like '%A04704241%'
          or drug_source_value like '%A04704411%'
          or drug_source_value like '%A18701951%'
          or drug_source_value like '%A50600551%'
          or drug_source_value like '%A25803331%'
          or drug_source_value like '%A22502871%'
          or drug_source_value like '%A37803071%'
          or drug_source_value like '%A37803181%'
          or drug_source_value like '%A82800081%'
          or drug_source_value like '%A78800191%'
          or drug_source_value like '%643300700%'
          or drug_source_value like '%645700820%'
          or drug_source_value like '%644301810%'
          or drug_source_value like '%645700970%'
          or drug_source_value like '%57600150%'
          or drug_source_value like '%55101030%'
          or drug_source_value like '%55101040%'
          or drug_source_value like '%57000320%'
          or drug_source_value like '%53600550%'
          or drug_source_value like '%53600560%'
          or drug_source_value like '%53300510%'
          or drug_source_value like '%53300520%'
          or drug_source_value like '%57700460%'
          or drug_source_value like '%57000850%'
          or drug_source_value like '%623005690%'
          or drug_source_value like '%623005700%'
          or drug_source_value like '%625200270%'
          or drug_source_value like '%628801410%'
          or drug_source_value like '%58800750%'
          or drug_source_value like '%58800990%'
          or drug_source_value like '%641801390%'
          or drug_source_value like '%625501010%'
          or drug_source_value like '%628900090%'
          or drug_source_value like '%623006000%'
          or drug_source_value like '%625200620%'
          or drug_source_value like '%628800150%'
          or drug_source_value like '%622802180%'
          or drug_source_value like '%59600410%'
          or drug_source_value like '%59000750%'
          or drug_source_value like '%625200380%'
          or drug_source_value like '%641605650%'
          or drug_source_value like '%642307890%'
          or drug_source_value like '%643104640%'
          or drug_source_value like '%643104650%'
          or drug_source_value like '%643701070%'
          or drug_source_value like '%643802680%'
          or drug_source_value like '%642900260%'
          or drug_source_value like '%643504840%'
          or drug_source_value like '%642100260%'
          or drug_source_value like '%643103770%'
          or drug_source_value like '%644101270%'
          or drug_source_value like '%645601660%'
          or drug_source_value like '%646204140%'
          or drug_source_value like '%647205110%'
          or drug_source_value like '%644502900%'
          or drug_source_value like '%646000430%'
          or drug_source_value like '%648603120%'
          or drug_source_value like '%649103410%'
          or drug_source_value like '%649002220%'
          or drug_source_value like '%650204850%'
          or drug_source_value like '%650204860%'
          or drug_source_value like '%649102240%'
          or drug_source_value like '%647303690%'
          or drug_source_value like '%647303720%'
          or drug_source_value like '%647303730%'
          or drug_source_value like '%649605330%'
          or drug_source_value like '%653402580%'
          or drug_source_value like '%654001570%'
          or drug_source_value like '%653000420%'
          or drug_source_value like '%652600630%'
          or drug_source_value like '%651601790%'
          or drug_source_value like '%661604410%'
          or drug_source_value like '%661604850%'
          or drug_source_value like '%661305130%'
          or drug_source_value like '%661305340%'
          or drug_source_value like '%658602800%'
          or drug_source_value like '%658604180%'
          or drug_source_value like '%661900300%'
          or drug_source_value like '%657304170%'
          or drug_source_value like '%657304180%'
          or drug_source_value like '%661305490%'
          or drug_source_value like '%658106410%'
          or drug_source_value like '%658106420%'
          or drug_source_value like '%658501710%'
          or drug_source_value like '%657202460%'
          or drug_source_value like '%656000190%'
          or drug_source_value like '%657400900%'
          or drug_source_value like '%662500740%'
          or drug_source_value like '%657805030%'
          or drug_source_value like '%669501440%'
          or drug_source_value like '%669901050%'
          or drug_source_value like '%670100250%'
          or drug_source_value like '%670606450%'
          or drug_source_value like '%670102390%'
          or drug_source_value like '%670501730%'
          or drug_source_value like '%669907180%'
          or drug_source_value like '%670608150%'
          or drug_source_value like '%665002690%'
          or drug_source_value like '%665002700%'
          or drug_source_value like '%670608160%'
          or drug_source_value like '%698000600%'
          or drug_source_value like '%693902320%'
          or drug_source_value like '%698503180%'
          or drug_source_value like '%694001320%'
          or drug_source_value like '%696602070%'
          or drug_source_value like '%678601690%'
          or drug_source_value like '%678601810%'
          or drug_source_value like '%693200730%'
          or drug_source_value like '%673400040%'
          or drug_source_value like '%690300780%'
          or drug_source_value like '%690300960%'
          or drug_source_value like '%629700020%'
          or drug_source_value like '%640903410%'
          or drug_source_value like '%54000770%'
          or drug_source_value like '%622802930%'
          or drug_source_value like '%642706100%'
          or drug_source_value like '%644602810%'
          or drug_source_value like '%645209450%'
          or drug_source_value like '%648603110%'
          or drug_source_value like '%650204500%'
          or drug_source_value like '%651202670%'
          or drug_source_value like '%647204910%'
          or drug_source_value like '%647204920%'
          or drug_source_value like '%650101190%'
          or drug_source_value like '%652903180%'
          or drug_source_value like '%652104700%'
          or drug_source_value like '%652104710%'
          or drug_source_value like '%652104720%'
          or drug_source_value like '%655602380%'
          or drug_source_value like '%654301540%'
          or drug_source_value like '%654701540%'
          or drug_source_value like '%652900320%'
          or drug_source_value like '%656600410%'
          or drug_source_value like '%663600330%'
          or drug_source_value like '%669907030%'
          or drug_source_value like '%670000170%'
          or drug_source_value like '%670000180%'
          or drug_source_value like '%690300760%'
          or drug_source_value like '%678600430%'
          or drug_source_value like '%678600730%'
          or drug_source_value like '%671704330%'
          or drug_source_value like '%694205420%'
          or drug_source_value like '%694205430%'
          or drug_source_value like '%699903340%'
          or drug_source_value like '%A03551021%'
          or drug_source_value like '%A06501841%'
          or drug_source_value like '%A05652841%'
          or drug_source_value like '%696601320%'
          or drug_source_value like '%A06751051%'
          or drug_source_value like '%A11152081%'
          or drug_source_value like '%A21451681%'
          or drug_source_value like '%A66351661%'
          or drug_source_value like '%A21455291%'
          or drug_source_value like '%A21457871%'
          or drug_source_value like '%A21950332%'
          or drug_source_value like '%A22695661%'
          or drug_source_value like '%A23053141%'
          or drug_source_value like '%A35103801%'
          or drug_source_value like '%A28301981%'
          or drug_source_value like '%644308860%'
          or drug_source_value like '%653102630%'
          or drug_source_value like '%658602980%'
          or drug_source_value like '%645103910%'
          or drug_source_value like '%645604420%'
          or drug_source_value like '%670304020%'
          or drug_source_value like '%645302650%'
          or drug_source_value like '%643302730%'
          or drug_source_value like '%644903930%'
          or drug_source_value like '%644701880%'

	UNION ALL

	select de.PERSON_ID, DRUG_EXPOSURE_START_DATE, COALESCE(DRUG_EXPOSURE_END_DATE, DATEADD(day,DAYS_SUPPLY,DRUG_EXPOSURE_START_DATE), DATEADD(day,1,DRUG_EXPOSURE_START_DATE)) as DRUG_EXPOSURE_END_DATE 
	FROM @cdm_database_schema.DRUG_EXPOSURE de
	JOIN ctePersons p on de.person_id = p.person_id
	where (drug_source_value like '%647201110%'
          or drug_source_value like '%645302660%'
          or drug_source_value like '%671701970%'
          or drug_source_value like '%644308860%'
          or drug_source_value like '%653102630%'
          or drug_source_value like '%658602980%'
          or drug_source_value like '%641100230%'
          or drug_source_value like '%640006650%'
          or drug_source_value like '%643506700%'
          or drug_source_value like '%53600550%'
          or drug_source_value like '%53300520%'
          or drug_source_value like '%57700460%'
          or drug_source_value like '%58800750%'
          or drug_source_value like '%623006000%'
          or drug_source_value like '%625200380%'
          or drug_source_value like '%643104640%'
          or drug_source_value like '%643802680%'
          or drug_source_value like '%642900260%'
          or drug_source_value like '%643504840%'
          or drug_source_value like '%649002220%'
          or drug_source_value like '%650204850%'
          or drug_source_value like '%647303720%'
          or drug_source_value like '%649605330%'
          or drug_source_value like '%661604850%'
          or drug_source_value like '%661305340%'
          or drug_source_value like '%657304170%'
          or drug_source_value like '%670102390%'
          or drug_source_value like '%670608150%'
          or drug_source_value like '%665002700%'
          or drug_source_value like '%694001320%'
          or drug_source_value like '%645401860%'
          or drug_source_value like '%649505100%'
          or drug_source_value like '%55101030%'
          or drug_source_value like '%53600560%'
          or drug_source_value like '%53300510%'
          or drug_source_value like '%57000850%'
          or drug_source_value like '%623005690%'
          or drug_source_value like '%625200270%'
          or drug_source_value like '%628801410%'
          or drug_source_value like '%58800990%'
          or drug_source_value like '%643104650%'
          or drug_source_value like '%646204140%'
          or drug_source_value like '%648603120%'
          or drug_source_value like '%649103410%'
          or drug_source_value like '%650204860%'
          or drug_source_value like '%647303730%'
          or drug_source_value like '%661305130%'
          or drug_source_value like '%658604180%'
          or drug_source_value like '%657304180%'
          or drug_source_value like '%658106410%'
          or drug_source_value like '%669907180%'
          or drug_source_value like '%670608160%'
          or drug_source_value like '%678601810%'
          or drug_source_value like '%673400040%'
          or drug_source_value like '%690300780%'
          or drug_source_value like '%643504270%'
          or drug_source_value like '%642900270%'
          or drug_source_value like '%645401870%'
          or drug_source_value like '%660702470%'
          or drug_source_value like '%643703970%'
          or drug_source_value like '%670303910%'
          or drug_source_value like '%55100970%'
          or drug_source_value like '%53300890%'
          or drug_source_value like '%57000410%'
          or drug_source_value like '%53601160%'
          or drug_source_value like '%641106100%'
          or drug_source_value like '%622804140%'
          or drug_source_value like '%628900970%'
          or drug_source_value like '%59000710%'
          or drug_source_value like '%629700820%'
          or drug_source_value like '%640903210%'
          or drug_source_value like '%642301630%'
          or drug_source_value like '%643200590%'
          or drug_source_value like '%647200950%'
          or drug_source_value like '%644700940%'
          or drug_source_value like '%645209690%'
          or drug_source_value like '%645602070%'
          or drug_source_value like '%644603440%'
          or drug_source_value like '%647803930%'
          or drug_source_value like '%646201140%'
          or drug_source_value like '%649000410%'
          or drug_source_value like '%649102400%'
          or drug_source_value like '%650205150%'
          or drug_source_value like '%650300880%'
          or drug_source_value like '%648601820%'
          or drug_source_value like '%654700380%'
          or drug_source_value like '%653801430%'
          or drug_source_value like '%652601290%'
          or drug_source_value like '%693900960%'
          or drug_source_value like '%654300960%'
          or drug_source_value like '%651201180%'
          or drug_source_value like '%656700970%'
          or drug_source_value like '%657500460%'
          or drug_source_value like '%661605130%'
          or drug_source_value like '%661901880%'
          or drug_source_value like '%658603020%'
          or drug_source_value like '%662504120%'
          or drug_source_value like '%658200640%'
          or drug_source_value like '%657306750%'
          or drug_source_value like '%656001060%'
          or drug_source_value like '%657805000%'
          or drug_source_value like '%661306280%'
          or drug_source_value like '%669902830%'
          or drug_source_value like '%669800690%'
          or drug_source_value like '%670606950%'
          or drug_source_value like '%669502320%'
          or drug_source_value like '%665000470%'
          or drug_source_value like '%670104220%'
          or drug_source_value like '%673400140%'
          or drug_source_value like '%696600300%'
          or drug_source_value like '%693201640%'
          or drug_source_value like '%679801410%'
          or drug_source_value like '%680500560%'
          or drug_source_value like '%698400120%'
          or drug_source_value like '%678900910%'
          or drug_source_value like '%678600890%'
          or drug_source_value like '%694205700%'
          or drug_source_value like '%689000520%'
          or drug_source_value like '%697100740%'
          or drug_source_value like '%674401130%'
          or drug_source_value like '%641104830%'
          or drug_source_value like '%641601750%'
          or drug_source_value like '%640000660%'
          or drug_source_value like '%643100260%'
          or drug_source_value like '%643702190%'
          or drug_source_value like '%642900900%'
          or drug_source_value like '%642702110%'
          or drug_source_value like '%644301980%'
          or drug_source_value like '%644802330%'
          or drug_source_value like '%647802260%'
          or drug_source_value like '%648503260%'
          or drug_source_value like '%649503750%'
          or drug_source_value like '%651500850%'
          or drug_source_value like '%653003190%'
          or drug_source_value like '%663600410%'
          or drug_source_value like '%694000300%'
          or drug_source_value like '%671700650%'
          or drug_source_value like '%641105090%'
          or drug_source_value like '%641100170%'
          or drug_source_value like '%657300180%'
          or drug_source_value like '%647201270%'
          or drug_source_value like '%656700410%'
          or drug_source_value like '%645401490%'
          or drug_source_value like '%649100210%'
          or drug_source_value like '%694001020%'
          or drug_source_value like '%674400920%'
          or drug_source_value like '%642900910%'
          or drug_source_value like '%644301990%'
          or drug_source_value like '%656700980%'
          or drug_source_value like '%53601480%'
          or drug_source_value like '%55101330%'
          or drug_source_value like '%57000790%'
          or drug_source_value like '%621801830%'
          or drug_source_value like '%628800670%'
          or drug_source_value like '%622803250%'
          or drug_source_value like '%642307750%'
          or drug_source_value like '%643104580%'
          or drug_source_value like '%644806060%'
          or drug_source_value like '%647201260%'
          or drug_source_value like '%649602320%'
          or drug_source_value like '%646200420%'
          or drug_source_value like '%650205300%'
          or drug_source_value like '%649102580%'
          or drug_source_value like '%648200040%'
          or drug_source_value like '%652604240%'
          or drug_source_value like '%652904310%'
          or drug_source_value like '%653801540%'
          or drug_source_value like '%654001910%'
          or drug_source_value like '%654303500%'
          or drug_source_value like '%656700400%'
          or drug_source_value like '%661306110%'
          or drug_source_value like '%658200880%'
          or drug_source_value like '%658603370%'
          or drug_source_value like '%669902910%'
          or drug_source_value like '%670401370%'
          or drug_source_value like '%684500980%'
          or drug_source_value like '%698504050%'
          or drug_source_value like '%693900900%'
          or drug_source_value like '%674400610%'
          or drug_source_value like '%690301000%'
          or drug_source_value like '%640901220%'
          or drug_source_value like '%644000850%'
          or drug_source_value like '%642700900%'
          or drug_source_value like '%643501960%'
          or drug_source_value like '%642901320%'
          or drug_source_value like '%645401480%'
          or drug_source_value like '%645900910%'
          or drug_source_value like '%651200900%'
          or drug_source_value like '%648504110%'
          or drug_source_value like '%649401910%'
          or drug_source_value like '%649801410%'
          or drug_source_value like '%649501940%'
          or drug_source_value like '%655902560%'
          or drug_source_value like '%661901200%'
          or drug_source_value like '%657300220%'
          or drug_source_value like '%663601350%'
          or drug_source_value like '%660701750%'
          or drug_source_value like '%670101050%'
          or drug_source_value like '%671701990%'
          or drug_source_value like '%57600150%'
          or drug_source_value like '%55101040%'
          or drug_source_value like '%57000320%'
          or drug_source_value like '%623005700%'
          or drug_source_value like '%628900090%'
          or drug_source_value like '%625501010%'
          or drug_source_value like '%641801390%'
          or drug_source_value like '%625200620%'
          or drug_source_value like '%628800150%'
          or drug_source_value like '%622802180%'
          or drug_source_value like '%59600410%'
          or drug_source_value like '%59000750%'
          or drug_source_value like '%641605650%'
          or drug_source_value like '%642307890%'
          or drug_source_value like '%643701070%'
          or drug_source_value like '%642100260%'
          or drug_source_value like '%643103770%'
          or drug_source_value like '%644101270%'
          or drug_source_value like '%645601660%'
          or drug_source_value like '%647205110%'
          or drug_source_value like '%644502900%'
          or drug_source_value like '%646000430%'
          or drug_source_value like '%649102240%'
          or drug_source_value like '%647303690%'
          or drug_source_value like '%653402580%'
          or drug_source_value like '%654001570%'
          or drug_source_value like '%653000420%'
          or drug_source_value like '%652600630%'
          or drug_source_value like '%651601790%'
          or drug_source_value like '%661604410%'
          or drug_source_value like '%658602800%'
          or drug_source_value like '%661900300%'
          or drug_source_value like '%661305490%'
          or drug_source_value like '%658106420%'
          or drug_source_value like '%658501710%'
          or drug_source_value like '%657202460%'
          or drug_source_value like '%656000190%'
          or drug_source_value like '%657400900%'
          or drug_source_value like '%662500740%'
          or drug_source_value like '%657805030%'
          or drug_source_value like '%669501440%'
          or drug_source_value like '%669901050%'
          or drug_source_value like '%670100250%'
          or drug_source_value like '%670606450%'
          or drug_source_value like '%670501730%'
          or drug_source_value like '%665002690%'
          or drug_source_value like '%693902320%'
          or drug_source_value like '%698000600%'
          or drug_source_value like '%698503180%'
          or drug_source_value like '%696602070%'
          or drug_source_value like '%678601690%'
          or drug_source_value like '%693200730%'
          or drug_source_value like '%690300960%'
          or drug_source_value like '%640900260%'
          or drug_source_value like '%641700130%'
          or drug_source_value like '%643200110%'
          or drug_source_value like '%643500540%'
          or drug_source_value like '%644300840%'
          or drug_source_value like '%642900250%'
          or drug_source_value like '%645200570%'
          or drug_source_value like '%645401470%'
          or drug_source_value like '%646200110%'
          or drug_source_value like '%648100470%'
          or drug_source_value like '%645901240%'
          or drug_source_value like '%649400410%'
          or drug_source_value like '%649800460%'
          or drug_source_value like '%648506360%'
          or drug_source_value like '%651200250%'
          or drug_source_value like '%655900820%'
          or drug_source_value like '%652900310%'
          or drug_source_value like '%657300510%'
          or drug_source_value like '%660701110%'
          or drug_source_value like '%670000160%'
          or drug_source_value like '%671802730%'
          or drug_source_value like '%669802320%'
          or drug_source_value like '%641100160%'
          or drug_source_value like '%668901110%'
          or drug_source_value like '%669800770%'
          or drug_source_value like '%A27803951%'
          or drug_source_value like '%A00802771%'
          or drug_source_value like '%642706340%'
          or drug_source_value like '%53601480%'
          or drug_source_value like '%55101330%'
          or drug_source_value like '%57000790%'
          or drug_source_value like '%621801830%'
          or drug_source_value like '%628800670%'
          or drug_source_value like '%622803250%'
          or drug_source_value like '%642307750%'
          or drug_source_value like '%643104580%'
          or drug_source_value like '%644806060%'
          or drug_source_value like '%647201260%'
          or drug_source_value like '%647201270%'
          or drug_source_value like '%649602320%'
          or drug_source_value like '%646200420%'
          or drug_source_value like '%650205300%'
          or drug_source_value like '%649102580%'
          or drug_source_value like '%648200040%'
          or drug_source_value like '%652604240%'
          or drug_source_value like '%652904310%'
          or drug_source_value like '%653801540%'
          or drug_source_value like '%654001910%'
          or drug_source_value like '%654303500%'
          or drug_source_value like '%656700400%'
          or drug_source_value like '%656700410%'
          or drug_source_value like '%661306110%'
          or drug_source_value like '%658200880%'
          or drug_source_value like '%658603370%'
          or drug_source_value like '%669902910%'
          or drug_source_value like '%670401370%'
          or drug_source_value like '%684500980%'
          or drug_source_value like '%698504050%'
          or drug_source_value like '%693900900%'
          or drug_source_value like '%674400610%'
          or drug_source_value like '%690301000%'
          or drug_source_value like '%641903040%'
          or drug_source_value like '%643701860%'
          or drug_source_value like '%644304680%'
          or drug_source_value like '%648102010%'
          or drug_source_value like '%645301760%'
          or drug_source_value like '%649700760%'
          or drug_source_value like '%648504120%'
          or drug_source_value like '%649000420%'
          or drug_source_value like '%649602330%'
          or drug_source_value like '%650101260%'
          or drug_source_value like '%653102790%'
          or drug_source_value like '%652104960%'
          or drug_source_value like '%658001840%'
          or drug_source_value like '%663300660%'
          or drug_source_value like '%656601820%'
          or drug_source_value like '%656601830%'
          or drug_source_value like '%671800800%'
          or drug_source_value like '%674101530%'
          or drug_source_value like '%671900290%'
          or drug_source_value like '%683601560%'
          or drug_source_value like '%670601690%'
          or drug_source_value like '%670000840%'
          or drug_source_value like '%698000850%'
          or drug_source_value like '%698000900%'
          or drug_source_value like '%A01304781%'
          or drug_source_value like '%699801670%'
          or drug_source_value like '%A03602111%'
          or drug_source_value like '%A06650701%'
          or drug_source_value like '%A05703451%'
          or drug_source_value like '%A18250471%'
          or drug_source_value like '%A13353881%'
          or drug_source_value like '%A16602311%'
          or drug_source_value like '%A12802401%'
          or drug_source_value like '%A18400021%'
          or drug_source_value like '%A18450231%'
          or drug_source_value like '%A08401921%'
          or drug_source_value like '%A15252221%'
          or drug_source_value like '%A19252961%'
          or drug_source_value like '%A50600121%'
          or drug_source_value like '%A50600131%'
          or drug_source_value like '%A78850721%'
          or drug_source_value like '%A22550221%'
          or drug_source_value like '%A31050081%'
          or drug_source_value like '%A31802211%'
          or drug_source_value like '%A25002631%'
          or drug_source_value like '%A36700081%'
          or drug_source_value like '%A20703311%'
          or drug_source_value like '%A60350391%'
          or drug_source_value like '%A34850281%'
          or drug_source_value like '%A22450021%'
          or drug_source_value like '%A28301341%'
          or drug_source_value like '%55100970%'
          or drug_source_value like '%53300890%'
          or drug_source_value like '%57000410%'
          or drug_source_value like '%53601160%'
          or drug_source_value like '%641100160%'
          or drug_source_value like '%641100170%'
          or drug_source_value like '%641105090%'
          or drug_source_value like '%641106100%'
          or drug_source_value like '%622804140%'
          or drug_source_value like '%628900970%'
          or drug_source_value like '%59000710%'
          or drug_source_value like '%629700820%'
          or drug_source_value like '%640903210%'
          or drug_source_value like '%642301630%'
          or drug_source_value like '%643200590%'
          or drug_source_value like '%647200950%'
          or drug_source_value like '%645209690%'
          or drug_source_value like '%644700940%'
          or drug_source_value like '%645602070%'
          or drug_source_value like '%644603440%'
          or drug_source_value like '%647803930%'
          or drug_source_value like '%646201140%'
          or drug_source_value like '%649000410%'
          or drug_source_value like '%649102400%'
          or drug_source_value like '%650205150%'
          or drug_source_value like '%650300880%'
          or drug_source_value like '%648601820%'
          or drug_source_value like '%654700380%'
          or drug_source_value like '%653801430%'
          or drug_source_value like '%652601290%'
          or drug_source_value like '%693900960%'
          or drug_source_value like '%654300960%'
          or drug_source_value like '%651201180%'
          or drug_source_value like '%656700970%'
          or drug_source_value like '%657500460%'
          or drug_source_value like '%661605130%'
          or drug_source_value like '%661901880%'
          or drug_source_value like '%658603020%'
          or drug_source_value like '%662504120%'
          or drug_source_value like '%658200640%'
          or drug_source_value like '%657306750%'
          or drug_source_value like '%656001060%'
          or drug_source_value like '%657805000%'
          or drug_source_value like '%661306280%'
          or drug_source_value like '%669902830%'
          or drug_source_value like '%669800690%'
          or drug_source_value like '%670606950%'
          or drug_source_value like '%669502320%'
          or drug_source_value like '%665000470%'
          or drug_source_value like '%670104220%'
          or drug_source_value like '%673400140%'
          or drug_source_value like '%694001020%'
          or drug_source_value like '%689000520%'
          or drug_source_value like '%696600300%'
          or drug_source_value like '%693201640%'
          or drug_source_value like '%679801410%'
          or drug_source_value like '%680500560%'
          or drug_source_value like '%698400120%'
          or drug_source_value like '%678900910%'
          or drug_source_value like '%674400920%'
          or drug_source_value like '%678600890%'
          or drug_source_value like '%694205700%'
          or drug_source_value like '%697100740%'
          or drug_source_value like '%674401130%'
          or drug_source_value like '%644100410%'
          or drug_source_value like '%647500360%'
          or drug_source_value like '%646004260%'
          or drug_source_value like '%649602290%'
          or drug_source_value like '%654802170%'
          or drug_source_value like '%658107560%'
          or drug_source_value like '%660702980%'
          or drug_source_value like '%656601040%'
          or drug_source_value like '%663300790%'
          or drug_source_value like '%667100140%'
          or drug_source_value like '%668900650%'
          or drug_source_value like '%680000170%'
          or drug_source_value like '%671900920%'
          or drug_source_value like '%690300620%'
          or drug_source_value like '%673200600%'
          or drug_source_value like '%670602710%'
          or drug_source_value like '%698000740%'
          or drug_source_value like '%699903380%'
          or drug_source_value like '%A02550781%'
          or drug_source_value like '%A06650581%'
          or drug_source_value like '%A05703801%'
          or drug_source_value like '%A19640231%'
          or drug_source_value like '%A08652001%'
          or drug_source_value like '%A12251401%'
          or drug_source_value like '%A12602071%'
          or drug_source_value like '%A08851391%'
          or drug_source_value like '%A07206121%'
          or drug_source_value like '%A50600111%'
          or drug_source_value like '%A50700861%'
          or drug_source_value like '%A33290051%'
          or drug_source_value like '%A27852321%'
          or drug_source_value like '%A21950991%'
          or drug_source_value like '%A20650131%'
          or drug_source_value like '%A20703291%'
          or drug_source_value like '%A82851331%'
          or drug_source_value like '%A34850041%'
          or drug_source_value like '%644304430%'
          or drug_source_value like '%656601140%'
          or drug_source_value like '%A08851411%'
          or drug_source_value like '%645700450%'
          or drug_source_value like '%689100890%'
          or drug_source_value like '%657300180%'
          or drug_source_value like '%643701910%'
          or drug_source_value like '%643302720%'
          or drug_source_value like '%647801590%'
          or drug_source_value like '%649700600%'
          or drug_source_value like '%651500110%'
          or drug_source_value like '%653002720%'
          or drug_source_value like '%656600990%'
          or drug_source_value like '%656601000%'
          or drug_source_value like '%670602870%'
          or drug_source_value like '%A08801891%'
          or drug_source_value like '%A18450171%'
          or drug_source_value like '%A12650991%'
          or drug_source_value like '%A08850031%'
          or drug_source_value like '%A29550871%'
          or drug_source_value like '%A25001561%'
          or drug_source_value like '%A25001571%'
          or drug_source_value like '%A31000901%'
          or drug_source_value like '%647201110%'
          or drug_source_value like '%645302650%'
          or drug_source_value like '%645302660%'
          or drug_source_value like '%671701970%'
          or drug_source_value like '%670304020%'
          or drug_source_value like '%654501510%'
          or drug_source_value like '%654300730%'
          or drug_source_value like '%656202670%'
          or drug_source_value like '%670300320%'
          or drug_source_value like '%670300330%'
          or drug_source_value like '%669901100%'
          or drug_source_value like '%698500320%'
          or drug_source_value like '%696600230%'
          or drug_source_value like '%A04704241%'
          or drug_source_value like '%A04704411%'
          or drug_source_value like '%A18701951%'
          or drug_source_value like '%A50600551%'
          or drug_source_value like '%A25803331%'
          or drug_source_value like '%A22502871%'
          or drug_source_value like '%A37803071%'
          or drug_source_value like '%A37803181%'
          or drug_source_value like '%A82800081%'
          or drug_source_value like '%A78800191%'
          or drug_source_value like '%643300700%'
          or drug_source_value like '%645700820%'
          or drug_source_value like '%644301810%'
          or drug_source_value like '%645700970%'
          or drug_source_value like '%57600150%'
          or drug_source_value like '%55101030%'
          or drug_source_value like '%55101040%'
          or drug_source_value like '%57000320%'
          or drug_source_value like '%53600550%'
          or drug_source_value like '%53600560%'
          or drug_source_value like '%53300510%'
          or drug_source_value like '%53300520%'
          or drug_source_value like '%57700460%'
          or drug_source_value like '%57000850%'
          or drug_source_value like '%623005690%'
          or drug_source_value like '%623005700%'
          or drug_source_value like '%625200270%'
          or drug_source_value like '%628801410%'
          or drug_source_value like '%58800750%'
          or drug_source_value like '%58800990%'
          or drug_source_value like '%641801390%'
          or drug_source_value like '%625501010%'
          or drug_source_value like '%628900090%'
          or drug_source_value like '%623006000%'
          or drug_source_value like '%625200620%'
          or drug_source_value like '%628800150%'
          or drug_source_value like '%622802180%'
          or drug_source_value like '%59600410%'
          or drug_source_value like '%59000750%'
          or drug_source_value like '%625200380%'
          or drug_source_value like '%641605650%'
          or drug_source_value like '%642307890%'
          or drug_source_value like '%643104640%'
          or drug_source_value like '%643104650%'
          or drug_source_value like '%643701070%'
          or drug_source_value like '%643802680%'
          or drug_source_value like '%642900260%'
          or drug_source_value like '%643504840%'
          or drug_source_value like '%642100260%'
          or drug_source_value like '%643103770%'
          or drug_source_value like '%644101270%'
          or drug_source_value like '%645601660%'
          or drug_source_value like '%646204140%'
          or drug_source_value like '%647205110%'
          or drug_source_value like '%644502900%'
          or drug_source_value like '%646000430%'
          or drug_source_value like '%648603120%'
          or drug_source_value like '%649103410%'
          or drug_source_value like '%649002220%'
          or drug_source_value like '%650204850%'
          or drug_source_value like '%650204860%'
          or drug_source_value like '%649102240%'
          or drug_source_value like '%647303690%'
          or drug_source_value like '%647303720%'
          or drug_source_value like '%647303730%'
          or drug_source_value like '%649605330%'
          or drug_source_value like '%653402580%'
          or drug_source_value like '%654001570%'
          or drug_source_value like '%653000420%'
          or drug_source_value like '%652600630%'
          or drug_source_value like '%651601790%'
          or drug_source_value like '%661604410%'
          or drug_source_value like '%661604850%'
          or drug_source_value like '%661305130%'
          or drug_source_value like '%661305340%'
          or drug_source_value like '%658602800%'
          or drug_source_value like '%658604180%'
          or drug_source_value like '%661900300%'
          or drug_source_value like '%657304170%'
          or drug_source_value like '%657304180%'
          or drug_source_value like '%661305490%'
          or drug_source_value like '%658106410%'
          or drug_source_value like '%658106420%'
          or drug_source_value like '%658501710%'
          or drug_source_value like '%657202460%'
          or drug_source_value like '%656000190%'
          or drug_source_value like '%657400900%'
          or drug_source_value like '%662500740%'
          or drug_source_value like '%657805030%'
          or drug_source_value like '%669501440%'
          or drug_source_value like '%669901050%'
          or drug_source_value like '%670100250%'
          or drug_source_value like '%670606450%'
          or drug_source_value like '%670102390%'
          or drug_source_value like '%670501730%'
          or drug_source_value like '%669907180%'
          or drug_source_value like '%670608150%'
          or drug_source_value like '%665002690%'
          or drug_source_value like '%665002700%'
          or drug_source_value like '%670608160%'
          or drug_source_value like '%698000600%'
          or drug_source_value like '%693902320%'
          or drug_source_value like '%698503180%'
          or drug_source_value like '%694001320%'
          or drug_source_value like '%696602070%'
          or drug_source_value like '%678601690%'
          or drug_source_value like '%678601810%'
          or drug_source_value like '%693200730%'
          or drug_source_value like '%673400040%'
          or drug_source_value like '%690300780%'
          or drug_source_value like '%690300960%'
          or drug_source_value like '%629700020%'
          or drug_source_value like '%640903410%'
          or drug_source_value like '%54000770%'
          or drug_source_value like '%622802930%'
          or drug_source_value like '%642706100%'
          or drug_source_value like '%644602810%'
          or drug_source_value like '%645209450%'
          or drug_source_value like '%648603110%'
          or drug_source_value like '%650204500%'
          or drug_source_value like '%651202670%'
          or drug_source_value like '%647204910%'
          or drug_source_value like '%647204920%'
          or drug_source_value like '%650101190%'
          or drug_source_value like '%652903180%'
          or drug_source_value like '%652104700%'
          or drug_source_value like '%652104710%'
          or drug_source_value like '%652104720%'
          or drug_source_value like '%655602380%'
          or drug_source_value like '%654301540%'
          or drug_source_value like '%654701540%'
          or drug_source_value like '%652900320%'
          or drug_source_value like '%656600410%'
          or drug_source_value like '%663600330%'
          or drug_source_value like '%669907030%'
          or drug_source_value like '%670000170%'
          or drug_source_value like '%670000180%'
          or drug_source_value like '%690300760%'
          or drug_source_value like '%678600430%'
          or drug_source_value like '%678600730%'
          or drug_source_value like '%671704330%'
          or drug_source_value like '%694205420%'
          or drug_source_value like '%694205430%'
          or drug_source_value like '%699903340%'
          or drug_source_value like '%A03551021%'
          or drug_source_value like '%A06501841%'
          or drug_source_value like '%A05652841%'
          or drug_source_value like '%696601320%'
          or drug_source_value like '%A06751051%'
          or drug_source_value like '%A11152081%'
          or drug_source_value like '%A21451681%'
          or drug_source_value like '%A66351661%'
          or drug_source_value like '%A21455291%'
          or drug_source_value like '%A21457871%'
          or drug_source_value like '%A21950332%'
          or drug_source_value like '%A22695661%'
          or drug_source_value like '%A23053141%'
          or drug_source_value like '%A35103801%'
          or drug_source_value like '%A28301981%'
          or drug_source_value like '%644308860%'
          or drug_source_value like '%653102630%'
          or drug_source_value like '%658602980%'
          or drug_source_value like '%645103910%'
          or drug_source_value like '%645604420%'
          or drug_source_value like '%670304020%'
          or drug_source_value like '%645302650%'
          or drug_source_value like '%643302730%'
          or drug_source_value like '%644903930%'
          or drug_source_value like '%644701880%'
) E
;

select et.event_id, et.person_id, ERAS.era_end_date as end_date
INTO #strategy_ends
from #included_events et
JOIN 
(
  select ENDS.person_id, min(drug_exposure_start_date) as era_start_date, DATEADD(day,0, ENDS.era_end_date) as era_end_date
  from
  (
    select de.person_id, de.drug_exposure_start_date, MIN(e.END_DATE) as era_end_date
    FROM #drugTarget DE
    JOIN 
    (
      --cteEndDates
      select PERSON_ID, DATEADD(day,-1 * 30,EVENT_DATE) as END_DATE -- unpad the end date by 30
      FROM
      (
				select PERSON_ID, EVENT_DATE, EVENT_TYPE, 
				MAX(START_ORDINAL) OVER (PARTITION BY PERSON_ID ORDER BY event_date, event_type ROWS UNBOUNDED PRECEDING) AS start_ordinal,
				ROW_NUMBER() OVER (PARTITION BY PERSON_ID ORDER BY EVENT_DATE, EVENT_TYPE) AS OVERALL_ORD -- this re-numbers the inner UNION so all rows are numbered ordered by the event date
				from
				(
					-- select the start dates, assigning a row number to each
					Select PERSON_ID, DRUG_EXPOSURE_START_DATE AS EVENT_DATE, 0 as EVENT_TYPE, ROW_NUMBER() OVER (PARTITION BY PERSON_ID ORDER BY DRUG_EXPOSURE_START_DATE) as START_ORDINAL
					from #drugTarget D

					UNION ALL

					-- add the end dates with NULL as the row number, padding the end dates by 30 to allow a grace period for overlapping ranges.
					select PERSON_ID, DATEADD(day,30,DRUG_EXPOSURE_END_DATE), 1 as EVENT_TYPE, NULL
					FROM #drugTarget D
				) RAWDATA
      ) E
      WHERE 2 * E.START_ORDINAL - E.OVERALL_ORD = 0
    ) E on DE.PERSON_ID = E.PERSON_ID and E.END_DATE >= DE.DRUG_EXPOSURE_START_DATE
    GROUP BY de.person_id, de.drug_exposure_start_date
  ) ENDS
  GROUP BY ENDS.person_id, ENDS.era_end_date
) ERAS on ERAS.person_id = et.person_id 
WHERE et.start_date between ERAS.era_start_date and ERAS.era_end_date;

TRUNCATE TABLE #drugTarget;
DROP TABLE #drugTarget;


-- generate cohort periods into #final_cohort
with cohort_ends (event_id, person_id, end_date) as
(
	-- cohort exit dates
  -- By default, cohort exit at the event's op end date
select event_id, person_id, op_end_date as end_date from #included_events
UNION ALL
-- End Date Strategy
SELECT event_id, person_id, end_date from #strategy_ends

),
first_ends (person_id, start_date, end_date) as
(
	select F.person_id, F.start_date, F.end_date
	FROM (
	  select I.event_id, I.person_id, I.start_date, E.end_date, row_number() over (partition by I.person_id, I.event_id order by E.end_date) as ordinal 
	  from #included_events I
	  join cohort_ends E on I.event_id = E.event_id and I.person_id = E.person_id and E.end_date >= I.start_date
	) F
	WHERE F.ordinal = 1
)
select person_id, start_date, end_date
INTO #cohort_rows
from first_ends;

with cteEndDates (person_id, end_date) AS -- the magic
(	
	SELECT
		person_id
		, DATEADD(day,-1 * 0, event_date)  as end_date
	FROM
	(
		SELECT
			person_id
			, event_date
			, event_type
			, MAX(start_ordinal) OVER (PARTITION BY person_id ORDER BY event_date, event_type ROWS UNBOUNDED PRECEDING) AS start_ordinal 
			, ROW_NUMBER() OVER (PARTITION BY person_id ORDER BY event_date, event_type) AS overall_ord
		FROM
		(
			SELECT
				person_id
				, start_date AS event_date
				, -1 AS event_type
				, ROW_NUMBER() OVER (PARTITION BY person_id ORDER BY start_date) AS start_ordinal
			FROM #cohort_rows
		
			UNION ALL
		

			SELECT
				person_id
				, DATEADD(day,0,end_date) as end_date
				, 1 AS event_type
				, NULL
			FROM #cohort_rows
		) RAWDATA
	) e
	WHERE (2 * e.start_ordinal) - e.overall_ord = 0
),
cteEnds (person_id, start_date, end_date) AS
(
	SELECT
		 c.person_id
		, c.start_date
		, MIN(e.end_date) AS end_date
	FROM #cohort_rows c
	JOIN cteEndDates e ON c.person_id = e.person_id AND e.end_date >= c.start_date
	GROUP BY c.person_id, c.start_date
)
select person_id, min(start_date) as start_date, end_date
into #final_cohort
from cteEnds
group by person_id, end_date
;

DELETE FROM @target_database_schema.@target_cohort_table where cohort_definition_id = @target_cohort_id;
INSERT INTO @target_database_schema.@target_cohort_table (cohort_definition_id, subject_id, cohort_start_date, cohort_end_date)
select @target_cohort_id as cohort_definition_id, person_id, start_date, end_date 
FROM #final_cohort CO
;

{0 != 0}?{
-- BEGIN: Censored Stats

delete from @results_database_schema.cohort_censor_stats where cohort_definition_id = @target_cohort_id;

-- END: Censored Stats
}
{0 != 0 & 2 != 0}?{

-- Create a temp table of inclusion rule rows for joining in the inclusion rule impact analysis

select cast(rule_sequence as int) as rule_sequence
into #inclusion_rules
from (
  SELECT CAST(0 as int) as rule_sequence UNION ALL SELECT CAST(1 as int) as rule_sequence
) IR;


-- Find the event that is the 'best match' per person.  
-- the 'best match' is defined as the event that satisfies the most inclusion rules.
-- ties are solved by choosing the event that matches the earliest inclusion rule, and then earliest.

select q.person_id, q.event_id
into #best_events
from #qualified_events Q
join (
	SELECT R.person_id, R.event_id, ROW_NUMBER() OVER (PARTITION BY R.person_id ORDER BY R.rule_count DESC,R.min_rule_id ASC, R.start_date ASC) AS rank_value
	FROM (
		SELECT Q.person_id, Q.event_id, COALESCE(COUNT(DISTINCT I.inclusion_rule_id), 0) AS rule_count, COALESCE(MIN(I.inclusion_rule_id), 0) AS min_rule_id, Q.start_date
		FROM #qualified_events Q
		LEFT JOIN #inclusion_events I ON q.person_id = i.person_id AND q.event_id = i.event_id
		GROUP BY Q.person_id, Q.event_id, Q.start_date
	) R
) ranked on Q.person_id = ranked.person_id and Q.event_id = ranked.event_id
WHERE ranked.rank_value = 1
;

-- modes of generation: (the same tables store the results for the different modes, identified by the mode_id column)
-- 0: all events
-- 1: best event


-- BEGIN: Inclusion Impact Analysis - event
-- calculte matching group counts
delete from @results_database_schema.cohort_inclusion_result where cohort_definition_id = @target_cohort_id and mode_id = 0;
insert into @results_database_schema.cohort_inclusion_result (cohort_definition_id, inclusion_rule_mask, person_count, mode_id)
select @target_cohort_id as cohort_definition_id, inclusion_rule_mask, count_big(*) as person_count, 0 as mode_id
from
(
  select Q.person_id, Q.event_id, CAST(SUM(coalesce(POWER(cast(2 as bigint), I.inclusion_rule_id), 0)) AS bigint) as inclusion_rule_mask
  from #qualified_events Q
  LEFT JOIN #inclusion_events I on q.person_id = i.person_id and q.event_id = i.event_id
  GROUP BY Q.person_id, Q.event_id
) MG -- matching groups
group by inclusion_rule_mask
;

-- calculate gain counts 
delete from @results_database_schema.cohort_inclusion_stats where cohort_definition_id = @target_cohort_id and mode_id = 0;
insert into @results_database_schema.cohort_inclusion_stats (cohort_definition_id, rule_sequence, person_count, gain_count, person_total, mode_id)
select @target_cohort_id as cohort_definition_id, ir.rule_sequence, coalesce(T.person_count, 0) as person_count, coalesce(SR.person_count, 0) gain_count, EventTotal.total, 0 as mode_id
from #inclusion_rules ir
left join
(
  select i.inclusion_rule_id, count_big(i.event_id) as person_count
  from #qualified_events Q
  JOIN #inclusion_events i on Q.person_id = I.person_id and Q.event_id = i.event_id
  group by i.inclusion_rule_id
) T on ir.rule_sequence = T.inclusion_rule_id
CROSS JOIN (select count(*) as total_rules from #inclusion_rules) RuleTotal
CROSS JOIN (select count_big(event_id) as total from #qualified_events) EventTotal
LEFT JOIN @results_database_schema.cohort_inclusion_result SR on SR.mode_id = 0 AND SR.cohort_definition_id = @target_cohort_id AND (POWER(cast(2 as bigint),RuleTotal.total_rules) - POWER(cast(2 as bigint),ir.rule_sequence) - 1) = SR.inclusion_rule_mask -- POWER(2,rule count) - POWER(2,rule sequence) - 1 is the mask for 'all except this rule'
;

-- calculate totals
delete from @results_database_schema.cohort_summary_stats where cohort_definition_id = @target_cohort_id and mode_id = 0;
insert into @results_database_schema.cohort_summary_stats (cohort_definition_id, base_count, final_count, mode_id)
select @target_cohort_id as cohort_definition_id, PC.total as person_count, coalesce(FC.total, 0) as final_count, 0 as mode_id
FROM
(select count_big(event_id) as total from #qualified_events) PC,
(select sum(sr.person_count) as total
  from @results_database_schema.cohort_inclusion_result sr
  CROSS JOIN (select count(*) as total_rules from #inclusion_rules) RuleTotal
  where sr.mode_id = 0 and sr.cohort_definition_id = @target_cohort_id and sr.inclusion_rule_mask = POWER(cast(2 as bigint),RuleTotal.total_rules)-1
) FC
;

-- END: Inclusion Impact Analysis - event

-- BEGIN: Inclusion Impact Analysis - person
-- calculte matching group counts
delete from @results_database_schema.cohort_inclusion_result where cohort_definition_id = @target_cohort_id and mode_id = 1;
insert into @results_database_schema.cohort_inclusion_result (cohort_definition_id, inclusion_rule_mask, person_count, mode_id)
select @target_cohort_id as cohort_definition_id, inclusion_rule_mask, count_big(*) as person_count, 1 as mode_id
from
(
  select Q.person_id, Q.event_id, CAST(SUM(coalesce(POWER(cast(2 as bigint), I.inclusion_rule_id), 0)) AS bigint) as inclusion_rule_mask
  from #best_events Q
  LEFT JOIN #inclusion_events I on q.person_id = i.person_id and q.event_id = i.event_id
  GROUP BY Q.person_id, Q.event_id
) MG -- matching groups
group by inclusion_rule_mask
;

-- calculate gain counts 
delete from @results_database_schema.cohort_inclusion_stats where cohort_definition_id = @target_cohort_id and mode_id = 1;
insert into @results_database_schema.cohort_inclusion_stats (cohort_definition_id, rule_sequence, person_count, gain_count, person_total, mode_id)
select @target_cohort_id as cohort_definition_id, ir.rule_sequence, coalesce(T.person_count, 0) as person_count, coalesce(SR.person_count, 0) gain_count, EventTotal.total, 1 as mode_id
from #inclusion_rules ir
left join
(
  select i.inclusion_rule_id, count_big(i.event_id) as person_count
  from #best_events Q
  JOIN #inclusion_events i on Q.person_id = I.person_id and Q.event_id = i.event_id
  group by i.inclusion_rule_id
) T on ir.rule_sequence = T.inclusion_rule_id
CROSS JOIN (select count(*) as total_rules from #inclusion_rules) RuleTotal
CROSS JOIN (select count_big(event_id) as total from #best_events) EventTotal
LEFT JOIN @results_database_schema.cohort_inclusion_result SR on SR.mode_id = 1 AND SR.cohort_definition_id = @target_cohort_id AND (POWER(cast(2 as bigint),RuleTotal.total_rules) - POWER(cast(2 as bigint),ir.rule_sequence) - 1) = SR.inclusion_rule_mask -- POWER(2,rule count) - POWER(2,rule sequence) - 1 is the mask for 'all except this rule'
;

-- calculate totals
delete from @results_database_schema.cohort_summary_stats where cohort_definition_id = @target_cohort_id and mode_id = 1;
insert into @results_database_schema.cohort_summary_stats (cohort_definition_id, base_count, final_count, mode_id)
select @target_cohort_id as cohort_definition_id, PC.total as person_count, coalesce(FC.total, 0) as final_count, 1 as mode_id
FROM
(select count_big(event_id) as total from #best_events) PC,
(select sum(sr.person_count) as total
  from @results_database_schema.cohort_inclusion_result sr
  CROSS JOIN (select count(*) as total_rules from #inclusion_rules) RuleTotal
  where sr.mode_id = 1 and sr.cohort_definition_id = @target_cohort_id and sr.inclusion_rule_mask = POWER(cast(2 as bigint),RuleTotal.total_rules)-1
) FC
;

-- END: Inclusion Impact Analysis - person

TRUNCATE TABLE #best_events;
DROP TABLE #best_events;

TRUNCATE TABLE #inclusion_rules;
DROP TABLE #inclusion_rules;
}

TRUNCATE TABLE #strategy_ends;
DROP TABLE #strategy_ends;


TRUNCATE TABLE #cohort_rows;
DROP TABLE #cohort_rows;

TRUNCATE TABLE #final_cohort;
DROP TABLE #final_cohort;

TRUNCATE TABLE #inclusion_events;
DROP TABLE #inclusion_events;

TRUNCATE TABLE #qualified_events;
DROP TABLE #qualified_events;

TRUNCATE TABLE #included_events;
DROP TABLE #included_events;

TRUNCATE TABLE #Codesets;
DROP TABLE #Codesets;
