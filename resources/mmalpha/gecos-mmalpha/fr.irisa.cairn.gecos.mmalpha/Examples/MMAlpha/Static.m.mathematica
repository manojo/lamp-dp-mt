<?xml version="1.0" encoding="ASCII"?>
<mathematica:BuiltInNode xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mathematica="http://www.irisa.fr/cairn/model/xtext/Mathematica" keyword="Protect">
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="BeginPackage">
          <children xsi:type="mathematica:StringLeaf" value="Alpha`Static`"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Domlib`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Options`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Matrix`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Tables`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Semantics`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Substitution`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Normalization`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Properties`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`ChangeOfBasis`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`SubSystems`"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="Static"/>
          <children xsi:type="mathematica:StringLeaf" value="usage"/>
        </children>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="The Static package contains functions for the &#xA;static analysis of Alpha programs. This functions are: analyze, dep,&#xA;dep1, checkUseful."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="analyze"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="analyze[] performs a static analysis of $results, and returns True if&#xA;the analysis is successful (even with warnings), False otherwise.&#xA;analyze[sys] performs a static analysis of sys and returns True if the&#xA;analysis is successful (even with warnings), False otherwise. The&#xA;analyze function has options verbose, recurse, library and&#xA;scalarTypeCheck (see Options[analyze]). Option verbose (Boolean;&#xA;default True) reports analysis progress.  Option recurse (Boolean;&#xA;defaut False) recursively looks up for all the subsystems involved and&#xA;analyzes them, too.  Option library (List; default $library) gives the&#xA;library to search for subsystems.  Example of option usage :&#xA;analyze[\{recurse->True, verbose->False\}]"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="analyze"/>
        <children xsi:type="mathematica:StringLeaf" value="WrongOptions"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="options must be False or True."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="analyze"/>
        <children xsi:type="mathematica:StringLeaf" value="ERROR"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="`1`"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="dep[] generates a dependency table for $result.  dep[sys] generates a&#xA;dependency table for sys.  The form of the table is: dtable[{ depend[&#xA;Domain, LHS_var_name, RHS_var_name, Matrix, RHS_var_domain], depend[&#xA;Domain, LHS_var_name, RHS_var_name, Matrix, RHS_var_domain],&#xA;. . . \]. The table may be pretty--printed using show[dep[]]."/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="dep1"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:StringLeaf" value="dep1[sys_, {occur:{_Integer..}, occurs___}] generates dependency&#xA;table entries for each occurrence in the list. Used by dep[] to&#xA;generate the dependency table."/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="checkUseful"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="checkUseful[sys, var] checks that the variable var is used in the&#xA;system sys for all the points of its domain; checkUseful[var] checks&#xA;that the variable var is used in $result.  checkUseful[sys] applies to&#xA;all the variables of sys.  checkUseful[] applies to all variables of&#xA;$result."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="checkDeclarations"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value=" chk decl"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="buildLHSIdList"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="buildLHSIdList"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="buildRHSIdList"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="buildRHSIdList"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
      <children xsi:type="mathematica:ASTNode" name="Begin">
        <children xsi:type="mathematica:StringLeaf" value="`Private`"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
        <children xsi:type="mathematica:SymbolLeaf" name="analyze"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:ASTNode" name="Options">
        <children xsi:type="mathematica:SymbolLeaf" name="analyze"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
              <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
              <children xsi:type="mathematica:SymbolLeaf" name="True"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
              <children xsi:type="mathematica:SymbolLeaf" name="recurse"/>
              <children xsi:type="mathematica:SymbolLeaf" name="False"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
              <children xsi:type="mathematica:SymbolLeaf" name="library"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
              <children xsi:type="mathematica:SymbolLeaf" name="scalarTypeCheck"/>
              <children xsi:type="mathematica:SymbolLeaf" name="False"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
              <children xsi:type="mathematica:SymbolLeaf" name="checkSubSystems"/>
              <children xsi:type="mathematica:SymbolLeaf" name="True"/>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="analyze"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="analyze"/>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="analyze">
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
          <children xsi:type="mathematica:SymbolLeaf" name="system"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:ASTNode" name="analyze">
      <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="analyze"/>
    <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
  </children>
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:ASTNode" name="Print">
      <children xsi:type="mathematica:StringLeaf" value="Analysis not possible."/>
    </children>
  </children>
</mathematica:BuiltInNode>
