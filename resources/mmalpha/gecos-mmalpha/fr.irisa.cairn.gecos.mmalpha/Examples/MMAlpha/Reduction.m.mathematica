<?xml version="1.0" encoding="ASCII"?>
<mathematica:BuiltInNode xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mathematica="http://www.irisa.fr/cairn/model/xtext/Mathematica" keyword="Protect">
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="BeginPackage">
          <children xsi:type="mathematica:StringLeaf" value="Alpha`Reduction`"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Domlib`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Options`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Matrix`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Tables`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Semantics`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Normalization`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Substitution`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Pipeline`"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="Reduction"/>
          <children xsi:type="mathematica:StringLeaf" value="usage"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="Package. Contains transformations to deal with reduction operators."/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="serializeReduce[pos, spec_String] serializes the reduction at&#xA;position pos in $result using serialization specifier spec.&#xA;Parameter pos may be either a position in the AST, or the name&#xA;(string) of a variable whose definition has the form &quot;pos = reduction&quot;.&#xA;serializeReduce[sys, pos_List, spec_String] does the same to program&#xA;in symbol sys.  Parameter spec is a string containing the new&#xA;variable name composed with the new serialized dependence (parameters&#xA;need not be given explicitly), for example: &quot;Z.(i,k->i,k-1)&quot; means&#xA;that the serialized variable will be &quot;Z&quot; and the serialize direction&#xA;will be the vector (0,-1)."/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="isolateReductions"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:StringLeaf" value="isolateReductions[] locates all the reductions in a system and isolates&#xA;these reductions in new equations"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="isolateOneReduction"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="isolates one reduction"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="splitReduction"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="splitReduction[y] tries to rewrite the reduction at rhs of symbol y&#xA;as a sequence of reduction"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
      <children xsi:type="mathematica:ASTNode" name="Begin">
        <children xsi:type="mathematica:StringLeaf" value="`Private`"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
        <children xsi:type="mathematica:SymbolLeaf" name="PtoZ"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="PtoZ"/>
        <children xsi:type="mathematica:StringLeaf" value="params"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="wrong parameters"/>
          <children xsi:type="mathematica:ASTNode" name="PtoZ">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="a"/>
              <children xsi:type="mathematica:ASTNode" name="domain">
                <children xsi:type="mathematica:IntLeaf"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:SymbolLeaf" name="a"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="PtoZ">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="po"/>
          <children xsi:type="mathematica:ASTNode" name="domain">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="id"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:ASTNode" name="Repeated">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                      <children xsi:type="mathematica:SymbolLeaf" name="pol"/>
                    </children>
                  </children>
                </children>
              </children>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:ASTNode" name="domain">
          <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:ASTNode" name="zpol">
              <children xsi:type="mathematica:ASTNode" name="matrix">
                <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                  <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                  <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                <children xsi:type="mathematica:ASTNode" name="IdentityMatrix">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                    <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="p"/>
            </children>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:ASTNode" name="PtoZ">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="a"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:SymbolLeaf" name="a"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:ASTNode" name="PtoZ">
          <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Message">
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="PtoZ"/>
            <children xsi:type="mathematica:StringLeaf" value="params"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
        <children xsi:type="mathematica:SymbolLeaf" name="redundantQ"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:ASTNode" name="redundantQ">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="m"/>
            <children xsi:type="mathematica:ASTNode" name="matrix">
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="r"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="c"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:ASTNode" name="Or">
          <children xsi:type="mathematica:ASTNode" name="identityQ">
            <children xsi:type="mathematica:SymbolLeaf" name="m"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="Equal">
            <children xsi:type="mathematica:ASTNode" name="Drop">
              <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
              <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="Table">
              <children xsi:type="mathematica:IntLeaf"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                  <children xsi:type="mathematica:SymbolLeaf" name="r"/>
                  <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="j"/>
                <children xsi:type="mathematica:SymbolLeaf" name="c"/>
              </children>
            </children>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
        <children xsi:type="mathematica:SymbolLeaf" name="ZtoP"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="ZtoP"/>
          <children xsi:type="mathematica:StringLeaf" value="params"/>
        </children>
        <children xsi:type="mathematica:StringLeaf" value="wrong parameters"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:ASTNode" name="ZtoP">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="zp"/>
            <children xsi:type="mathematica:ASTNode" name="domain">
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                  <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="z"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:ASTNode" name="Repeated">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                        <children xsi:type="mathematica:SymbolLeaf" name="zpol"/>
                      </children>
                    </children>
                  </children>
                </children>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="If">
            <children xsi:type="mathematica:ASTNode" name="And">
              <children xsi:type="mathematica:ASTNode" name="redundantQ">
                <children xsi:type="mathematica:ASTNode" name="Part">
                  <children xsi:type="mathematica:SymbolLeaf" name="z"/>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="SameQ">
                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                  <children xsi:type="mathematica:SymbolLeaf" name="z"/>
                </children>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="domain">
              <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
              <children xsi:type="mathematica:ASTNode" name="Part">
                <children xsi:type="mathematica:SymbolLeaf" name="z"/>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
                <children xsi:type="mathematica:IntLeaf" value="3"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="Part">
                <children xsi:type="mathematica:SymbolLeaf" name="z"/>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
                <children xsi:type="mathematica:IntLeaf" value="2"/>
              </children>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="zp"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:ASTNode" name="ZtoP">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="a"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:ASTNode" name="ZtoP">
            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Message">
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="ZtoP"/>
              <children xsi:type="mathematica:StringLeaf" value="params"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="splitReduction"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:ASTNode" name="Options">
            <children xsi:type="mathematica:SymbolLeaf" name="splitReduction"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
              <children xsi:type="mathematica:SymbolLeaf" name="debug"/>
              <children xsi:type="mathematica:SymbolLeaf" name="False"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:ASTNode" name="splitReduction">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="s"/>
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
            <children xsi:type="mathematica:BuiltInNode" keyword="Module">
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="temp"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="temp"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                <children xsi:type="mathematica:ASTNode" name="Check">
                  <children xsi:type="mathematica:ASTNode" name="splitReduction"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="temp"/>
              </children>
            </children>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:ASTNode" name="splitReduction">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="system"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="s"/>
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
            <children xsi:type="mathematica:BuiltInNode" keyword="Module">
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                <children xsi:type="mathematica:SymbolLeaf" name="op"/>
                <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                <children xsi:type="mathematica:SymbolLeaf" name="h"/>
                <children xsi:type="mathematica:SymbolLeaf" name="u"/>
                <children xsi:type="mathematica:SymbolLeaf" name="mmah"/>
                <children xsi:type="mathematica:SymbolLeaf" name="mmaf"/>
                <children xsi:type="mathematica:SymbolLeaf" name="mmau"/>
                <children xsi:type="mathematica:SymbolLeaf" name="f1"/>
                <children xsi:type="mathematica:SymbolLeaf" name="indexes"/>
                <children xsi:type="mathematica:SymbolLeaf" name="pm"/>
                <children xsi:type="mathematica:SymbolLeaf" name="pmNumber"/>
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
                      <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="Not">
                    <children xsi:type="mathematica:ASTNode" name="MemberQ">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Union">
                        <children xsi:type="mathematica:ASTNode" name="getLocalVars">
                          <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="getOutputVars">
                          <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="splitReduction"/>
                        <children xsi:type="mathematica:StringLeaf" value="wrgvar"/>
                      </children>
                      <children xsi:type="mathematica:StringLeaf" value="`1` should be a local or output var of this system"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Throw">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                          <children xsi:type="mathematica:SymbolLeaf" name="splitReduction"/>
                          <children xsi:type="mathematica:StringLeaf" value="wrgvar"/>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Check">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                    <children xsi:type="mathematica:ASTNode" name="getEquation">
                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="splitReduction"/>
                        <children xsi:type="mathematica:StringLeaf" value="wrgequ"/>
                      </children>
                      <children xsi:type="mathematica:StringLeaf" value="there is no equation with `s` as lhs"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Throw">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                          <children xsi:type="mathematica:SymbolLeaf" name="splitReduction"/>
                          <children xsi:type="mathematica:StringLeaf" value="wrgequ"/>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Check">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                      <children xsi:type="mathematica:IntLeaf" value="2"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="splitReduction"/>
                        <children xsi:type="mathematica:StringLeaf" value="wrgequ1"/>
                      </children>
                      <children xsi:type="mathematica:StringLeaf" value="rhs of `s` is not a reduction"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Throw">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                          <children xsi:type="mathematica:SymbolLeaf" name="splitReduction"/>
                          <children xsi:type="mathematica:StringLeaf" value="wrgequ"/>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="s"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                    <children xsi:type="mathematica:ASTNode" name="Head">
                      <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="reduce"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                        <children xsi:type="mathematica:StringLeaf" value="notared"/>
                      </children>
                      <children xsi:type="mathematica:StringLeaf" value="selected expression is not a reduction"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Throw">
                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                            <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                            <children xsi:type="mathematica:StringLeaf" value="notared"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="op"/>
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="Operator: "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="op"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                    <children xsi:type="mathematica:IntLeaf" value="2"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="Dep function: "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                    <children xsi:type="mathematica:IntLeaf" value="3"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="Expression: "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="pm"/>
                  <children xsi:type="mathematica:ASTNode" name="getSystemParameters">
                    <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="pmNumber"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                    <children xsi:type="mathematica:SymbolLeaf" name="pm"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="indexes"/>
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                    <children xsi:type="mathematica:IntLeaf" value="3"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="indexes : "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="indexes"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="mmaf"/>
                  <children xsi:type="mathematica:ASTNode" name="alphaToMmaMatrix">
                    <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="mmaf : "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="mmaf"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="mmaf"/>
                  <children xsi:type="mathematica:ASTNode" name="Drop">
                    <children xsi:type="mathematica:SymbolLeaf" name="mmaf"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="pmNumber"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="mmaf : "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="mmaf"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                    <children xsi:type="mathematica:SymbolLeaf" name="mmaf"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="mmaf"/>
                    <children xsi:type="mathematica:ASTNode" name="Transpose">
                      <children xsi:type="mathematica:ASTNode" name="Drop">
                        <children xsi:type="mathematica:ASTNode" name="Transpose">
                          <children xsi:type="mathematica:SymbolLeaf" name="mmaf"/>
                        </children>
                        <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="mmaf : "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="mmaf"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="f1"/>
                  <children xsi:type="mathematica:ASTNode" name="mmaToAlphaMatrix">
                    <children xsi:type="mathematica:SymbolLeaf" name="mmaf"/>
                    <children xsi:type="mathematica:ASTNode" name="Drop">
                      <children xsi:type="mathematica:SymbolLeaf" name="indexes"/>
                      <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="f1 : "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="f1"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:SymbolLeaf" name="h"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="u"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="hermite">
                    <children xsi:type="mathematica:SymbolLeaf" name="f1"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Print">
                  <children xsi:type="mathematica:StringLeaf" value="Hermite form :"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                  <children xsi:type="mathematica:SymbolLeaf" name="ashow"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:SymbolLeaf" name="h"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="u"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="mmaf"/>
                  <children xsi:type="mathematica:ASTNode" name="alphaToMmaMatrix">
                    <children xsi:type="mathematica:SymbolLeaf" name="f1"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="MMa form of f "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="mmaf"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="mmah"/>
                  <children xsi:type="mathematica:ASTNode" name="alphaToMmaMatrix">
                    <children xsi:type="mathematica:SymbolLeaf" name="h"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="MMa form of h "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="mmah"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="mmau"/>
                  <children xsi:type="mathematica:ASTNode" name="alphaToMmaMatrix">
                    <children xsi:type="mathematica:SymbolLeaf" name="u"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                  <children xsi:type="mathematica:ASTNode" name="Print">
                    <children xsi:type="mathematica:StringLeaf" value="MMa form of u "/>
                    <children xsi:type="mathematica:SymbolLeaf" name="mmau"/>
                  </children>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
              </children>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="splitReduction"/>
            <children xsi:type="mathematica:StringLeaf" value="params"/>
          </children>
          <children xsi:type="mathematica:StringLeaf" value="wrong arguments"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:ASTNode" name="splitReduction">
            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Message">
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="splitReduction"/>
              <children xsi:type="mathematica:StringLeaf" value="params"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
              <children xsi:type="mathematica:SymbolLeaf" name="partPos"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="partPos">
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="expr"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                  <children xsi:type="mathematica:ASTNode" name="BlankSequence"/>
                </children>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:ASTNode" name="Part">
                <children xsi:type="mathematica:SymbolLeaf" name="expr"/>
                <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                <children xsi:type="mathematica:SymbolLeaf" name="opIdentity"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="opIdentity">
                <children xsi:type="mathematica:SymbolLeaf" name="add"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:ASTNode" name="const">
                  <children xsi:type="mathematica:IntLeaf"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="opIdentity">
                  <children xsi:type="mathematica:SymbolLeaf" name="mul"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                  <children xsi:type="mathematica:ASTNode" name="const">
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="opIdentity">
                    <children xsi:type="mathematica:SymbolLeaf" name="max"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:ASTNode" name="const">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                        <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="Infinity"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="opIdentity">
                      <children xsi:type="mathematica:SymbolLeaf" name="min"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:ASTNode" name="const">
                        <children xsi:type="mathematica:SymbolLeaf" name="Infinity"/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="opIdentity">
                        <children xsi:type="mathematica:SymbolLeaf" name="and"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                        <children xsi:type="mathematica:ASTNode" name="const">
                          <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="opIdentity">
                          <children xsi:type="mathematica:SymbolLeaf" name="or"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:ASTNode" name="const">
                            <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="opIdentity">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:ASTNode" name="Print">
                              <children xsi:type="mathematica:StringLeaf" value="Reduce: ? reduction must be over a commutative/associative operator."/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="const">
                              <children xsi:type="mathematica:IntLeaf"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                            <children xsi:type="mathematica:SymbolLeaf" name="outExp"/>
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
          <children xsi:type="mathematica:ASTNode" name="outExp">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="f"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="Y"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="In"/>
              <children xsi:type="mathematica:ASTNode" name="domain">
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="ix"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="ps"/>
                    <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="ctx"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="idx"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="id"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Module">
            <children xsi:type="mathematica:BuiltInNode" keyword="List">
              <children xsi:type="mathematica:SymbolLeaf" name="P"/>
              <children xsi:type="mathematica:SymbolLeaf" name="P1"/>
              <children xsi:type="mathematica:SymbolLeaf" name="g"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
              <children xsi:type="mathematica:ASTNode" name="If">
                <children xsi:type="mathematica:ASTNode" name="DomEmptyQ">
                  <children xsi:type="mathematica:SymbolLeaf" name="In"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Return">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:ASTNode" name="restrict">
                      <children xsi:type="mathematica:SymbolLeaf" name="ctx"/>
                      <children xsi:type="mathematica:ASTNode" name="affine">
                        <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                        <children xsi:type="mathematica:ASTNode" name="idMatrix">
                          <children xsi:type="mathematica:SymbolLeaf" name="idx"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                        </children>
                      </children>
                    </children>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="P"/>
                <children xsi:type="mathematica:ASTNode" name="domain">
                  <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="ix"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="g"/>
                <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                  <children xsi:type="mathematica:ASTNode" name="inverseInContext">
                    <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="P"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="idx"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:IntLeaf" value="3"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="P1"/>
                <children xsi:type="mathematica:ASTNode" name="DomZPreimage">
                  <children xsi:type="mathematica:SymbolLeaf" name="P"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="g"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="Prepend">
                <children xsi:type="mathematica:ASTNode" name="outExp">
                  <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="Y"/>
                  <children xsi:type="mathematica:ASTNode" name="DomDifference">
                    <children xsi:type="mathematica:SymbolLeaf" name="In"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="P"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="DomDifference">
                    <children xsi:type="mathematica:SymbolLeaf" name="ctx"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="P1"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="idx"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="id"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="restrict">
                  <children xsi:type="mathematica:SymbolLeaf" name="P1"/>
                  <children xsi:type="mathematica:ASTNode" name="affine">
                    <children xsi:type="mathematica:SymbolLeaf" name="Y"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="g"/>
                  </children>
                </children>
              </children>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="outExp"/>
            <children xsi:type="mathematica:StringLeaf" value="params"/>
          </children>
          <children xsi:type="mathematica:StringLeaf" value="wrong parameters"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:ASTNode" name="outExp">
            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Message">
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="outExp"/>
              <children xsi:type="mathematica:StringLeaf" value="params"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:ASTNode" name="Options">
            <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
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
              <children xsi:type="mathematica:SymbolLeaf" name="invert"/>
              <children xsi:type="mathematica:SymbolLeaf" name="False"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:ASTNode" name="serializeReduce">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
              <children xsi:type="mathematica:ASTNode" name="Alternatives">
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                    <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="serializeReduce">
                <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                <children xsi:type="mathematica:StringLeaf" value=""/>
                <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
              <children xsi:type="mathematica:ASTNode" name="serializeReduce">
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                  <children xsi:type="mathematica:ASTNode" name="Alternatives">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                        <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="spec"/>
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
                  <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:SymbolLeaf" name="temp"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="temp"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                      <children xsi:type="mathematica:ASTNode" name="Check">
                        <children xsi:type="mathematica:ASTNode" name="serializeReduce"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="spec"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="temp"/>
                    </children>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
              <children xsi:type="mathematica:ASTNode" name="serializeReduce">
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                    <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="posSpec"/>
                  <children xsi:type="mathematica:ASTNode" name="Alternatives">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                        <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="spec"/>
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
                    <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                        <children xsi:type="mathematica:SymbolLeaf" name="specAST"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="Y"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="T"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="op"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="idx"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="Ydom5"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="Ydom4"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="Ydom3"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="Ydom2"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="Ydom1"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="Ydom"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="Ytyp"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="Yeqn"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="vrb"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="result"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="nospec"/>
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
                              <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="normOpt"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                              <children xsi:type="mathematica:SymbolLeaf" name="norm"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Options">
                              <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="inv"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                              <children xsi:type="mathematica:SymbolLeaf" name="invert"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Options">
                              <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="nospec"/>
                          <children xsi:type="mathematica:ASTNode" name="SameQ">
                            <children xsi:type="mathematica:SymbolLeaf" name="spec"/>
                            <children xsi:type="mathematica:StringLeaf" value=""/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:ASTNode" name="MatchQ">
                            <children xsi:type="mathematica:SymbolLeaf" name="posSpec"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                              <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:ASTNode" name="Check">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                                <children xsi:type="mathematica:ASTNode" name="Position">
                                  <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                  <children xsi:type="mathematica:ASTNode" name="getDefinition">
                                    <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="posSpec"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                    <children xsi:type="mathematica:StringLeaf" value="wrongpos"/>
                                  </children>
                                  <children xsi:type="mathematica:StringLeaf" value="position is not a local var of sys"/>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="Throw">
                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                        <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                        <children xsi:type="mathematica:StringLeaf" value="wrongpos"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                  </children>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="If">
                              <children xsi:type="mathematica:ASTNode" name="SameQ">
                                <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                    <children xsi:type="mathematica:StringLeaf" value="wrongsymb"/>
                                  </children>
                                  <children xsi:type="mathematica:StringLeaf" value="the symbol does not correspond to any equation."/>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="Throw">
                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                        <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                        <children xsi:type="mathematica:StringLeaf" value="wrongsymb"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                  </children>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                              <children xsi:type="mathematica:ASTNode" name="First">
                                <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="If">
                            <children xsi:type="mathematica:ASTNode" name="SameQ">
                              <children xsi:type="mathematica:SymbolLeaf" name="posSpec"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                  <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                  <children xsi:type="mathematica:StringLeaf" value="nopos"/>
                                </children>
                                <children xsi:type="mathematica:StringLeaf" value="no position given"/>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="Throw">
                                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                      <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                      <children xsi:type="mathematica:StringLeaf" value="nopos"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="posSpec"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:ASTNode" name="Not">
                            <children xsi:type="mathematica:SymbolLeaf" name="nospec"/>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:ASTNode" name="Check">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="specAST"/>
                                <children xsi:type="mathematica:ASTNode" name="readExp">
                                  <children xsi:type="mathematica:SymbolLeaf" name="spec"/>
                                  <children xsi:type="mathematica:ASTNode" name="If">
                                    <children xsi:type="mathematica:ASTNode" name="SameQ">
                                      <children xsi:type="mathematica:ASTNode" name="Head">
                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                          <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                                          <children xsi:type="mathematica:IntLeaf" value="3"/>
                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:SymbolLeaf" name="pol"/>
                                    </children>
                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                      <children xsi:type="mathematica:IntLeaf" value="2"/>
                                      <children xsi:type="mathematica:IntLeaf" value="2"/>
                                    </children>
                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                      <children xsi:type="mathematica:IntLeaf" value="2"/>
                                      <children xsi:type="mathematica:IntLeaf" value="3"/>
                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                      <children xsi:type="mathematica:IntLeaf" value="3"/>
                                    </children>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                    <children xsi:type="mathematica:StringLeaf" value="errorReadExp"/>
                                  </children>
                                  <children xsi:type="mathematica:StringLeaf" value="could not parse second parameter"/>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="Throw">
                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                        <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                        <children xsi:type="mathematica:StringLeaf" value="errorReadExp"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                  </children>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="If">
                              <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                              <children xsi:type="mathematica:ASTNode" name="Print">
                                <children xsi:type="mathematica:SymbolLeaf" name="specAST"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="If">
                              <children xsi:type="mathematica:ASTNode" name="Not">
                                <children xsi:type="mathematica:ASTNode" name="MatchQ">
                                  <children xsi:type="mathematica:SymbolLeaf" name="specAST"/>
                                  <children xsi:type="mathematica:ASTNode" name="affine">
                                    <children xsi:type="mathematica:ASTNode" name="var">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                      <children xsi:type="mathematica:SymbolLeaf" name="matrix"/>
                                    </children>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                    <children xsi:type="mathematica:StringLeaf" value="errorSpec"/>
                                  </children>
                                  <children xsi:type="mathematica:StringLeaf" value="spec should have the form &quot;Var.dep&quot;."/>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="Throw">
                                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                        <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                        <children xsi:type="mathematica:StringLeaf" value="errorSpec"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                  </children>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:SymbolLeaf" name="nospec"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="Y"/>
                            <children xsi:type="mathematica:ASTNode" name="ToString">
                              <children xsi:type="mathematica:ASTNode" name="Unique">
                                <children xsi:type="mathematica:StringLeaf" value="ser"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="Y"/>
                            <children xsi:type="mathematica:ASTNode" name="Part">
                              <children xsi:type="mathematica:SymbolLeaf" name="specAST"/>
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                          <children xsi:type="mathematica:ASTNode" name="Print">
                            <children xsi:type="mathematica:SymbolLeaf" name="Y"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="Check">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                            <children xsi:type="mathematica:ASTNode" name="partPos">
                              <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                <children xsi:type="mathematica:StringLeaf" value="errorpos"/>
                              </children>
                              <children xsi:type="mathematica:StringLeaf" value="wrong position"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Throw">
                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                    <children xsi:type="mathematica:StringLeaf" value="errorpos"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                              </children>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                          <children xsi:type="mathematica:ASTNode" name="Print">
                            <children xsi:type="mathematica:StringLeaf" value="Expression to be reduced is: "/>
                            <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                            <children xsi:type="mathematica:ASTNode" name="Head">
                              <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                            </children>
                            <children xsi:type="mathematica:SymbolLeaf" name="reduce"/>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                <children xsi:type="mathematica:StringLeaf" value="notared"/>
                              </children>
                              <children xsi:type="mathematica:StringLeaf" value="selected expression is not a reduction"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Throw">
                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                    <children xsi:type="mathematica:StringLeaf" value="notared"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                              </children>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="op"/>
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                          <children xsi:type="mathematica:ASTNode" name="Print">
                            <children xsi:type="mathematica:StringLeaf" value="Operator: "/>
                            <children xsi:type="mathematica:SymbolLeaf" name="op"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                          <children xsi:type="mathematica:ASTNode" name="Print">
                            <children xsi:type="mathematica:StringLeaf" value="Dep function: "/>
                            <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:SymbolLeaf" name="red"/>
                            <children xsi:type="mathematica:IntLeaf" value="3"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                          <children xsi:type="mathematica:ASTNode" name="Print">
                            <children xsi:type="mathematica:StringLeaf" value="Expression: "/>
                            <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                              <children xsi:type="mathematica:ASTNode" name="Part">
                                <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                                <children xsi:type="mathematica:IntLeaf" value="2"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                <children xsi:type="mathematica:ASTNode" name="Part">
                                  <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                <children xsi:type="mathematica:StringLeaf" value="onedim"/>
                              </children>
                              <children xsi:type="mathematica:StringLeaf" value="cannot serialize multidimensional reductions"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Throw">
                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                    <children xsi:type="mathematica:StringLeaf" value="onedim"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                              </children>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:ASTNode" name="Not">
                            <children xsi:type="mathematica:SymbolLeaf" name="nospec"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="T"/>
                            <children xsi:type="mathematica:ASTNode" name="Part">
                              <children xsi:type="mathematica:SymbolLeaf" name="specAST"/>
                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:SymbolLeaf" name="ns"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="ns"/>
                                <children xsi:type="mathematica:ASTNode" name="nullSpaceVectors">
                                  <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="If">
                                <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                    <children xsi:type="mathematica:SymbolLeaf" name="ns"/>
                                  </children>
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                      <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                      <children xsi:type="mathematica:StringLeaf" value="wrngnullspace"/>
                                    </children>
                                    <children xsi:type="mathematica:StringLeaf" value="reduction function must have one and only one null space vector"/>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="Throw">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                        <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                        <children xsi:type="mathematica:StringLeaf" value="wrngnullspace"/>
                                      </children>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="If">
                                <children xsi:type="mathematica:SymbolLeaf" name="inv"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                  <children xsi:type="mathematica:SymbolLeaf" name="ns"/>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                    <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="ns"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="T"/>
                                <children xsi:type="mathematica:ASTNode" name="translationMatrix">
                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                    <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                                    <children xsi:type="mathematica:IntLeaf" value="3"/>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                    <children xsi:type="mathematica:SymbolLeaf" name="ns"/>
                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                          <children xsi:type="mathematica:ASTNode" name="Print">
                            <children xsi:type="mathematica:StringLeaf" value="T matrix is: "/>
                            <children xsi:type="mathematica:SymbolLeaf" name="T"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                            <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                            <children xsi:type="mathematica:StringLeaf" value="notatrans"/>
                          </children>
                          <children xsi:type="mathematica:StringLeaf" value="the serialization dependence is not a proper translation"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:ASTNode" name="Or">
                            <children xsi:type="mathematica:ASTNode" name="Not">
                              <children xsi:type="mathematica:ASTNode" name="translationQ">
                                <children xsi:type="mathematica:SymbolLeaf" name="T"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="identityQ">
                              <children xsi:type="mathematica:SymbolLeaf" name="T"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:ASTNode" name="Throw">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                  <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                  <children xsi:type="mathematica:StringLeaf" value="notatrans"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                            <children xsi:type="mathematica:ASTNode" name="Part">
                              <children xsi:type="mathematica:SymbolLeaf" name="T"/>
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Part">
                              <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                <children xsi:type="mathematica:StringLeaf" value="notcompatible"/>
                              </children>
                              <children xsi:type="mathematica:StringLeaf" value="the serialization dependence is not compatible with the dimension of the body of the reduction"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Throw">
                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                    <children xsi:type="mathematica:StringLeaf" value="notcompatible"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                              </children>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                            <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                            <children xsi:type="mathematica:ASTNode" name="composeAffines">
                              <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="T"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:ASTNode" name="Print">
                              <children xsi:type="mathematica:StringLeaf" value="serializeReduce: ? The serialization dependence:"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="ashow">
                              <children xsi:type="mathematica:SymbolLeaf" name="T"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Print">
                              <children xsi:type="mathematica:StringLeaf" value="is not in null space of projection of the reduce:"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="ashow">
                              <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                <children xsi:type="mathematica:StringLeaf" value="error"/>
                              </children>
                              <children xsi:type="mathematica:StringLeaf" value="unexpected error"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Throw">
                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                    <children xsi:type="mathematica:StringLeaf" value="error"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                              </children>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                          <children xsi:type="mathematica:ASTNode" name="expDomain">
                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:ASTNode" name="Print">
                              <children xsi:type="mathematica:StringLeaf" value="Domain of expression in reduction is : "/>
                              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="ashow">
                              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="Ydom5"/>
                          <children xsi:type="mathematica:ASTNode" name="getContextDomain">
                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:ASTNode" name="Print">
                              <children xsi:type="mathematica:StringLeaf" value="Domain of reduction expression (in context) is : "/>
                              <children xsi:type="mathematica:SymbolLeaf" name="Ydom5"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="ashow">
                              <children xsi:type="mathematica:SymbolLeaf" name="Ydom5"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="idx"/>
                          <children xsi:type="mathematica:ASTNode" name="If">
                            <children xsi:type="mathematica:ASTNode" name="SameQ">
                              <children xsi:type="mathematica:ASTNode" name="Head">
                                <children xsi:type="mathematica:ASTNode" name="Part">
                                  <children xsi:type="mathematica:SymbolLeaf" name="Ydom5"/>
                                  <children xsi:type="mathematica:IntLeaf" value="3"/>
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:SymbolLeaf" name="pol"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Part">
                              <children xsi:type="mathematica:SymbolLeaf" name="Ydom5"/>
                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Part">
                              <children xsi:type="mathematica:SymbolLeaf" name="Ydom5"/>
                              <children xsi:type="mathematica:IntLeaf" value="3"/>
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                              <children xsi:type="mathematica:IntLeaf" value="3"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                              <children xsi:type="mathematica:ASTNode" name="Part">
                                <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                              </children>
                              <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                              <children xsi:type="mathematica:SymbolLeaf" name="idx"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:ASTNode" name="Print">
                              <children xsi:type="mathematica:StringLeaf" value="Dimension of reduction does not match its context."/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Throw">
                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                    <children xsi:type="mathematica:StringLeaf" value="error"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                              </children>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="Ydom4"/>
                          <children xsi:type="mathematica:ASTNode" name="DomZPreimage">
                            <children xsi:type="mathematica:SymbolLeaf" name="Ydom5"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="Ydom3"/>
                          <children xsi:type="mathematica:ASTNode" name="DomIntersection">
                            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="Ydom4"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="Ydom2"/>
                          <children xsi:type="mathematica:ASTNode" name="DomZPreimage">
                            <children xsi:type="mathematica:SymbolLeaf" name="Ydom3"/>
                            <children xsi:type="mathematica:ASTNode" name="inverseMatrix">
                              <children xsi:type="mathematica:SymbolLeaf" name="T"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="Ydom1"/>
                          <children xsi:type="mathematica:ASTNode" name="DomUnion">
                            <children xsi:type="mathematica:SymbolLeaf" name="Ydom2"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="Ydom3"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="Ydom"/>
                          <children xsi:type="mathematica:ASTNode" name="DomConvex">
                            <children xsi:type="mathematica:SymbolLeaf" name="Ydom1"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:ASTNode" name="Not">
                            <children xsi:type="mathematica:ASTNode" name="DomEmptyQ">
                              <children xsi:type="mathematica:ASTNode" name="DomDifference">
                                <children xsi:type="mathematica:SymbolLeaf" name="Ydom"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="Ydom1"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:ASTNode" name="Print">
                              <children xsi:type="mathematica:StringLeaf" value="function T cannot totally define f(dom(exp))"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Throw">
                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                                    <children xsi:type="mathematica:StringLeaf" value="error"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                              </children>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="Ytyp"/>
                          <children xsi:type="mathematica:ASTNode" name="expType">
                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="Yeqn"/>
                          <children xsi:type="mathematica:ASTNode" name="equation">
                            <children xsi:type="mathematica:SymbolLeaf" name="Y"/>
                            <children xsi:type="mathematica:ASTNode" name="case">
                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                <children xsi:type="mathematica:ASTNode" name="restrict">
                                  <children xsi:type="mathematica:ASTNode" name="DomDifference">
                                    <children xsi:type="mathematica:SymbolLeaf" name="Ydom"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="Ydom3"/>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="affine">
                                    <children xsi:type="mathematica:ASTNode" name="opIdentity">
                                      <children xsi:type="mathematica:SymbolLeaf" name="op"/>
                                    </children>
                                    <children xsi:type="mathematica:ASTNode" name="idMatrix">
                                      <children xsi:type="mathematica:ASTNode" name="If">
                                        <children xsi:type="mathematica:ASTNode" name="SameQ">
                                          <children xsi:type="mathematica:ASTNode" name="Head">
                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                              <children xsi:type="mathematica:SymbolLeaf" name="Ydom"/>
                                              <children xsi:type="mathematica:IntLeaf" value="3"/>
                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                            </children>
                                          </children>
                                          <children xsi:type="mathematica:SymbolLeaf" name="pol"/>
                                        </children>
                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                          <children xsi:type="mathematica:SymbolLeaf" name="Ydom"/>
                                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                                        </children>
                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                          <children xsi:type="mathematica:SymbolLeaf" name="Ydom"/>
                                          <children xsi:type="mathematica:IntLeaf" value="3"/>
                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                          <children xsi:type="mathematica:IntLeaf" value="3"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                    </children>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="restrict">
                                  <children xsi:type="mathematica:SymbolLeaf" name="Ydom3"/>
                                  <children xsi:type="mathematica:ASTNode" name="binop">
                                    <children xsi:type="mathematica:SymbolLeaf" name="op"/>
                                    <children xsi:type="mathematica:ASTNode" name="affine">
                                      <children xsi:type="mathematica:ASTNode" name="var">
                                        <children xsi:type="mathematica:SymbolLeaf" name="Y"/>
                                      </children>
                                      <children xsi:type="mathematica:SymbolLeaf" name="T"/>
                                    </children>
                                    <children xsi:type="mathematica:SymbolLeaf" name="exp"/>
                                  </children>
                                </children>
                              </children>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="result"/>
                          <children xsi:type="mathematica:ASTNode" name="Insert">
                            <children xsi:type="mathematica:ASTNode" name="Insert">
                              <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                                <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                <children xsi:type="mathematica:ASTNode" name="normalize">
                                  <children xsi:type="mathematica:ASTNode" name="case">
                                    <children xsi:type="mathematica:ASTNode" name="outExp">
                                      <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                                      <children xsi:type="mathematica:ASTNode" name="var">
                                        <children xsi:type="mathematica:SymbolLeaf" name="Y"/>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="DomDifference">
                                        <children xsi:type="mathematica:SymbolLeaf" name="Ydom"/>
                                        <children xsi:type="mathematica:SymbolLeaf" name="Ydom2"/>
                                      </children>
                                      <children xsi:type="mathematica:SymbolLeaf" name="Ydom5"/>
                                      <children xsi:type="mathematica:SymbolLeaf" name="idx"/>
                                      <children xsi:type="mathematica:ASTNode" name="opIdentity">
                                        <children xsi:type="mathematica:SymbolLeaf" name="op"/>
                                      </children>
                                    </children>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="decl">
                                <children xsi:type="mathematica:SymbolLeaf" name="Y"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="Ytyp"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="Ydom"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                <children xsi:type="mathematica:IntLeaf" value="5"/>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:SymbolLeaf" name="Yeqn"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:IntLeaf" value="6"/>
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:SymbolLeaf" name="normOpt"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="result"/>
                            <children xsi:type="mathematica:ASTNode" name="normalize">
                              <children xsi:type="mathematica:SymbolLeaf" name="result"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="result"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                    <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                    <children xsi:type="mathematica:StringLeaf" value="params"/>
                  </children>
                  <children xsi:type="mathematica:StringLeaf" value="wrong parameters"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:ASTNode" name="serializeReduce">
                    <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                      <children xsi:type="mathematica:SymbolLeaf" name="serializeReduce"/>
                      <children xsi:type="mathematica:StringLeaf" value="params"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                  <children xsi:type="mathematica:SymbolLeaf" name="redName"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:ASTNode" name="redName">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                        <children xsi:type="mathematica:SymbolLeaf" name="Symbol"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="StringReplace">
                    <children xsi:type="mathematica:ASTNode" name="StringJoin">
                      <children xsi:type="mathematica:StringLeaf" value="red"/>
                      <children xsi:type="mathematica:ASTNode" name="ToString">
                        <children xsi:type="mathematica:ASTNode" name="Unique">
                          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                      <children xsi:type="mathematica:StringLeaf" value="$"/>
                      <children xsi:type="mathematica:StringLeaf" value=""/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:ASTNode" name="redName">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="StringReplace">
                    <children xsi:type="mathematica:ASTNode" name="StringJoin">
                      <children xsi:type="mathematica:StringLeaf" value="red"/>
                      <children xsi:type="mathematica:ASTNode" name="ToString">
                        <children xsi:type="mathematica:ASTNode" name="Unique">
                          <children xsi:type="mathematica:ASTNode" name="ToString">
                            <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                          </children>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                      <children xsi:type="mathematica:StringLeaf" value="$"/>
                      <children xsi:type="mathematica:StringLeaf" value=""/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                    <children xsi:type="mathematica:SymbolLeaf" name="redName"/>
                    <children xsi:type="mathematica:StringLeaf" value="params"/>
                  </children>
                  <children xsi:type="mathematica:StringLeaf" value="wrong parameters"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:ASTNode" name="redName">
                    <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                      <children xsi:type="mathematica:SymbolLeaf" name="redName"/>
                      <children xsi:type="mathematica:StringLeaf" value="params"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                  <children xsi:type="mathematica:SymbolLeaf" name="isolateOneReduction"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:ASTNode" name="Options">
                    <children xsi:type="mathematica:SymbolLeaf" name="isolateOneReduction"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                      <children xsi:type="mathematica:SymbolLeaf" name="debug"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:ASTNode" name="isolateOneReduction">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                        <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                          <children xsi:type="mathematica:ASTNode" name="Check">
                            <children xsi:type="mathematica:ASTNode" name="isolateOneReduction"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                    </children>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                <children xsi:type="mathematica:ASTNode" name="isolateOneReduction">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                      <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
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
                          <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="posEquation"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="newLhs"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="expression"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="redEquation"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
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
                                <children xsi:type="mathematica:SymbolLeaf" name="isolateOneReduction"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="posEquation"/>
                            <children xsi:type="mathematica:ASTNode" name="Take">
                              <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="Check">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                              <children xsi:type="mathematica:ASTNode" name="First">
                                <children xsi:type="mathematica:ASTNode" name="getPart">
                                  <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="posEquation"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                  <children xsi:type="mathematica:SymbolLeaf" name="isolateOneReduction"/>
                                  <children xsi:type="mathematica:StringLeaf" value="error1"/>
                                </children>
                                <children xsi:type="mathematica:StringLeaf" value="could not get lhs"/>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="Throw">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="isolateOneReduction"/>
                                    <children xsi:type="mathematica:StringLeaf" value="error1"/>
                                  </children>
                                </children>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="If">
                            <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                            <children xsi:type="mathematica:ASTNode" name="Print">
                              <children xsi:type="mathematica:StringLeaf" value="lhs: "/>
                              <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="newLhs"/>
                            <children xsi:type="mathematica:ASTNode" name="redName">
                              <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="If">
                            <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                            <children xsi:type="mathematica:ASTNode" name="Print">
                              <children xsi:type="mathematica:StringLeaf" value="newLhs: "/>
                              <children xsi:type="mathematica:SymbolLeaf" name="newLhs"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="redEquation"/>
                            <children xsi:type="mathematica:ASTNode" name="getPart">
                              <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="If">
                            <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                            <children xsi:type="mathematica:ASTNode" name="Print">
                              <children xsi:type="mathematica:StringLeaf" value="reduction equation: "/>
                              <children xsi:type="mathematica:SymbolLeaf" name="redEquation"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                            <children xsi:type="mathematica:ASTNode" name="addLocal">
                              <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="newLhs"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                <children xsi:type="mathematica:SymbolLeaf" name="contextDomain"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="If">
                            <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                            <children xsi:type="mathematica:ASTNode" name="ashow">
                              <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                        </children>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                      <children xsi:type="mathematica:SymbolLeaf" name="isolateOneReduction"/>
                      <children xsi:type="mathematica:StringLeaf" value="params"/>
                    </children>
                    <children xsi:type="mathematica:StringLeaf" value="wrong parameters"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                    <children xsi:type="mathematica:ASTNode" name="isolateOneReduction">
                      <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="isolateOneReduction"/>
                        <children xsi:type="mathematica:StringLeaf" value="params"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                    <children xsi:type="mathematica:SymbolLeaf" name="isolateReductions"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                    <children xsi:type="mathematica:ASTNode" name="Options">
                      <children xsi:type="mathematica:SymbolLeaf" name="isolateReductions"/>
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
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                    <children xsi:type="mathematica:ASTNode" name="isolateReductions">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                        <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:SymbolLeaf" name="temp"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="temp"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                          <children xsi:type="mathematica:ASTNode" name="Check">
                            <children xsi:type="mathematica:ASTNode" name="isolateReductions"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="temp"/>
                        </children>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:ASTNode" name="isolateReductions">
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
                          <children xsi:type="mathematica:SymbolLeaf" name="redcases"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="vrb"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="savesys"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="firstRed"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="res"/>
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
                                <children xsi:type="mathematica:SymbolLeaf" name="isolateReductions"/>
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
                                <children xsi:type="mathematica:SymbolLeaf" name="isolateReductions"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="redcases"/>
                            <children xsi:type="mathematica:ASTNode" name="Position">
                              <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                              <children xsi:type="mathematica:ASTNode" name="reduce">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="redcases"/>
                            <children xsi:type="mathematica:ASTNode" name="Select">
                              <children xsi:type="mathematica:SymbolLeaf" name="redcases"/>
                              <children xsi:type="mathematica:ASTNode" name="Function">
                                <children xsi:type="mathematica:ASTNode" name="Greater">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                    <children xsi:type="mathematica:ASTNode" name="Slot">
                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:IntLeaf" value="3"/>
                                </children>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="If">
                            <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                            <children xsi:type="mathematica:ASTNode" name="Print">
                              <children xsi:type="mathematica:StringLeaf" value="Initial reductions: "/>
                              <children xsi:type="mathematica:SymbolLeaf" name="redcases"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="While">
                            <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                              <children xsi:type="mathematica:SymbolLeaf" name="redcases"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="firstRed"/>
                                <children xsi:type="mathematica:ASTNode" name="Part">
                                  <children xsi:type="mathematica:SymbolLeaf" name="redcases"/>
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                                <children xsi:type="mathematica:ASTNode" name="Apply">
                                  <children xsi:type="mathematica:SymbolLeaf" name="Part"/>
                                  <children xsi:type="mathematica:ASTNode" name="Append">
                                    <children xsi:type="mathematica:ASTNode" name="Prepend">
                                      <children xsi:type="mathematica:ASTNode" name="Take">
                                        <children xsi:type="mathematica:SymbolLeaf" name="firstRed"/>
                                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="If">
                                <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                <children xsi:type="mathematica:ASTNode" name="Print">
                                  <children xsi:type="mathematica:StringLeaf" value="lhs: "/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="If">
                                <children xsi:type="mathematica:ASTNode" name="Or">
                                  <children xsi:type="mathematica:SymbolLeaf" name="vrb"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="Print">
                                  <children xsi:type="mathematica:StringLeaf" value="--- Isolating reduction in Definition of "/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="Check">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                  <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                  <children xsi:type="mathematica:ASTNode" name="isolateOneReduction">
                                    <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="firstRed"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="opts"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                      <children xsi:type="mathematica:SymbolLeaf" name="isolateReductions"/>
                                      <children xsi:type="mathematica:StringLeaf" value="error"/>
                                    </children>
                                    <children xsi:type="mathematica:StringLeaf" value="error while calling isolateReduction"/>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="Throw">
                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                          <children xsi:type="mathematica:SymbolLeaf" name="isolateReductions"/>
                                          <children xsi:type="mathematica:StringLeaf" value="error"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:SymbolLeaf" name="savesys"/>
                                    </children>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="ashow">
                                <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="redcases"/>
                                <children xsi:type="mathematica:ASTNode" name="Position">
                                  <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                  <children xsi:type="mathematica:ASTNode" name="reduce">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="redcases"/>
                                <children xsi:type="mathematica:ASTNode" name="Select">
                                  <children xsi:type="mathematica:SymbolLeaf" name="redcases"/>
                                  <children xsi:type="mathematica:ASTNode" name="Function">
                                    <children xsi:type="mathematica:ASTNode" name="Greater">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                        <children xsi:type="mathematica:ASTNode" name="Slot">
                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:IntLeaf" value="3"/>
                                    </children>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="If">
                                <children xsi:type="mathematica:SymbolLeaf" name="dbg"/>
                                <children xsi:type="mathematica:ASTNode" name="Print">
                                  <children xsi:type="mathematica:StringLeaf" value="Reductions at end of loop: "/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="redcases"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                        </children>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                      <children xsi:type="mathematica:SymbolLeaf" name="isolateReductions"/>
                      <children xsi:type="mathematica:StringLeaf" value="params"/>
                    </children>
                    <children xsi:type="mathematica:StringLeaf" value="wrong parameters"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                    <children xsi:type="mathematica:ASTNode" name="isolateReductions">
                      <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="isolateReductions"/>
                        <children xsi:type="mathematica:StringLeaf" value="params"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                      <children xsi:type="mathematica:SymbolLeaf" name="splitReduce"/>
                      <children xsi:type="mathematica:StringLeaf" value="usage"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:StringLeaf" value="splitReduce[sys:_system,pos:_List] tries to separate a reduce of &#xA;sys into two reduce (for example, reduce(+,func,A+B+C) ->&#xA;reduce(+,func,A+B)+reduce(+,func,C)) and return&#xA;the resulting system. The position pos must be the position of the binop&#xA;around which the splitting is done. This should work for any reducable&#xA;operators. splitReduce[pos_List] apply on $result"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                        <children xsi:type="mathematica:SymbolLeaf" name="splitReduce"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                    <children xsi:type="mathematica:ASTNode" name="splitReduce">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                <children xsi:type="mathematica:ASTNode" name="splitReduce"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="If">
                              <children xsi:type="mathematica:ASTNode" name="MatchQ">
                                <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                  <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                            </children>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="splitReduce"/>
                        <children xsi:type="mathematica:StringLeaf" value="WrongPos"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                        <children xsi:type="mathematica:StringLeaf" value=" getPart[sys,`1`] should retrun a binop"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                          <children xsi:type="mathematica:SymbolLeaf" name="splitReduce"/>
                          <children xsi:type="mathematica:StringLeaf" value="reduceNotFound"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:StringLeaf" value="sorry, the position `1` is not in a&#xA;reduce"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                            <children xsi:type="mathematica:SymbolLeaf" name="splitReduce"/>
                            <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                            <children xsi:type="mathematica:StringLeaf" value=" Wrong Argument for splitReduce"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                              <children xsi:type="mathematica:SymbolLeaf" name="splitReduce"/>
                              <children xsi:type="mathematica:StringLeaf" value="WrongOp"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                              <children xsi:type="mathematica:StringLeaf" value=" sorry, the operator of the reduction is `1` and&#xA;the splitting operator is `2`, they should be the same"/>
                              <children xsi:type="mathematica:ASTNode" name="splitReduce">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                  <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                    <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                  <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                  <children xsi:type="mathematica:ASTNode" name="Catch">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="expAst"/>
                                          <children xsi:type="mathematica:ASTNode" name="getPart">
                                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                            <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:ASTNode" name="If">
                                          <children xsi:type="mathematica:ASTNode" name="Not">
                                            <children xsi:type="mathematica:ASTNode" name="MatchQ">
                                              <children xsi:type="mathematica:SymbolLeaf" name="expAst"/>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                                <children xsi:type="mathematica:SymbolLeaf" name="binop"/>
                                              </children>
                                            </children>
                                          </children>
                                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                <children xsi:type="mathematica:SymbolLeaf" name="splitReduce"/>
                                                <children xsi:type="mathematica:StringLeaf" value="WrongPos"/>
                                              </children>
                                              <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="Throw">
                                              <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                            </children>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="theOp"/>
                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                            <children xsi:type="mathematica:SymbolLeaf" name="expAst"/>
                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="posReduce"/>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                            <children xsi:type="mathematica:ASTNode" name="Function">
                                              <children xsi:type="mathematica:ASTNode" name="Drop">
                                                <children xsi:type="mathematica:ASTNode" name="Slot">
                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                </children>
                                                <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                              </children>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="Position">
                                              <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                              <children xsi:type="mathematica:SymbolLeaf" name="reduce"/>
                                            </children>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="goodPosReduce"/>
                                          <children xsi:type="mathematica:ASTNode" name="Select">
                                            <children xsi:type="mathematica:SymbolLeaf" name="posReduce"/>
                                            <children xsi:type="mathematica:ASTNode" name="Function">
                                              <children xsi:type="mathematica:ASTNode" name="SameQ">
                                                <children xsi:type="mathematica:ASTNode" name="Take">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                    <children xsi:type="mathematica:ASTNode" name="Slot">
                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                    </children>
                                                  </children>
                                                </children>
                                                <children xsi:type="mathematica:ASTNode" name="Slot">
                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                </children>
                                              </children>
                                            </children>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:ASTNode" name="If">
                                          <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                              <children xsi:type="mathematica:SymbolLeaf" name="goodPosReduce"/>
                                            </children>
                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                          </children>
                                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                <children xsi:type="mathematica:SymbolLeaf" name="splitReduce"/>
                                                <children xsi:type="mathematica:StringLeaf" value="reduceNotFound"/>
                                              </children>
                                              <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="Throw">
                                              <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                            </children>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="thePosReduce"/>
                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                            <children xsi:type="mathematica:SymbolLeaf" name="goodPosReduce"/>
                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="astReduce"/>
                                          <children xsi:type="mathematica:ASTNode" name="getPart">
                                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                            <children xsi:type="mathematica:SymbolLeaf" name="thePosReduce"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:ASTNode" name="If">
                                          <children xsi:type="mathematica:ASTNode" name="And">
                                            <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                <children xsi:type="mathematica:SymbolLeaf" name="astReduce"/>
                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                              </children>
                                              <children xsi:type="mathematica:SymbolLeaf" name="theOp"/>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="Or">
                                              <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="astReduce"/>
                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                </children>
                                                <children xsi:type="mathematica:SymbolLeaf" name="minus"/>
                                              </children>
                                              <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                                <children xsi:type="mathematica:SymbolLeaf" name="theOp"/>
                                                <children xsi:type="mathematica:SymbolLeaf" name="add"/>
                                              </children>
                                            </children>
                                          </children>
                                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                <children xsi:type="mathematica:SymbolLeaf" name="splitReduce"/>
                                                <children xsi:type="mathematica:StringLeaf" value="WrongOp"/>
                                              </children>
                                              <children xsi:type="mathematica:ASTNode" name="Part">
                                                <children xsi:type="mathematica:SymbolLeaf" name="astReduce"/>
                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                              </children>
                                              <children xsi:type="mathematica:SymbolLeaf" name="theOp"/>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="Throw">
                                              <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                            </children>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="domS2"/>
                                          <children xsi:type="mathematica:ASTNode" name="expDomain">
                                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                            <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="nbIndices"/>
                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                            <children xsi:type="mathematica:SymbolLeaf" name="domS2"/>
                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="expIndices"/>
                                          <children xsi:type="mathematica:ASTNode" name="If">
                                            <children xsi:type="mathematica:ASTNode" name="SameQ">
                                              <children xsi:type="mathematica:ASTNode" name="Head">
                                                <children xsi:type="mathematica:ASTNode" name="Part">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="domS2"/>
                                                  <children xsi:type="mathematica:IntLeaf" value="3"/>
                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                </children>
                                              </children>
                                              <children xsi:type="mathematica:SymbolLeaf" name="pol"/>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                              <children xsi:type="mathematica:SymbolLeaf" name="domS2"/>
                                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                              <children xsi:type="mathematica:SymbolLeaf" name="domS2"/>
                                              <children xsi:type="mathematica:IntLeaf" value="3"/>
                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                              <children xsi:type="mathematica:IntLeaf" value="3"/>
                                            </children>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="identOp"/>
                                          <children xsi:type="mathematica:ASTNode" name="opIdentity">
                                            <children xsi:type="mathematica:SymbolLeaf" name="theOp"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="expIdentOp"/>
                                          <children xsi:type="mathematica:ASTNode" name="affine">
                                            <children xsi:type="mathematica:SymbolLeaf" name="identOp"/>
                                            <children xsi:type="mathematica:ASTNode" name="matrix">
                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                                <children xsi:type="mathematica:SymbolLeaf" name="nbIndices"/>
                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                              </children>
                                              <children xsi:type="mathematica:SymbolLeaf" name="expIndices"/>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                <children xsi:type="mathematica:ASTNode" name="Append">
                                                  <children xsi:type="mathematica:ASTNode" name="Table">
                                                    <children xsi:type="mathematica:IntLeaf"/>
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                      <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                      <children xsi:type="mathematica:SymbolLeaf" name="nbIndices"/>
                                                    </children>
                                                  </children>
                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                </children>
                                              </children>
                                            </children>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="newReduce1"/>
                                          <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                                            <children xsi:type="mathematica:SymbolLeaf" name="astReduce"/>
                                            <children xsi:type="mathematica:SymbolLeaf" name="expIdentOp"/>
                                            <children xsi:type="mathematica:ASTNode" name="Append">
                                              <children xsi:type="mathematica:ASTNode" name="Drop">
                                                <children xsi:type="mathematica:SymbolLeaf" name="pos"/>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="thePosReduce"/>
                                                </children>
                                              </children>
                                              <children xsi:type="mathematica:IntLeaf" value="3"/>
                                            </children>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="newReduce2"/>
                                          <children xsi:type="mathematica:ASTNode" name="reduce">
                                            <children xsi:type="mathematica:SymbolLeaf" name="theOp"/>
                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                              <children xsi:type="mathematica:SymbolLeaf" name="astReduce"/>
                                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                              <children xsi:type="mathematica:SymbolLeaf" name="expAst"/>
                                              <children xsi:type="mathematica:IntLeaf" value="3"/>
                                            </children>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="newAst"/>
                                          <children xsi:type="mathematica:ASTNode" name="binop">
                                            <children xsi:type="mathematica:SymbolLeaf" name="theOp"/>
                                            <children xsi:type="mathematica:SymbolLeaf" name="newReduce1"/>
                                            <children xsi:type="mathematica:SymbolLeaf" name="newReduce2"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:ASTNode" name="Put">
                                          <children xsi:type="mathematica:SymbolLeaf" name="newAst"/>
                                          <children xsi:type="mathematica:StringLeaf" value="/tmp/tt"/>
                                        </children>
                                        <children xsi:type="mathematica:ASTNode" name="show">
                                          <children xsi:type="mathematica:SymbolLeaf" name="newAst"/>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="newSys"/>
                                          <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                            <children xsi:type="mathematica:SymbolLeaf" name="newAst"/>
                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                              <children xsi:type="mathematica:SymbolLeaf" name="thePosReduce"/>
                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                            </children>
                                          </children>
                                        </children>
                                      </children>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="splitReduce">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                      <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                                      <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                    </children>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="splitReduce"/>
                                    <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
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
</mathematica:BuiltInNode>
