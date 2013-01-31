<?xml version="1.0" encoding="ASCII"?>
<mathematica:BuiltInNode xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mathematica="http://www.irisa.fr/cairn/model/xtext/Mathematica" keyword="Protect">
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="BeginPackage">
          <children xsi:type="mathematica:StringLeaf" value="Alpha`Substitution`"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Domlib`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Options`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Matrix`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Tables`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Semantics`"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="Substitution"/>
          <children xsi:type="mathematica:StringLeaf" value="usage"/>
        </children>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Alpha``Substitution is the package which contains the &#xA;functions for substituting Alpha variables."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="substituteInDef"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="substituteInDef[lhs, var] substitutes in $result all occurrences of&#xA;variable `var' in the RHS of the definition of variable `lhs' by the&#xA;definition of `var', and returns the new system in $result.&#xA;substituteInDef[lhs,var,rank] substitutes occurrences `rank' of&#xA;variable `var' in the RHS of the defition of variable `lhs' by the&#xA;definition of `var'. The parameter rank specifies which occurrence to&#xA;replace ( 1 = first, 2 = second, {1,2}= first and second,&#xA;etc). substitute[sys,lhs,var] and substitute[sys,lhs,var,rank] do&#xA;the same on program contained in symbol `sys'."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="replaceDefinition"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="replaceDefinition[lhs_, rhs_] replaces the&#xA;definition (RHS of an equation) of a variable `lhs' in an in program&#xA;$result' with the Alpha expression `rhs'.&#xA;replaceDefinition[sys_Alpha`system, lhs_, rhs_] Replaces the&#xA;definition of variable `lhs' in an ALPHA program `sys' with the Alpha&#xA;expression `rhs' and return the new system.&#xA; `lhs' is a variable name (either symbol or string). `rhs' is&#xA;either an ast or a string."/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="replaceDefinition"/>
            <children xsi:type="mathematica:StringLeaf" value="notes"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="The function returns a copy of the original program in which the RHS of the&#xA;equation defining the specified variable is replaced by an expression passed&#xA;as parameter. The result of the substitution is not normalized. The meaning&#xA;of the program can be changed."/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="replaceDefinition"/>
              <children xsi:type="mathematica:StringLeaf" value="lhs"/>
            </children>
          </children>
          <children xsi:type="mathematica:StringLeaf" value="lhs should be a variable name, either&#xA;in String of Symbol form"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="replaceDefinition"/>
        <children xsi:type="mathematica:StringLeaf" value="rhs"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="rhs should be an Alpha expression"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="replaceDefinition"/>
        <children xsi:type="mathematica:StringLeaf" value="arg1"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="first argument should be an alpha ast"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="replaceDefinition"/>
        <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="Wrong Argument for replace Definition: `1`"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="getOccurs"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="getOccurs[stringPattern_String] Extracts the occurrences of a given pattern (`stringPattern'&#xA;or `pattern') in an ALPHA system (`sys' or default $result).&#xA;Returns a Mathematica position specifier, containing the list of occurrence&#xA;positions in the system. Can also be called in the following way:&#xA;getOccurs[pattern_]&#xA;getOccurs[sys_Alpha`system, stringPattern_String]&#xA;getOccurs[sys_Alpha`system, pattern_]"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="getOccurs"/>
              <children xsi:type="mathematica:StringLeaf" value="notes"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="If the pattern is a string, 'getOccurs' replaces it by the corresponding&#xA;ALPHA abstract syntax tree (assuming it is an external representation of a&#xA;valid ALPHA a.s.t.) Otherwise, 'getOccuInDefQrs' uses the pattern directly.&#xA;`getOccurs' returns a _list_ of positions, possibly empty."/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="getOccursInDef"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value="getOccursInDef[lhs_String, pattern_]  Lists the positions of occurrences of a pattern `pattern'&#xA;in the definition of variable `lhs' inside an ALPHA program `sys'&#xA;(default $result). If `rank' is not given, the positions of&#xA;all occurrences is returned, otherwise rank specifies which occurrence&#xA;to report ( 1 = first, 2 = second, {1,2}= first and second, etc).&#xA;Returns a Mathematica position specifier.&#xA;Can also be called in the following way:&#xA;getOccursInDef[sys_Alpha`system, lhs_String, pattern_],&#xA;getOccursInDef[lhs_, pattern_, rank:(_Integer | {_Integer..})],&#xA;getOccursInDef[sys_Alpha`system, lhs_, pattern_,&#xA;rank:(_Integer | {_Integer..})]"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="getOccursInDef"/>
                  <children xsi:type="mathematica:StringLeaf" value="notes"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                  <children xsi:type="mathematica:StringLeaf" value="The pattern can be any Mathematica expression, e.g., 'Alpha`var[&quot;A&quot;]'.&#xA;&#xA;The paths returned by this function are given wrt. the root of the tree&#xA;passed as parameter. It is up to the user to ensure that he uses them with&#xA;the same tree."/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                    <children xsi:type="mathematica:SymbolLeaf" name="occursInDefQ"/>
                    <children xsi:type="mathematica:StringLeaf" value="usage"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:StringLeaf" value="occursInDefQ[varLHS_String,pattern_] Predicate.&#xA; Indicates whether or not a pattern appears on the RHS&#xA;of the definition of a variable.&#xA;Returns 'True' if the pattern occurs in the RHS of the equation defining&#xA;the LHS variable. can also be called with a system as first argument"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                      <children xsi:type="mathematica:SymbolLeaf" name="unusedVarQ"/>
                      <children xsi:type="mathematica:StringLeaf" value="usage"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:StringLeaf" value="unusedVarQ[var_String] Checks whether the local or input variable &#xA;`var' is used in RHS of some&#xA;equation or not in $result. unusedVarQ[var_String] &#xA;Checks whether the  variable &#xA;`var' is used in system `sys'. returns&#xA;'True' if the variable occurs in at least one equation, False otherwise."/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="removeUnusedVar"/>
                        <children xsi:type="mathematica:StringLeaf" value="usage"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                        <children xsi:type="mathematica:StringLeaf" value="removeUnusedVar[ast,var] removes an unused local variable definition. &#xA;`var' can be a string or a symbol. `ast' defaults to Alpha`$result.&#xA;Returns the program with the declaration and the definition of&#xA;the variable removed."/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                          <children xsi:type="mathematica:SymbolLeaf" name="removeUnusedVar"/>
                          <children xsi:type="mathematica:StringLeaf" value="notes"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:StringLeaf" value="'removeUnusedVar' uses the predicate 'unusedVarQ' to check if the variable&#xA;given as parameter is actually unused."/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                            <children xsi:type="mathematica:SymbolLeaf" name="removeUnusedVar"/>
                            <children xsi:type="mathematica:StringLeaf" value="qv"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                            <children xsi:type="mathematica:StringLeaf" value="&#xA;functions:unusedVarQ, removeAllUnusedVars;&#xA;&#xA;variables:Alpha`$result, Alpha`$program;&#xA;&#xA;packages:&quot;Alpha`&quot;.&#xA;"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                              <children xsi:type="mathematica:SymbolLeaf" name="removeAllUnusedVars"/>
                              <children xsi:type="mathematica:StringLeaf" value="usage"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                              <children xsi:type="mathematica:StringLeaf" value="removeAllUnusedVars[] Removes the definitions of all unused local&#xA;  variables of $result.&#xA;Returns the program with declarations and definitions of the relevant&#xA;variables removed. removeAllUnusedVars[sys] applies to system `sys',&#xA;does not modify $result"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                <children xsi:type="mathematica:SymbolLeaf" name="removeAllUnusedVars"/>
                                <children xsi:type="mathematica:StringLeaf" value="notes"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                <children xsi:type="mathematica:StringLeaf" value="'removeAllUnusedVars' uses the predicate 'unusedVarQ' to build the list of&#xA;unused variables, then it removes the corresponding declarations and&#xA;definitions."/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                  <children xsi:type="mathematica:SymbolLeaf" name="removeAllUnusedVars"/>
                                  <children xsi:type="mathematica:StringLeaf" value="qv"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                  <children xsi:type="mathematica:StringLeaf" value="&#xA;functions:unusedVarQ, removeUnusedVar;&#xA;&#xA;variables:Alpha`$result, Alpha`$program;&#xA;&#xA;packages:&quot;Alpha`&quot;.&#xA;"/>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="addLocal"/>
                                    <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:StringLeaf" value="see addlocal"/>
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
        <children xsi:type="mathematica:SymbolLeaf" name="addlocal"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="addlocal[var_String, expression_String] declares a new local variable&#xA;`var' in $result and defines is as `expression' on the domain of&#xA;`expression' (see expDomain[]).  All instances of `expression' in&#xA;$result are replaced with the variable `var'.&#xA;addlocal[sys_Alpha`system, var_String, expression_String] declares a&#xA;new local variable `var', defines is as `expression', all instances of&#xA;`expression' in `sys' are replaced with the variable `var', the new&#xA;system is returned. addlocal[sys_Alpha`system, var_String, pos_List]&#xA;adds a new local variable `var', defined on the context domain of `pos'&#xA;(see getContextDomain[]) as the expression at position list `pos', and&#xA;replaces only this expression with an instance of var. The modified&#xA;system is returned."/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="addLocalLHS"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="addLocalRHS[var_String, expression_String] uses is similar to addlocal (see addlocal) but its action is more clearly defined &#xA;from a set of equation which is like:  A=...;X=...A... , addLocalLHS[&quot;B&quot;,&quot;A&quot;] changes it into B=A;A=...;X=...B.... &#xA;(B is added on the LHS of the equation using A)"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="addLocalRHS"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="addLocalRHS[var_String, expression_String]  is exactly  to addlocal (see addlocal) but its action is more clearly defined &#xA;from a set of equation which is like:  A=Y;X=...A... , addLocalRHS[&quot;B&quot;,&quot;A&quot;] changes it into A=B;B=Y;X=...B...., (B is added on the RHS of the &#xA;equation using A) exept if A is an &#xA;input in which case it acts as  addLocalLHS (B=A;X=...B....)"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="addlocal"/>
                <children xsi:type="mathematica:StringLeaf" value="invalidPos"/>
              </children>
            </children>
            <children xsi:type="mathematica:StringLeaf" value="Not the position of an expression"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="addlocal"/>
        <children xsi:type="mathematica:StringLeaf" value="empty"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="Domain of new variable is empty"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="addlocal"/>
        <children xsi:type="mathematica:StringLeaf" value="params"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="wrong parameters"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="addlocal"/>
        <children xsi:type="mathematica:StringLeaf" value="notes"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="`addlocal' is the inverse transformation of&#xA;`substituteInDef'."/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="getNewName"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="getNewName[var_String] checks that the&#xA;identificator &quot;var&quot; is not already used in $result and returns it if&#xA;not. If this identificator already exists, it return a modified&#xA;version of &quot;var&quot; by duplicating its last letter,&#xA;getNewName[sys_system, var_String] checks in sys"/>
            <children xsi:type="mathematica:ASTNode" name="Begin">
              <children xsi:type="mathematica:StringLeaf" value="`Private`"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="vuewTrucDontJeNesaispasquoifaire"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="declares a new local variable&#xA;`var' in $result and defines is as `expression' on the domain of&#xA;`expression' (see expDomain[]).  All instances of `expression' in&#xA;$result are replaced with the variable `var'.&#xA;addlocal[sys_Alpha`system, var_String, expression_String] declares a&#xA;new local variable `var', defines is as `expression', all instances of&#xA;`expression' in `sys' are replaced with the variable `var', the new&#xA;system is returned. addlocal[sys_Alpha`system, var_String, pos_List]&#xA;adds a new local variable `var', defined on the context domain of `pos'&#xA;(see getContextDomain[]) as the expression at position list `pos', and&#xA;replaces only this expression with an instance of var. The modified&#xA;system is returned."/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="getInteractive"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value="Function. Finds occurrences specified interactively. &#xA;&#xA;Parameters: &#xA;1)&#xA;an Alpha syntax tree (defaults to 'Alpha`$result',) &#xA;2) external&#xA;representation of the occurrence &#xA;(String.) &#xA;&#xA;Returns the position of the occurrence or the list of selected&#xA;occurrence positions if multiple matches were found and selected. Both&#xA;parameters may be omitted."/>
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="getInteractive"/>
                  <children xsi:type="mathematica:StringLeaf" value="notes"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                  <children xsi:type="mathematica:StringLeaf" value="'getInteractive' asks the user if the search has to be restricted to a&#xA;single equation. In the case where multiple matches are found, it also asks&#xA;to choose the relevant ones. The occurrences are always extracted in&#xA;depth-first, left-to-right order."/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                    <children xsi:type="mathematica:SymbolLeaf" name="getInteractive"/>
                    <children xsi:type="mathematica:StringLeaf" value="qv"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                  <children xsi:type="mathematica:StringLeaf" value="functions:any interactive functions requiring occurrence &#xA;&#xA;specifications;&#xA;&#xA;variables:Alpha`$result;&#xA;&#xA;packages:&quot;Alpha`&quot;, any package containing occurrence-based&#xA;&#xA; functions."/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                    <children xsi:type="mathematica:SymbolLeaf" name="replaceDefinition"/>
                  </children>
                </children>
              </children>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="replaceDefinition">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="replaceDefinition">
        <children xsi:type="mathematica:ASTNode" name="ToString">
          <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
        </children>
        <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="replaceDefinition">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
        <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
      <children xsi:type="mathematica:ASTNode" name="replaceDefinition"/>
      <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
      <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
    </children>
  </children>
  <children xsi:type="mathematica:ASTNode" name="If">
    <children xsi:type="mathematica:ASTNode" name="SameQ"/>
  </children>
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
  </children>
</mathematica:BuiltInNode>
