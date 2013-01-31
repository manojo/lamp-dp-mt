<?xml version="1.0" encoding="ASCII"?>
<mathematica:BuiltInNode xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mathematica="http://www.irisa.fr/cairn/model/xtext/Mathematica" keyword="Protect">
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:BuiltInNode" keyword="BeginPackage">
      <children xsi:type="mathematica:StringLeaf" value="Alpha`HandelGen`Output`"/>
    </children>
    <children xsi:type="mathematica:ASTNode" name="Begin">
      <children xsi:type="mathematica:StringLeaf" value="`Private`"/>
    </children>
    <children xsi:type="mathematica:ASTNode" name="Unprotect">
      <children xsi:type="mathematica:SymbolLeaf" name="writeCcode"/>
      <children xsi:type="mathematica:SymbolLeaf" name="printC"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="writeCcode"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="writeCcode[]."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="printC"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="printC[]."/>
    </children>
    <children xsi:type="mathematica:ASTNode" name="Unprotect">
      <children xsi:type="mathematica:SymbolLeaf" name="Format"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="Format">
        <children xsi:type="mathematica:ASTNode" name="vseq">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="x"/>
            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="-C-code-"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="Format">
        <children xsi:type="mathematica:ASTNode" name="hseq">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="x"/>
            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="-C-code-"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="Format">
        <children xsi:type="mathematica:ASTNode" name="block">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="x"/>
            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="-C-code-"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="Format">
        <children xsi:type="mathematica:ASTNode" name="list">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="x"/>
            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="-C-code-"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="Format">
        <children xsi:type="mathematica:ASTNode" name="left">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="x"/>
            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="-C-code-"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="Format">
        <children xsi:type="mathematica:SymbolLeaf" name="deadCode"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="-C-code-"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Protect">
      <children xsi:type="mathematica:SymbolLeaf" name="Format"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="printC"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="printC"/>
        <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="`1`"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="printC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="printC">
        <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
        <children xsi:type="mathematica:IntLeaf" value="2"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="printC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="vseq"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
          <children xsi:type="mathematica:ASTNode" name="PatternTest">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="NonNegative"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
          <children xsi:type="mathematica:BuiltInNode" keyword="Map">
            <children xsi:type="mathematica:ASTNode" name="Function">
              <children xsi:type="mathematica:ASTNode" name="printC">
                <children xsi:type="mathematica:ASTNode" name="Slot">
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
              </children>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="printC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="block"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
          <children xsi:type="mathematica:ASTNode" name="PatternTest">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="NonNegative"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
          <children xsi:type="mathematica:ASTNode" name="printC">
            <children xsi:type="mathematica:ASTNode" name="hseq">
              <children xsi:type="mathematica:ASTNode" name="Part">
                <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
              </children>
              <children xsi:type="mathematica:StringLeaf" value=" {"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="printC">
            <children xsi:type="mathematica:ASTNode" name="Part">
              <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
              <children xsi:type="mathematica:IntLeaf" value="2"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
              <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
              <children xsi:type="mathematica:IntLeaf" value="2"/>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="printC">
            <children xsi:type="mathematica:StringLeaf" value="}"/>
            <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="printC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="left"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
          <children xsi:type="mathematica:ASTNode" name="PatternTest">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="NonNegative"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Print">
        <children xsi:type="mathematica:ASTNode" name="treeToC">
          <children xsi:type="mathematica:ASTNode" name="Apply">
            <children xsi:type="mathematica:SymbolLeaf" name="hseq"/>
            <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="printC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
          <children xsi:type="mathematica:ASTNode" name="PatternTest">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="NonNegative"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Print">
        <children xsi:type="mathematica:ASTNode" name="Apply">
          <children xsi:type="mathematica:SymbolLeaf" name="StringJoin"/>
          <children xsi:type="mathematica:ASTNode" name="Array">
            <children xsi:type="mathematica:ASTNode" name="Function">
              <children xsi:type="mathematica:StringLeaf" value=" "/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
          </children>
        </children>
        <children xsi:type="mathematica:ASTNode" name="treeToC">
          <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="writeCcode"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="writeCcode"/>
        <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="`1`"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="writeCcode">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="f"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="OutputStream"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:ASTNode" name="writeCcode">
          <children xsi:type="mathematica:SymbolLeaf" name="f"/>
          <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          <children xsi:type="mathematica:IntLeaf"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="writeCcode">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="f"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="OutputStream"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="vseq"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
          <children xsi:type="mathematica:ASTNode" name="PatternTest">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="NonNegative"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:BuiltInNode" keyword="Module">
          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Map">
              <children xsi:type="mathematica:ASTNode" name="Function">
                <children xsi:type="mathematica:ASTNode" name="writeCcode">
                  <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                  <children xsi:type="mathematica:ASTNode" name="Slot">
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
                </children>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="writeCcode">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="f"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="OutputStream"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="block"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
          <children xsi:type="mathematica:ASTNode" name="PatternTest">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="NonNegative"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:BuiltInNode" keyword="Module">
          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:ASTNode" name="writeCcode">
              <children xsi:type="mathematica:SymbolLeaf" name="f"/>
              <children xsi:type="mathematica:ASTNode" name="hseq">
                <children xsi:type="mathematica:ASTNode" name="Part">
                  <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
                <children xsi:type="mathematica:StringLeaf" value=" {"/>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="writeCcode">
              <children xsi:type="mathematica:SymbolLeaf" name="f"/>
              <children xsi:type="mathematica:ASTNode" name="Part">
                <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
                <children xsi:type="mathematica:IntLeaf" value="2"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
                <children xsi:type="mathematica:IntLeaf" value="2"/>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="writeCcode">
              <children xsi:type="mathematica:SymbolLeaf" name="f"/>
              <children xsi:type="mathematica:StringLeaf" value="}"/>
              <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="writeCcode">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="f"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="OutputStream"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="left"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
          <children xsi:type="mathematica:ASTNode" name="PatternTest">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="NonNegative"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:ASTNode" name="WriteString">
          <children xsi:type="mathematica:SymbolLeaf" name="f"/>
          <children xsi:type="mathematica:ASTNode" name="treeToC">
            <children xsi:type="mathematica:ASTNode" name="Apply">
              <children xsi:type="mathematica:SymbolLeaf" name="hseq"/>
              <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
            </children>
          </children>
          <children xsi:type="mathematica:StringLeaf" value="&#xA;"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="writeCcode">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="f"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="OutputStream"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
          <children xsi:type="mathematica:ASTNode" name="PatternTest">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="NonNegative"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:ASTNode" name="WriteString">
          <children xsi:type="mathematica:SymbolLeaf" name="f"/>
          <children xsi:type="mathematica:ASTNode" name="Apply">
            <children xsi:type="mathematica:SymbolLeaf" name="StringJoin"/>
            <children xsi:type="mathematica:ASTNode" name="Array">
              <children xsi:type="mathematica:ASTNode" name="Function">
                <children xsi:type="mathematica:StringLeaf" value=" "/>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="tab"/>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="treeToC">
            <children xsi:type="mathematica:SymbolLeaf" name="tree"/>
          </children>
          <children xsi:type="mathematica:StringLeaf" value="&#xA;"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="writeCcode">
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
              <children xsi:type="mathematica:SymbolLeaf" name="writeCcode"/>
              <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="List">
              <children xsi:type="mathematica:SymbolLeaf" name="a"/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:ASTNode" name="Unprotect">
      <children xsi:type="mathematica:SymbolLeaf" name="treeToC"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="treeToC"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="treeToC"/>
        <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="`1`"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="l"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="hseq"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Apply">
        <children xsi:type="mathematica:SymbolLeaf" name="StringJoin"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Map">
          <children xsi:type="mathematica:SymbolLeaf" name="treeToC"/>
          <children xsi:type="mathematica:SymbolLeaf" name="l"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:ASTNode" name="list"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value=""/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:ASTNode" name="list">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="f"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:SymbolLeaf" name="f"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:ASTNode" name="list">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="f"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="r"/>
            <children xsi:type="mathematica:ASTNode" name="BlankSequence"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="StringJoin">
        <children xsi:type="mathematica:ASTNode" name="treeToC">
          <children xsi:type="mathematica:SymbolLeaf" name="f"/>
        </children>
        <children xsi:type="mathematica:StringLeaf" value=", "/>
        <children xsi:type="mathematica:ASTNode" name="If">
          <children xsi:type="mathematica:ASTNode" name="Equal">
            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="r"/>
              </children>
            </children>
            <children xsi:type="mathematica:IntLeaf" value="1"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="treeToC">
            <children xsi:type="mathematica:SymbolLeaf" name="r"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="treeToC">
            <children xsi:type="mathematica:ASTNode" name="list">
              <children xsi:type="mathematica:SymbolLeaf" name="r"/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="f"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="r"/>
            <children xsi:type="mathematica:ASTNode" name="BlankSequence"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="StringJoin">
        <children xsi:type="mathematica:StringLeaf" value="("/>
        <children xsi:type="mathematica:ASTNode" name="ToString">
          <children xsi:type="mathematica:ASTNode" name="Apply">
            <children xsi:type="mathematica:BuiltInNode" keyword="Plus"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Map">
              <children xsi:type="mathematica:SymbolLeaf" name="treeToC"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="f"/>
                <children xsi:type="mathematica:SymbolLeaf" name="r"/>
              </children>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:StringLeaf" value=")"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="f"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="r"/>
            <children xsi:type="mathematica:ASTNode" name="BlankSequence"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="StringJoin">
        <children xsi:type="mathematica:ASTNode" name="If">
          <children xsi:type="mathematica:ASTNode" name="SameQ">
            <children xsi:type="mathematica:SymbolLeaf" name="f"/>
            <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
          </children>
          <children xsi:type="mathematica:StringLeaf" value="-"/>
          <children xsi:type="mathematica:ASTNode" name="StringJoin">
            <children xsi:type="mathematica:ASTNode" name="treeToC">
              <children xsi:type="mathematica:SymbolLeaf" name="f"/>
            </children>
            <children xsi:type="mathematica:StringLeaf" value="*"/>
          </children>
        </children>
        <children xsi:type="mathematica:ASTNode" name="If">
          <children xsi:type="mathematica:ASTNode" name="Equal">
            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="r"/>
              </children>
            </children>
            <children xsi:type="mathematica:IntLeaf" value="1"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="treeToC">
            <children xsi:type="mathematica:SymbolLeaf" name="r"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="treeToC">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:SymbolLeaf" name="r"/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:ASTNode" name="And">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="f"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="r"/>
            <children xsi:type="mathematica:ASTNode" name="BlankSequence"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="StringJoin">
        <children xsi:type="mathematica:ASTNode" name="treeToC">
          <children xsi:type="mathematica:SymbolLeaf" name="f"/>
        </children>
        <children xsi:type="mathematica:StringLeaf" value=" &amp;&amp; "/>
        <children xsi:type="mathematica:ASTNode" name="If">
          <children xsi:type="mathematica:ASTNode" name="Equal">
            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="r"/>
              </children>
            </children>
            <children xsi:type="mathematica:IntLeaf" value="1"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="treeToC">
            <children xsi:type="mathematica:SymbolLeaf" name="r"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="treeToC">
            <children xsi:type="mathematica:ASTNode" name="And">
              <children xsi:type="mathematica:SymbolLeaf" name="r"/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:ASTNode" name="Power">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="e"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="i"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
            </children>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="StringJoin">
        <children xsi:type="mathematica:StringLeaf" value="power("/>
        <children xsi:type="mathematica:ASTNode" name="treeToC">
          <children xsi:type="mathematica:SymbolLeaf" name="e"/>
        </children>
        <children xsi:type="mathematica:StringLeaf" value=","/>
        <children xsi:type="mathematica:ASTNode" name="treeToC">
          <children xsi:type="mathematica:SymbolLeaf" name="i"/>
        </children>
        <children xsi:type="mathematica:StringLeaf" value=")"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:ASTNode" name="Max">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="f"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="r"/>
            <children xsi:type="mathematica:ASTNode" name="BlankSequence"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="StringJoin">
        <children xsi:type="mathematica:StringLeaf" value="max("/>
        <children xsi:type="mathematica:ASTNode" name="treeToC">
          <children xsi:type="mathematica:SymbolLeaf" name="f"/>
        </children>
        <children xsi:type="mathematica:StringLeaf" value=","/>
        <children xsi:type="mathematica:ASTNode" name="If">
          <children xsi:type="mathematica:ASTNode" name="Equal">
            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="r"/>
              </children>
            </children>
            <children xsi:type="mathematica:IntLeaf" value="1"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="treeToC">
            <children xsi:type="mathematica:SymbolLeaf" name="r"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="treeToC">
            <children xsi:type="mathematica:ASTNode" name="Max">
              <children xsi:type="mathematica:SymbolLeaf" name="r"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:StringLeaf" value=")"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:ASTNode" name="Min">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="f"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="r"/>
            <children xsi:type="mathematica:ASTNode" name="BlankSequence"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="StringJoin">
        <children xsi:type="mathematica:StringLeaf" value="min("/>
        <children xsi:type="mathematica:ASTNode" name="treeToC">
          <children xsi:type="mathematica:SymbolLeaf" name="f"/>
        </children>
        <children xsi:type="mathematica:StringLeaf" value=","/>
        <children xsi:type="mathematica:ASTNode" name="If">
          <children xsi:type="mathematica:ASTNode" name="Equal">
            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="r"/>
              </children>
            </children>
            <children xsi:type="mathematica:IntLeaf" value="1"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="treeToC">
            <children xsi:type="mathematica:SymbolLeaf" name="r"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="treeToC">
            <children xsi:type="mathematica:ASTNode" name="Min">
              <children xsi:type="mathematica:SymbolLeaf" name="r"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:StringLeaf" value=")"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:ASTNode" name="Equal">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="l"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="r"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="StringJoin">
        <children xsi:type="mathematica:StringLeaf" value="("/>
        <children xsi:type="mathematica:ASTNode" name="treeToC">
          <children xsi:type="mathematica:SymbolLeaf" name="l"/>
        </children>
        <children xsi:type="mathematica:StringLeaf" value=" == "/>
        <children xsi:type="mathematica:ASTNode" name="treeToC">
          <children xsi:type="mathematica:SymbolLeaf" name="r"/>
        </children>
        <children xsi:type="mathematica:StringLeaf" value=")"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:ASTNode" name="GreaterEqual">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="l"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="r"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="StringJoin">
        <children xsi:type="mathematica:StringLeaf" value="("/>
        <children xsi:type="mathematica:ASTNode" name="treeToC">
          <children xsi:type="mathematica:SymbolLeaf" name="l"/>
        </children>
        <children xsi:type="mathematica:StringLeaf" value=" >= "/>
        <children xsi:type="mathematica:ASTNode" name="treeToC">
          <children xsi:type="mathematica:SymbolLeaf" name="r"/>
        </children>
        <children xsi:type="mathematica:StringLeaf" value=")"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="c"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="Ceiling"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="If">
        <children xsi:type="mathematica:ASTNode" name="UnsameQ">
          <children xsi:type="mathematica:ASTNode" name="Position">
            <children xsi:type="mathematica:SymbolLeaf" name="c"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="Rational"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="StringJoin">
          <children xsi:type="mathematica:StringLeaf" value="((int)ceil("/>
          <children xsi:type="mathematica:ASTNode" name="Apply">
            <children xsi:type="mathematica:SymbolLeaf" name="StringJoin"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Map">
              <children xsi:type="mathematica:SymbolLeaf" name="treeToC"/>
              <children xsi:type="mathematica:SymbolLeaf" name="c"/>
            </children>
          </children>
          <children xsi:type="mathematica:StringLeaf" value="))"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="StringJoin">
          <children xsi:type="mathematica:ASTNode" name="Apply">
            <children xsi:type="mathematica:SymbolLeaf" name="StringJoin"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Map">
              <children xsi:type="mathematica:SymbolLeaf" name="treeToC"/>
              <children xsi:type="mathematica:SymbolLeaf" name="c"/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="c"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="Floor"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="If">
        <children xsi:type="mathematica:ASTNode" name="UnsameQ">
          <children xsi:type="mathematica:ASTNode" name="Position">
            <children xsi:type="mathematica:SymbolLeaf" name="c"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="Rational"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="StringJoin">
          <children xsi:type="mathematica:StringLeaf" value="((int)floor("/>
          <children xsi:type="mathematica:ASTNode" name="Apply">
            <children xsi:type="mathematica:SymbolLeaf" name="StringJoin"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Map">
              <children xsi:type="mathematica:SymbolLeaf" name="treeToC"/>
              <children xsi:type="mathematica:SymbolLeaf" name="c"/>
            </children>
          </children>
          <children xsi:type="mathematica:StringLeaf" value="))"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="StringJoin">
          <children xsi:type="mathematica:ASTNode" name="Apply">
            <children xsi:type="mathematica:SymbolLeaf" name="StringJoin"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Map">
              <children xsi:type="mathematica:SymbolLeaf" name="treeToC"/>
              <children xsi:type="mathematica:SymbolLeaf" name="c"/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="r"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="Rational"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="ToString">
        <children xsi:type="mathematica:SymbolLeaf" name="r"/>
        <children xsi:type="mathematica:SymbolLeaf" name="CForm"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="i"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="ToString">
        <children xsi:type="mathematica:SymbolLeaf" name="i"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="s"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="String"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="s"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:ASTNode" name="symbol">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="s"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
              <children xsi:type="mathematica:SymbolLeaf" name="String"/>
            </children>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="s"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:SymbolLeaf" name="deadCode"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="/* dead code removed */"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="StringJoin">
        <children xsi:type="mathematica:ASTNode" name="ToString">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="treeToC">
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
              <children xsi:type="mathematica:SymbolLeaf" name="treeToC"/>
              <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="List">
              <children xsi:type="mathematica:SymbolLeaf" name="a"/>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="Throw"/>
        </children>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:ASTNode" name="treeToC">
      <children xsi:type="mathematica:SymbolLeaf" name="True"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value="1"/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:ASTNode" name="treeToC">
      <children xsi:type="mathematica:SymbolLeaf" name="False"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value="0"/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Protect">
    <children xsi:type="mathematica:SymbolLeaf" name="treeToC"/>
  </children>
  <children xsi:type="mathematica:ASTNode" name="End"/>
  <children xsi:type="mathematica:BuiltInNode" keyword="Protect">
    <children xsi:type="mathematica:SymbolLeaf" name="writeCcode"/>
    <children xsi:type="mathematica:SymbolLeaf" name="printC"/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Protect">
    <children xsi:type="mathematica:SymbolLeaf" name="vseq"/>
    <children xsi:type="mathematica:SymbolLeaf" name="hseq"/>
    <children xsi:type="mathematica:SymbolLeaf" name="block"/>
    <children xsi:type="mathematica:SymbolLeaf" name="list"/>
    <children xsi:type="mathematica:SymbolLeaf" name="left"/>
  </children>
  <children xsi:type="mathematica:ASTNode" name="EndPackage"/>
  <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
</mathematica:BuiltInNode>
