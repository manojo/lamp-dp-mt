<?xml version="1.0" encoding="ASCII"?>
<mathematica:BuiltInNode xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mathematica="http://www.irisa.fr/cairn/model/xtext/Mathematica" keyword="Protect">
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="BeginPackage">
          <children xsi:type="mathematica:StringLeaf" value="Alpha`ChangeOfBasis`"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Domlib`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Options`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Matrix`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Substitution`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Normalization`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Tables`"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="ChangeOfBasis"/>
          <children xsi:type="mathematica:StringLeaf" value="usage"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="Package. Contains the definition of the &quot;change of basis&quot;&#xA;transformation (see changeOfBasis)."/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="ChangeOfBasis"/>
            <children xsi:type="mathematica:StringLeaf" value="bugs"/>
          </children>
        </children>
        <children xsi:type="mathematica:StringLeaf" value="In extended changeOfBasis, the &#xA;number of new indexes does not seem to be checked against&#xA;the change of basis function"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="changeOfBasis[var.fn_String] returns a copy of $result in which the&#xA;variable var is reindexed by an unimodular affine function fn. The&#xA;change of basis is specified as &quot;B.(i,j,k -> i+1,j,k)&quot; where B is&#xA;the variable to be reindexed, and the change of basis matrix has the&#xA;format of an Alpha dependence, with one difference: the index mapping&#xA;function is understood as a mapping from initial to new position (and&#xA;not the opposite). If it is square, this matrix should be&#xA;unimodular. Non-square change of basis (also called generalized change of basis) &#xA;are allowed, in that case, the&#xA;function should be called this way: changeOfBasis[var.fn_String,&#xA;{index_String, ...}] applies a change of basis fn on variable var,&#xA;except that the new indices of var are named according to the second&#xA;argument (example: changeOfBasis[&quot;B.(i,j ->&#xA;1,i,j)&quot;,{&quot;i1&quot;,&quot;j1&quot;,&quot;k1&quot;}]).  changeOfBasis[sys_Alpha`system,&#xA;var.fn_String, {index_String, ...}]  applies a change of basis to&#xA;system `sys' instead of $result.  changeOfBasis[&quot;B.(i,j ->&#xA;1,i,j)&quot;,recurse->True] recursively executes the change&#xA;of basis on subsystem `subsys' called with `B' as input or output. The recursive &#xA;change of basis has many restriction: as the semantics of the subsystem is modified, &#xA;we impose that there is only one occurence of `subsys' appearing in the system.&#xA; Moreover, the recursive change of basis can &#xA;modify only `local' indices (indices which are not extension indices in the use of `subsys') &#xA;and must involve only local indices and  parameter transmitted to the subsystem. &#xA;The  change of basis on the extension indices can be performed with the function extDomainCOB[] (see ?extDomainCOB)"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="extDomainCOB"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="extDomainCOB[&quot;subSysName.(j->g(j,N))&quot;] applies the change of basis to all the variables &#xA;implied in the use of the subsystem `subSysName' and change the extension domain accordingly. this change of basis &#xA;should be applied to a system where the following use appear: &quot;use {j| ....} subSysName[...] (...) returns (...)&quot;. &#xA;j are the extension indices, N are the parameter of the caller. The change of basis must only depend on the extention indices&#xA; and on the parameters as indicated here. The parameter assignement function must &#xA;be simple (i.e. each parameter of the subsystem is assigned to a parameter of the caller, e.g. (N,M,P->P,N) &#xA;This transformation should have no impact on the subsystems. "/>
            <children xsi:type="mathematica:ASTNode" name="Begin">
              <children xsi:type="mathematica:StringLeaf" value="`Private`"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="Options">
              <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
              <children xsi:type="mathematica:SymbolLeaf" name="allVariablesAllowed"/>
              <children xsi:type="mathematica:SymbolLeaf" name="False"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
              <children xsi:type="mathematica:SymbolLeaf" name="recurse"/>
              <children xsi:type="mathematica:SymbolLeaf" name="False"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
              <children xsi:type="mathematica:SymbolLeaf" name="debug"/>
              <children xsi:type="mathematica:SymbolLeaf" name="False"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
              <children xsi:type="mathematica:SymbolLeaf" name="extDomUseCOB"/>
              <children xsi:type="mathematica:SymbolLeaf" name="False"/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
        <children xsi:type="mathematica:StringLeaf" value="wrgmat"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="your matrix is not unimodular!"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
        <children xsi:type="mathematica:StringLeaf" value="nonlocal"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="change of basis on non-local variable."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
        <children xsi:type="mathematica:StringLeaf" value="params"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="wrong parameters."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
        <children xsi:type="mathematica:StringLeaf" value="wrgarg"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="cannot parse the change of basis specification."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
        <children xsi:type="mathematica:StringLeaf" value="nlocv"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="`1` is not a local variable."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
        <children xsi:type="mathematica:StringLeaf" value="wrgvar"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="`1` is not a variable of this program."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
        <children xsi:type="mathematica:StringLeaf" value="wrgdim"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="the change of basis does not match dimension of variable."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
        <children xsi:type="mathematica:StringLeaf" value="wrgdim2"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="the dimension of the change of basis is inconsistent with  the number&#xA;of new indices"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="addDimension"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="This function is obsolete and has been replaced&#xA;by changeOfBasis. For example, `addDimension[&quot;X.(i->i,j)&quot;,\{&quot;Z&quot;\}]' &#xA;should be replaced by `changeOfBasis[&quot;X.(i->i,j)&quot;,\{&quot;i&quot;,&quot;Z&quot;\}]'. &#xA;Notice that in the changeOfBasis, ALL the new indexes should be given"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="addDimension"/>
        <children xsi:type="mathematica:StringLeaf" value="warning"/>
      </children>
      <children xsi:type="mathematica:ASTNode" name="addDimension"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="addDimension"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="addDimension">
        <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="addDimension"/>
          <children xsi:type="mathematica:StringLeaf" value="warning"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="defRule"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="defRule">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
        <children xsi:type="mathematica:ASTNode" name="decl">
          <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="type"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:ASTNode" name="decl">
          <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
          <children xsi:type="mathematica:SymbolLeaf" name="type"/>
          <children xsi:type="mathematica:ASTNode" name="DomZPreimage">
            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
            <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="matchingLhsRule"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="matchingLhsRule">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="Module">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:SymbolLeaf" name="res"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="res"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                <children xsi:type="mathematica:ASTNode" name="equation">
                  <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="equation">
                  <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="With">
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="LHSindices"/>
                        <children xsi:type="mathematica:ASTNode" name="Part">
                          <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
                          <children xsi:type="mathematica:IntLeaf" value="3"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                      <children xsi:type="mathematica:ASTNode" name="normalize">
                        <children xsi:type="mathematica:ASTNode" name="affine">
                          <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                            <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                              <children xsi:type="mathematica:ASTNode" name="var">
                                <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="affine">
                                <children xsi:type="mathematica:ASTNode" name="var">
                                  <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                          <children xsi:type="mathematica:ASTNode" name="matrix">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                              <children xsi:type="mathematica:SymbolLeaf" name="l"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                              <children xsi:type="mathematica:SymbolLeaf" name="c"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                              <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                              <children xsi:type="mathematica:SymbolLeaf" name="m"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="matrix">
                            <children xsi:type="mathematica:SymbolLeaf" name="l"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="c"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="LHSindices"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="m"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                          <children xsi:type="mathematica:ASTNode" name="domain">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                              <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                              <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                              <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="domain">
                            <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="LHSindices"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                          </children>
                        </children>
                      </children>
                    </children>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="res"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="otherLhsRule"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="otherLhsRule">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="Module">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:SymbolLeaf" name="res"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="res"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                <children xsi:type="mathematica:ASTNode" name="equation">
                  <children xsi:type="mathematica:ASTNode" name="Condition">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                        <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                      <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="normalize">
                  <children xsi:type="mathematica:ASTNode" name="equation">
                    <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                      <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                        <children xsi:type="mathematica:ASTNode" name="var">
                          <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="affine">
                          <children xsi:type="mathematica:ASTNode" name="var">
                            <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
                        </children>
                      </children>
                    </children>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="res"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="useInputsRule"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="useInputsRule">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
        <children xsi:type="mathematica:ASTNode" name="use">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="id"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="extDom"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="paramAssgn"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="inputs"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="outputs"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
        <children xsi:type="mathematica:ASTNode" name="use">
          <children xsi:type="mathematica:SymbolLeaf" name="id"/>
          <children xsi:type="mathematica:SymbolLeaf" name="extDom"/>
          <children xsi:type="mathematica:SymbolLeaf" name="paramAssgn"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Map">
            <children xsi:type="mathematica:SymbolLeaf" name="normalize"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
              <children xsi:type="mathematica:SymbolLeaf" name="inputs"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                <children xsi:type="mathematica:ASTNode" name="affine">
                  <children xsi:type="mathematica:ASTNode" name="var">
                    <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="f1"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="affine">
                  <children xsi:type="mathematica:ASTNode" name="affine">
                    <children xsi:type="mathematica:ASTNode" name="var">
                      <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="f1"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
                </children>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="outputs"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="useOutputRule"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="useOutputRule">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="newName"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
        <children xsi:type="mathematica:ASTNode" name="use">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="id"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="pass"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="i"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="Condition">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="o"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="MemberQ">
              <children xsi:type="mathematica:SymbolLeaf" name="o"/>
              <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="List">
          <children xsi:type="mathematica:ASTNode" name="use">
            <children xsi:type="mathematica:SymbolLeaf" name="id"/>
            <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
            <children xsi:type="mathematica:SymbolLeaf" name="pass"/>
            <children xsi:type="mathematica:SymbolLeaf" name="i"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
              <children xsi:type="mathematica:SymbolLeaf" name="o"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                <children xsi:type="mathematica:SymbolLeaf" name="newName"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="equation">
            <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
            <children xsi:type="mathematica:ASTNode" name="affine">
              <children xsi:type="mathematica:ASTNode" name="var">
                <children xsi:type="mathematica:SymbolLeaf" name="newName"/>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="useCOB"/>
        <children xsi:type="mathematica:StringLeaf" value="buildNewCOB"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value=" Error during the recursive COB, COB aborted&#xA; "/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="useCOB"/>
            <children xsi:type="mathematica:StringLeaf" value="failed"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="Sorry, change of Basis failed for&#xA;   variable `1` on subsystem `2`"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="useCOB"/>
              <children xsi:type="mathematica:StringLeaf" value="varUsedSeveralTimes"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="Variable `1` in involved into  I/O of several subsystem, cannot perform an extension domain change of basis, please add a local copy of `1`"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
              <children xsi:type="mathematica:SymbolLeaf" name="useCOB"/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="useCOB">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
          <children xsi:type="mathematica:ASTNode" name="system">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="n"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="p"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="in"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="o"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="locals"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="equas"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="oldDecl"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="decl"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
          <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
            <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:ASTNode" name="Catch">
              <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:SymbolLeaf" name="allVariables"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="optRecurse"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="optDebug"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="libres"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="eqnUse"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="eqnUseLHSvar"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="subSystemNames"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="subSystemName"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="subSys1"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="useSubSys1"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="COBmat"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="nbIndiceVar"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="nbExtension"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="posLHSvarInUse"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="subName"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="curUse"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="realFunc"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="subSysVarDecl"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="newIndices"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="curSubSys1"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="allVariables"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                        <children xsi:type="mathematica:SymbolLeaf" name="allVariablesAllowed"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Options">
                        <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="optRecurse"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                        <children xsi:type="mathematica:SymbolLeaf" name="recurse"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Options">
                        <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="optDebug"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                        <children xsi:type="mathematica:SymbolLeaf" name="debug"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Options">
                        <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="If">
                    <children xsi:type="mathematica:SymbolLeaf" name="optDebug"/>
                    <children xsi:type="mathematica:ASTNode" name="Print">
                      <children xsi:type="mathematica:StringLeaf" value="****Entering useCOB "/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="optExtDomUseCOB"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                        <children xsi:type="mathematica:SymbolLeaf" name="extDomUseCOB"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Options">
                        <children xsi:type="mathematica:SymbolLeaf" name="changeOfBasis"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="libres"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="eqnUse"/>
                    <children xsi:type="mathematica:ASTNode" name="Select">
                      <children xsi:type="mathematica:SymbolLeaf" name="equas"/>
                      <children xsi:type="mathematica:ASTNode" name="Function">
                        <children xsi:type="mathematica:ASTNode" name="Equal">
                          <children xsi:type="mathematica:ASTNode" name="Head">
                            <children xsi:type="mathematica:ASTNode" name="Slot">
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="use"/>
                        </children>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="eqnUseLHSvar"/>
                    <children xsi:type="mathematica:ASTNode" name="Select">
                      <children xsi:type="mathematica:SymbolLeaf" name="eqnUse"/>
                      <children xsi:type="mathematica:ASTNode" name="Function">
                        <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                          <children xsi:type="mathematica:ASTNode" name="Position">
                            <children xsi:type="mathematica:ASTNode" name="Slot">
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                            </children>
                            <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="Infinity"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                        </children>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="If">
                    <children xsi:type="mathematica:SymbolLeaf" name="optExtDomUseCOB"/>
                    <children xsi:type="mathematica:ASTNode" name="If">
                      <children xsi:type="mathematica:ASTNode" name="Greater">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                          <children xsi:type="mathematica:SymbolLeaf" name="eqnUseLHSvar"/>
                        </children>
                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                            <children xsi:type="mathematica:SymbolLeaf" name="useCOB"/>
                            <children xsi:type="mathematica:StringLeaf" value="varUsedSeveralTimes"/>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="Throw"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="SameQ">
                    <children xsi:type="mathematica:SymbolLeaf" name="eqnUseLHSvar"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Return">
                    <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="subSystemNames"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                        <children xsi:type="mathematica:SymbolLeaf" name="First"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="eqnUseLHSvar"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="If">
                      <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Union">
                            <children xsi:type="mathematica:SymbolLeaf" name="subSystemNames"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                          <children xsi:type="mathematica:SymbolLeaf" name="subSystemNames"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                        <children xsi:type="mathematica:ASTNode" name="Print">
                          <children xsi:type="mathematica:StringLeaf" value="Variable "/>
                          <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                          <children xsi:type="mathematica:StringLeaf" value=" in involved into  I/O of&#xA;   several times the same subsystem, not implemented "/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="Throw"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="If">
                    <children xsi:type="mathematica:SymbolLeaf" name="optDebug"/>
                    <children xsi:type="mathematica:ASTNode" name="Print">
                      <children xsi:type="mathematica:StringLeaf" value="subSystem to examine: "/>
                      <children xsi:type="mathematica:SymbolLeaf" name="subSystemNames"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Do">
                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="subSystemName"/>
                        <children xsi:type="mathematica:ASTNode" name="Part">
                          <children xsi:type="mathematica:SymbolLeaf" name="subSystemNames"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="If">
                        <children xsi:type="mathematica:SymbolLeaf" name="optDebug"/>
                        <children xsi:type="mathematica:ASTNode" name="Print">
                          <children xsi:type="mathematica:StringLeaf" value=" examining: "/>
                          <children xsi:type="mathematica:SymbolLeaf" name="subSystemName"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="subSys1"/>
                        <children xsi:type="mathematica:ASTNode" name="getSystem">
                          <children xsi:type="mathematica:SymbolLeaf" name="subSystemName"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="If">
                        <children xsi:type="mathematica:ASTNode" name="SameQ">
                          <children xsi:type="mathematica:SymbolLeaf" name="subSys1"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                              <children xsi:type="mathematica:SymbolLeaf" name="useCOB"/>
                              <children xsi:type="mathematica:StringLeaf" value="failed"/>
                            </children>
                            <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="subSystemName"/>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="Throw"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="useSubSys1"/>
                      <children xsi:type="mathematica:ASTNode" name="First">
                        <children xsi:type="mathematica:ASTNode" name="Select">
                          <children xsi:type="mathematica:SymbolLeaf" name="eqnUseLHSvar"/>
                          <children xsi:type="mathematica:ASTNode" name="Function">
                            <children xsi:type="mathematica:ASTNode" name="SameQ">
                              <children xsi:type="mathematica:ASTNode" name="First">
                                <children xsi:type="mathematica:ASTNode" name="Slot">
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:SymbolLeaf" name="subSystemName"/>
                            </children>
                          </children>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="COBmat"/>
                      <children xsi:type="mathematica:ASTNode" name="Part">
                        <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
                        <children xsi:type="mathematica:IntLeaf" value="4"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="If">
                      <children xsi:type="mathematica:ASTNode" name="Not">
                        <children xsi:type="mathematica:ASTNode" name="checkSubIndexIndependence">
                          <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="oldDecl"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="useSubSys1"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Throw"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="If">
                    <children xsi:type="mathematica:ASTNode" name="Not">
                      <children xsi:type="mathematica:ASTNode" name="checkExtIndexIndependence">
                        <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="subSys1"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="oldDecl"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="useSubSys1"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Throw"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="Not">
                    <children xsi:type="mathematica:ASTNode" name="checkParamUseValidity">
                      <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="subSys1"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="oldDecl"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="useSubSys1"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Throw"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="posLHSvarInUse"/>
                <children xsi:type="mathematica:ASTNode" name="Position">
                  <children xsi:type="mathematica:SymbolLeaf" name="useSubSys1"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="If">
                <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                    <children xsi:type="mathematica:SymbolLeaf" name="posLHSvarInUse"/>
                  </children>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="More than one use of "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                    <children xsi:type="mathematica:StringLeaf" value=" in use "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="subSystemName"/>
                    <children xsi:type="mathematica:StringLeaf" value=" not implemented"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Throw"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="SameQ">
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="posLHSvarInUse"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                    </children>
                    <children xsi:type="mathematica:IntLeaf" value="4"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="subName"/>
                      <children xsi:type="mathematica:ASTNode" name="getPart">
                        <children xsi:type="mathematica:ASTNode" name="Part">
                          <children xsi:type="mathematica:SymbolLeaf" name="subSys1"/>
                          <children xsi:type="mathematica:IntLeaf" value="3"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:SymbolLeaf" name="posLHSvarInUse"/>
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                          </children>
                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="If">
                      <children xsi:type="mathematica:SymbolLeaf" name="optDebug"/>
                      <children xsi:type="mathematica:ASTNode" name="show">
                        <children xsi:type="mathematica:SymbolLeaf" name="useSubSys1"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="curUse"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                        <children xsi:type="mathematica:SymbolLeaf" name="useSubSys1"/>
                        <children xsi:type="mathematica:ASTNode" name="useInputsRule">
                          <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="If">
                      <children xsi:type="mathematica:SymbolLeaf" name="optDebug"/>
                      <children xsi:type="mathematica:ASTNode" name="show">
                        <children xsi:type="mathematica:SymbolLeaf" name="curUse"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                        <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                          <children xsi:type="mathematica:SymbolLeaf" name="useSubSys1"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="curUse"/>
                        </children>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="subName"/>
                    <children xsi:type="mathematica:ASTNode" name="getPart">
                      <children xsi:type="mathematica:ASTNode" name="Part">
                        <children xsi:type="mathematica:SymbolLeaf" name="subSys1"/>
                        <children xsi:type="mathematica:IntLeaf" value="4"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                        <children xsi:type="mathematica:ASTNode" name="Part">
                          <children xsi:type="mathematica:SymbolLeaf" name="posLHSvarInUse"/>
                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                        </children>
                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="realFunc"/>
                  <children xsi:type="mathematica:ASTNode" name="buildNewCOB">
                    <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="subSys1"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="oldDecl"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="useSubSys1"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="LHSvar"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="subName"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="fn"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="optDebug"/>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:ASTNode" name="Print">
                      <children xsi:type="mathematica:StringLeaf" value="recursive COB:"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="show">
                      <children xsi:type="mathematica:SymbolLeaf" name="realFunc"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="Not">
                    <children xsi:type="mathematica:ASTNode" name="MatchQ">
                      <children xsi:type="mathematica:SymbolLeaf" name="realFunc"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                        <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="useCOB"/>
                        <children xsi:type="mathematica:StringLeaf" value="buildNewCOB"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Throw"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="subSysVarDecl"/>
                <children xsi:type="mathematica:ASTNode" name="getDeclaration">
                  <children xsi:type="mathematica:SymbolLeaf" name="subSys1"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="subName"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="nbIndiceVar"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="oldDecl"/>
                    <children xsi:type="mathematica:IntLeaf" value="3"/>
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                      <children xsi:type="mathematica:IntLeaf" value="2"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                    </children>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="nbExtension"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="useSubSys1"/>
                    <children xsi:type="mathematica:IntLeaf" value="3"/>
                    <children xsi:type="mathematica:IntLeaf" value="2"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                      <children xsi:type="mathematica:IntLeaf" value="2"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="If">
                <children xsi:type="mathematica:SymbolLeaf" name="optExtDomUseCOB"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="newIndices"/>
                  <children xsi:type="mathematica:ASTNode" name="Drop">
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
                      <children xsi:type="mathematica:IntLeaf" value="3"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                        <children xsi:type="mathematica:SymbolLeaf" name="nbIndiceVar"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="nbExtension"/>
                        </children>
                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                        <children xsi:type="mathematica:ASTNode" name="Part">
                          <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                        </children>
                        <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="newIndices"/>
                  <children xsi:type="mathematica:ASTNode" name="Drop">
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
                      <children xsi:type="mathematica:IntLeaf" value="3"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                        <children xsi:type="mathematica:ASTNode" name="Part">
                          <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="nbExtension"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                        <children xsi:type="mathematica:ASTNode" name="Part">
                          <children xsi:type="mathematica:SymbolLeaf" name="fnInverse"/>
                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                        </children>
                        <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                      </children>
                    </children>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="If">
                <children xsi:type="mathematica:SymbolLeaf" name="optDebug"/>
                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value=" for use of system"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="subSystemName"/>
                    <children xsi:type="mathematica:StringLeaf" value=" the recursive COB applied will be: "/>
                    <children xsi:type="mathematica:ASTNode" name="show">
                      <children xsi:type="mathematica:SymbolLeaf" name="realFunc"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                        <children xsi:type="mathematica:SymbolLeaf" name="silent"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="The names of the new indices will be:"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="newIndices"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="If">
                <children xsi:type="mathematica:ASTNode" name="Or">
                  <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="realFunc"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                    </children>
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="realFunc"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                    </children>
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="curSubSys1"/>
                  <children xsi:type="mathematica:ASTNode" name="changeOfBasis">
                    <children xsi:type="mathematica:SymbolLeaf" name="subSys1"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="subName"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="realFunc"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="newIndices"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                      <children xsi:type="mathematica:SymbolLeaf" name="allVariablesAllowed"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="curSubSys1"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="subSys1"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="If">
                <children xsi:type="mathematica:SymbolLeaf" name="optDebug"/>
                <children xsi:type="mathematica:ASTNode" name="Print">
                  <children xsi:type="mathematica:StringLeaf" value="the new subSystem is :"/>
                  <children xsi:type="mathematica:ASTNode" name="show">
                    <children xsi:type="mathematica:SymbolLeaf" name="curSubSys1"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                      <children xsi:type="mathematica:SymbolLeaf" name="silent"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                    </children>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="libres"/>
                <children xsi:type="mathematica:ASTNode" name="putSystem">
                  <children xsi:type="mathematica:SymbolLeaf" name="curSubSys1"/>
                </children>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="List">
          <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
          <children xsi:type="mathematica:IntLeaf" value="1"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Length">
            <children xsi:type="mathematica:BuiltInNode" keyword="Union">
              <children xsi:type="mathematica:SymbolLeaf" name="subSystemNames"/>
            </children>
          </children>
        </children>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
  <children xsi:type="mathematica:SymbolLeaf" name="libres"/>
</mathematica:BuiltInNode>
