<?xml version="1.0" encoding="ASCII"?>
<mathematica:BuiltInNode xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mathematica="http://www.irisa.fr/cairn/model/xtext/Mathematica" keyword="Protect">
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="BeginPackage">
          <children xsi:type="mathematica:StringLeaf" value="Alpha`Options`"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="debug"/>
          <children xsi:type="mathematica:StringLeaf" value="usage"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="option (Boolean). If True, debug mode. "/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="option (Boolean). If True, print intermediate information."/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="recurse"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="option (Boolean). If True, apply the function&#xA;recursively to all the subsystem."/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="library"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value="option (List of Alpha`system). Defines the library which&#xA;must be used by the function."/>
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="contextDomain"/>
                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                </children>
              </children>
              <children xsi:type="mathematica:StringLeaf" value="option of addLocal. If True (default), the new&#xA;variable is added with the contextual domain of the expression, with the&#xA;form of addLocal with a position. Otherwise, the expression domain is &#xA;used."/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="invert"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of serializeReduce. If True (default False), &#xA;the nullspace vector is inverted"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="norm"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of removeIdEqus. If True, normalization is done"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="inputEquations"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of removeIdEqus. If False, an equation&#xA;of the forme X = in, where in is an input variable, is not removed."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="allLibrary"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of removeIdEqus (default False). If set to &#xA;True, all programs of library are treated."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="resolutionSoft"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="(+) resolutionSoft is an option of&#xA;schedule. If resolutionSoft -> pip, the schedule is computed using Pip,&#xA;through a file interface (implemented in Farkas resolution only). &#xA;None of the following are yet implemented:&#xA;If resolutionSoft -> mma, the schedule is computed using the Mathematica&#xA;function ConstrainedMin (implemented in Vertex resolution only).&#xA; resolutionSoft -> lpSolve the schedule is computed using the LpSolve library&#xA;function ConstrainedMin (not implemented yet)."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="pip"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="possible value (default) of the options resolutionSoft of&#xA;schedule"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="mma"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="possible value  of the options resolutionSoft of schedule"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="lpSolve"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="possible value of the options resolutionSoft of schedule"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="schedMethod"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value=" Options of schedule (symbol), select the&#xA;scheduling method to be used. schedMethod->farkas (default) stands for&#xA;P. Feautrier's method (using PIP with file interface) implemented in&#xA;the scheduleFarkas function. schedMethod->farkas2 stands for the most recent &#xA;implementation of this method (ModularSchedule) .schedMethod->Vertex stands for&#xA;P. Quinton's vertex method (using MMA linear resolveur). WARNING: the&#xA;setting of this options greatly influence the setting of the others&#xA;options of schedule because they correspond to two completely&#xA;different implementations"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="farkas"/>
                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                  <children xsi:type="mathematica:StringLeaf" value="value of options schedMethod of schedule, the schedule &#xA;will be computed with P. Feautrier's method (using PIP with file&#xA;interface)"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                    <children xsi:type="mathematica:SymbolLeaf" name="vertex"/>
                    <children xsi:type="mathematica:StringLeaf" value="usage"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:StringLeaf" value="value of options schedMethod of schedule, the schedule &#xA;will be computed with P. Quinton's vertex method (using MMA linear resolveur)"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                      <children xsi:type="mathematica:SymbolLeaf" name="integerSolution"/>
                      <children xsi:type="mathematica:StringLeaf" value="usage"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:StringLeaf" value="(+) integerSolution is an option of&#xA;schedule. &#xA;If integerSolution -> True (default for farkas resolution)&#xA; the schedule has integral coefficients. If integerSolution ->&#xA;False, (default for Vertex resolution)&#xA;the schedule may have rational coefficients."/>
                </children>
              </children>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="bigParPos"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value=" bigParPos is an option of&#xA;Pip related functions, Integer type. It indicates the position of the big Paramter. If set to negative integer, there is no big parameter"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="addConstraints"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="option of schedule. The type is : List of&#xA; String or List of List of String (in case of MultiDim schedule),&#xA; default value : {}. Additional constraints for the LP.  add&#xA; constrains expressed in the strings to the current scheduling&#xA; process.&#xA; schedule[addConstraints->{&quot;TA[i,j,N]=i+2j-2&quot;,&quot;TBD2==2&quot;,&quot;TBD1+2TBD3>=1&quot;}]\&#xA; Impose that the schedule function of variable A is i+2j-2, Then we&#xA; have constraints on the coefficients of the timing function of the&#xA; B variable (the  second coefficient&#xA; must be 2, etc...). In case of a multi-dimensionnal scheduling, the&#xA; ith list is added to the constraints of the ith dimension"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="durations"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="option of schedule (List) default {}.  select a&#xA;mode for counting the duration of instructions.  durations -> {} : each&#xA;equation is 1 (whatever complex is the computation)&#xA;(default). durations -> ListOfInteger: The duration of each equation is&#xA;given by the user the options &quot;durationByEq&quot; indicates whether these&#xA;values stand for a duration by equation (default in Farkas resolution,&#xA;not implemented in Vertex resolution) or a duration by dependence&#xA;(default in Vertex resolution, not implemented in Farkas resolution).&#xA;durations -> ListOfListOfInteger: same as previous one but for&#xA;multidimensionnal scheduling (one list of integer by dimension).  "/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="durationByEq"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value=" option of schedule (boolean) indicates whether the&#xA;duration values given in the &quot;durations&quot; option stand&#xA; for a duration by equation (default in Farkas resolution,&#xA;not implemented in Vertex resolution) or a duration by dependence&#xA;(default in Vertex resolution, not implemented in Farkas resolution).&#xA;In the case of a duration by equation, the&#xA;list must contain as many integer as there are VARIABLES (do not&#xA;forget the inputs and output), the order is the order of declaration&#xA;in the Alpha program. In the case of a duration by dependence, the &#xA; must contain as many integer as there are dependecies  &#xA;the order is the order of the dependencies returned by the dep[]&#xA;function "/>
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="givenSchedVect"/>
                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                </children>
              </children>
              <children xsi:type="mathematica:StringLeaf" value="options of Schedule, List of schedule given&#xA;  for some variable, the syntaxe for each schedule is the one present&#xA;  in $schedule: {{a, {i, j, N}, sched[{0, 0, 0}, 0]}} (The list of&#xA;  indice may be replaced by {}) "/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="affineByVar"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="Value of option scheduleType of schedule, the&#xA;&#x9;&#x9; resulting schedule will be affine by variable"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="sameLinearPart"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="Value of option scheduleType of schedule, the&#xA;&#x9;&#x9; resulting schedule will be affine by variable with&#xA;&#x9;&#x9; the same linear part for all local variables"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="sameLinearPartExceptParam"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="Value of option scheduleType of schedule, the&#xA;&#x9;&#x9; resulting schedule will be affine by variable with&#xA;&#x9;&#x9; the same linear part for all local variables"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="scheduleType"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:StringLeaf" value="scheduleType is an option of schedule (symbol) which&#xA;gives the type of the schedule searched.  scheduleType -> affineByVar (default)&#xA;: affine by variable schedule.  scheduleType -> sameLinearPart: affine with&#xA;constant linear part.  scheduleType -> sameLinearPartExceptParam: affine with constant linear&#xA;part except for the parameters"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="optimizationType"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value=" options of schedule (symbol), indicates&#xA;the objective fonction used by the schedule: minimizing time, delays&#xA;on dependencies of nothing.  optimizationType->time tries to get&#xA;aminimal time schedule (default).  optimizationType->delay tries to&#xA;minimize the delays on the dependencies (not implemented currently)&#xA;optimizationType->Null no objective function is provided (not&#xA;implemented in Vertex resolution). In that case the coefficient of the&#xA;timing function are minimized lexicographically (from output to&#xA;input)."/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="time"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="possible value (default) of option optimizationType of schedule"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="delay"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="possible value of option optimizationType of&#xA;schedule"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="multi"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value="possible value  of option optimizationType of schedule or of option structSchedType of buildSchedConstraints"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="mono"/>
                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                  <children xsi:type="mathematica:StringLeaf" value="possible value  of option structSchedType of buildSchedConstraint"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                    <children xsi:type="mathematica:SymbolLeaf" name="scheduleDim"/>
                    <children xsi:type="mathematica:StringLeaf" value="usage"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:StringLeaf" value="Option of buildSched Constraint (integer or list&#xA;of integer), indicates the dimension to which the constraints should&#xA;be set"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                      <children xsi:type="mathematica:SymbolLeaf" name="structSchedType"/>
                      <children xsi:type="mathematica:StringLeaf" value="usage"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:StringLeaf" value="Option of buildSched Constraint&#xA;(integer or list of integer), indicates whether the use will be&#xA;pipelined (no additionnal dimension in the schedule) or considered as&#xA;an instantaneous call (additionnal dimention in the schedule)"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="multiSchedDepth"/>
                        <children xsi:type="mathematica:StringLeaf" value="usage"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                        <children xsi:type="mathematica:StringLeaf" value="options of schedule (integer) indicating the depth of&#xA;the  current schedule taking place in a multi dimensionnal scheduling&#xA;process&#xA;(this option should not be set by the user, it is for internal use only)"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                          <children xsi:type="mathematica:SymbolLeaf" name="onlyVar"/>
                          <children xsi:type="mathematica:StringLeaf" value="usage"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:StringLeaf" value=" Option of schedule which is a list of string&#xA;(default value: all)&#xA; indicating the only variables that we wish to schedule. Warning, if &#xA;some variable are needed for the computation of the one indicated,&#xA; the function will try to find their execution dates in $schedule &#xA;(only implemented in the Farkas method)"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                            <children xsi:type="mathematica:SymbolLeaf" name="all"/>
                            <children xsi:type="mathematica:StringLeaf" value="usage"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                            <children xsi:type="mathematica:StringLeaf" value="value of various options (onlyVar, onlyDep,....)"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                              <children xsi:type="mathematica:SymbolLeaf" name="onlyDep"/>
                              <children xsi:type="mathematica:StringLeaf" value="usage"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                              <children xsi:type="mathematica:StringLeaf" value=" Option of schedule which is a list of integer&#xA;(default value: all) indicating the only dependences  that we wish to schedule (used for &#xA;multiSched[]) "/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                <children xsi:type="mathematica:SymbolLeaf" name="objFunction"/>
                                <children xsi:type="mathematica:StringLeaf" value="usage"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                <children xsi:type="mathematica:StringLeaf" value="objFunction is an option of schedule which gives&#xA;the type of minimization done for minimizing what we try to minimize&#xA;(i.e. time or delay or whatever). the technique for that is to build a&#xA;function of the parameters of the system and to minimize the&#xA;  coefficient of this function with respect to constraints which&#xA;  ensure that this function is greater than what we want to minimize. &#xA;The technique used by default (objFunction->lexicographic) &#xA;in the Farkas resolution is to minimize&#xA;  lexicographically the coefficient of this function in the order of&#xA;  their declaration in the Alpha program. but one can chose to&#xA;  minimize them in another order:&#xA;  objFunction->lexicographic[&quot;N&quot;,&quot;P&quot;,&quot;M&quot;] (not implemented anywhere)&#xA;or to minimize a function of these coefficients example:&#xA;  objFunction->2&quot;N&quot;+&quot;P&quot; (only implemented in the vertex&#x9;&#x9;&#x9;     resolution) "/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                  <children xsi:type="mathematica:SymbolLeaf" name="lexicographic"/>
                                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                  <children xsi:type="mathematica:StringLeaf" value="possible value of the objFunction option of the&#xA;  schedule function"/>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="checkSched"/>
                                    <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:StringLeaf" value="(+) checkSched is an option of schedule which allows a schedule &#xA;to be checked for a given Alpha program. This option can be used only&#xA;for affine by variable schedules. The form of this &#xA;option is checkSched -> list, where list has the same syntax as &#xA;$schedule (see ?$schedule for more information).&#xA;&#xA;WARNING: this option is not implemented"/>
                              </children>
                            </children>
                          </children>
                        </children>
                      </children>
                    </children>
                  </children>
                </children>
              </children>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="parameterConstraints"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="parameterConstraints is an option of dep. If set, constraints on the&#xA;parameters are included in the domains of the dependencies. Default is&#xA;False"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="subSystems"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="options of schedule (boolean) and dep indicating&#xA;whether or not the function takes into account the calls to other&#xA;  systems (default, false)"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="subSystemSchedule"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="option of schedule (list), indicates, &#xA;if the subSystems option is set to True, the schedules of the&#xA;  different subsystems called in the system to schedule for performing&#xA;  a structured scheduling"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="multiDimensional"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value=" option of Schedule (boolean), indicates &#xA;if we perform a multi dimensional scheduling or mono dimensionnal&#xA;  scheduming (default)"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="outputForm"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value="options of schedule, gselect the output of the&#xA;schedule which may be a schedule, a LP, a domain .... The default&#xA;value is outputForm->scheduleResult i.e. the result isx a schedule (see&#xA;?$schedule). other value: outputForm->lpSolve (Linear Programming&#xA;problem (LP) formated for lp_solve), outputForm->lpMMA (LP&#xA;formated for MMA (to be implemented)), outputForm->domain (schedule polytope (Alpha`domain,Warning works for small programs))"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="dataFlowConstantsNull"/>
                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                </children>
              </children>
              <children xsi:type="mathematica:StringLeaf" value="dataFlowConstantsNull is an option of scd. Its default value is True,&#xA;forcing the constant part of the first level of a data-flow schedule&#xA;to be 0 for all variables."/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="dataFlowPeriod"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="dataFlowPeriod is an option of scd. Its default value is 1. If set to&#xA;an  integer, forces the period of the data-flow schedule to be this&#xA;integer. If set to any non integral value, the data-flow period is&#xA;choosen automatically,  and assumed to be >=1. Most often used in&#xA;combination with dataFlowConstantsNull set to False."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="dataFlowVariables"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="dataFlowVariables is an option of scd, which is considered only for&#xA;data-flow schedules. Its default value is &lt;&lt;all>>, meaning that all&#xA;variables are considered for data-flow scheduling. If it is set to a&#xA;list of strings, it gives the list of variables which must not be&#xA;inserted in the dataflow variables. These variables will be considered&#xA;only for scheduling in the next dimensions of the schedule."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="verticesPositives"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="verticesPositives is an option of scd, scheduleConstraints, and &#xA;timeMinSchedConstraints. Its default value is False. When set, this&#xA;option forces the scheduler to find timing-functions which are positive&#xA;at the vertices of the domains of the variables. Usually, only&#xA;constraints on rays of the domains are taken into account. This option&#xA;is not used, as it most often results in non-integral (i.e. strictly&#xA;rational) schedules."/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="sortOrder"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:StringLeaf" value="sortOrder is an option of showSchedResult, which specifies the order&#xA;in which the results are given. Default is noOrder. Other possibilities&#xA;are lexicographic, or an integer which specifies the number of coefficient&#xA;given backwards"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="noOrder"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="noOrder is a value for the option sortOrder of showSchedResult"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="eliminatesDoubles"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="Options of dep[], if set to False &#xA;dep[] returns the usual dependence list. If set to True, the dependences&#xA;  returned does not contain twice the same dependence"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="equalitySimpl"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value=" options of dep[], if set to True, try to&#xA;  simplify the dep according to the context (default True)"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="scalarTypeCheck"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="option to analyze[] (Boolean). If True,&#xA;perform scalar type checking. For internal use mostly."/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="occurence"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:StringLeaf" value="option of inlineAll[] and inlineSubsystem[] (Integer). &#xA;When a given subsystem is used several times in&#xA;the same caller system, the value of occurence selects the instance to&#xA;be inlined."/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="rename"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of inlineAll[] and inlineSubsystem[] (Boolean). &#xA;rename -> True  forces the renaming of all variables, whereas&#xA;if rename -> False, variables are renamed only in case of conflict."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="renameCounter"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of inlineAll[] and inlineSubsystem[]&#xA;(Integer, default 1).  Sets the value to be appended to variable names&#xA;in case when they are renamed to avoid name conflicts. "/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="current"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of inlineAll[] and inlineSubsystem[] (Boolean). If&#xA;True, $result and $program are updated."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="underscore"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of inlineSubsystem and inlineAll (Boolean). When True&#xA;(default), new identifier separator is _, whereas it is X otherwise"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="indexnorm"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="option of normalize[] (Boolean). indexnorm -> True&#xA;  normalizes index expressions also. The default is False."/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="alphaFormat"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="options of simplifySystem: alphaFormat->Alpha (default)&#xA;simplify a system to the standard normalized Alpha&#xA;form. alphaFormat->Alpha0 simplify to Alpha0 format,&#xA;alphaFormat->AlpHard is not implemented"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="Alpha0"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:StringLeaf" value="value of the alphaFormat options of simplifySystem"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="initZeroReg"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="options of toAlpha0v2: initZeroReg->False &#xA;do not generate a control signal for the register that are initialized&#xA;with a zero. These register will be initialized by the Rst signal"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="verifyCone"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="verifyCone is an option of uniformization&#xA;which verifies whether the dependence cone is pointed if set to True (default value)&#xA;or does not if it is False."/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="alignInp"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="alignInp is an option of uniformization. If set to&#xA;True the uniformize function will try to uniformize a dependence by&#xA;aligning the input instead of routing the dependence. The default&#xA;value is False."/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="routeOnce"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value="routeOnce is an option of uniformization. If&#xA;set to True the uniformize function  will perform routing for the&#xA;first vector of the route. The default value&#xA;is False."/>
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="tmpFile"/>
                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                  <children xsi:type="mathematica:StringLeaf" value="tmpFile is an option of uniformization. If&#xA;set to True the uniformize function  will output a file in /tmp&#xA;directory after each iteration of uniformization. The default value&#xA;is False."/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                    <children xsi:type="mathematica:SymbolLeaf" name="silent"/>
                    <children xsi:type="mathematica:StringLeaf" value="usage"/>
                  </children>
                </children>
                <children xsi:type="mathematica:StringLeaf" value="option of show (False). If silent is True, show does not print&#xA;its result, but returns a string."/>
              </children>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="allVariablesAllowed"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of changeOfBasis, default False. If True &#xA;the change of basis can be applied to any variable. Not yet operational..."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="showSquareDeps"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of uniformizeInfo"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="showNonSquareDeps"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of uniformizeInfo"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="showUniformDeps"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of uniformizeInfo"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="showNonUniformDeps"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of uniformizeInfo"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="showUniformizableDeps"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of uniformizeInfo"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="showNonUniformizableDeps"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of uniformizeInfo"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="minimize"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of simplex. Default is True"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="boundedDelay"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of timeMinSchedConstraints. Currently not used."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="extraEdges"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of depGraph, allowing edges to be added"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="labelOffset"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of depGraph, allowing the offset of the position of a label &#xA;to be modified. Default is 0.025."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="labelSize"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of depGraph, allowing the size of the labels to be changed.&#xA;Default value is 0.1 ."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="onlyIdDep"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of depGraph (default False), If set to True, build a graph where only &#xA;identity dependences are present. (require an aligned program)."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="cellType"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of Vhdl"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="tempFile"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of Vhdl"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="vhdlLibrary"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of Vhdl"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="compass"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of Vhdl"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="compactCode"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of Vhdl"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="clockEnable"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of Vhdl"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="skipLines"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of Vhdl"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="stdLogic"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of Vhdl. If set, produces stdlogic types"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="initialize"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option of vhdlType. If set, produces initialized declarations"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="controler"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option value for option cellType of alphaToVHDL"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="cell"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option value for option cellType of alphaToVHDL"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="module"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Option value for option cellType of alphaToVHDL"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="rewrite"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="rewite: option (boolean) for cGen. If True, output file is&#xA;overwritten if it already exists."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="include"/>
        <children xsi:type="mathematica:StringLeaf" value="usqge"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="include: option of code Generators, specify as a list of string the list of file to be included (default: False)"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="noPrint"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:StringLeaf" value="boolean option of cGen. If True, the generated C code does not provide &#xA;prompts before the inputs, nor before the outputs, which makes it easier&#xA;to run a test from an input file"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="alreadySchedule"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of cGen (boolean, default false), if set to True, cGen does not &#xA;perform schedule neither change of Basis: WARNING not Implemented yet "/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="stimuli"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="option of cGen (boolean, default False), if set to True, cGen &#xA;generates one stimuli file by input and output variable"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="interactive"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="interactive is a (boolean) option of cGen. If True, cGen also generates &#xA;a function main which (i) reads system inputs on stdin (ii) evaluates the &#xA;system, (iii) prints the outputs on stdout"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="matlab"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="matlab is a boolean option of cGen. If True, cGen also generates a &#xA;function mexFunction which is used for interface with matlab code"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="bitTrue"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="bitTrue is a boolean option of cGen. If True, cGen includes the &#xA;bitOperators.h file in the C code and produces the compile script to &#xA;compile the code"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="debugC"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="debugC: option (boolean) for VirtexGen. If True, Virtexgen generates &#xA;a function main which (i) reads system inputs on stdin (ii) evaluate &#xA;the system, (iii) prints the outputs on stdout (the output are not &#xA;significant in that case)"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="onlyLocalVars"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="option used  when a function shouyld be applied sometimes nly on local variables "/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="projVector"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="options of appSched to indicate what is the projection vector (appSched will try to find a unimodulary completion that is a projection along this vector) should be a Mathematica Vector (integer list) for instance: {1,0,0}(dimension is the number of indices plus parameter). Warning, this function does not try very hard to find a projection, the first one found is choosen. If it failed, please use the projMatrix options "/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="projMatrix"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="options of appSched to indicate what is the projection Matrix used for completing the schedule. should be a Mathematica Matrix (list of list of integer) for instance: {{1,0,0},{0,1,0}}. This matrix is a linear Matrix, i.e. it does not contains the affine part information (dimension is the number of indices plus parameter) "/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="checkCase"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:StringLeaf" value="checkCase is an option of getContextDomain. If set, the function&#xA;checks on the fly that the branches of the case expressions do not &#xA;overlap. False by default."/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="mergeDomains"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="mergeDomains is an option of simplifySpaceDom. If set (True), the&#xA;domains are merged before the simplification is applied. Default&#xA;value is False"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:SymbolLeaf" name="extDomUseCOB"/>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value=" extDomUseCOB is an option of changeOfBasis used internal &#xA;to allow a non identity part on extention indices during a recursive change of basis, this option should not be used by the end user (the resulting program maybe wrong))"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="onlyModules"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:StringLeaf" value="onlyModules is an option of alpha2ToAlphard. If set (True), the&#xA;program does not accept a system which is not a module. Default is&#xA;False."/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="startTime"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="startTime is an options of systemC generator for controleurs to indicate the &#xA;starting time of an Alphard program, i.e. the smallest value taken by the t index upon all the domains of the library, default Infinity"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="systemCFiles"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="systemCFile is an options of systemC generator that indicates whether the codeis generated in one&#xA;.h file (option value 1, default value) or in two files (.h and .cpp file, option value 2)"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="busWidth"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="options of socLibGen (default 32) set the bus Width used during the generation of the systemC &#xA;interface to Alphard programs"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="inputOrOutput"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="options of  socLibGen for internal use"/>
              <children xsi:type="mathematica:ASTNode" name="Begin">
                <children xsi:type="mathematica:StringLeaf" value="`Private`"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="End"/>
              <children xsi:type="mathematica:ASTNode" name="EndPackage"/>
            </children>
          </children>
        </children>
      </children>
    </children>
  </children>
</mathematica:BuiltInNode>
