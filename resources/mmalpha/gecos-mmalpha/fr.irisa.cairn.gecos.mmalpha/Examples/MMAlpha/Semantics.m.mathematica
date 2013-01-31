<?xml version="1.0" encoding="ASCII"?>
<mathematica:BuiltInNode xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mathematica="http://www.irisa.fr/cairn/model/xtext/Mathematica" keyword="Protect">
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="BeginPackage">
          <children xsi:type="mathematica:StringLeaf" value="Alpha`Semantics`"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Domlib`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Matrix`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Options`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Tables`"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="Semantics"/>
          <children xsi:type="mathematica:StringLeaf" value="usage"/>
        </children>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Alpha`Semantics`Semantics` is the package which contains the &#xA;functions to compute the type of Alpha expressions."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="expType"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="expType[exp] computes the type (Alpha`integer, Alpha`boolean,&#xA;Alpha`real, Alpha`bottom) of an expression and checks its correctness&#xA;using type--matching rules. expType[sys,exp] does the same to program&#xA;in symbol sys.  The expression may be given as a String, a position&#xA;vector (following the convention of the Mathematica function Position)&#xA;in the system, or as an AST. expType returns Alpha`bottom if the&#xA;expression is not correctly typed.  In such a case, the offending tree&#xA;and the colliding types are printed on the screen."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="expType"/>
        <children xsi:type="mathematica:StringLeaf" value="arg"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Wrong arguments"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="expDimension"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="expDimension[exp] computes the dimension of expression exp in&#xA;system $result. expDimension[sys,exp] computes the dimension of&#xA;expression exp in system contained in symbol sys. The expression&#xA;may be given as a String, a position vector (following the convention&#xA;of the Mathematica function Position) in the system, or as an AST.&#xA;expDimension outputs error messages if dimensions are not compatible,&#xA;and returns dimension -1 in this case.  Remark: parameters are counted&#xA;as additional dimensions."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="expDomain"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="expDomain[exp] computes and returns the domain of exp in program&#xA;$returns, or $Failed if the expression is badly formed.&#xA;expDomain[sys,exp] computes and returns the domain of exp in program&#xA;sys.  expDomain generates error and warning messages accordingly. The&#xA;expression may be given as a String, a position vector (following the&#xA;convention of the Mathematica function Position) in the system, or as&#xA;an AST."/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="getContextDomain"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:StringLeaf" value="getContextDomain[pos] computes the context domain in which an&#xA;expression at position pos in $result is used.  getContextDomain[sys,&#xA;pos] computes the context domain in which an expression at position&#xA;pos in sys.  The context is the domain inherited by an expression from&#xA;the constructs which surrounds it.  The position is counted from the&#xA;root of the system (Mathematica notion of position)."/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="matchTypes"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="matchTypes[type1,type2] computes the type corresponding to the union&#xA;of those of the parameters (integer, boolean, real). Returns the &#xA;resulting type or bottom if the types are uncompatible."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="expDomain"/>
        <children xsi:type="mathematica:StringLeaf" value="ERROR"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value=" "/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="replaceByEquivExpr"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="replaceByEquivExpr[position1,expr2] replace in $result the expression&#xA;present at position positin1 by expr2.&#xA;replaceByEquivExpr[expr1,expr2] replace in $result all occurences of&#xA;expr1 by expr2. expr1 and expr2 can be given in AST form of Alpha form&#xA;(String). WARNING The equivalence of the resulting program is NOT&#xA;guaranteed. A test is made to check if the two expressions are&#xA;equivalent, but if this test fails, the replacement is done anyway.&#xA;This function should be used for replacing expression by equivalent&#xA;one when this cannot be done automatically (for instance, in presence&#xA;of degenerated domains). Can also be called as&#xA;replaceByEquivExpr[sys,expr1,expr2], or&#xA;replaceByEquivExpr[sys,position1,,expr2]"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="changeType"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="changeType[sys,var,newType] changes the type of variable var&#xA;to newType in syst. No typing compatibility check are done: no&#xA;semantic preserving property. Mainly used for changing integers to&#xA;fixed bit width integers. changeType[var,newType] applies on and&#xA;modifies $result."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
      <children xsi:type="mathematica:ASTNode" name="Begin">
        <children xsi:type="mathematica:StringLeaf" value="`Private`"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
        <children xsi:type="mathematica:SymbolLeaf" name="booleanType"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="booleanType">
        <children xsi:type="mathematica:SymbolLeaf" name="boolean"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="boolean"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="booleanType">
        <children xsi:type="mathematica:SymbolLeaf" name="unkown"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="boolean"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="booleanType">
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="integerType"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="integerType">
        <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="integerType">
        <children xsi:type="mathematica:SymbolLeaf" name="unkown"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="integerType">
        <children xsi:type="mathematica:ASTNode" name="integer">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="a"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="b"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="integerType">
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="numberType"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="numberType">
        <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="numberType">
        <children xsi:type="mathematica:SymbolLeaf" name="real"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="real"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="numberType">
        <children xsi:type="mathematica:SymbolLeaf" name="unkown"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="unkown"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="numberType">
        <children xsi:type="mathematica:ASTNode" name="integer">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="a"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="b"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="numberType">
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="matchTypes"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="matchTypes">
        <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
        <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="matchTypes">
        <children xsi:type="mathematica:SymbolLeaf" name="real"/>
        <children xsi:type="mathematica:SymbolLeaf" name="real"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="real"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="matchTypes">
        <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
        <children xsi:type="mathematica:SymbolLeaf" name="real"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="real"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="matchTypes">
        <children xsi:type="mathematica:SymbolLeaf" name="real"/>
        <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="real"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="matchTypes">
        <children xsi:type="mathematica:SymbolLeaf" name="boolean"/>
        <children xsi:type="mathematica:SymbolLeaf" name="boolean"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="boolean"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="matchTypes">
        <children xsi:type="mathematica:SymbolLeaf" name="boolean"/>
        <children xsi:type="mathematica:SymbolLeaf" name="unkown"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="boolean"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="matchTypes">
        <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
        <children xsi:type="mathematica:SymbolLeaf" name="unkown"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="matchTypes">
        <children xsi:type="mathematica:SymbolLeaf" name="real"/>
        <children xsi:type="mathematica:SymbolLeaf" name="unkown"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="real"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="matchTypes">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="b"/>
          <children xsi:type="mathematica:ASTNode" name="integer">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="matchTypes">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:ASTNode" name="integer">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="b"/>
          <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
        </children>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="matchTypes">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:ASTNode" name="integer">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="b"/>
          <children xsi:type="mathematica:ASTNode" name="integer">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
        <children xsi:type="mathematica:BuiltInNode" keyword="List">
          <children xsi:type="mathematica:SymbolLeaf" name="widthA"/>
          <children xsi:type="mathematica:SymbolLeaf" name="widthB"/>
          <children xsi:type="mathematica:SymbolLeaf" name="codeA"/>
          <children xsi:type="mathematica:SymbolLeaf" name="codeB"/>
          <children xsi:type="mathematica:SymbolLeaf" name="widthFinal"/>
          <children xsi:type="mathematica:SymbolLeaf" name="codeFinal"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="If">
          <children xsi:type="mathematica:ASTNode" name="And">
            <children xsi:type="mathematica:ASTNode" name="MatchQ">
              <children xsi:type="mathematica:SymbolLeaf" name="a"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="MatchQ">
              <children xsi:type="mathematica:SymbolLeaf" name="b"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="widthA"/>
              <children xsi:type="mathematica:ASTNode" name="Part">
                <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                <children xsi:type="mathematica:IntLeaf" value="2"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="widthB"/>
              <children xsi:type="mathematica:ASTNode" name="Part">
                <children xsi:type="mathematica:SymbolLeaf" name="b"/>
                <children xsi:type="mathematica:IntLeaf" value="2"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="widthFinal"/>
              <children xsi:type="mathematica:ASTNode" name="Max">
                <children xsi:type="mathematica:SymbolLeaf" name="widthA"/>
                <children xsi:type="mathematica:SymbolLeaf" name="widthB"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="codeFinal"/>
              <children xsi:type="mathematica:ASTNode" name="If">
                <children xsi:type="mathematica:ASTNode" name="Or">
                  <children xsi:type="mathematica:ASTNode" name="SameQ">
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                    </children>
                    <children xsi:type="mathematica:StringLeaf" value="S"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="SameQ">
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="b"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                    </children>
                    <children xsi:type="mathematica:StringLeaf" value="S"/>
                  </children>
                </children>
                <children xsi:type="mathematica:StringLeaf" value="S"/>
                <children xsi:type="mathematica:StringLeaf" value="U"/>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="integer">
              <children xsi:type="mathematica:SymbolLeaf" name="codeFinal"/>
              <children xsi:type="mathematica:SymbolLeaf" name="widthFinal"/>
            </children>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="matchTypes">
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
            <children xsi:type="mathematica:SymbolLeaf" name="typeName"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="typeName">
            <children xsi:type="mathematica:SymbolLeaf" name="numberType"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="integer/real"/>
            <children xsi:type="mathematica:ASTNode" name="typeName">
              <children xsi:type="mathematica:SymbolLeaf" name="integerType"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="integer"/>
              <children xsi:type="mathematica:ASTNode" name="typeName">
                <children xsi:type="mathematica:SymbolLeaf" name="booleanType"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value="boolean"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                  <children xsi:type="mathematica:SymbolLeaf" name="unaryTypeCheck"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="unaryTypeCheck">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                      <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="expr"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="crntType"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="typeFunction"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                      <children xsi:type="mathematica:SymbolLeaf" name="Symbol"/>
                    </children>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="If">
                <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                  <children xsi:type="mathematica:SymbolLeaf" name="crntType"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                    <children xsi:type="mathematica:ASTNode" name="typeFunction">
                      <children xsi:type="mathematica:SymbolLeaf" name="crntType"/>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="crntType"/>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:ASTNode" name="Print">
                      <children xsi:type="mathematica:StringLeaf" value="ERROR: Type mismatch in :"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="ashow">
                      <children xsi:type="mathematica:SymbolLeaf" name="expr"/>
                      <children xsi:type="mathematica:ASTNode" name="Part">
                        <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Print">
                      <children xsi:type="mathematica:ASTNode" name="StringJoin">
                        <children xsi:type="mathematica:StringLeaf" value="Expression is "/>
                        <children xsi:type="mathematica:ASTNode" name="ToString">
                          <children xsi:type="mathematica:SymbolLeaf" name="crntType"/>
                        </children>
                        <children xsi:type="mathematica:StringLeaf" value=" instead of "/>
                        <children xsi:type="mathematica:ASTNode" name="typeName">
                          <children xsi:type="mathematica:SymbolLeaf" name="typeFunction"/>
                        </children>
                        <children xsi:type="mathematica:StringLeaf" value=".&#xA;"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
                  </children>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
              </children>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="binaryTypeCheck"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="binaryTypeCheck">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="system"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="expr"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="crntType1"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="crntType2"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="typeFunction"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="Symbol"/>
            </children>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="With">
        <children xsi:type="mathematica:BuiltInNode" keyword="List">
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="res"/>
            <children xsi:type="mathematica:ASTNode" name="matchTypes">
              <children xsi:type="mathematica:SymbolLeaf" name="crntType1"/>
              <children xsi:type="mathematica:SymbolLeaf" name="crntType2"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:ASTNode" name="If">
          <children xsi:type="mathematica:ASTNode" name="And">
            <children xsi:type="mathematica:ASTNode" name="UnsameQ">
              <children xsi:type="mathematica:SymbolLeaf" name="crntType1"/>
              <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="UnsameQ">
              <children xsi:type="mathematica:SymbolLeaf" name="crntType2"/>
              <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="If">
            <children xsi:type="mathematica:ASTNode" name="UnsameQ">
              <children xsi:type="mathematica:ASTNode" name="typeFunction">
                <children xsi:type="mathematica:SymbolLeaf" name="res"/>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="res"/>
            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
              <children xsi:type="mathematica:ASTNode" name="Print">
                <children xsi:type="mathematica:StringLeaf" value="ERROR: Type mismatch in :"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="ashow">
                <children xsi:type="mathematica:SymbolLeaf" name="expr"/>
                <children xsi:type="mathematica:ASTNode" name="Part">
                  <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="Print">
                <children xsi:type="mathematica:ASTNode" name="StringJoin">
                  <children xsi:type="mathematica:StringLeaf" value="Expression is ("/>
                  <children xsi:type="mathematica:ASTNode" name="ToString">
                    <children xsi:type="mathematica:SymbolLeaf" name="crntType1"/>
                  </children>
                  <children xsi:type="mathematica:StringLeaf" value=","/>
                  <children xsi:type="mathematica:ASTNode" name="ToString">
                    <children xsi:type="mathematica:SymbolLeaf" name="crntType2"/>
                  </children>
                  <children xsi:type="mathematica:StringLeaf" value=") instead of ("/>
                  <children xsi:type="mathematica:ASTNode" name="typeName">
                    <children xsi:type="mathematica:SymbolLeaf" name="typeFunction"/>
                  </children>
                  <children xsi:type="mathematica:StringLeaf" value=","/>
                  <children xsi:type="mathematica:ASTNode" name="typeName">
                    <children xsi:type="mathematica:SymbolLeaf" name="typeFunction"/>
                  </children>
                  <children xsi:type="mathematica:StringLeaf" value=").&#xA;"/>
                </children>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
            </children>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="externalTypeCheck"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="externalTypeCheck">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="system"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="name"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="dcltypes"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="args"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="With">
            <children xsi:type="mathematica:BuiltInNode" keyword="List">
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="matchQ"/>
                <children xsi:type="mathematica:ASTNode" name="Function">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:SymbolLeaf" name="dcl"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="arg"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="If">
                    <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                      <children xsi:type="mathematica:ASTNode" name="matchTypes">
                        <children xsi:type="mathematica:SymbolLeaf" name="dcl"/>
                        <children xsi:type="mathematica:ASTNode" name="expType">
                          <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="arg"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                      <children xsi:type="mathematica:ASTNode" name="Print">
                        <children xsi:type="mathematica:StringLeaf" value="ERROR: "/>
                        <children xsi:type="mathematica:StringLeaf" value="type mismatch for parameter "/>
                        <children xsi:type="mathematica:ASTNode" name="sprint">
                          <children xsi:type="mathematica:SymbolLeaf" name="arg"/>
                        </children>
                        <children xsi:type="mathematica:StringLeaf" value=" in external operator "/>
                        <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                        <children xsi:type="mathematica:StringLeaf" value=" call (expected "/>
                        <children xsi:type="mathematica:SymbolLeaf" name="dcl"/>
                        <children xsi:type="mathematica:StringLeaf" value=")"/>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                    </children>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="dcllen"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="dcltypes"/>
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="argslen"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                  <children xsi:type="mathematica:SymbolLeaf" name="args"/>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="If">
              <children xsi:type="mathematica:ASTNode" name="Equal">
                <children xsi:type="mathematica:SymbolLeaf" name="dcllen"/>
                <children xsi:type="mathematica:SymbolLeaf" name="argslen"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="If">
                <children xsi:type="mathematica:ASTNode" name="Apply">
                  <children xsi:type="mathematica:SymbolLeaf" name="And"/>
                  <children xsi:type="mathematica:ASTNode" name="MapThread">
                    <children xsi:type="mathematica:SymbolLeaf" name="matchQ"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:ASTNode" name="Part">
                        <children xsi:type="mathematica:SymbolLeaf" name="dcltypes"/>
                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="args"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Part">
                  <children xsi:type="mathematica:SymbolLeaf" name="dcltypes"/>
                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                <children xsi:type="mathematica:ASTNode" name="Print">
                  <children xsi:type="mathematica:StringLeaf" value="ERROR: "/>
                  <children xsi:type="mathematica:StringLeaf" value="external operator "/>
                  <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                  <children xsi:type="mathematica:StringLeaf" value=" called with "/>
                  <children xsi:type="mathematica:SymbolLeaf" name="argslen"/>
                  <children xsi:type="mathematica:StringLeaf" value=" arguments instead of "/>
                  <children xsi:type="mathematica:SymbolLeaf" name="dcllen"/>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="bottom"/>
              </children>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="expType"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:ASTNode" name="expType">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                <children xsi:type="mathematica:SymbolLeaf" name="String"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="expType"/>
          <children xsi:type="mathematica:ASTNode" name="readExp">
            <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
            <children xsi:type="mathematica:ASTNode" name="Part"/>
            <children xsi:type="mathematica:IntLeaf" value="2"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="expType">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
          </children>
        </children>
        <children xsi:type="mathematica:ASTNode" name="expType"/>
        <children xsi:type="mathematica:ASTNode" name="getPart"/>
        <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="expType">
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
      </children>
    </children>
    <children xsi:type="mathematica:ASTNode" name="expType"/>
    <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
  </children>
</mathematica:BuiltInNode>
