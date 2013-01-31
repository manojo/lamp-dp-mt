BeginPackage["Alpha`TestSchedule`",
  {"Alpha`","Alpha`Domlib`","Alpha`Schedule`","Alpha`ScheduleTools`",
   "Alpha`VertexSchedule`","Alpha`FarkasSchedule`", "Alpha`Options`",
   "Alpha`Tables`"}];

Begin["`Private`"];

(* Written by Tanguy Risset, updated by P. Quinton, Dec. 2008 *)
Module[ {dir, res, scd1, scd2, ast, testResult},

  $testResult = True; 

  res = 
    {
      testFunction[
        load["Test1.alpha"]; scd1 = schedule[];
        testSched[ $result, $schedule ], True, "Schedule 1"
      ]
    ,
      testFunction[
        load["Test2.alpha"];
        schedule[]; testSched[ $result,$schedule ],
        True, "Schedule 2.1"
      ]
    ,
      testFunction[
        load["Test1.alpha"];
        scd[]; testSched[ $result,$schedule ],
        True, "Schedule 2.2"
      ]
    ,
      testFunction[
        load["Test3.alpha"];
        schedule[]; testSched[ $result,$schedule ],
        True, "Schedule 3.1"
      ]
    ,
      testFunction[
        load["Test3.alpha"];
        scd[]; testSched[ $result,$schedule ],
        True, "Schedule 3.2"
      ]
    ,
      testFunction[
        load["Test4.alpha"];
        schedule[ scheduleType -> sameLinearPart]; 
        testSched[ $result,$schedule ],
        True, "Schedule 4.1"
      ]
    ,
      testFunction[
        load["Test4.alpha"];
        scd[ scheduleType -> sameLinearPart]; 
        testSched[ $result,$schedule ],
        True, "Schedule 4.2"
      ]
    ,
      testFunction[
        load["TestAffine2.alpha"];
        schedule[]; 
        testSched[ $result,$schedule ],
        True, "Schedule affine 1.1"
      ]
    ,
      testFunction[
        load["TestUnion.alpha"];
        schedule[ ratOrInt -> 0 ]; 
        testSched[ $result,$schedule ],
        True, "Schedule affine 2.1"
      ]
    ,
      testFunction[
        load["TestUnion.alpha"];
        scd[ ]; 
        testSched[ $result,$schedule ],
        True, "Schedule affine 2.2"
      ]
    ,
      testFunction[
        load["TestWrong.alpha"];
        schedule[ ],
        $Failed, "Schedule affine 3.1"
      ]
    ,
      testFunction[
        Check[
          load["TestWrong.alpha"];
          scd[ ]; False,
          True
        ],
        True, "Schedule affine 3.2"
      ]
    ,
      testFunction[
        load["TestUnbounded.alpha"];
        schedule[ ],
        $Failed, "Schedule affine 4.1"
      ]
    ,
      testFunction[
        Check[
          load["TestUnbounded.alpha"];
          scd[ ]; False,
          True
        ],
        True, "Schedule affine 4.2"
      ]
    ,
      testFunction[
        load["TestUnbounded.alpha"];
        schedule[ optimizationType -> Null ]; testSched[ $result, $schedule ],
        True, "Schedule affine 5.1"
      ]
    ,
      testFunction[
        load["TestUnbounded.alpha"];
        scd[ optimizationType->Null ]; testSched[ $result, $schedule ],
        True, "Schedule affine 5.2"
      ]
    ,
      testFunction[
        load["Test1.alpha"];
        schedule[ debug -> True ]; testSched[ $result, $schedule ],
        True, "Schedule options 1"
      ]
    ,
      testFunction[
        load["Test1.alpha"];
        schedule[ verbose -> False ]; testSched[ $result, $schedule ],
        True, "Schedule options 2"
      ]
    ,
      testFunction[
        load["Test1.alpha"];
        testSched[ schedule[] ],
        True, "Schedule options 3"
      ]
    ,
      testFunction[
        load["TestSchedType.alpha"];
        scd1 = schedule[ scheduleType -> affineByVar ];
        testSched[]&&(scd1[[2,2,3,1]]=!=scd1[[2,3,3,1]]),
        True, "Schedule options 4"
      ]
    ,
      testFunction[
        load["TestSchedType.alpha"];
        scd1 = schedule[ scheduleType -> sameLinearPart ];
        testSched[]&&(scd1[[2,2,3,1]]===scd1[[2,3,3,1]]),
        True, "Schedule options 5"
      ]
    ,
      testFunction[
        load["TestSchedType2.alpha"];
        scd1 = schedule[ scheduleType -> sameLinearPartExceptParam ];
        testSched[]&&(scd1[[2,3,3,1]]=!=scd1[[2,4,3,1]]),
        True, "Schedule options 6 "
      ]
    ,
      testFunction[
        load["TestUnbounded.alpha"];
        schedule[ optimizationType -> Null ];
        testSched[],
        True, "Schedule options 7 "
      ]
    ,
      testFunction[
        load["TestUnbounded.alpha"];
        schedule[ optimizationType -> time ],
        $Failed, "Schedule options 8 "
      ]
    ,
      testFunction[
        load["TestRat.alpha"];
        MatchQ[schedule[integerSolution->False],
          scheduleResult["test6", {{"A1", {"j", "N"}, sched[{1/3, 0}, 0]}, 
            {"A2", {"j", "N"}, sched[{1/3, 0}, 2/3]}}, {0, 0}]],
          True, "Schedule options 9 "
      ]
    ,
      testFunction[
        load["TestRat.alpha"];
        MatchQ[schedule[],
          scheduleResult["test6", {{"A1", {"j", "N"}, sched[{1, 0}, 0]}, 
            {"A2", {"j", "N"}, sched[{1, 0}, 0]}}, {0, 0}]],
          True, "Schedule options 10 "
      ]
    ,
      testFunction[
        load["MMunif.alpha"];
        schedule[addConstraints->{"TaD1==2","TaD2==3","TaD3>=3",
          "Ca>=5","TCD1+TCD2+TAD1>=10","Tc[i1,j,N]=10N+3i1+4"}],
        scheduleResult["prodVect", {{"a", {"i", "j", "N"}, sched[{2, 3, 3}, 5]}, 
          {"b", {"i", "j", "N"}, sched[{0, 0, 0}, 0]}, 
          {"c", {"i", "j", "N"}, sched[{3, 0, 10}, 4]}, 
          {"B", {"i", "j", "k", "N"}, sched[{1, 0, 0, 0}, 0]}, 
          {"A", {"i", "j", "k", "N"}, sched[{3, 1, 3, 3}, 4]}, 
          {"C", {"i", "j", "k", "N"}, sched[{6, 1, 3, 3}, 2]}}, {13, 4}],
        "Schedule options 11 "
      ]
    ,
      testFunction[
        load["TestDuration.alpha"];
        schedule[ durations -> {} ]; testSched[],
        True,
        "Schedule options 12 "
      ]
    ,
      testFunction[
        load["TestDuration.alpha"];
        schedule[duration->{1,2,3,10,100,1000} ]; testSched[],
        True,
        "Schedule options 13 "
      ]
    ,
      testFunction[
        load["TestDuration.alpha"];
        schedule[duration->{1,2,3,5,10,100} ]; testSched[],
        True,
        "Schedule options 14 "
      ]
    ,
      testFunction[
        load["Test1.alpha"];
        MatchQ[ schedule[ outputForm -> domain ], Alpha`domain[___] ],
        True,
        "Schedule options 15 "
      ]
    ,
      testFunction[
        load["MMunif.alpha"]; scd1 = $result;
        schedule[]; appSched[]; scd2 = $result;
        scd2 =!= scd1,
        True,
        "appSched 1 "
      ]
    ,
      testFunction[
        !isScheduledQ[],
        True,
        "appSched 2 "
      ]
    ,
      testFunction[
        isScheduledQ[ onlyLocalVars -> True ],
        True,
        "appSched 3 "
      ]
    ,
      testFunction[
        load["MMunif.alpha"]; ast = $result;
        !isScheduledQ[],
        True,
        "appSched 4 "
      ]
    ,
      testFunction[
        $result = ast;
        scd1 = schedule[ scheduleType -> sameLinearPart ];
        Check[
	      appSched[ projVector->{0,1,0,0} ]; True,
              False],
        True,
        "appSched 5 "
      ]
    ,
      testFunction[
        $result = ast;
        scd1 = schedule[ scheduleType -> sameLinearPart ];
        Check[
          appSched[ projMatrix -> 
            {{0, 0, 1, 0}, {0, 1, 0, 0}, {0, 0, 0, 1}} 
          ]; True,
              False],
        True,
        "appSched 6 "
      ]
    ,
      testFunction[
        $result = ast;
        scd1 = schedule[ scheduleType -> sameLinearPart ];
        Check[
	      appSched[ variables -> {"A","B"}
          ]; True,
              False],
        True,
        "appSched 7 "
      ]
    ,
      testFunction[
        $result = ast;
        scd1 = schedule[ scheduleType -> sameLinearPart ];
        Check[
	      appSched[ variables->{{"A",{2}},{"B",{1}}}
          ]; True,
              False],
        True,
        "appSched 8 "
      ]
    ,
      testFunction[
        load["MMunif.alpha"];
        scd1 = schedule[ scheduleType -> sameLinearPart ];
        Check[
          appSched[ variables->{{{"A"},{2}},{{"B"},{1}},{other,{3}}}
          ]; True,
              False],
        True,
        "appSched 9 "
      ]
    ,
      testFunction[
        load["DLMS_Alpha0.alpha"];
        addAllParameterDomain[];
        isScheduledQ[onlyLocalVars -> True, durations -> 0, verbose -> True],
        True,
        "appSched 10 "
      ]
    ,
      testFunction[
        load["MMunif.alpha"];
        renameIndices[{"t1","t2","p3"}];
        MatchQ[$result,system[___]] && 
          Take[$result[[5,1,3,2]],3]==={"t1","t2","p3"},
        True,
        "appSched 11 "
      ]
    ,
      testFunction[
        load["PIC3Unif3.alpha"];
        renameIndices[{"t1","t2","p3","p5"}];
        Length[ $result[[5]] ] === 14,
        True,
        "appSched 12 "
      ]
    ,
      testFunction[
        load["PIC3Unif3.alpha"];
        renameIndices[{"t1","t2","p3","p5"}, recurse->True];
        Length[ $result[[5]] ] === 13 &&
        Take[$result[[5,1,3,2]],4]==={"t1","t2","p3","p5"} &&  
        Take[$library[[-2,3,1,3,2]],2]==={"t1","t2"},
        True,
        "appSched 13 "
      ]
    ,
      testFunction[
        load["MatMat.alpha"];
        getSystem["MatVect"];
        testSched[ schedule[] ],
        True,
        "Structured scheduling 1 "
      ]

    ,
      testFunction[
        load["MatMat.alpha"];
        getSystem["MatMat"];
        testSched[ structSched[] ],
        True,
        "Structured scheduling 2 "
      ]
    ,
      testFunction[
        load["MatMat.alpha"];
        getSystem["MatMat"];
        structSched[structSchedType->multi,multiSchedDepth->2];
        testSched[$schedule]&& Length[$schedule[[2,1]]]>3,
        True,
        "Structured scheduling 3 "
      ]

    };

$testResult = $testResult && Apply[And,res];

];

End[];

EndPackage[];
