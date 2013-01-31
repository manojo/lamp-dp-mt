<?xml version="1.0" encoding="ASCII"?>
<mathematica:BuiltInNode xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mathematica="http://www.irisa.fr/cairn/model/xtext/Mathematica" keyword="Protect">
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="BeginPackage">
          <children xsi:type="mathematica:StringLeaf" value="Alpha`SubSystems`"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Domlib`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Options`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Matrix`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Tables`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Semantics`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Substitution`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Normalization`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Cut`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`ChangeOfBasis`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Visual`"/>
          </children>
        </children>
        <children xsi:type="mathematica:ASTNode" name="Options">
          <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="List">
        <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
          <children xsi:type="mathematica:SymbolLeaf" name="debug"/>
          <children xsi:type="mathematica:SymbolLeaf" name="False"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="spread[ var, index ] replaces var in system $result by a set of&#xA;variables varI, where I is in the range of index of var"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="SubSystems"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="Package. Contains fonctions for subsystem&#xA;manipulations: inlineSubsystem, inlineAll, removeIdEqus,&#xA;assignParameterValue, fixParameter"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="underscore"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:StringLeaf" value="option of inlineSubsystem and inlineAll (Boolean). When True&#xA;(default), new identifier separator is _, whereas it is X otherwise"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
        <children xsi:type="mathematica:StringLeaf" value="NoSSInLib"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="declaration of `1` not found in library."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
        <children xsi:type="mathematica:StringLeaf" value="NoSuchOcc"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="occurrence `1` of `2` does not exist."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
        <children xsi:type="mathematica:StringLeaf" value="WrongParamNumber"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="subsystem `1` has `2` parameters, `3` are assigned."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
        <children xsi:type="mathematica:StringLeaf" value="Stx"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="Syntax is inlineSubsystem[name_String, options_:List ]"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="inlineSubsystem[name,{options}] searches the current system (see&#xA;option : caller) for a use statement of the subsystem name, and&#xA;replaces this use statement with its definition extracted from the&#xA;library, with proper variable renaming and parameter instanciation.&#xA;Returns the modified system if no error, the caller otherwise.  Side&#xA;effect: if the &quot;current&quot; option is set, sets Alpha`$program to the&#xA;previous Alpha`$result and sets Alpha`$result to the returned value.&#xA;Options are occurence, rename, renameCounter, verbose, caller,&#xA;library, and current (default options in Options[inlineSubsystem])."/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
              <children xsi:type="mathematica:StringLeaf" value="qv"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="functions : getSystem&#xA;variable : inliningRenameCounter"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="inlineAll"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value="inlineAll[{options}] inlines all the subsystems of system $result.&#xA;Options are rename, renameCounter, verbose, caller, library, and current.&#xA;(see Options[inLineAll] for default values)."/>
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="library"/>
                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                </children>
              </children>
              <children xsi:type="mathematica:StringLeaf" value="library is an Option of inlineAll and inlineSubsystem.  &#xA;library -> list of Alpha`system&#xA;(default $library) specifies the list of systems to search for a&#xA;subsystem. When more than one declaration of the same system appear in&#xA;the library, the first one is inlined."/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="assignParameterValue"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="assignParameterValue[param_String,value_Integer,sys_Ast]&#xA; Gives the&#xA;value `value' to the parameter `param' the Alpha system `sys' and&#xA;returns the modified&#xA;system. assignParameterValue[param_String,value_Integer] assign the &#xA;value of `param' in $result."/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="assignParameterValueLib"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="see fixParameter"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="fixParameter"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="fixParameter[param_String,value_Integer,systName_String]&#xA;  Function. Gives a value to a parameter in an Alpha system of name&#xA;  &quot;systName&quot; and in the call to &quot;systName&quot; in $library.  returns&#xA;  the new library (list of Alpha system) and affect $library (except&#xA;  if $library is explicitely specified as the 4th parameter). if the&#xA;  system name is ommited, the function fix the parameter in all the&#xA;  program of $library and in $result.WARNING: currently, this function&#xA;  suppose that the parameter &quot;param&quot; has the same value every where,&#xA;  you also have to ensure that $result is the top calling system of&#xA;  the library (i.e. the module in an AlpHard program)"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="inliningRenameCounter"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value="Variable. Holds the counter value used to avoid name conflicts &#xA;while renaming the variables."/>
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="removeIdEqus"/>
                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                </children>
              </children>
              <children xsi:type="mathematica:StringLeaf" value="removeIdEqus[] removes equations of the form A=B in $result introduced&#xA;for example by the inlineSubsystem and inlineAll transformations. &#xA;removeIdEqus[sys] removes the silly equation of sys and returns the&#xA;transformed system. Warning, this function does not normalize the&#xA;system, unless option norm -> True is used. removeIdEqus has&#xA;options norm, allLibrary and inputEquations."/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="substDom"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="substDom[ dom_Alpha`domain,&#xA;extensionDom_Alpha`domain, parameterAssignation_Alpha`matrix, &#xA;numberOfSubSystemParameters_Integer]&#xA;&#xA;Function. Computes the transformation of a domain&#xA;in a subsystem inlining. For internal use only"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="subSystemUsedBy"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="subSystemUsedBy[sys_Alpha`system] returns the list&#xA;of names of subsystems used by system `sys' (default $result)"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="topoSort"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:StringLeaf" value="topoSort[lib:{__system}] returns the list of system&#xA;names of library lib, sorted in the reverse hierachical order, i.e. if&#xA;a system A uses a system B and a system C, topoSort returns {B, C, &#xA;A} or {C, B, A}"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="simplifyUseInputs"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:StringLeaf" value="simplifyUseInputs[sys:_Alpha`system] adds &#xA; local `buffer' variables  for each input which is not already a simple variable (input to a use may be any expression), the new variable is defined on the 'real domain' of the expression: its context domain intersected with its use domain."/>
        <children xsi:type="mathematica:ASTNode" name="Begin">
          <children xsi:type="mathematica:StringLeaf" value="`Private`"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
        <children xsi:type="mathematica:StringLeaf" value="wrgvar"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="`1` is not a local var of the current system"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
        <children xsi:type="mathematica:StringLeaf" value="errorProj"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="error while calling DomProject"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
        <children xsi:type="mathematica:StringLeaf" value="wrgindex"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="`1` is not an index of variable `2`"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
        <children xsi:type="mathematica:StringLeaf" value="domUnbounded"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="projected domain appears unbounded"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
        <children xsi:type="mathematica:StringLeaf" value="errorCut"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="error while calling the cut function"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
        <children xsi:type="mathematica:StringLeaf" value="errorCob"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="error while calling the changeOfBasis function"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="spread">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="var"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="indexProj"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
          <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
            <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
          </children>
        </children>
        <children xsi:type="mathematica:ASTNode" name="Catch">
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Module">
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                <children xsi:type="mathematica:SymbolLeaf" name="dproj"/>
                <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                <children xsi:type="mathematica:SymbolLeaf" name="indexes"/>
                <children xsi:type="mathematica:SymbolLeaf" name="varBefore"/>
                <children xsi:type="mathematica:SymbolLeaf" name="minval"/>
                <children xsi:type="mathematica:SymbolLeaf" name="maxval"/>
                <children xsi:type="mathematica:SymbolLeaf" name="varAfter"/>
                <children xsi:type="mathematica:SymbolLeaf" name="varRest"/>
                <children xsi:type="mathematica:SymbolLeaf" name="cob1"/>
                <children xsi:type="mathematica:SymbolLeaf" name="cob2"/>
                <children xsi:type="mathematica:SymbolLeaf" name="stIndexes"/>
                <children xsi:type="mathematica:SymbolLeaf" name="curval"/>
                <children xsi:type="mathematica:SymbolLeaf" name="stcurval"/>
                <children xsi:type="mathematica:SymbolLeaf" name="remIndexes"/>
                <children xsi:type="mathematica:SymbolLeaf" name="bb"/>
                <children xsi:type="mathematica:SymbolLeaf" name="c"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="Not">
                    <children xsi:type="mathematica:ASTNode" name="MemberQ">
                      <children xsi:type="mathematica:ASTNode" name="getLocalVars"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="var"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Throw">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
                        <children xsi:type="mathematica:StringLeaf" value="wrgvar"/>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="var"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Check">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                    <children xsi:type="mathematica:ASTNode" name="getDeclarationDomain">
                      <children xsi:type="mathematica:SymbolLeaf" name="var"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Throw">
                    <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="Domain of variable "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="var"/>
                    <children xsi:type="mathematica:StringLeaf" value=" is "/>
                    <children xsi:type="mathematica:ASTNode" name="show">
                      <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                        <children xsi:type="mathematica:SymbolLeaf" name="silent"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Check">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="dproj"/>
                    <children xsi:type="mathematica:ASTNode" name="DomProject">
                      <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                        <children xsi:type="mathematica:SymbolLeaf" name="indexProj"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Throw">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
                        <children xsi:type="mathematica:StringLeaf" value="errorProj"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Check">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="bb"/>
                    <children xsi:type="mathematica:ASTNode" name="getBoundingBox">
                      <children xsi:type="mathematica:SymbolLeaf" name="dproj"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Throw">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
                        <children xsi:type="mathematica:StringLeaf" value="errorbb"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="Enclosing box is: "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="bb"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:SymbolLeaf" name="minval"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="maxval"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="bb"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="Or">
                    <children xsi:type="mathematica:ASTNode" name="Equal">
                      <children xsi:type="mathematica:SymbolLeaf" name="minval"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                        <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="Infinity"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Equal">
                      <children xsi:type="mathematica:SymbolLeaf" name="maxval"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="Infinity"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Throw">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
                        <children xsi:type="mathematica:StringLeaf" value="domUnbounded"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="indexes"/>
                  <children xsi:type="mathematica:ASTNode" name="If">
                    <children xsi:type="mathematica:ASTNode" name="SameQ">
                      <children xsi:type="mathematica:ASTNode" name="Head">
                        <children xsi:type="mathematica:ASTNode" name="Part">
                          <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                          <children xsi:type="mathematica:IntLeaf" value="3"/>
                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="pol"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                      <children xsi:type="mathematica:IntLeaf" value="2"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                      <children xsi:type="mathematica:IntLeaf" value="3"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                      <children xsi:type="mathematica:IntLeaf" value="3"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="Not">
                    <children xsi:type="mathematica:ASTNode" name="MemberQ">
                      <children xsi:type="mathematica:SymbolLeaf" name="indexes"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="indexProj"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Throw">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
                        <children xsi:type="mathematica:StringLeaf" value="wrgindex"/>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="indexProj"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="var"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="stIndexes"/>
                  <children xsi:type="mathematica:ASTNode" name="StringJoin">
                    <children xsi:type="mathematica:ASTNode" name="StringDrop">
                      <children xsi:type="mathematica:ASTNode" name="ToString">
                        <children xsi:type="mathematica:SymbolLeaf" name="indexes"/>
                      </children>
                      <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                    </children>
                    <children xsi:type="mathematica:StringLeaf" value="|"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="Projected domain is "/>
                    <children xsi:type="mathematica:ASTNode" name="show">
                      <children xsi:type="mathematica:SymbolLeaf" name="dproj"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                        <children xsi:type="mathematica:SymbolLeaf" name="silent"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="varRest"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="var"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="remIndexes"/>
                  <children xsi:type="mathematica:ASTNode" name="Complement">
                    <children xsi:type="mathematica:SymbolLeaf" name="indexes"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:SymbolLeaf" name="indexProj"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:ASTNode" name="Print">
                      <children xsi:type="mathematica:SymbolLeaf" name="indexes"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Print">
                      <children xsi:type="mathematica:SymbolLeaf" name="remIndexes"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="For">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="curval"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="maxval"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Greater">
                    <children xsi:type="mathematica:SymbolLeaf" name="curval"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="minval"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Decrement">
                    <children xsi:type="mathematica:SymbolLeaf" name="curval"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="stcurval"/>
                      <children xsi:type="mathematica:ASTNode" name="ToString">
                        <children xsi:type="mathematica:SymbolLeaf" name="curval"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="varBefore"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="varRest"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="varAfter"/>
                      <children xsi:type="mathematica:ASTNode" name="StringJoin">
                        <children xsi:type="mathematica:SymbolLeaf" name="var"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="stcurval"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="varRest"/>
                      <children xsi:type="mathematica:ASTNode" name="StringJoin">
                        <children xsi:type="mathematica:SymbolLeaf" name="varAfter"/>
                        <children xsi:type="mathematica:StringLeaf" value="rest"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Check">
                      <children xsi:type="mathematica:ASTNode" name="cut">
                        <children xsi:type="mathematica:SymbolLeaf" name="varBefore"/>
                        <children xsi:type="mathematica:ASTNode" name="StringJoin">
                          <children xsi:type="mathematica:SymbolLeaf" name="stIndexes"/>
                          <children xsi:type="mathematica:ASTNode" name="ToString">
                            <children xsi:type="mathematica:SymbolLeaf" name="indexProj"/>
                          </children>
                          <children xsi:type="mathematica:StringLeaf" value="="/>
                          <children xsi:type="mathematica:SymbolLeaf" name="stcurval"/>
                          <children xsi:type="mathematica:StringLeaf" value="}"/>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="varAfter"/>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:ASTNode" name="Equal">
                            <children xsi:type="mathematica:SymbolLeaf" name="curval"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                              <children xsi:type="mathematica:SymbolLeaf" name="minval"/>
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="StringJoin">
                            <children xsi:type="mathematica:SymbolLeaf" name="var"/>
                            <children xsi:type="mathematica:ASTNode" name="ToString">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                <children xsi:type="mathematica:SymbolLeaf" name="curval"/>
                                <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="varRest"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Throw">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                            <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
                            <children xsi:type="mathematica:StringLeaf" value="errorCut"/>
                          </children>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="cob1"/>
                      <children xsi:type="mathematica:ASTNode" name="StringJoin">
                        <children xsi:type="mathematica:SymbolLeaf" name="varAfter"/>
                        <children xsi:type="mathematica:StringLeaf" value=".("/>
                        <children xsi:type="mathematica:ASTNode" name="StringTake">
                          <children xsi:type="mathematica:ASTNode" name="ToString">
                            <children xsi:type="mathematica:SymbolLeaf" name="indexes"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                            <children xsi:type="mathematica:IntLeaf" signed="-" value="2"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:StringLeaf" value="->"/>
                        <children xsi:type="mathematica:ASTNode" name="StringTake">
                          <children xsi:type="mathematica:ASTNode" name="ToString">
                            <children xsi:type="mathematica:SymbolLeaf" name="remIndexes"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                            <children xsi:type="mathematica:IntLeaf" signed="-" value="2"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:StringLeaf" value=")"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="If">
                      <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                      <children xsi:type="mathematica:ASTNode" name="Print">
                        <children xsi:type="mathematica:ASTNode" name="StringJoin">
                          <children xsi:type="mathematica:StringLeaf" value="Calling cob[ "/>
                          <children xsi:type="mathematica:SymbolLeaf" name="cob1"/>
                          <children xsi:type="mathematica:StringLeaf" value=" ,"/>
                          <children xsi:type="mathematica:ASTNode" name="ToString">
                            <children xsi:type="mathematica:SymbolLeaf" name="remIndexes"/>
                          </children>
                          <children xsi:type="mathematica:StringLeaf" value=" ]"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Check">
                      <children xsi:type="mathematica:ASTNode" name="changeOfBasis">
                        <children xsi:type="mathematica:SymbolLeaf" name="cob1"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="remIndexes"/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Throw">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                            <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
                            <children xsi:type="mathematica:StringLeaf" value="errorCob"/>
                          </children>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="cob1"/>
                  <children xsi:type="mathematica:ASTNode" name="StringJoin">
                    <children xsi:type="mathematica:SymbolLeaf" name="var"/>
                    <children xsi:type="mathematica:ASTNode" name="ToString">
                      <children xsi:type="mathematica:SymbolLeaf" name="curval"/>
                    </children>
                    <children xsi:type="mathematica:StringLeaf" value=".("/>
                    <children xsi:type="mathematica:ASTNode" name="StringTake">
                      <children xsi:type="mathematica:ASTNode" name="ToString">
                        <children xsi:type="mathematica:SymbolLeaf" name="indexes"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                        <children xsi:type="mathematica:IntLeaf" signed="-" value="2"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:StringLeaf" value="->"/>
                    <children xsi:type="mathematica:ASTNode" name="StringTake">
                      <children xsi:type="mathematica:ASTNode" name="ToString">
                        <children xsi:type="mathematica:SymbolLeaf" name="remIndexes"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                        <children xsi:type="mathematica:IntLeaf" signed="-" value="2"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:StringLeaf" value=")"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Check">
                  <children xsi:type="mathematica:ASTNode" name="changeOfBasis">
                    <children xsi:type="mathematica:SymbolLeaf" name="cob1"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="remIndexes"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Throw">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
                        <children xsi:type="mathematica:StringLeaf" value="errorCob"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="normalize"/>
                <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
              </children>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:ASTNode" name="spread">
          <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Message">
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
            <children xsi:type="mathematica:StringLeaf" value="wrgparams"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="spread"/>
          <children xsi:type="mathematica:StringLeaf" value="wrgparams"/>
        </children>
        <children xsi:type="mathematica:StringLeaf" value="spread called with wrong parameters"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="substDom"/>
          <children xsi:type="mathematica:StringLeaf" value="usage"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="substDom[ dom_Alpha`domain,&#xA;extensionDom_Alpha`domain, parameterAssignation_Alpha`matrix, &#xA;numberOfSubSystemParameters_Integer]&#xA;&#xA;Function. Computes the transformation of a domain&#xA;in a subsystem inlining. For internal use only"/>
            <children xsi:type="mathematica:SymbolLeaf" name="inliningRenameCounter"/>
          </children>
          <children xsi:type="mathematica:IntLeaf" value="1"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
            <children xsi:type="mathematica:SymbolLeaf" name="buildIdList"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="buildIdList">
            <children xsi:type="mathematica:ASTNode" name="system">
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="sysName"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                  <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="paramSpace"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                  <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="inVars"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="outVars"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="localVars"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="equations"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:ASTNode" name="Join">
                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                        <children xsi:type="mathematica:SymbolLeaf" name="sysName"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                        <children xsi:type="mathematica:ASTNode" name="Function">
                          <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="inVars"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                        <children xsi:type="mathematica:ASTNode" name="Function">
                          <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="outVars"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                        <children xsi:type="mathematica:ASTNode" name="Function">
                          <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="localVars"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="buildIdList">
                      <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                        <children xsi:type="mathematica:ASTNode" name="Print">
                          <children xsi:type="mathematica:StringLeaf" value="Problem in buildIdList&#xA;"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                        <children xsi:type="mathematica:SymbolLeaf" name="isUse"/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="isUse">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                          <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="equation">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                              <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                        <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                        <children xsi:type="mathematica:ASTNode" name="isUse">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                              <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="use">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                              <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                              <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                              <children xsi:type="mathematica:SymbolLeaf" name="pAss"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                              <children xsi:type="mathematica:SymbolLeaf" name="arg"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="retVar"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                </children>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                            <children xsi:type="mathematica:ASTNode" name="Equal">
                              <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                <children xsi:type="mathematica:ASTNode" name="isUse">
                                  <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                  <children xsi:type="mathematica:ASTNode" name="Print">
                                    <children xsi:type="mathematica:StringLeaf" value="Problem in isUse&#xA;"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                  <children xsi:type="mathematica:SymbolLeaf" name="splitEquList"/>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="splitEquList">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                    <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                      <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                      <children xsi:type="mathematica:SymbolLeaf" name="equs1"/>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                      <children xsi:type="mathematica:SymbolLeaf" name="occ"/>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                        <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                      </children>
                                    </children>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                      <children xsi:type="mathematica:ASTNode" name="Print">
                                        <children xsi:type="mathematica:StringLeaf" value="Error : Bug in finUse2"/>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                        <children xsi:type="mathematica:SymbolLeaf" name="equs1"/>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:ASTNode" name="splitEquList">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                        <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                          <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                          <children xsi:type="mathematica:SymbolLeaf" name="equs1"/>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                          </children>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                            <children xsi:type="mathematica:SymbolLeaf" name="equs2"/>
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                            </children>
                                          </children>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                            <children xsi:type="mathematica:SymbolLeaf" name="occ"/>
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                            </children>
                                          </children>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                          <children xsi:type="mathematica:ASTNode" name="If">
                                            <children xsi:type="mathematica:ASTNode" name="isUse">
                                              <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                                              <children xsi:type="mathematica:ASTNode" name="First">
                                                <children xsi:type="mathematica:SymbolLeaf" name="equs2"/>
                                              </children>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="If">
                                              <children xsi:type="mathematica:ASTNode" name="Equal">
                                                <children xsi:type="mathematica:SymbolLeaf" name="occ"/>
                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                              </children>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                <children xsi:type="mathematica:SymbolLeaf" name="equs1"/>
                                                <children xsi:type="mathematica:ASTNode" name="Rest">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="equs2"/>
                                                </children>
                                              </children>
                                              <children xsi:type="mathematica:ASTNode" name="splitEquList">
                                                <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                  <children xsi:type="mathematica:ASTNode" name="Append">
                                                    <children xsi:type="mathematica:SymbolLeaf" name="equs1"/>
                                                    <children xsi:type="mathematica:ASTNode" name="First">
                                                      <children xsi:type="mathematica:SymbolLeaf" name="equs2"/>
                                                    </children>
                                                  </children>
                                                  <children xsi:type="mathematica:ASTNode" name="Rest">
                                                    <children xsi:type="mathematica:SymbolLeaf" name="equs2"/>
                                                  </children>
                                                </children>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="occ"/>
                                                  <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                </children>
                                              </children>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="splitEquList">
                                              <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                <children xsi:type="mathematica:ASTNode" name="Append">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="equs1"/>
                                                  <children xsi:type="mathematica:ASTNode" name="First">
                                                    <children xsi:type="mathematica:SymbolLeaf" name="equs2"/>
                                                  </children>
                                                </children>
                                                <children xsi:type="mathematica:ASTNode" name="Rest">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="equs2"/>
                                                </children>
                                              </children>
                                              <children xsi:type="mathematica:SymbolLeaf" name="occ"/>
                                            </children>
                                          </children>
                                          <children xsi:type="mathematica:ASTNode" name="splitEquList">
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                              <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                            </children>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                              <children xsi:type="mathematica:ASTNode" name="Print">
                                                <children xsi:type="mathematica:StringLeaf" value="Problem in SubSystems`splitEquList"/>
                                              </children>
                                            </children>
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                              <children xsi:type="mathematica:SymbolLeaf" name="addColumns"/>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="addColumns">
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                </children>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="size"/>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                    <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                  </children>
                                                </children>
                                              </children>
                                            </children>
                                            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                <children xsi:type="mathematica:ASTNode" name="Transpose">
                                                  <children xsi:type="mathematica:ASTNode" name="Join">
                                                    <children xsi:type="mathematica:ASTNode" name="Array">
                                                      <children xsi:type="mathematica:ASTNode" name="Function">
                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                          <children xsi:type="mathematica:ASTNode" name="Equal">
                                                            <children xsi:type="mathematica:ASTNode" name="Slot">
                                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                            </children>
                                                            <children xsi:type="mathematica:ASTNode" name="Slot">
                                                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                            </children>
                                                          </children>
                                                          <children xsi:type="mathematica:IntLeaf"/>
                                                          <children xsi:type="mathematica:IntLeaf"/>
                                                        </children>
                                                      </children>
                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                        <children xsi:type="mathematica:SymbolLeaf" name="size"/>
                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                          <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                        </children>
                                                      </children>
                                                    </children>
                                                    <children xsi:type="mathematica:ASTNode" name="Transpose">
                                                      <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                    </children>
                                                  </children>
                                                </children>
                                                <children xsi:type="mathematica:ASTNode" name="addColumns">
                                                  <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                </children>
                                              </children>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                    <children xsi:type="mathematica:ASTNode" name="Print">
                                                      <children xsi:type="mathematica:StringLeaf" value="Problem in addColumns&#xA;"/>
                                                    </children>
                                                  </children>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                    <children xsi:type="mathematica:SymbolLeaf" name="matExtHom"/>
                                                  </children>
                                                  <children xsi:type="mathematica:ASTNode" name="matExtHom">
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                      <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                      </children>
                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                        <children xsi:type="mathematica:SymbolLeaf" name="size"/>
                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                          <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                        </children>
                                                      </children>
                                                    </children>
                                                  </children>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                      <children xsi:type="mathematica:ASTNode" name="Join">
                                                        <children xsi:type="mathematica:ASTNode" name="Array">
                                                          <children xsi:type="mathematica:ASTNode" name="Function">
                                                            <children xsi:type="mathematica:ASTNode" name="If">
                                                              <children xsi:type="mathematica:ASTNode" name="Equal">
                                                                <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                </children>
                                                                <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                </children>
                                                              </children>
                                                              <children xsi:type="mathematica:ASTNode" name="Last">
                                                                <children xsi:type="mathematica:ASTNode" name="Last">
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                </children>
                                                              </children>
                                                              <children xsi:type="mathematica:IntLeaf"/>
                                                            </children>
                                                          </children>
                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                            <children xsi:type="mathematica:SymbolLeaf" name="size"/>
                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                              <children xsi:type="mathematica:SymbolLeaf" name="size"/>
                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                </children>
                                                              </children>
                                                            </children>
                                                          </children>
                                                        </children>
                                                        <children xsi:type="mathematica:ASTNode" name="addColumns">
                                                          <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                          <children xsi:type="mathematica:SymbolLeaf" name="size"/>
                                                        </children>
                                                      </children>
                                                      <children xsi:type="mathematica:ASTNode" name="matExtHom">
                                                        <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                      </children>
                                                    </children>
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                          <children xsi:type="mathematica:ASTNode" name="Print">
                                                            <children xsi:type="mathematica:StringLeaf" value="Problem in matExtHom&#xA;"/>
                                                          </children>
                                                        </children>
                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                          <children xsi:type="mathematica:SymbolLeaf" name="affExtHom"/>
                                                        </children>
                                                        <children xsi:type="mathematica:ASTNode" name="affExtHom">
                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                            <children xsi:type="mathematica:SymbolLeaf" name="fun"/>
                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                              <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                            </children>
                                                          </children>
                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                            <children xsi:type="mathematica:SymbolLeaf" name="ind"/>
                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                            </children>
                                                          </children>
                                                        </children>
                                                        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                            <children xsi:type="mathematica:ASTNode" name="Block">
                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                                                              </children>
                                                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="ind"/>
                                                                </children>
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                </children>
                                                                <children xsi:type="mathematica:ASTNode" name="While">
                                                                  <children xsi:type="mathematica:ASTNode" name="Less">
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Union">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                                                          <children xsi:type="mathematica:SymbolLeaf" name="fun"/>
                                                                          <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                        </children>
                                                                      </children>
                                                                    </children>
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                      <children xsi:type="mathematica:ASTNode" name="Join">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                                                          <children xsi:type="mathematica:SymbolLeaf" name="fun"/>
                                                                          <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                        </children>
                                                                      </children>
                                                                    </children>
                                                                  </children>
                                                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                                                        <children xsi:type="mathematica:ASTNode" name="Function">
                                                                          <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                                                                          <children xsi:type="mathematica:ASTNode" name="StringJoin">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                                                                            <children xsi:type="mathematica:StringLeaf" value="_"/>
                                                                            <children xsi:type="mathematica:ASTNode" name="ToString">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                                                                            </children>
                                                                          </children>
                                                                        </children>
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                      </children>
                                                                    </children>
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                                                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                      </children>
                                                                    </children>
                                                                  </children>
                                                                </children>
                                                                <children xsi:type="mathematica:ASTNode" name="matrix">
                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="fun"/>
                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                    </children>
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                    </children>
                                                                  </children>
                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="fun"/>
                                                                      <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                    </children>
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                    </children>
                                                                  </children>
                                                                  <children xsi:type="mathematica:ASTNode" name="Join">
                                                                    <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="fun"/>
                                                                      <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                    </children>
                                                                  </children>
                                                                  <children xsi:type="mathematica:ASTNode" name="matExtHom">
                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="fun"/>
                                                                      <children xsi:type="mathematica:IntLeaf" value="4"/>
                                                                    </children>
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                    </children>
                                                                  </children>
                                                                </children>
                                                              </children>
                                                            </children>
                                                            <children xsi:type="mathematica:ASTNode" name="affExtHom">
                                                              <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                            </children>
                                                          </children>
                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                <children xsi:type="mathematica:ASTNode" name="Print">
                                                                  <children xsi:type="mathematica:StringLeaf" value="Problem in affExtHom&#xA;"/>
                                                                </children>
                                                              </children>
                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                <children xsi:type="mathematica:SymbolLeaf" name="domExtHom"/>
                                                              </children>
                                                              <children xsi:type="mathematica:ASTNode" name="domExtHom">
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                    <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                                                                  </children>
                                                                </children>
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="ind"/>
                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                  </children>
                                                                </children>
                                                              </children>
                                                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                  <children xsi:type="mathematica:ASTNode" name="Block">
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="domidlst"/>
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                    </children>
                                                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="ind"/>
                                                                      </children>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                                                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                      </children>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="domidlst"/>
                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                          <children xsi:type="mathematica:ASTNode" name="SameQ">
                                                                            <children xsi:type="mathematica:ASTNode" name="Head">
                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                                <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="pol"/>
                                                                          </children>
                                                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                          </children>
                                                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                            <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                            <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                          </children>
                                                                        </children>
                                                                      </children>
                                                                      <children xsi:type="mathematica:ASTNode" name="While">
                                                                        <children xsi:type="mathematica:ASTNode" name="Less">
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Union">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="domidlst"/>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                            <children xsi:type="mathematica:ASTNode" name="Join">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="domidlst"/>
                                                                            </children>
                                                                          </children>
                                                                        </children>
                                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                                                              <children xsi:type="mathematica:ASTNode" name="Function">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                                                                                <children xsi:type="mathematica:ASTNode" name="StringJoin">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                                                                                  <children xsi:type="mathematica:StringLeaf" value="_"/>
                                                                                  <children xsi:type="mathematica:ASTNode" name="ToString">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                                                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                            </children>
                                                                          </children>
                                                                        </children>
                                                                      </children>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                        <children xsi:type="mathematica:ASTNode" name="matrix">
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                            </children>
                                                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                            </children>
                                                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                          </children>
                                                                          <children xsi:type="mathematica:ASTNode" name="Join">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:ASTNode" name="Array">
                                                                            <children xsi:type="mathematica:ASTNode" name="Function">
                                                                              <children xsi:type="mathematica:ASTNode" name="If">
                                                                                <children xsi:type="mathematica:ASTNode" name="Equal">
                                                                                  <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                                    <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                                    <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                                    </children>
                                                                                  </children>
                                                                                </children>
                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                <children xsi:type="mathematica:IntLeaf"/>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                              </children>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="indices"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                        </children>
                                                                      </children>
                                                                      <children xsi:type="mathematica:ASTNode" name="DomZPreimage">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                      </children>
                                                                    </children>
                                                                  </children>
                                                                  <children xsi:type="mathematica:ASTNode" name="domExtHom">
                                                                    <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                  </children>
                                                                </children>
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                      <children xsi:type="mathematica:ASTNode" name="Print">
                                                                        <children xsi:type="mathematica:StringLeaf" value="Problem in domExtHom&#xA;"/>
                                                                      </children>
                                                                    </children>
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="substDom"/>
                                                                    </children>
                                                                    <children xsi:type="mathematica:ASTNode" name="substDom">
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                      </children>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                      </children>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                      </children>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                          <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                        </children>
                                                                      </children>
                                                                    </children>
                                                                  </children>
                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                      <children xsi:type="mathematica:ASTNode" name="Block">
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                          <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                                                          <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                          <children xsi:type="mathematica:SymbolLeaf" name="idlst"/>
                                                                        </children>
                                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="idlst"/>
                                                                            <children xsi:type="mathematica:ASTNode" name="If">
                                                                              <children xsi:type="mathematica:ASTNode" name="SameQ">
                                                                                <children xsi:type="mathematica:ASTNode" name="Head">
                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                                    <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                  </children>
                                                                                </children>
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="pol"/>
                                                                              </children>
                                                                              <children xsi:type="mathematica:ASTNode" name="Drop">
                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                  <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:ASTNode" name="Drop">
                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                                  <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                  <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                  <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                            <children xsi:type="mathematica:ASTNode" name="affExtHom">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="idlst"/>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                                                            <children xsi:type="mathematica:ASTNode" name="DomZPreimage">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:ASTNode" name="DomIntersection">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                                                            <children xsi:type="mathematica:ASTNode" name="domExtHom">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="idlst"/>
                                                                            </children>
                                                                          </children>
                                                                        </children>
                                                                      </children>
                                                                      <children xsi:type="mathematica:ASTNode" name="substDom">
                                                                        <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                      </children>
                                                                    </children>
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                          <children xsi:type="mathematica:ASTNode" name="Print">
                                                                            <children xsi:type="mathematica:StringLeaf" value="Problem in substDom&#xA;"/>
                                                                          </children>
                                                                        </children>
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                          <children xsi:type="mathematica:SymbolLeaf" name="removeParameterId"/>
                                                                        </children>
                                                                        <children xsi:type="mathematica:ASTNode" name="removeParameterId">
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="nbParams"/>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                            </children>
                                                                          </children>
                                                                        </children>
                                                                      </children>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                          <children xsi:type="mathematica:ASTNode" name="matrix">
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                              </children>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="nbParams"/>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                            </children>
                                                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                              <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                            </children>
                                                                            <children xsi:type="mathematica:ASTNode" name="Append">
                                                                              <children xsi:type="mathematica:ASTNode" name="Drop">
                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                  <children xsi:type="mathematica:IntLeaf" value="4"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                    <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="nbParams"/>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:ASTNode" name="Last">
                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                  <children xsi:type="mathematica:IntLeaf" value="4"/>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:ASTNode" name="removeParameterId">
                                                                            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                          </children>
                                                                        </children>
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                              <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                <children xsi:type="mathematica:StringLeaf" value="Problem in removeParameterId&#xA;"/>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="addParameterId"/>
                                                                            </children>
                                                                            <children xsi:type="mathematica:ASTNode" name="addParameterId">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="nbParams"/>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                              <children xsi:type="mathematica:ASTNode" name="matrix">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="nbParams"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                  <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:ASTNode" name="Join">
                                                                                  <children xsi:type="mathematica:ASTNode" name="Drop">
                                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                      <children xsi:type="mathematica:IntLeaf" value="4"/>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="Array">
                                                                                    <children xsi:type="mathematica:ASTNode" name="Function">
                                                                                      <children xsi:type="mathematica:ASTNode" name="If">
                                                                                        <children xsi:type="mathematica:ASTNode" name="Equal">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                                            <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                                <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                              <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="nbParams"/>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="Last">
                                                                                          <children xsi:type="mathematica:ASTNode" name="Last">
                                                                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                              <children xsi:type="mathematica:IntLeaf" value="4"/>
                                                                                            </children>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:IntLeaf"/>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="nbParams"/>
                                                                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                            <children xsi:type="mathematica:IntLeaf" value="4"/>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:ASTNode" name="addParameterId">
                                                                                <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                  <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                    <children xsi:type="mathematica:StringLeaf" value="Problem in addParameterId&#xA;"/>
                                                                                  </children>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="substDep"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:ASTNode" name="substDep">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                    </children>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                  <children xsi:type="mathematica:ASTNode" name="If">
                                                                                    <children xsi:type="mathematica:ASTNode" name="Equal">
                                                                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                                                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:ASTNode" name="composeAffines">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                                                                      <children xsi:type="mathematica:ASTNode" name="affExtHom">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                                        <children xsi:type="mathematica:ASTNode" name="Drop">
                                                                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                                                                            <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                            <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                                          </children>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:ASTNode" name="addParameterId">
                                                                                      <children xsi:type="mathematica:ASTNode" name="composeAffines">
                                                                                        <children xsi:type="mathematica:ASTNode" name="removeParameterId">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="affExtHom">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                                          <children xsi:type="mathematica:ASTNode" name="Drop">
                                                                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                                                                              <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                              <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                                            </children>
                                                                                          </children>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                                          <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="substDep">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                  </children>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                    <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                      <children xsi:type="mathematica:StringLeaf" value="Problem in substDep&#xA;"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="substPAssgn"/>
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
                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                  <children xsi:type="mathematica:ASTNode" name="substPAssgn">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                      <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                        <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                      <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                        <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                      <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                        <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                      </children>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="composeAffines">
                                    <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                    <children xsi:type="mathematica:ASTNode" name="affExtHom">
                                      <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                      <children xsi:type="mathematica:ASTNode" name="Drop">
                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                          <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                          <children xsi:type="mathematica:IntLeaf" value="3"/>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                          <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                          <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                        </children>
                                      </children>
                                    </children>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                  <children xsi:type="mathematica:ASTNode" name="substPAssgn">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                      <children xsi:type="mathematica:ASTNode" name="Print">
                                        <children xsi:type="mathematica:StringLeaf" value="Problem in substPAssign&#xA;"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                      <children xsi:type="mathematica:SymbolLeaf" name="substDecl"/>
                                    </children>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                  <children xsi:type="mathematica:ASTNode" name="substDecl">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                      <children xsi:type="mathematica:SymbolLeaf" name="decla"/>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                      <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                        <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                      <children xsi:type="mathematica:SymbolLeaf" name="callerDecls"/>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                        <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                        <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                        <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                          <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                        <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                        <children xsi:type="mathematica:ASTNode" name="decl">
                                          <children xsi:type="mathematica:ASTNode" name="If">
                                            <children xsi:type="mathematica:ASTNode" name="MemberQ">
                                              <children xsi:type="mathematica:SymbolLeaf" name="callerDecls"/>
                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                <children xsi:type="mathematica:SymbolLeaf" name="decla"/>
                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                              </children>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                              <children xsi:type="mathematica:ASTNode" name="If">
                                                <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                <children xsi:type="mathematica:ASTNode" name="Print">
                                                  <children xsi:type="mathematica:StringLeaf" value="    Renaming variable "/>
                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                    <children xsi:type="mathematica:SymbolLeaf" name="decla"/>
                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                  </children>
                                                  <children xsi:type="mathematica:StringLeaf" value=" to "/>
                                                  <children xsi:type="mathematica:ASTNode" name="StringJoin">
                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                      <children xsi:type="mathematica:SymbolLeaf" name="decla"/>
                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                    </children>
                                                    <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                  </children>
                                                </children>
                                                <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                              </children>
                                              <children xsi:type="mathematica:ASTNode" name="StringJoin">
                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="decla"/>
                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                </children>
                                                <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                              </children>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                              <children xsi:type="mathematica:SymbolLeaf" name="decla"/>
                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                            </children>
                                          </children>
                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                            <children xsi:type="mathematica:SymbolLeaf" name="decla"/>
                                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                                          </children>
                                          <children xsi:type="mathematica:ASTNode" name="substDom">
                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                              <children xsi:type="mathematica:SymbolLeaf" name="decla"/>
                                              <children xsi:type="mathematica:IntLeaf" value="3"/>
                                            </children>
                                            <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                            <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                            <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:ASTNode" name="substDecl">
                                          <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                            <children xsi:type="mathematica:ASTNode" name="Print">
                                              <children xsi:type="mathematica:StringLeaf" value="Problem in substDecl&#xA;"/>
                                            </children>
                                          </children>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                            <children xsi:type="mathematica:SymbolLeaf" name="substDecls"/>
                                          </children>
                                          <children xsi:type="mathematica:ASTNode" name="substDecls">
                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                              <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                              </children>
                                            </children>
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                              <children xsi:type="mathematica:SymbolLeaf" name="callerDecls"/>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                              </children>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                                                </children>
                                              </children>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                </children>
                                              </children>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                </children>
                                              </children>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                              </children>
                                            </children>
                                          </children>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                              <children xsi:type="mathematica:ASTNode" name="substDecls">
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                  </children>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                    <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                      <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                    </children>
                                                  </children>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                    <children xsi:type="mathematica:SymbolLeaf" name="callerDecls"/>
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                    </children>
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                      <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                        <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                                                      </children>
                                                    </children>
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                      <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                        <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                      </children>
                                                    </children>
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                      <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                        <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                      </children>
                                                    </children>
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                      <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                    </children>
                                                  </children>
                                                </children>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                    <children xsi:type="mathematica:ASTNode" name="Prepend">
                                                      <children xsi:type="mathematica:ASTNode" name="substDecls">
                                                        <children xsi:type="mathematica:ASTNode" name="Rest">
                                                          <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                        </children>
                                                        <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                        <children xsi:type="mathematica:SymbolLeaf" name="callerDecls"/>
                                                        <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                        <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                        <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                        <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                      </children>
                                                      <children xsi:type="mathematica:ASTNode" name="substDecl">
                                                        <children xsi:type="mathematica:ASTNode" name="First">
                                                          <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                        </children>
                                                        <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                        <children xsi:type="mathematica:SymbolLeaf" name="callerDecls"/>
                                                        <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                        <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                        <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                        <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                      </children>
                                                    </children>
                                                    <children xsi:type="mathematica:ASTNode" name="substDecls">
                                                      <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                    </children>
                                                  </children>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                        <children xsi:type="mathematica:ASTNode" name="Print">
                                                          <children xsi:type="mathematica:StringLeaf" value="Problem in substDecls&#xA;"/>
                                                        </children>
                                                      </children>
                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                        <children xsi:type="mathematica:SymbolLeaf" name="substExpr"/>
                                                      </children>
                                                      <children xsi:type="mathematica:ASTNode" name="substExpr">
                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                            <children xsi:type="mathematica:SymbolLeaf" name="var"/>
                                                          </children>
                                                        </children>
                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                          <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                          </children>
                                                        </children>
                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                          <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                          </children>
                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                            <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                              <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                                                            </children>
                                                          </children>
                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                            <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                              <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                            </children>
                                                          </children>
                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                            <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                            </children>
                                                          </children>
                                                        </children>
                                                      </children>
                                                      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                          <children xsi:type="mathematica:ASTNode" name="If">
                                                            <children xsi:type="mathematica:ASTNode" name="MemberQ">
                                                              <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                              </children>
                                                            </children>
                                                            <children xsi:type="mathematica:ASTNode" name="var">
                                                              <children xsi:type="mathematica:ASTNode" name="StringJoin">
                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                </children>
                                                                <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                              </children>
                                                            </children>
                                                            <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                          </children>
                                                          <children xsi:type="mathematica:ASTNode" name="substExpr">
                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                              <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                                                              </children>
                                                            </children>
                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                              <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                              </children>
                                                            </children>
                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                              <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                              </children>
                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                                                                </children>
                                                              </children>
                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                                </children>
                                                              </children>
                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                </children>
                                                              </children>
                                                            </children>
                                                          </children>
                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                              <children xsi:type="mathematica:ASTNode" name="substDom">
                                                                <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                                                                <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                              </children>
                                                              <children xsi:type="mathematica:ASTNode" name="substExpr">
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                    <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                                  </children>
                                                                </children>
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                    <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                  </children>
                                                                </children>
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                  <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                  </children>
                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                    <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                                                                    </children>
                                                                  </children>
                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                    <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                                    </children>
                                                                  </children>
                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                    <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                    </children>
                                                                  </children>
                                                                </children>
                                                              </children>
                                                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                  <children xsi:type="mathematica:ASTNode" name="substDep">
                                                                    <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                                                                    <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                    <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                  </children>
                                                                  <children xsi:type="mathematica:ASTNode" name="substExpr">
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                    </children>
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                      </children>
                                                                    </children>
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                      </children>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                          <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                                                                        </children>
                                                                      </children>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                          <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                                        </children>
                                                                      </children>
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                        <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                          <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                        </children>
                                                                      </children>
                                                                    </children>
                                                                  </children>
                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                      <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                                                                      <children xsi:type="mathematica:ASTNode" name="substExpr">
                                                                        <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                      </children>
                                                                    </children>
                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                          <children xsi:type="mathematica:ASTNode" name="Print">
                                                                            <children xsi:type="mathematica:StringLeaf" value="Problem in substExpr&#xA;"/>
                                                                          </children>
                                                                        </children>
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                          <children xsi:type="mathematica:SymbolLeaf" name="substEqus"/>
                                                                        </children>
                                                                        <children xsi:type="mathematica:ASTNode" name="substEqus">
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="equs"/>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                              </children>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="equs"/>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                    <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="varname"/>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:ASTNode" name="If">
                                                                                      <children xsi:type="mathematica:ASTNode" name="MemberQ">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="varname"/>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                        <children xsi:type="mathematica:ASTNode" name="StringJoin">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="varname"/>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="MapAll">
                                                                                          <children xsi:type="mathematica:ASTNode" name="Function">
                                                                                            <children xsi:type="mathematica:ASTNode" name="substExpr">
                                                                                              <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="varname"/>
                                                                                        <children xsi:type="mathematica:ASTNode" name="MapAll">
                                                                                          <children xsi:type="mathematica:ASTNode" name="Function">
                                                                                            <children xsi:type="mathematica:ASTNode" name="substExpr">
                                                                                              <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                    <children xsi:type="mathematica:ASTNode" name="use">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="subExtDom"/>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="subpAssgn"/>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="inputs"/>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="outputs"/>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="use">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                          <children xsi:type="mathematica:ASTNode" name="substDom">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="subExtDom"/>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="substPAssgn">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="subpAssgn"/>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="MapAll">
                                                                                            <children xsi:type="mathematica:ASTNode" name="Function">
                                                                                              <children xsi:type="mathematica:ASTNode" name="substExpr">
                                                                                                <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="pAssgn"/>
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="pDimSub"/>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="inputs"/>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                                                                            <children xsi:type="mathematica:ASTNode" name="Function">
                                                                                              <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                <children xsi:type="mathematica:ASTNode" name="MemberQ">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="StringJoin">
                                                                                                  <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                </children>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="outputs"/>
                                                                                          </children>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:ASTNode" name="substEqus">
                                                                                      <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                    </children>
                                                                                  </children>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                      <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                        <children xsi:type="mathematica:StringLeaf" value="Problem in substEqus&#xA;"/>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="inputEqus"/>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:ASTNode" name="inputEqus">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                        <children xsi:type="mathematica:ASTNode" name="inputEqus">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="exps"/>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                              </children>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                  <children xsi:type="mathematica:StringLeaf" value="expandSubSystem : not the same number of declared and actual inputs"/>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:ASTNode" name="inputEqus">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                      <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                        <children xsi:type="mathematica:StringLeaf" value="expandSubSystem : not the same number of declared and actual inputs"/>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="inputEqus">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="exps"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Prepend">
                                                                                                              <children xsi:type="mathematica:ASTNode" name="inputEqus">
                                                                                                                <children xsi:type="mathematica:ASTNode" name="Rest">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:ASTNode" name="Rest">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="exps"/>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                <children xsi:type="mathematica:ASTNode" name="MemberQ">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                    <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                                                                                    </children>
                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="StringJoin">
                                                                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                      <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                                                                                      </children>
                                                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                    </children>
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                                                  </children>
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="exps"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                    <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                                                                                    </children>
                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                  </children>
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="exps"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="inputEqus">
                                                                                                              <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                  <children xsi:type="mathematica:StringLeaf" value="Problem in inputEqus"/>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="outputEqus"/>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:ASTNode" name="outputEqus">
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="outputEqus">
                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="retvars"/>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                      </children>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                                        </children>
                                                                                                                      </children>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                        </children>
                                                                                                                      </children>
                                                                                                                    </children>
                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                            <children xsi:type="mathematica:StringLeaf" value="expandSubSystem : not the same number of declared and actual outputs"/>
                                                                                                                          </children>
                                                                                                                        </children>
                                                                                                                        <children xsi:type="mathematica:ASTNode" name="outputEqus">
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                            </children>
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                                              </children>
                                                                                                                            </children>
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                              </children>
                                                                                                                            </children>
                                                                                                                          </children>
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                                  <children xsi:type="mathematica:StringLeaf" value="expandSubSystem : not the same number of declared and actual outputs"/>
                                                                                                                                </children>
                                                                                                                              </children>
                                                                                                                              <children xsi:type="mathematica:ASTNode" name="outputEqus">
                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                                  </children>
                                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="retvars"/>
                                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                                    </children>
                                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                                                      </children>
                                                                                                                                    </children>
                                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                                      </children>
                                                                                                                                    </children>
                                                                                                                                  </children>
                                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                                      <children xsi:type="mathematica:ASTNode" name="Prepend">
                                                                                                                                        <children xsi:type="mathematica:ASTNode" name="outputEqus">
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Rest">
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Rest">
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="retvars"/>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                                                                        </children>
                                                                                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="MemberQ">
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="callerIds"/>
                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                                                                                                              </children>
                                                                                                                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                            </children>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="retvars"/>
                                                                                                                                            </children>
                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="var">
                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="StringJoin">
                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                                                                                                                  </children>
                                                                                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                </children>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="ext"/>
                                                                                                                                              </children>
                                                                                                                                            </children>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="retvars"/>
                                                                                                                                            </children>
                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="var">
                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="decls"/>
                                                                                                                                                </children>
                                                                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                              </children>
                                                                                                                                            </children>
                                                                                                                                          </children>
                                                                                                                                        </children>
                                                                                                                                      </children>
                                                                                                                                      <children xsi:type="mathematica:ASTNode" name="outputEqus">
                                                                                                                                        <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                                                                      </children>
                                                                                                                                    </children>
                                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                                            <children xsi:type="mathematica:StringLeaf" value="Problem in outputEqus"/>
                                                                                                                                          </children>
                                                                                                                                        </children>
                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="doInlineSS"/>
                                                                                                                                        </children>
                                                                                                                                        <children xsi:type="mathematica:ASTNode" name="doInlineSS">
                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                                                            </children>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="occurence"/>
                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                                                            </children>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                                                                                            </children>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="rename"/>
                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="underscore"/>
                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="countervalue"/>
                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                                                            </children>
                                                                                                                                          </children>
                                                                                                                                        </children>
                                                                                                                                      </children>
                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Catch">
                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="matches"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="ss"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="error"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="useNode"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="equsBeforeUse"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="equsAfterUse"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="expString"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="subParams"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="callerParams"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="paramAssign"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="newLoc"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="callerIdList"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="subIdList"/>
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="newEqus"/>
                                                                                                                                              </children>
                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                                                    <children xsi:type="mathematica:StringLeaf" value="underscore option is: "/>
                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="underscore"/>
                                                                                                                                                  </children>
                                                                                                                                                </children>
                                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="error"/>
                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                                                                                                                                                </children>
                                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="matches"/>
                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Cases">
                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                                                                    <children xsi:type="mathematica:ASTNode" name="system">
                                                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                                                    </children>
                                                                                                                                                  </children>
                                                                                                                                                </children>
                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Unequal">
                                                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="matches"/>
                                                                                                                                                    </children>
                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                  </children>
                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                                    <children xsi:type="mathematica:ASTNode" name="Greater">
                                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="matches"/>
                                                                                                                                                      </children>
                                                                                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                    </children>
                                                                                                                                                    <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                                                      <children xsi:type="mathematica:StringLeaf" value="Warning : more than one declarations of "/>
                                                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                                                                                      <children xsi:type="mathematica:StringLeaf" value=" in library."/>
                                                                                                                                                    </children>
                                                                                                                                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
                                                                                                                                                          <children xsi:type="mathematica:StringLeaf" value="NoSSInLib"/>
                                                                                                                                                        </children>
                                                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                                                                                      </children>
                                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="error"/>
                                                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                                                                                                                                                      </children>
                                                                                                                                                    </children>
                                                                                                                                                  </children>
                                                                                                                                                </children>
                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="error"/>
                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                                    <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                                                      <children xsi:type="mathematica:StringLeaf" value="Aborting inlining."/>
                                                                                                                                                    </children>
                                                                                                                                                  </children>
                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="ss"/>
                                                                                                                                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="matches"/>
                                                                                                                                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                      </children>
                                                                                                                                                    </children>
                                                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="matches"/>
                                                                                                                                                      <children xsi:type="mathematica:ASTNode" name="Cases">
                                                                                                                                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                                                                          <children xsi:type="mathematica:IntLeaf" value="6"/>
                                                                                                                                                        </children>
                                                                                                                                                        <children xsi:type="mathematica:ASTNode" name="use">
                                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                                                        </children>
                                                                                                                                                      </children>
                                                                                                                                                    </children>
                                                                                                                                                    <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                                      <children xsi:type="mathematica:ASTNode" name="Less">
                                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="matches"/>
                                                                                                                                                        </children>
                                                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="occurence"/>
                                                                                                                                                      </children>
                                                                                                                                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
                                                                                                                                                            <children xsi:type="mathematica:StringLeaf" value="NoSuchOcc"/>
                                                                                                                                                          </children>
                                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="occurence"/>
                                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                                                                                        </children>
                                                                                                                                                        <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                                                          <children xsi:type="mathematica:StringLeaf" value="Aborting inlining."/>
                                                                                                                                                        </children>
                                                                                                                                                      </children>
                                                                                                                                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="useNode"/>
                                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="matches"/>
                                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="occurence"/>
                                                                                                                                                          </children>
                                                                                                                                                        </children>
                                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="equsBeforeUse"/>
                                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="equsAfterUse"/>
                                                                                                                                                          </children>
                                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="splitEquList">
                                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                                                                                <children xsi:type="mathematica:IntLeaf" value="6"/>
                                                                                                                                                              </children>
                                                                                                                                                            </children>
                                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="occurence"/>
                                                                                                                                                          </children>
                                                                                                                                                        </children>
                                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="subParams"/>
                                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="ss"/>
                                                                                                                                                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                                                          </children>
                                                                                                                                                        </children>
                                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="callerParams"/>
                                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                                                                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                                                          </children>
                                                                                                                                                        </children>
                                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="useNode"/>
                                                                                                                                                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                                                          </children>
                                                                                                                                                        </children>
                                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="paramAssign"/>
                                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="useNode"/>
                                                                                                                                                            <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                                                                          </children>
                                                                                                                                                        </children>
                                                                                                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Unequal">
                                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="subParams"/>
                                                                                                                                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                            </children>
                                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="paramAssign"/>
                                                                                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                              </children>
                                                                                                                                                              <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                                                                                            </children>
                                                                                                                                                          </children>
                                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
                                                                                                                                                                <children xsi:type="mathematica:StringLeaf" value="WrongParamNumber"/>
                                                                                                                                                              </children>
                                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="subParams"/>
                                                                                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                              </children>
                                                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="paramAssign"/>
                                                                                                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                                </children>
                                                                                                                                                                <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                                                                                              </children>
                                                                                                                                                            </children>
                                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                                                              <children xsi:type="mathematica:StringLeaf" value="Aborting inlining."/>
                                                                                                                                                            </children>
                                                                                                                                                          </children>
                                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                                                                <children xsi:type="mathematica:StringLeaf" value="  Expanding occurence #"/>
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="occurence"/>
                                                                                                                                                                <children xsi:type="mathematica:StringLeaf" value=" of subsystem "/>
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                                                                                                <children xsi:type="mathematica:StringLeaf" value=" in system "/>
                                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                                </children>
                                                                                                                                                              </children>
                                                                                                                                                            </children>
                                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="callerIdList"/>
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="buildIdList">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                                                                              </children>
                                                                                                                                                            </children>
                                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="subIdList"/>
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="buildIdList">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="ss"/>
                                                                                                                                                              </children>
                                                                                                                                                            </children>
                                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Less">
                                                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Union">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="subIdList"/>
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="callerIdList"/>
                                                                                                                                                                  </children>
                                                                                                                                                                </children>
                                                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Join">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="subIdList"/>
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="callerIdList"/>
                                                                                                                                                                  </children>
                                                                                                                                                                </children>
                                                                                                                                                              </children>
                                                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="inliningRenameCounter"/>
                                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="Max">
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="inliningRenameCounter"/>
                                                                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="countervalue"/>
                                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                                  </children>
                                                                                                                                                                </children>
                                                                                                                                                              </children>
                                                                                                                                                            </children>
                                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="rename"/>
                                                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="callerIdList"/>
                                                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Union">
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="subIdList"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="callerIdList"/>
                                                                                                                                                                </children>
                                                                                                                                                              </children>
                                                                                                                                                            </children>
                                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="underscore"/>
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="expString"/>
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="StringJoin">
                                                                                                                                                                    <children xsi:type="mathematica:StringLeaf" value="_"/>
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                                                                                                    <children xsi:type="mathematica:ASTNode" name="ToString">
                                                                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="countervalue"/>
                                                                                                                                                                    </children>
                                                                                                                                                                  </children>
                                                                                                                                                                </children>
                                                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="expString"/>
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="StringJoin">
                                                                                                                                                                    <children xsi:type="mathematica:StringLeaf" value="X"/>
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                                                                                                    <children xsi:type="mathematica:ASTNode" name="ToString">
                                                                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="countervalue"/>
                                                                                                                                                                    </children>
                                                                                                                                                                  </children>
                                                                                                                                                                </children>
                                                                                                                                                              </children>
                                                                                                                                                            </children>
                                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="vrb"/>
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="expString"/>
                                                                                                                                                              </children>
                                                                                                                                                            </children>
                                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="newLoc"/>
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Join">
                                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                                                                                  <children xsi:type="mathematica:IntLeaf" value="5"/>
                                                                                                                                                                </children>
                                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="substDecls">
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="ss"/>
                                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                                                                                  </children>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="expString"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="callerIdList"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="paramAssign"/>
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="subParams"/>
                                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                                  </children>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                                                                                                </children>
                                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="substDecls">
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="ss"/>
                                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="4"/>
                                                                                                                                                                  </children>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="expString"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="callerIdList"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="paramAssign"/>
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="subParams"/>
                                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                                  </children>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                                                                                                </children>
                                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="substDecls">
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="ss"/>
                                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="5"/>
                                                                                                                                                                  </children>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="expString"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="callerIdList"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="paramAssign"/>
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="subParams"/>
                                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                                  </children>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                                                                                                </children>
                                                                                                                                                              </children>
                                                                                                                                                            </children>
                                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="newEqus"/>
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Join">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="equsBeforeUse"/>
                                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="inputEqus">
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="ss"/>
                                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                                                                                  </children>
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="useNode"/>
                                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="4"/>
                                                                                                                                                                  </children>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="expString"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="callerIdList"/>
                                                                                                                                                                </children>
                                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="substEqus">
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="ss"/>
                                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="6"/>
                                                                                                                                                                  </children>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="expString"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="callerIdList"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="extDomain"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="paramAssign"/>
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="subParams"/>
                                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                                  </children>
                                                                                                                                                                </children>
                                                                                                                                                                <children xsi:type="mathematica:ASTNode" name="outputEqus">
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="ss"/>
                                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="4"/>
                                                                                                                                                                  </children>
                                                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="useNode"/>
                                                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="5"/>
                                                                                                                                                                  </children>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="expString"/>
                                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="callerIdList"/>
                                                                                                                                                                </children>
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="equsAfterUse"/>
                                                                                                                                                              </children>
                                                                                                                                                            </children>
                                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="system">
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                                              </children>
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                                                                                <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                                                              </children>
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                                                                                <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                                                                              </children>
                                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                                                                                <children xsi:type="mathematica:IntLeaf" value="4"/>
                                                                                                                                                              </children>
                                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="newLoc"/>
                                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="newEqus"/>
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
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="doInlineSS">
                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                                            </children>
                                                                                                                                          </children>
                                                                                                                                        </children>
                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                                                <children xsi:type="mathematica:StringLeaf" value="Problem in SubSystems`doInlineSS"/>
                                                                                                                                              </children>
                                                                                                                                            </children>
                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="swapProgramResult"/>
                                                                                                                                            </children>
                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="swapProgramResult">
                                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                                                                                                </children>
                                                                                                                                              </children>
                                                                                                                                            </children>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                                                                              </children>
                                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                                                                            </children>
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="swapProgramResult"/>
                                                                                                                                        </children>
                                                                                                                                      </children>
                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Times"/>
                                                                                                                                        <children xsi:type="mathematica:ASTNode" name="swapProgramResult">
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                                                                        </children>
                                                                                                                                      </children>
                                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                                            <children xsi:type="mathematica:StringLeaf" value="Problem in SubSystems`swapProgramResult"/>
                                                                                                                                          </children>
                                                                                                                                        </children>
                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
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
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                  <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="occurence"/>
                                                                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="underscore"/>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="rename"/>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="renameCounter"/>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="inliningRenameCounter"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="library"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="current"/>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="inlineSubsystem">
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="Optional">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                          </children>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="inlined"/>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="inlined"/>
                                                                                                <children xsi:type="mathematica:ASTNode" name="doInlineSS">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="name"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="occurence"/>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="library"/>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="rename"/>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="underscore"/>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="renameCounter"/>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="current"/>
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="swapProgramResult">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="inlined"/>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="inlined"/>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="inlineSubsystem">
                                                                                            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="inlineSubsystem"/>
                                                                                                  <children xsi:type="mathematica:StringLeaf" value="Stx"/>
                                                                                                </children>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="expandSubSystem"/>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:ASTNode" name="expandSubSystem">
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="systemId"/>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="occ"/>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:StringLeaf" value="norename"/>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                              <children xsi:type="mathematica:ASTNode" name="Block">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="inlined"/>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="inlined"/>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="inlineSubsystem">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="systemId"/>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="rename"/>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="occurence"/>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="occ"/>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="swapProgramResult">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="inlined"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:ASTNode" name="expandSubSystem">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="systemId"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="occ"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                <children xsi:type="mathematica:ASTNode" name="Block">
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="inlined"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="inlined"/>
                                                                                                      <children xsi:type="mathematica:ASTNode" name="inlineSubsystem">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="systemId"/>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="rename"/>
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="occurence"/>
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="occ"/>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="swapProgramResult">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="inlined"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="expandSubSystem">
                                                                                                  <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                      <children xsi:type="mathematica:StringLeaf" value="ERROR : Syntax is expandSubSystem[name_String, occ_Integer]"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                      <children xsi:type="mathematica:StringLeaf" value="               or expandSubSystem[name_String, occ_Integer, &quot;norename&quot;]"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="inlineAll"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="inlineAll"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="rename"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="underscore"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="renameCounter"/>
                                                                                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="library"/>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="current"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="inlineAll">
                                                                                                      <children xsi:type="mathematica:ASTNode" name="Optional">
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="expanded"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="ren"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="verb"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="underS"/>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="expanded"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="inlineAll"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="library"/>
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="inlineAll"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="ren"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="rename"/>
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="inlineAll"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="underS"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="underscore"/>
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="inlineAll"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="verb"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="inlineAll"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="renameCounter"/>
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="inlineAll"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="While">
                                                                                                          <children xsi:type="mathematica:ASTNode" name="Unequal">
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Cases">
                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="expanded"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="6"/>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:ASTNode" name="use">
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="expanded"/>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="inlineSubsystem">
                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Cases">
                                                                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="expanded"/>
                                                                                                                      <children xsi:type="mathematica:IntLeaf" value="6"/>
                                                                                                                    </children>
                                                                                                                    <children xsi:type="mathematica:ASTNode" name="use">
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                    </children>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="caller"/>
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="expanded"/>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="library"/>
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="underscore"/>
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="underS"/>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="rename"/>
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="ren"/>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="verb"/>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="renameCounter"/>
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Increment">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="counter"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="current"/>
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="current"/>
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="inlineAll"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:ASTNode" name="swapProgramResult">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="expanded"/>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="expanded"/>
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
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="addCstLine"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="addCstLine">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                              </children>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                              <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                <children xsi:type="mathematica:ASTNode" name="Equal">
                                                                                                  <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="Prepend">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Last">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="Prepend">
                                                                                                  <children xsi:type="mathematica:ASTNode" name="addCstLine">
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Rest">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Rest">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:ASTNode" name="addCstLine">
                                                                                                <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                  <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                    <children xsi:type="mathematica:StringLeaf" value="Problem in addCstLine"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="removeFromIdList"/>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="removeFromIdList">
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                      <children xsi:type="mathematica:StringLeaf" value="ERROR : Subsystems`removeFromIdList : "/>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                      <children xsi:type="mathematica:StringLeaf" value=" not found."/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="removeFromIdList">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                      <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                        <children xsi:type="mathematica:ASTNode" name="Equal">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                          <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="Rest">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="Prepend">
                                                                                                          <children xsi:type="mathematica:ASTNode" name="removeFromIdList">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Rest">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:ASTNode" name="removeFromIdList">
                                                                                                        <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                          <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                            <children xsi:type="mathematica:StringLeaf" value="Problem in Subsystems`removeFromIdList"/>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="buildPAssign"/>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="buildPAssign">
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                            <children xsi:type="mathematica:ASTNode" name="matrix">
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:ASTNode" name="removeFromIdList">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:ASTNode" name="addCstLine">
                                                                                                                <children xsi:type="mathematica:ASTNode" name="IdentityMatrix">
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="idList"/>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="buildPAssign">
                                                                                                              <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                  <children xsi:type="mathematica:StringLeaf" value="Problem in buildPAssign"/>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="assParValExpr"/>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:ASTNode" name="assParValExpr">
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="expr"/>
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="parAssgn"/>
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="parDomDim"/>
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="expr"/>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                                                    <children xsi:type="mathematica:ASTNode" name="domain">
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                                        </children>
                                                                                                                      </children>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="ids"/>
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                        </children>
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="pols"/>
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                          </children>
                                                                                                                        </children>
                                                                                                                        <children xsi:type="mathematica:ASTNode" name="DomZPreimage">
                                                                                                                          <children xsi:type="mathematica:ASTNode" name="domain">
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="ids"/>
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="pols"/>
                                                                                                                          </children>
                                                                                                                          <children xsi:type="mathematica:ASTNode" name="affExtHom">
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="parAssgn"/>
                                                                                                                            <children xsi:type="mathematica:ASTNode" name="Drop">
                                                                                                                              <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                <children xsi:type="mathematica:ASTNode" name="SameQ">
                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Head">
                                                                                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="pols"/>
                                                                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                    </children>
                                                                                                                                  </children>
                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="pol"/>
                                                                                                                                </children>
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="ids"/>
                                                                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="zpols"/>
                                                                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                  <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                                                </children>
                                                                                                                              </children>
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                                <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="parDomDim"/>
                                                                                                                              </children>
                                                                                                                            </children>
                                                                                                                          </children>
                                                                                                                        </children>
                                                                                                                      </children>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                                                        <children xsi:type="mathematica:ASTNode" name="matrix">
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="rows"/>
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                                            </children>
                                                                                                                          </children>
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="cols"/>
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                                            </children>
                                                                                                                          </children>
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="ids"/>
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                            </children>
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                              </children>
                                                                                                                            </children>
                                                                                                                            <children xsi:type="mathematica:ASTNode" name="substDep">
                                                                                                                              <children xsi:type="mathematica:ASTNode" name="matrix">
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="rows"/>
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="cols"/>
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="ids"/>
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                                                                                                                              </children>
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="parAssgn"/>
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="parDomDim"/>
                                                                                                                            </children>
                                                                                                                          </children>
                                                                                                                        </children>
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="assignParameterValue"/>
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
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                      <children xsi:type="mathematica:ASTNode" name="assignParameterValue">
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:ASTNode" name="assignParameterValue">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                      <children xsi:type="mathematica:ASTNode" name="assignParameterValue">
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="parAssgn"/>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="parRank"/>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="params"/>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="paramlist"/>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="paramlist"/>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                              <children xsi:type="mathematica:ASTNode" name="SameQ">
                                                                                                                <children xsi:type="mathematica:ASTNode" name="Head">
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="pol"/>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                            <children xsi:type="mathematica:ASTNode" name="MemberQ">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="paramlist"/>
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="parAssgn"/>
                                                                                                                <children xsi:type="mathematica:ASTNode" name="buildPAssign">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="paramlist"/>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                                                      <children xsi:type="mathematica:ASTNode" name="domain">
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                                          </children>
                                                                                                                        </children>
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="ids"/>
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                          </children>
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="pols"/>
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                            </children>
                                                                                                                          </children>
                                                                                                                          <children xsi:type="mathematica:ASTNode" name="assParValExpr">
                                                                                                                            <children xsi:type="mathematica:ASTNode" name="domain">
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="ids"/>
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="pols"/>
                                                                                                                            </children>
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="parAssgn"/>
                                                                                                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
                                                                                                                                <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                              </children>
                                                                                                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                            </children>
                                                                                                                          </children>
                                                                                                                        </children>
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                                                          <children xsi:type="mathematica:ASTNode" name="domain">
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                                              </children>
                                                                                                                            </children>
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="zpols"/>
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                              </children>
                                                                                                                            </children>
                                                                                                                            <children xsi:type="mathematica:ASTNode" name="assParValExpr">
                                                                                                                              <children xsi:type="mathematica:ASTNode" name="domain">
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="zpols"/>
                                                                                                                              </children>
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="parAssgn"/>
                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
                                                                                                                                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                                </children>
                                                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                              </children>
                                                                                                                            </children>
                                                                                                                          </children>
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                                                            <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                                                </children>
                                                                                                                              </children>
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="expr"/>
                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                              </children>
                                                                                                                            </children>
                                                                                                                            <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                                                                                                                              <children xsi:type="mathematica:ASTNode" name="assParValExpr">
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="expr"/>
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="parAssgn"/>
                                                                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
                                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                                  </children>
                                                                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                </children>
                                                                                                                              </children>
                                                                                                                            </children>
                                                                                                                          </children>
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                                                            <children xsi:type="mathematica:ASTNode" name="use">
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                                                </children>
                                                                                                                              </children>
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="extDom"/>
                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                                                                                                                                </children>
                                                                                                                              </children>
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="params"/>
                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                                                                                                                </children>
                                                                                                                              </children>
                                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="inputs"/>
                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                                </children>
                                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="outputs"/>
                                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                                                  </children>
                                                                                                                                </children>
                                                                                                                                <children xsi:type="mathematica:ASTNode" name="use">
                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="DomZPreimage">
                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="extDom"/>
                                                                                                                                    <children xsi:type="mathematica:ASTNode" name="affExtHom">
                                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="parAssgn"/>
                                                                                                                                      <children xsi:type="mathematica:ASTNode" name="Drop">
                                                                                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="SameQ">
                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="Head">
                                                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="extDom"/>
                                                                                                                                                <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                              </children>
                                                                                                                                            </children>
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="pol"/>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="extDom"/>
                                                                                                                                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                                          </children>
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="extDom"/>
                                                                                                                                            <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                            <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                                                          </children>
                                                                                                                                        </children>
                                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                                          <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                                                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
                                                                                                                                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                                            </children>
                                                                                                                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                          </children>
                                                                                                                                        </children>
                                                                                                                                      </children>
                                                                                                                                    </children>
                                                                                                                                  </children>
                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="substPAssgn">
                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="params"/>
                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="parAssgn"/>
                                                                                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
                                                                                                                                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                                      </children>
                                                                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                    </children>
                                                                                                                                  </children>
                                                                                                                                  <children xsi:type="mathematica:ASTNode" name="assParValExpr">
                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="inputs"/>
                                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="parAssgn"/>
                                                                                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="syst"/>
                                                                                                                                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                                      </children>
                                                                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                                    </children>
                                                                                                                                  </children>
                                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="outputs"/>
                                                                                                                                </children>
                                                                                                                              </children>
                                                                                                                            </children>
                                                                                                                          </children>
                                                                                                                        </children>
                                                                                                                      </children>
                                                                                                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="assignParameterValue"/>
                                                                                                                            <children xsi:type="mathematica:StringLeaf" value="notParameter"/>
                                                                                                                          </children>
                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                                        </children>
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                                                                                                      </children>
                                                                                                                    </children>
                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="params"/>
                                                                                                                      <children xsi:type="mathematica:ASTNode" name="getSystemParameterDomain">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                                                                                                      </children>
                                                                                                                    </children>
                                                                                                                    <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                      <children xsi:type="mathematica:ASTNode" name="DomEmptyQ">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="params"/>
                                                                                                                      </children>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="fixParameter"/>
                                                                                                                          <children xsi:type="mathematica:StringLeaf" value="wrongparamvalue"/>
                                                                                                                        </children>
                                                                                                                      </children>
                                                                                                                    </children>
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                                <children xsi:type="mathematica:ASTNode" name="assignParameterValue">
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                                    </children>
                                                                                                                  </children>
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                                    </children>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                                                                                                      </children>
                                                                                                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                                                                                                          <children xsi:type="mathematica:ASTNode" name="assignParameterValue">
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                                          </children>
                                                                                                                        </children>
                                                                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                                          <children xsi:type="mathematica:ASTNode" name="MatchQ">
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                                                                                                            <children xsi:type="mathematica:ASTNode" name="system">
                                                                                                                              <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                                                            </children>
                                                                                                                          </children>
                                                                                                                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                                                                                                          </children>
                                                                                                                          <children xsi:type="mathematica:ASTNode" name="putSystem"/>
                                                                                                                        </children>
                                                                                                                      </children>
                                                                                                                    </children>
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:ASTNode" name="assignParameterValue">
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                    <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                      <children xsi:type="mathematica:StringLeaf" value="Problem in assignParameterValue"/>
                                                                                                                    </children>
                                                                                                                  </children>
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="assignParameterValueLib"/>
                                                                                                                  </children>
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="assignParameterValueLib">
                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                                                                                                                      <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                                                    </children>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                    <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                      <children xsi:type="mathematica:StringLeaf" value="Warning: Obsolete function, use fixParameter[] instead"/>
                                                                                                                    </children>
                                                                                                                    <children xsi:type="mathematica:ASTNode" name="fixParameter">
                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                                                                                                                    </children>
                                                                                                                  </children>
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="fixParameter"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                            <children xsi:type="mathematica:ASTNode" name="fixParameter">
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Catch">
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                    <children xsi:type="mathematica:StringLeaf" value="Warning, currently this function supposes that  "/>
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                                    <children xsi:type="mathematica:StringLeaf" value=" has the same value everywhere and that $result contrains the top calling system of the library"/>
                                                                                                                  </children>
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                                  </children>
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Do">
                                                                                                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                        </children>
                                                                                                                      </children>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                                        <children xsi:type="mathematica:ASTNode" name="Check">
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="temp"/>
                                                                                                                            <children xsi:type="mathematica:ASTNode" name="fixParameter">
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                                            </children>
                                                                                                                          </children>
                                                                                                                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                                            <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                                              <children xsi:type="mathematica:StringLeaf" value=" not set in "/>
                                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                                                            </children>
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="temp"/>
                                                                                                                          </children>
                                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="fixParameter"/>
                                                                                                                            <children xsi:type="mathematica:StringLeaf" value="notParameter"/>
                                                                                                                          </children>
                                                                                                                        </children>
                                                                                                                      </children>
                                                                                                                    </children>
                                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Length"/>
                                                                                                                    </children>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                                                <children xsi:type="mathematica:ASTNode" name="getSystem">
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part"/>
                                                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                    <children xsi:type="mathematica:ASTNode" name="fixParameter">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="systName"/>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="fixParameter">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="systName"/>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                                      <children xsi:type="mathematica:ASTNode" name="getSystem">
                                                                                                        <children xsi:type="mathematica:ASTNode" name="Part"/>
                                                                                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                </children>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="fixParameter"/>
                                                                                                <children xsi:type="mathematica:StringLeaf" value="notParameter"/>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:StringLeaf" value="`1` is not a parameter"/>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="fixParameter"/>
                                                                                                <children xsi:type="mathematica:StringLeaf" value="wrongparamvalue"/>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:StringLeaf" value="the value of the parameter is outside the parameter domain. &#xA;The resulting system is meaningless."/>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                              <children xsi:type="mathematica:ASTNode" name="fixParameter">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="systName"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="Catch">
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="parRank"/>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="lib1"/>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="newLib"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="getSystem">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="systName"/>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="lib1"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="parRank"/>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                          <children xsi:type="mathematica:ASTNode" name="Position">
                                                                                                            <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                              <children xsi:type="mathematica:ASTNode" name="SameQ">
                                                                                                                <children xsi:type="mathematica:ASTNode" name="Head">
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="pol"/>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="2"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                        <children xsi:type="mathematica:ASTNode" name="Not">
                                                                                                          <children xsi:type="mathematica:ASTNode" name="MatchQ">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="parRank"/>
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="fixParameter"/>
                                                                                                              <children xsi:type="mathematica:StringLeaf" value="notParameter"/>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:ASTNode" name="Throw">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="lib1"/>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="assignParameterValue">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="value"/>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="lib1"/>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="putSystem">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="lib1"/>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="lib1"/>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="Check">
                                                                                                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="newLib"/>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="lib1"/>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                                                    <children xsi:type="mathematica:ASTNode" name="use">
                                                                                                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                                                                                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                      </children>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="extDom"/>
                                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                                      </children>
                                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="params"/>
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
                                                                                                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                                                                                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                      </children>
                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="extDom"/>
                                                                                                                      <children xsi:type="mathematica:ASTNode" name="suppressRowNum">
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="params"/>
                                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="parRank"/>
                                                                                                                      </children>
                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="inputs"/>
                                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="outputs"/>
                                                                                                                    </children>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                              <children xsi:type="mathematica:ASTNode" name="MatchQ">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="newLib"/>
                                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                  <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                                                                  </children>
                                                                                                                </children>
                                                                                                              </children>
                                                                                                              <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="ident"/>
                                                                                                                <children xsi:type="mathematica:StringLeaf" value=" suppressed in use of "/>
                                                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                                                                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                                </children>
                                                                                                                <children xsi:type="mathematica:StringLeaf" value=" in library "/>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="newLib"/>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="lib1"/>
                                                                                                        </children>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="lib1"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="removeIdEqus"/>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="removeIdEqus"/>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="debug"/>
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="norm"/>
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="inputEquations"/>
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="allLibrary"/>
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                                <children xsi:type="mathematica:ASTNode" name="removeIdEqus">
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="Catch">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="allLib"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="vrb"/>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="debug"/>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="removeIdEqus"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="vrb"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="removeIdEqus"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="allLib"/>
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="allLibrary"/>
                                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                                              </children>
                                                                                                            </children>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="removeIdEqus"/>
                                                                                                            </children>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                          <children xsi:type="mathematica:ASTNode" name="Not">
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="allLib"/>
                                                                                                          </children>
                                                                                                          <children xsi:type="mathematica:ASTNode" name="Check">
                                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                                            <children xsi:type="mathematica:ASTNode" name="removeIdEqus"/>
                                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                                          </children>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                                                                                        </children>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:ASTNode" name="Throw">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="Check">
                                                                                                    <children xsi:type="mathematica:ASTNode" name="For">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                      </children>
                                                                                                      <children xsi:type="mathematica:ASTNode" name="LessEqual">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Length"/>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Increment">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                                      <children xsi:type="mathematica:ASTNode" name="Part"/>
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="vrb"/>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                                      <children xsi:type="mathematica:StringLeaf" value="---- Removing useless equations of system "/>
                                                                                                      <children xsi:type="mathematica:ASTNode" name="getSystemName"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="removeIdEqus"/>
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:ASTNode" name="putSystem"/>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="prog"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="Throw"/>
                                                                                    </children>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                        </children>
                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                          <children xsi:type="mathematica:ASTNode" name="removeIdEqus">
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                              <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:ASTNode" name="Catch">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="toRemove"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="varsToRemove"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="eqs"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="cureq"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="lhsVars"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="j"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="vrb"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="nrm"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="inputvars"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="outputvars"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="debug"/>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="removeIdEqus"/>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="vrb"/>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="removeIdEqus"/>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="nrm"/>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="norm"/>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="removeIdEqus"/>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="inputE"/>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="inputEquations"/>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="removeIdEqus"/>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                                                                                    <children xsi:type="mathematica:ASTNode" name="removeAllUnusedVars">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="inputvars"/>
                                                                                    <children xsi:type="mathematica:ASTNode" name="getInputVars">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="outputvars"/>
                                                                                    <children xsi:type="mathematica:ASTNode" name="getOutputVars">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="If">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                                                                    <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                      <children xsi:type="mathematica:StringLeaf" value="Input vars: "/>
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="inputvars"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="If">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                                                                    <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                      <children xsi:type="mathematica:StringLeaf" value="Output vars: "/>
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="outputvars"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="eqs"/>
                                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                                                                                      <children xsi:type="mathematica:IntLeaf" value="6"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="For">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:ASTNode" name="LessEqual">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="eqs"/>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:ASTNode" name="Increment">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:ASTNode" name="Catch">
                                                                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                                                                          <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                            <children xsi:type="mathematica:StringLeaf" value="Considering equation "/>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="cureq"/>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="eqs"/>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                            </children>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="toRemove"/>
                                                                                          <children xsi:type="mathematica:ASTNode" name="Join">
                                                                                            <children xsi:type="mathematica:ASTNode" name="Cases">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="cureq"/>
                                                                                              <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="var">
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                </children>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:ASTNode" name="Cases">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="cureq"/>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="u"/>
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="affine">
                                                                                                    <children xsi:type="mathematica:ASTNode" name="var">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="mm"/>
                                                                                                      <children xsi:type="mathematica:ASTNode" name="PatternTest">
                                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="identityQ"/>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="u"/>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="var">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                              </children>
                                                                                            </children>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                                          <children xsi:type="mathematica:ASTNode" name="Not">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="inputE"/>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="toRemove"/>
                                                                                            <children xsi:type="mathematica:ASTNode" name="Cases">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="toRemove"/>
                                                                                              <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                <children xsi:type="mathematica:ASTNode" name="var">
                                                                                                  <children xsi:type="mathematica:ASTNode" name="Condition">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Not">
                                                                                                      <children xsi:type="mathematica:ASTNode" name="MemberQ">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="inputvars"/>
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                </children>
                                                                                              </children>
                                                                                            </children>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                                                                          <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                            <children xsi:type="mathematica:StringLeaf" value="toRemove : "/>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="toRemove"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                                          <children xsi:type="mathematica:ASTNode" name="SameQ">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="toRemove"/>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="Throw">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="varsToRemove"/>
                                                                                          <children xsi:type="mathematica:ASTNode" name="Cases">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="toRemove"/>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                              <children xsi:type="mathematica:ASTNode" name="Condition">
                                                                                                <children xsi:type="mathematica:ASTNode" name="equation">
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="var">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="Not">
                                                                                                  <children xsi:type="mathematica:ASTNode" name="MemberQ">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="outputvars"/>
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                                                                                            </children>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                                                                          <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                            <children xsi:type="mathematica:StringLeaf" value="Variables to be removed : "/>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="varsToRemove"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                                          <children xsi:type="mathematica:ASTNode" name="SameQ">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="varsToRemove"/>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="Throw">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="If">
                                                                                          <children xsi:type="mathematica:ASTNode" name="Greater">
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="varsToRemove"/>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                            <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                              <children xsi:type="mathematica:StringLeaf" value="Error"/>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:ASTNode" name="Throw">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                                                                            </children>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="varsToRemove"/>
                                                                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                                                                                          <children xsi:type="mathematica:ASTNode" name="removeOneIdEqu">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="If">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="nrm"/>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                                                                                      <children xsi:type="mathematica:ASTNode" name="normalize">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                            <children xsi:type="mathematica:ASTNode" name="removeIdEqus">
                                                                              <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="removeOneIdEqus"/>
                                                                                <children xsi:type="mathematica:StringLeaf" value="params"/>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="removeOneIdEqu"/>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                            <children xsi:type="mathematica:ASTNode" name="removeOneIdEqu">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                                                              </children>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:ASTNode" name="Catch">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="vrb"/>
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="newsys"/>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="debug"/>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="removeIdEqus"/>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="vrb"/>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="Options">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="removeIdEqus"/>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:ASTNode" name="If">
                                                                                      <children xsi:type="mathematica:ASTNode" name="Or">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="vrb"/>
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="Print">
                                                                                        <children xsi:type="mathematica:StringLeaf" value="Removing var "/>
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                                                                                      <children xsi:type="mathematica:ASTNode" name="Position">
                                                                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                          <children xsi:type="mathematica:IntLeaf" value="6"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="var">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                                                                                      <children xsi:type="mathematica:ASTNode" name="Select">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                                                                                        <children xsi:type="mathematica:ASTNode" name="Function">
                                                                                          <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                                                                            <children xsi:type="mathematica:ASTNode" name="getPart">
                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                                <children xsi:type="mathematica:IntLeaf" value="6"/>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                  <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:IntLeaf"/>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="use"/>
                                                                                          </children>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="newsys"/>
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:ASTNode" name="If">
                                                                                      <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:IntLeaf"/>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="lhsVars"/>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                                                                            <children xsi:type="mathematica:ASTNode" name="Function">
                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="newsys"/>
                                                                                                    <children xsi:type="mathematica:IntLeaf" value="6"/>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="For">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="j"/>
                                                                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="LessEqual">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="j"/>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="lhsVars"/>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="j"/>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="j"/>
                                                                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="newsys"/>
                                                                                            <children xsi:type="mathematica:ASTNode" name="substituteInDef">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="newsys"/>
                                                                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="lhsVars"/>
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="j"/>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                                                                                            </children>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="newsys"/>
                                                                                          <children xsi:type="mathematica:ASTNode" name="removeAllUnusedVars">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="newsys"/>
                                                                                          </children>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="newsys"/>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                              <children xsi:type="mathematica:ASTNode" name="removeOneIdEqu">
                                                                                <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                              </children>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="removeOneIdEqu"/>
                                                                                  <children xsi:type="mathematica:StringLeaf" value="params"/>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="subSystemUsedBy"/>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="subSystemUsedBy"/>
                                                                                <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
                                                                              </children>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                  <children xsi:type="mathematica:StringLeaf" value="Wrong Argument for subSystemUsedBy"/>
                                                                                  <children xsi:type="mathematica:ASTNode" name="subSystemUsedBy"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                    <children xsi:type="mathematica:ASTNode" name="subSystemUsedBy"/>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="subSystemUsedBy">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="listName"/>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="listName"/>
                                                                                          <children xsi:type="mathematica:ASTNode" name="Cases">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                              <children xsi:type="mathematica:ASTNode" name="use">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="nom"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="nom"/>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="listName"/>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:ASTNode" name="subSystemUsedBy">
                                                                                      <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="subSystemUsedBy"/>
                                                                                        <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="systemDep"/>
                                                                                    </children>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="systemDep"/>
                                                                              <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
                                                                            </children>
                                                                            <children xsi:type="mathematica:StringLeaf" value="`1`"/>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                            <children xsi:type="mathematica:ASTNode" name="systemDep">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                  <children xsi:type="mathematica:ASTNode" name="BlankSequence">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="With">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="names"/>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="First"/>
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:ASTNode" name="Apply">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="Join"/>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                                                                  <children xsi:type="mathematica:ASTNode" name="Function">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:ASTNode" name="Cases">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="u"/>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="use"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                          <children xsi:type="mathematica:ASTNode" name="First">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="First">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="u"/>
                                                                                          </children>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="lib"/>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                            <children xsi:type="mathematica:ASTNode" name="systemDep">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                                                                                <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="systemDep"/>
                                                                                    <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                            <children xsi:type="mathematica:SymbolLeaf" name="topoSort"/>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                              <children xsi:type="mathematica:SymbolLeaf" name="topoSort"/>
                                                                              <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
                                                                            </children>
                                                                            <children xsi:type="mathematica:StringLeaf" value="`1`"/>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                            <children xsi:type="mathematica:ASTNode" name="topoSort">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="l"/>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                  <children xsi:type="mathematica:ASTNode" name="BlankSequence">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="roots"/>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="names"/>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="First"/>
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="l"/>
                                                                                  </children>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                                                                  <children xsi:type="mathematica:ASTNode" name="systemDep">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="l"/>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                <children xsi:type="mathematica:ASTNode" name="While">
                                                                                  <children xsi:type="mathematica:ASTNode" name="Greater">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="names"/>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:IntLeaf"/>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="roots"/>
                                                                                      <children xsi:type="mathematica:ASTNode" name="Append">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="roots"/>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="With">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="nonroots"/>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="First"/>
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                                                                              </children>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="Complement">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="names"/>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="nonroots"/>
                                                                                          </children>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="names"/>
                                                                                      <children xsi:type="mathematica:ASTNode" name="Complement">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="names"/>
                                                                                        <children xsi:type="mathematica:ASTNode" name="Last">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="roots"/>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                                                                      <children xsi:type="mathematica:ASTNode" name="Select">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                                                                        <children xsi:type="mathematica:ASTNode" name="Function">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="MemberQ">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="names"/>
                                                                                            <children xsi:type="mathematica:ASTNode" name="Last">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                                                                                            </children>
                                                                                          </children>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                                                                  </children>
                                                                                </children>
                                                                                <children xsi:type="mathematica:ASTNode" name="Flatten">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="roots"/>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                            <children xsi:type="mathematica:ASTNode" name="topoSort">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                                                                                <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="topoSort"/>
                                                                                    <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="simplifyUseInputs"/>
                                                                              </children>
                                                                              <children xsi:type="mathematica:ASTNode" name="simplifyUseInputs"/>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="tempSys"/>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="tempSys"/>
                                                                                      <children xsi:type="mathematica:ASTNode" name="simplifyUseInputs"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="If">
                                                                                    <children xsi:type="mathematica:ASTNode" name="MatchQ">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="tempSys"/>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="tempSys"/>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:ASTNode" name="simplifyUseInputs">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                                </children>
                                                                              </children>
                                                                            </children>
                                                                          </children>
                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="eqs"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="useEqs"/>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="eqs"/>
                                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                      <children xsi:type="mathematica:IntLeaf" value="6"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="useEqs"/>
                                                                                    <children xsi:type="mathematica:ASTNode" name="Select">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="eqs"/>
                                                                                      <children xsi:type="mathematica:ASTNode" name="Function">
                                                                                        <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                            <children xsi:type="mathematica:ASTNode" name="Position">
                                                                                              <children xsi:type="mathematica:ASTNode" name="Slot">
                                                                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="use"/>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:IntLeaf"/>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="Do">
                                                                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="curUse"/>
                                                                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="useEqs"/>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                                                                        <children xsi:type="mathematica:ASTNode" name="simplifyUseInputsForUse">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="curUse"/>
                                                                                        </children>
                                                                                      </children>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="useEqs"/>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:ASTNode" name="simplifyUseInputs">
                                                                                <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                              </children>
                                                                            </children>
                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="simplifyUseInputs"/>
                                                                                  <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="simplifyUseInputsForUse"/>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="simplifyUseInputsForUse"/>
                                                                                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                  <children xsi:type="mathematica:StringLeaf" value="in test"/>
                                                                                  <children xsi:type="mathematica:ASTNode" name="simplifyUseInputsForUse">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="curUse"/>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="use"/>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="tempSys"/>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="tempSys"/>
                                                                                          <children xsi:type="mathematica:ASTNode" name="simplifyUseInputsForUse"/>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="curUse"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="If">
                                                                                        <children xsi:type="mathematica:ASTNode" name="MatchQ">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="tempSys"/>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="tempSys"/>
                                                                                      </children>
                                                                                    </children>
                                                                                  </children>
                                                                                </children>
                                                                                <children xsi:type="mathematica:ASTNode" name="simplifyUseInputsForUse">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="curUse"/>
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="use"/>
                                                                                    </children>
                                                                                  </children>
                                                                                </children>
                                                                              </children>
                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="listInVars"/>
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="curVar"/>
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="curVarName"/>
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="newVar"/>
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="posUses"/>
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="posUse"/>
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="localUse"/>
                                                                                    </children>
                                                                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="posUses"/>
                                                                                        <children xsi:type="mathematica:ASTNode" name="Position">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="curUse"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="If">
                                                                                        <children xsi:type="mathematica:ASTNode" name="SameQ">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="posUses"/>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                                            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="simplifyUseInputsForUse"/>
                                                                                              <children xsi:type="mathematica:StringLeaf" value="UseNotFound"/>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="Return">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="posUse"/>
                                                                                          <children xsi:type="mathematica:ASTNode" name="First">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="posUses"/>
                                                                                          </children>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="localUse"/>
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="curUse"/>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="listInVars"/>
                                                                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="curUse"/>
                                                                                          <children xsi:type="mathematica:IntLeaf" value="4"/>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:ASTNode" name="Do">
                                                                                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="curExpr"/>
                                                                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="listInVars"/>
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="curExprPos"/>
                                                                                            <children xsi:type="mathematica:ASTNode" name="Join">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="posUse"/>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                                <children xsi:type="mathematica:IntLeaf" value="4"/>
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                              </children>
                                                                                            </children>
                                                                                          </children>
                                                                                          <children xsi:type="mathematica:ASTNode" name="If">
                                                                                            <children xsi:type="mathematica:ASTNode" name="MatchQ">
                                                                                              <children xsi:type="mathematica:SymbolLeaf" name="curExpr"/>
                                                                                              <children xsi:type="mathematica:ASTNode" name="var">
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                </children>
                                                                                              </children>
                                                                                            </children>
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                                                                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                              <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                <children xsi:type="mathematica:ASTNode" name="MatchQ">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="curExpr"/>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="affine">
                                                                                                    <children xsi:type="mathematica:ASTNode" name="var">
                                                                                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                                                                        <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                                                                      </children>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="matrix">
                                                                                                      <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="curVarName"/>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="StringJoin">
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="curExpr"/>
                                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:StringLeaf" value="IN"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="curVarName"/>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="StringJoin">
                                                                                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="curUse"/>
                                                                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                                    </children>
                                                                                                    <children xsi:type="mathematica:StringLeaf" value="IN"/>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="ToString">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="newVar"/>
                                                                                                <children xsi:type="mathematica:ASTNode" name="getNewName">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="curVarName"/>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                                                                                <children xsi:type="mathematica:ASTNode" name="addLocal">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="newVar"/>
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="curExprPos"/>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="localUse"/>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="localUse"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="curExpr"/>
                                                                                                    <children xsi:type="mathematica:ASTNode" name="var">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="newVar"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                <children xsi:type="mathematica:SymbolLeaf" name="posUses"/>
                                                                                                <children xsi:type="mathematica:ASTNode" name="Position">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="localUse"/>
                                                                                                </children>
                                                                                              </children>
                                                                                              <children xsi:type="mathematica:ASTNode" name="If">
                                                                                                <children xsi:type="mathematica:ASTNode" name="SameQ">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="posUses"/>
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                                                                                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="simplifyUseInputsForUse"/>
                                                                                                      <children xsi:type="mathematica:StringLeaf" value="UseNotFound"/>
                                                                                                    </children>
                                                                                                  </children>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="Return">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                                                                  <children xsi:type="mathematica:SymbolLeaf" name="posUse"/>
                                                                                                  <children xsi:type="mathematica:ASTNode" name="First">
                                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="posUses"/>
                                                                                                  </children>
                                                                                                </children>
                                                                                              </children>
                                                                                            </children>
                                                                                          </children>
                                                                                        </children>
                                                                                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                                                          <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                                                          <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                                                            <children xsi:type="mathematica:SymbolLeaf" name="listInVars"/>
                                                                                          </children>
                                                                                        </children>
                                                                                      </children>
                                                                                      <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                                                                    </children>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="simplifyUseInputsForUse">
                                                                                    <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                                                                  </children>
                                                                                </children>
                                                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                                                    <children xsi:type="mathematica:SymbolLeaf" name="simplifyUseInputsForUse"/>
                                                                                    <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
                                                                                  </children>
                                                                                  <children xsi:type="mathematica:ASTNode" name="End"/>
                                                                                  <children xsi:type="mathematica:ASTNode" name="EndPackage"/>
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
</mathematica:BuiltInNode>
