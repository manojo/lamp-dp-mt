<?xml version="1.0" encoding="ASCII"?>
<mathematica:BuiltInNode xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mathematica="http://www.irisa.fr/cairn/model/xtext/Mathematica" keyword="Protect">
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="BeginPackage">
          <children xsi:type="mathematica:StringLeaf" value="Alpha`Omega`"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Domlib`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Matrix`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Tables`"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="Omega"/>
          <children xsi:type="mathematica:StringLeaf" value="usage"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="Package for interface with Omega calculator of Bill&#xA;Pugh"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="readDomOmega"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="readDomOmega[domain_String]&#xA;&#xA;Function. Parses an Omega (Bill Pugh Tool) domain &#xA;   and returns&#xA;the abstact syntax tree of the corresponding domain in Alpha.&#xA;No parameters are allowed"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="loadDomOmega"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="loadDomOmega[file_String]&#xA;&#xA;Function. Parses an Omega (Bill Pugh Tool) domain &#xA;   contained in a file and returns&#xA;the abstact syntax tree of the corresponding domain in Alpha.&#xA;No parameters are allowed"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="showDomOmega"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value="showDomOmega[domain_Alpha`domain]&#xA;&#xA;Function. Parses an ALPHA domain and write on screen &#xA;it in Omega Format &#xA;"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="writeDomOmega"/>
                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                  <children xsi:type="mathematica:StringLeaf" value="writeDomOmega[B_Alpha`domain]&#xA;&#xA;Function. Parses an ALPHA domain and write in  a string  &#xA; in Omega Format "/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                    <children xsi:type="mathematica:SymbolLeaf" name="integerDomEmptyQ"/>
                    <children xsi:type="mathematica:StringLeaf" value="usage"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:StringLeaf" value="integerDomEmptyQ[d_Alpha`domain]&#xA;&#xA;Function. Test (with omega) if a domain is integer empty or not "/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                      <children xsi:type="mathematica:SymbolLeaf" name="integerHull"/>
                      <children xsi:type="mathematica:StringLeaf" value="usage"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:StringLeaf" value="integerHull[d_Alpha`domain]&#xA;&#xA;Function. Computes (with omega) the integer hull of a domain "/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="integralDomSimplify"/>
                        <children xsi:type="mathematica:StringLeaf" value="usage"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                        <children xsi:type="mathematica:StringLeaf" value="integralDomSimplify[dom1], simplify a&#xA;domain  if it is a union of domain which is equal to its convex hull,&#xA;WARNING, the execution may be long"/>
                        <children xsi:type="mathematica:ASTNode" name="Begin">
                          <children xsi:type="mathematica:StringLeaf" value="`Private`"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                          <children xsi:type="mathematica:SymbolLeaf" name="readDomOmega"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                          <children xsi:type="mathematica:SymbolLeaf" name="readDomOmega"/>
                          <children xsi:type="mathematica:StringLeaf" value="wrongPar"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:StringLeaf" value="Wrong arguments"/>
                          <children xsi:type="mathematica:ASTNode" name="readDomOmega">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                              <children xsi:type="mathematica:SymbolLeaf" name="B"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                              </children>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                            <children xsi:type="mathematica:ASTNode" name="RunThrough">
                              <children xsi:type="mathematica:StringLeaf" value="read_alpha -B"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="B"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="readDomOmega">
                              <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                  <children xsi:type="mathematica:SymbolLeaf" name="readDomOmega"/>
                                  <children xsi:type="mathematica:StringLeaf" value="wrongPar"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                <children xsi:type="mathematica:SymbolLeaf" name="loadDomOmega"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                <children xsi:type="mathematica:SymbolLeaf" name="loadDomOmega"/>
                                <children xsi:type="mathematica:StringLeaf" value="wrongPar"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                <children xsi:type="mathematica:StringLeaf" value="Wrong arguments"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                  <children xsi:type="mathematica:SymbolLeaf" name="loadDomOmega"/>
                                  <children xsi:type="mathematica:StringLeaf" value="fnf"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                  <children xsi:type="mathematica:StringLeaf" value="File `1` not found"/>
                                  <children xsi:type="mathematica:ASTNode" name="loadDomOmega">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                      <children xsi:type="mathematica:SymbolLeaf" name="filename"/>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                        <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                      </children>
                                    </children>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                        <children xsi:type="mathematica:SymbolLeaf" name="stream1"/>
                                        <children xsi:type="mathematica:SymbolLeaf" name="domdomList1"/>
                                        <children xsi:type="mathematica:SymbolLeaf" name="domList1"/>
                                        <children xsi:type="mathematica:SymbolLeaf" name="domList1bis"/>
                                        <children xsi:type="mathematica:SymbolLeaf" name="domList2"/>
                                        <children xsi:type="mathematica:SymbolLeaf" name="domString"/>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="stream1"/>
                                          <children xsi:type="mathematica:ASTNode" name="OpenRead">
                                            <children xsi:type="mathematica:SymbolLeaf" name="filename"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:ASTNode" name="If">
                                          <children xsi:type="mathematica:ASTNode" name="SameQ">
                                            <children xsi:type="mathematica:SymbolLeaf" name="stream1"/>
                                          </children>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                              <children xsi:type="mathematica:SymbolLeaf" name="loadDomOmega"/>
                                              <children xsi:type="mathematica:StringLeaf" value="fnf"/>
                                            </children>
                                            <children xsi:type="mathematica:SymbolLeaf" name="filename"/>
                                          </children>
                                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                              <children xsi:type="mathematica:SymbolLeaf" name="domList1"/>
                                              <children xsi:type="mathematica:ASTNode" name="ReadList">
                                                <children xsi:type="mathematica:SymbolLeaf" name="stream1"/>
                                                <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="RecordSeparators"/>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                    <children xsi:type="mathematica:StringLeaf" value="#"/>
                                                  </children>
                                                </children>
                                              </children>
                                            </children>
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                              <children xsi:type="mathematica:SymbolLeaf" name="domList1bis"/>
                                              <children xsi:type="mathematica:ASTNode" name="Select">
                                                <children xsi:type="mathematica:SymbolLeaf" name="domList1"/>
                                                <children xsi:type="mathematica:ASTNode" name="Function">
                                                  <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                                    <children xsi:type="mathematica:ASTNode" name="StringLength">
                                                      <children xsi:type="mathematica:ASTNode" name="Slot">
                                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                      </children>
                                                    </children>
                                                    <children xsi:type="mathematica:IntLeaf"/>
                                                  </children>
                                                </children>
                                              </children>
                                            </children>
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                              <children xsi:type="mathematica:SymbolLeaf" name="domList2"/>
                                              <children xsi:type="mathematica:ASTNode" name="Select">
                                                <children xsi:type="mathematica:SymbolLeaf" name="domList1bis"/>
                                                <children xsi:type="mathematica:ASTNode" name="Function">
                                                  <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                                    <children xsi:type="mathematica:ASTNode" name="StringTake">
                                                      <children xsi:type="mathematica:ASTNode" name="Slot">
                                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                      </children>
                                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                    </children>
                                                    <children xsi:type="mathematica:StringLeaf" value="#"/>
                                                  </children>
                                                </children>
                                              </children>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="If">
                                              <children xsi:type="mathematica:ASTNode" name="Greater">
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="domList2"/>
                                                </children>
                                                <children xsi:type="mathematica:IntLeaf"/>
                                              </children>
                                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="domString"/>
                                                  <children xsi:type="mathematica:ASTNode" name="Apply">
                                                    <children xsi:type="mathematica:SymbolLeaf" name="StringJoin"/>
                                                    <children xsi:type="mathematica:SymbolLeaf" name="domList2"/>
                                                  </children>
                                                </children>
                                                <children xsi:type="mathematica:ASTNode" name="RunThrough">
                                                  <children xsi:type="mathematica:StringLeaf" value="read_alpha -B"/>
                                                  <children xsi:type="mathematica:SymbolLeaf" name="domString"/>
                                                </children>
                                              </children>
                                              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                            </children>
                                          </children>
                                        </children>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:ASTNode" name="loadDomOmega">
                                      <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                          <children xsi:type="mathematica:SymbolLeaf" name="loadDomOmega"/>
                                          <children xsi:type="mathematica:StringLeaf" value="wrongPar"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                        <children xsi:type="mathematica:SymbolLeaf" name="showDomOmega"/>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                        <children xsi:type="mathematica:SymbolLeaf" name="showDomOmega"/>
                                        <children xsi:type="mathematica:StringLeaf" value="wrongPar"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                        <children xsi:type="mathematica:StringLeaf" value="Wrong arguments"/>
                                        <children xsi:type="mathematica:ASTNode" name="showDomOmega">
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                            <children xsi:type="mathematica:SymbolLeaf" name="B"/>
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                              <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                                            </children>
                                          </children>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                          <children xsi:type="mathematica:ASTNode" name="Put">
                                            <children xsi:type="mathematica:SymbolLeaf" name="B"/>
                                            <children xsi:type="mathematica:StringLeaf" value="!write_alpha -B"/>
                                          </children>
                                          <children xsi:type="mathematica:ASTNode" name="showDomOmega">
                                            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                            <children xsi:type="mathematica:SymbolLeaf" name="showDomOmega"/>
                                            <children xsi:type="mathematica:StringLeaf" value="wrongPar"/>
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
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="writeDomOmega"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="writeDomOmega"/>
          <children xsi:type="mathematica:StringLeaf" value="wrongPar"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="Wrong arguments"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="writeDomOmega"/>
            <children xsi:type="mathematica:StringLeaf" value="pb1"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value=" probably I/O Problem"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="writeDomOmega"/>
              <children xsi:type="mathematica:StringLeaf" value="pb2"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value=" I/O Problem"/>
              <children xsi:type="mathematica:ASTNode" name="writeDomOmega">
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="b"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                    <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:SymbolLeaf" name="name1"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="stream1"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="domdomList1"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="domList2"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="name1"/>
                      <children xsi:type="mathematica:ASTNode" name="StringJoin">
                        <children xsi:type="mathematica:StringLeaf" value="/tmp/writeDomOmega"/>
                        <children xsi:type="mathematica:ASTNode" name="Environment">
                          <children xsi:type="mathematica:StringLeaf" value="USER"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Put">
                      <children xsi:type="mathematica:SymbolLeaf" name="b"/>
                      <children xsi:type="mathematica:ASTNode" name="StringJoin">
                        <children xsi:type="mathematica:StringLeaf" value="!write_alpha -B >"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="name1"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="stream1"/>
                      <children xsi:type="mathematica:ASTNode" name="OpenRead">
                        <children xsi:type="mathematica:SymbolLeaf" name="name1"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="If">
                      <children xsi:type="mathematica:ASTNode" name="SameQ">
                        <children xsi:type="mathematica:SymbolLeaf" name="stream1"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                          <children xsi:type="mathematica:SymbolLeaf" name="writeDomOmega"/>
                          <children xsi:type="mathematica:StringLeaf" value="fnf"/>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="filename"/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="domList1"/>
                          <children xsi:type="mathematica:ASTNode" name="ReadList">
                            <children xsi:type="mathematica:SymbolLeaf" name="stream1"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                              <children xsi:type="mathematica:SymbolLeaf" name="RecordSeparators"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                <children xsi:type="mathematica:StringLeaf" value="#"/>
                                <children xsi:type="mathematica:StringLeaf" value="&#xA;"/>
                              </children>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="domList2"/>
                          <children xsi:type="mathematica:ASTNode" name="Select">
                            <children xsi:type="mathematica:SymbolLeaf" name="domList1"/>
                            <children xsi:type="mathematica:ASTNode" name="Function">
                              <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                <children xsi:type="mathematica:ASTNode" name="StringTake">
                                  <children xsi:type="mathematica:ASTNode" name="Slot">
                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  </children>
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                                <children xsi:type="mathematica:StringLeaf" value="#"/>
                              </children>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:ASTNode" name="Greater">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                              <children xsi:type="mathematica:SymbolLeaf" name="domList2"/>
                            </children>
                            <children xsi:type="mathematica:IntLeaf"/>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                              <children xsi:type="mathematica:ASTNode" name="Apply">
                                <children xsi:type="mathematica:SymbolLeaf" name="StringJoin"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="domList2"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Close">
                              <children xsi:type="mathematica:SymbolLeaf" name="stream1"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                            <children xsi:type="mathematica:StringLeaf" value="writeDomOmega::pb1"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="writeDomOmega">
                  <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="writeDomOmega"/>
                  <children xsi:type="mathematica:StringLeaf" value="wrongPar"/>
                </children>
              </children>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="integerDomEmpty"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="integerDomEmptyQ"/>
        <children xsi:type="mathematica:StringLeaf" value="wrongPar"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="Wrong arguments"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="integerDomEmptyQ"/>
            <children xsi:type="mathematica:StringLeaf" value="pb1"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="Problem in reading Omega's answer, see file `1`"/>
            <children xsi:type="mathematica:ASTNode" name="integerDomEmptyQ">
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                  <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
                </children>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:SymbolLeaf" name="name1"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="name2"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="str1"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="str2"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="str3"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="str4"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="str5"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="str6"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="name1"/>
                    <children xsi:type="mathematica:ASTNode" name="StringJoin">
                      <children xsi:type="mathematica:StringLeaf" value="/tmp/integerDomEmpty1"/>
                      <children xsi:type="mathematica:ASTNode" name="Environment">
                        <children xsi:type="mathematica:StringLeaf" value="USER"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="name2"/>
                    <children xsi:type="mathematica:ASTNode" name="StringJoin">
                      <children xsi:type="mathematica:StringLeaf" value="/tmp/integerDomEmpty2"/>
                      <children xsi:type="mathematica:ASTNode" name="Environment">
                        <children xsi:type="mathematica:StringLeaf" value="USER"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="str1"/>
                    <children xsi:type="mathematica:StringLeaf" value="# test with Omega &#xA;"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="str2"/>
                    <children xsi:type="mathematica:StringLeaf" value="Dom1:= "/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="str3"/>
                    <children xsi:type="mathematica:ASTNode" name="writeDomOmega">
                      <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="str4"/>
                    <children xsi:type="mathematica:StringLeaf" value=";&#xA;"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="str5"/>
                    <children xsi:type="mathematica:StringLeaf" value="&#xA;"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="str6"/>
                    <children xsi:type="mathematica:StringLeaf" value="Dom1;"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Put">
                    <children xsi:type="mathematica:ASTNode" name="OutputForm">
                      <children xsi:type="mathematica:ASTNode" name="StringJoin">
                        <children xsi:type="mathematica:SymbolLeaf" name="str1"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="str2"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="str3"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="str4"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="str5"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="str6"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="name1"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Run">
                    <children xsi:type="mathematica:ASTNode" name="StringJoin">
                      <children xsi:type="mathematica:StringLeaf" value="oc &lt;"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="name1"/>
                      <children xsi:type="mathematica:StringLeaf" value=" >"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="name2"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="domFinal"/>
                    <children xsi:type="mathematica:ASTNode" name="loadDomOmega">
                      <children xsi:type="mathematica:SymbolLeaf" name="name2"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="If">
                    <children xsi:type="mathematica:ASTNode" name="MatchQ">
                      <children xsi:type="mathematica:SymbolLeaf" name="domFinal"/>
                      <children xsi:type="mathematica:ASTNode" name="domain">
                        <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                      <children xsi:type="mathematica:ASTNode" name="Run">
                        <children xsi:type="mathematica:ASTNode" name="StringJoin">
                          <children xsi:type="mathematica:StringLeaf" value="rm "/>
                          <children xsi:type="mathematica:SymbolLeaf" name="name1"/>
                          <children xsi:type="mathematica:StringLeaf" value=" "/>
                          <children xsi:type="mathematica:SymbolLeaf" name="name2"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="If">
                        <children xsi:type="mathematica:ASTNode" name="DomEmptyQ">
                          <children xsi:type="mathematica:SymbolLeaf" name="domFinal"/>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                          <children xsi:type="mathematica:SymbolLeaf" name="integerDomEmptyQ"/>
                          <children xsi:type="mathematica:StringLeaf" value="pb1"/>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="name2"/>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                    </children>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="integerDomEmptyQ">
                <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Message">
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="integerDomEmptyQ"/>
                <children xsi:type="mathematica:StringLeaf" value="wrongPar"/>
              </children>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="integerDomEmpty"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="integerHull"/>
        <children xsi:type="mathematica:StringLeaf" value="wrongPar"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="Wrong arguments"/>
          <children xsi:type="mathematica:ASTNode" name="integerHull">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="d"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
              </children>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:BuiltInNode" keyword="Module">
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="name1"/>
                <children xsi:type="mathematica:SymbolLeaf" name="name2"/>
                <children xsi:type="mathematica:SymbolLeaf" name="str1"/>
                <children xsi:type="mathematica:SymbolLeaf" name="str2"/>
                <children xsi:type="mathematica:SymbolLeaf" name="str3"/>
                <children xsi:type="mathematica:SymbolLeaf" name="str4"/>
                <children xsi:type="mathematica:SymbolLeaf" name="str5"/>
                <children xsi:type="mathematica:SymbolLeaf" name="str6"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="name1"/>
                  <children xsi:type="mathematica:ASTNode" name="StringJoin">
                    <children xsi:type="mathematica:StringLeaf" value="/tmp/integerHull1"/>
                    <children xsi:type="mathematica:ASTNode" name="Environment">
                      <children xsi:type="mathematica:StringLeaf" value="USER"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="name2"/>
                  <children xsi:type="mathematica:ASTNode" name="StringJoin">
                    <children xsi:type="mathematica:StringLeaf" value="/tmp/integerHull2"/>
                    <children xsi:type="mathematica:ASTNode" name="Environment">
                      <children xsi:type="mathematica:StringLeaf" value="USER"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="str1"/>
                  <children xsi:type="mathematica:StringLeaf" value="# hull with Omega &#xA;"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="str2"/>
                  <children xsi:type="mathematica:StringLeaf" value="Dom1:= "/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="str3"/>
                  <children xsi:type="mathematica:ASTNode" name="writeDomOmega">
                    <children xsi:type="mathematica:SymbolLeaf" name="d"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="str4"/>
                  <children xsi:type="mathematica:StringLeaf" value=";&#xA;"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="str5"/>
                  <children xsi:type="mathematica:StringLeaf" value="&#xA;"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="str6"/>
                  <children xsi:type="mathematica:StringLeaf" value="Hull Dom1;"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Put">
                  <children xsi:type="mathematica:ASTNode" name="OutputForm">
                    <children xsi:type="mathematica:ASTNode" name="StringJoin">
                      <children xsi:type="mathematica:SymbolLeaf" name="str1"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="str2"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="str3"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="str4"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="str5"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="str6"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="name1"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Run">
                  <children xsi:type="mathematica:ASTNode" name="StringJoin">
                    <children xsi:type="mathematica:StringLeaf" value="oc &lt;"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="name1"/>
                    <children xsi:type="mathematica:StringLeaf" value=" >"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="name2"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="domFinal"/>
                  <children xsi:type="mathematica:ASTNode" name="loadDomOmega">
                    <children xsi:type="mathematica:SymbolLeaf" name="name2"/>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="integerHull">
              <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Message">
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="integerHull"/>
              <children xsi:type="mathematica:StringLeaf" value="wrongPar"/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="integralDomSimplify"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="integralDomSimplify">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="dom1"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
            </children>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:BuiltInNode" keyword="Module">
            <children xsi:type="mathematica:BuiltInNode" keyword="List">
              <children xsi:type="mathematica:SymbolLeaf" name="integerHull1"/>
              <children xsi:type="mathematica:SymbolLeaf" name="convHull1"/>
              <children xsi:type="mathematica:SymbolLeaf" name="res1"/>
              <children xsi:type="mathematica:SymbolLeaf" name="res2"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="integerHull1"/>
                <children xsi:type="mathematica:ASTNode" name="integerHull">
                  <children xsi:type="mathematica:SymbolLeaf" name="dom1"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="convHull1"/>
                <children xsi:type="mathematica:ASTNode" name="DomConvex">
                  <children xsi:type="mathematica:SymbolLeaf" name="dom1"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="If">
                <children xsi:type="mathematica:ASTNode" name="Greater">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="dom1"/>
                      <children xsi:type="mathematica:IntLeaf" value="3"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="DomEqualQ">
                    <children xsi:type="mathematica:SymbolLeaf" name="integerHull1"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="convHull1"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="res1"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="convHull1"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="res1"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="dom1"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="res1"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="dom1"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="If">
                <children xsi:type="mathematica:ASTNode" name="Not">
                  <children xsi:type="mathematica:ASTNode" name="DomEmptyQ">
                    <children xsi:type="mathematica:SymbolLeaf" name="res1"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="integerDomEmptyQ">
                    <children xsi:type="mathematica:SymbolLeaf" name="res1"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="res2"/>
                    <children xsi:type="mathematica:ASTNode" name="DomEmpty">
                      <children xsi:type="mathematica:ASTNode" name="Part">
                        <children xsi:type="mathematica:SymbolLeaf" name="res1"/>
                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="res2"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="res1"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="res2"/>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="integralDomSimplify">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="a"/>
              <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Message">
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="integralDomSimplify"/>
                <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="a"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="Throw">
              <children xsi:type="mathematica:StringLeaf" value="ERROR"/>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="End"/>
          <children xsi:type="mathematica:ASTNode" name="EndPackage"/>
        </children>
      </children>
    </children>
  </children>
</mathematica:BuiltInNode>
