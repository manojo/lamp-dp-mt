<?xml version="1.0" encoding="ASCII"?>
<mathematica:BuiltInNode xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mathematica="http://www.irisa.fr/cairn/model/xtext/Mathematica" keyword="Protect">
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:BuiltInNode" keyword="BeginPackage">
      <children xsi:type="mathematica:StringLeaf" value="Alpha`Lexicographic`"/>
    </children>
    <children xsi:type="mathematica:ASTNode" name="Unprotect">
      <children xsi:type="mathematica:SymbolLeaf" name="domLexGreater"/>
      <children xsi:type="mathematica:SymbolLeaf" name="domLexLower"/>
      <children xsi:type="mathematica:SymbolLeaf" name="lexLowerQ"/>
      <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterQ"/>
      <children xsi:type="mathematica:SymbolLeaf" name="lexLowerOrEqualQ"/>
      <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrEqualQ"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="domLexGreater"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="domLexGreater[v:_Matrix] returns a domain D&#xA;such that for all z in D, z>v, where > means lexicographically greater. V is a&#xA;parametrized vertex. If v is a n*(p+1) matrix, D is a n+p domain, and the p last&#xA;dimensions are parameter dimensions. Example: domLexGreater[{{1,0},{0,2}}]&#xA;returns {a,b,c | c+1&lt;=a} | {a,b,c | a=c; 3&lt;=b}, where c is the parameter index.&#xA;domLexGreater[v:_Vector] is a shortcut for 0-dimensional parameter&#xA;space. (i.e. domLexGreater[{0,0,1}] means domLexGreater[{{0},{0},{1}}]."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="domLexLower"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="domLexLower[v:_Matrix] returns a domain D&#xA;such that for all z in D, z&lt;v, where &lt; means lexicographically lower. V is a&#xA;parametrized vertex. If v is a n*(p+1) matrix, D is a n+p domain, and the p last&#xA;dimensions are parameter dimensions. Example: domLexLower[{{1,0},{0,2}}]&#xA;returns {a,b,c | a&lt;=c-1} | {a,b,c | a=c; b&lt;=1}, where c is the parameter index.&#xA;domLexLower[v:_Vector] is a shortcut for 0-dimensional parameter&#xA;space. (i.e. domLexLower[{0,0,1}] means domLexGreater[{{0},{0},{1}}]."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterQ"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="lexGreaterQ[a:_Matrix, b:_Matrix, p:_domain] returns True &#xA;if a is lexicographicallygreater than b for any value of parameters in p. a and b &#xA;are parametrized vectors."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrEqualQ"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="lexGreaterOrEqualQ[a:_Matrix, b:_Matrix,&#xA;p:_domain] returns True if a is lexicographically greater or equal than b for&#xA;any value of parameters in p. a and b are parametrized vectors."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="lexLowerQ"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="lexLowerQ[a:_Matrix, b:_Matrix, p:_domain] returns True &#xA;if a is lexicographically lower than b for any value of parameters in p. a and b &#xA;are parametrized vectors."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="lexLowerOrEqualQ"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="lexLowerOrEqualQ[a:_Matrix, b:_Matrix, p:_domain]&#xA;returns True if a is lexicographically lower or equal than b for any value of&#xA;parameters in p. a and b are parametrized vectors."/>
    </children>
    <children xsi:type="mathematica:ASTNode" name="Begin">
      <children xsi:type="mathematica:StringLeaf" value="`Private`"/>
    </children>
    <children xsi:type="mathematica:ASTNode" name="Needs">
      <children xsi:type="mathematica:StringLeaf" value="Fail`"/>
    </children>
    <children xsi:type="mathematica:ASTNode" name="Needs">
      <children xsi:type="mathematica:StringLeaf" value="Alpha`"/>
    </children>
    <children xsi:type="mathematica:ASTNode" name="Needs">
      <children xsi:type="mathematica:StringLeaf" value="Alpha`Domlib`"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="Lexicographic"/>
        <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="`1`"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="domLexGreater"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="domLexGreater"/>
        <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="Lexicographic"/>
        <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="domLexGreater">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:ASTNode" name="BlankSequence">
              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
            </children>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:ASTNode" name="domLexGreater">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Length">
            <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="domLexGreater">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:ASTNode" name="BlankSequence">
              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="k"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:ASTNode" name="domLexGreaterOrLower">
          <children xsi:type="mathematica:BuiltInNode" keyword="Map">
            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
            <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="k"/>
          <children xsi:type="mathematica:IntLeaf" value="1"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="domLexGreater">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:ASTNode" name="PatternTest">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            <children xsi:type="mathematica:SymbolLeaf" name="MatrixQ"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:ASTNode" name="domLexGreater">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Length">
            <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="domLexGreater">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:ASTNode" name="PatternTest">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            <children xsi:type="mathematica:SymbolLeaf" name="MatrixQ"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="k"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:SymbolLeaf" name="res"/>
          <children xsi:type="mathematica:ASTNode" name="domLexGreaterOrLower">
            <children xsi:type="mathematica:SymbolLeaf" name="v"/>
            <children xsi:type="mathematica:SymbolLeaf" name="k"/>
            <children xsi:type="mathematica:IntLeaf" value="1"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="domLexGreater">
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
              <children xsi:type="mathematica:SymbolLeaf" name="domLexGreater"/>
              <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="List">
              <children xsi:type="mathematica:SymbolLeaf" name="a"/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="domLexLower"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="domLexLower"/>
        <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="Lexicographic"/>
        <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="domLexLower">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:ASTNode" name="BlankSequence">
              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
            </children>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:ASTNode" name="domLexLower">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Length">
            <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="domLexLower">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:ASTNode" name="BlankSequence">
              <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="k"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:ASTNode" name="domLexGreaterOrLower">
          <children xsi:type="mathematica:BuiltInNode" keyword="Map">
            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
            <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="k"/>
          <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="domLexLower">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:ASTNode" name="PatternTest">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            <children xsi:type="mathematica:SymbolLeaf" name="MatrixQ"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:ASTNode" name="domLexLower">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Length">
            <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="domLexLower">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:ASTNode" name="PatternTest">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            <children xsi:type="mathematica:SymbolLeaf" name="MatrixQ"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="k"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:ASTNode" name="domLexGreaterOrLower">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:SymbolLeaf" name="k"/>
          <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="domLexLower">
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
              <children xsi:type="mathematica:SymbolLeaf" name="domLexLower"/>
              <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="List">
              <children xsi:type="mathematica:SymbolLeaf" name="a"/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="domLexGreaterOrLower"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="domLexGreaterOrLower"/>
        <children xsi:type="mathematica:StringLeaf" value="kdim"/>
      </children>
      <children xsi:type="mathematica:StringLeaf" value="k is larger than length(v) (`2` > `1`)."/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="domLexGreaterOrLower">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="v"/>
          <children xsi:type="mathematica:ASTNode" name="PatternTest">
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            <children xsi:type="mathematica:SymbolLeaf" name="MatrixQ"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="k"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="sign"/>
          <children xsi:type="mathematica:ASTNode" name="Alternatives">
            <children xsi:type="mathematica:IntLeaf" value="1"/>
            <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
        <children xsi:type="mathematica:BuiltInNode" keyword="List">
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
              <children xsi:type="mathematica:SymbolLeaf" name="v"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="p"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
              <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                <children xsi:type="mathematica:ASTNode" name="First">
                  <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                </children>
              </children>
              <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
            </children>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="l"/>
          <children xsi:type="mathematica:SymbolLeaf" name="lm"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="If">
          <children xsi:type="mathematica:ASTNode" name="Or">
            <children xsi:type="mathematica:ASTNode" name="Greater">
              <children xsi:type="mathematica:SymbolLeaf" name="k"/>
              <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="Less">
              <children xsi:type="mathematica:SymbolLeaf" name="k"/>
              <children xsi:type="mathematica:IntLeaf" value="1"/>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Message">
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="domLexGreaterOrLower"/>
                <children xsi:type="mathematica:StringLeaf" value="kdim"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                <children xsi:type="mathematica:SymbolLeaf" name="v"/>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="k"/>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="lm"/>
              <children xsi:type="mathematica:ASTNode" name="Table">
                <children xsi:type="mathematica:ASTNode" name="matrix">
                  <children xsi:type="mathematica:SymbolLeaf" name="l"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                    <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                    <children xsi:type="mathematica:IntLeaf" value="2"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="indexList">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                      <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="MapThread">
                    <children xsi:type="mathematica:SymbolLeaf" name="Join"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:ASTNode" name="Join">
                        <children xsi:type="mathematica:ASTNode" name="Array">
                          <children xsi:type="mathematica:ASTNode" name="Function">
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:IntLeaf"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                            <children xsi:type="mathematica:SymbolLeaf" name="l"/>
                            <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                        <children xsi:type="mathematica:SymbolLeaf" name="sign"/>
                        <children xsi:type="mathematica:ASTNode" name="Take">
                          <children xsi:type="mathematica:ASTNode" name="IdentityMatrix">
                            <children xsi:type="mathematica:SymbolLeaf" name="dim"/>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="l"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="sign"/>
                          <children xsi:type="mathematica:ASTNode" name="Take">
                            <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="l"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="Join">
                          <children xsi:type="mathematica:ASTNode" name="Array">
                            <children xsi:type="mathematica:ASTNode" name="Function">
                              <children xsi:type="mathematica:IntLeaf"/>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                <children xsi:type="mathematica:SymbolLeaf" name="l"/>
                                <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                            <children xsi:type="mathematica:ASTNode" name="Join">
                              <children xsi:type="mathematica:ASTNode" name="Array">
                                <children xsi:type="mathematica:ASTNode" name="Function">
                                  <children xsi:type="mathematica:IntLeaf"/>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                              </children>
                            </children>
                          </children>
                        </children>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:SymbolLeaf" name="l"/>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="k"/>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="lm"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                <children xsi:type="mathematica:SymbolLeaf" name="DomConstraints"/>
                <children xsi:type="mathematica:SymbolLeaf" name="lm"/>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="Fold">
              <children xsi:type="mathematica:SymbolLeaf" name="DomUnion"/>
              <children xsi:type="mathematica:ASTNode" name="First">
                <children xsi:type="mathematica:SymbolLeaf" name="lm"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="Rest">
                <children xsi:type="mathematica:SymbolLeaf" name="lm"/>
              </children>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="domLexGreaterOrLower">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Throw"/>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
    <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterQ"/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterQ"/>
      <children xsi:type="mathematica:StringLeaf" value="failed"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value=""/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterQ"/>
      <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="Lexicographic"/>
      <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterQ"/>
      <children xsi:type="mathematica:StringLeaf" value="dim"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value="matrices mismatch."/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterQ"/>
      <children xsi:type="mathematica:StringLeaf" value="param"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value="matrices and param mismatch."/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterQ"/>
      <children xsi:type="mathematica:StringLeaf" value="domimage"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value="failed."/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="lexGreaterQ">
      <children xsi:type="mathematica:ASTNode" name="Condition">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="MatrixQ">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:SymbolLeaf" name="IntegerQ"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Condition">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="b"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="MatrixQ">
          <children xsi:type="mathematica:SymbolLeaf" name="b"/>
          <children xsi:type="mathematica:SymbolLeaf" name="IntegerQ"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="p"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
          <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:ASTNode" name="verbFail">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterQ"/>
        <children xsi:type="mathematica:StringLeaf" value="failed"/>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:BuiltInNode" keyword="With">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="strict"/>
              <children xsi:type="mathematica:ASTNode" name="chkFail">
                <children xsi:type="mathematica:ASTNode" name="domLexLower">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="nonStrict"/>
              <children xsi:type="mathematica:ASTNode" name="chkFail">
                <children xsi:type="mathematica:ASTNode" name="domLexLower">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:IntLeaf"/>
                  </children>
                </children>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="lexGreaterOrLowerQ">
            <children xsi:type="mathematica:SymbolLeaf" name="a"/>
            <children xsi:type="mathematica:SymbolLeaf" name="b"/>
            <children xsi:type="mathematica:SymbolLeaf" name="p"/>
            <children xsi:type="mathematica:SymbolLeaf" name="strict"/>
            <children xsi:type="mathematica:SymbolLeaf" name="nonStrict"/>
            <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterQ"/>
            <children xsi:type="mathematica:SymbolLeaf" name="False"/>
          </children>
        </children>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="lexGreaterQ">
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
            <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterQ"/>
            <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          </children>
        </children>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
    <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrEqualQ"/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrEqualQ"/>
      <children xsi:type="mathematica:StringLeaf" value="failed"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value=""/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrEqualQ"/>
      <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="Lexicographic"/>
      <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrEqualQ"/>
      <children xsi:type="mathematica:StringLeaf" value="dim"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value="matrices mismatch."/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrEqualQ"/>
      <children xsi:type="mathematica:StringLeaf" value="param"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value="matrices and param mismatch."/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrEqualQ"/>
      <children xsi:type="mathematica:StringLeaf" value="domimage"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value="failed."/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="lexGreaterOrEqualQ">
      <children xsi:type="mathematica:ASTNode" name="Condition">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="MatrixQ">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:SymbolLeaf" name="IntegerQ"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Condition">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="b"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="MatrixQ">
          <children xsi:type="mathematica:SymbolLeaf" name="b"/>
          <children xsi:type="mathematica:SymbolLeaf" name="IntegerQ"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="p"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
          <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:ASTNode" name="verbFail">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrEqualQ"/>
        <children xsi:type="mathematica:StringLeaf" value="failed"/>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:BuiltInNode" keyword="With">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="strict"/>
              <children xsi:type="mathematica:ASTNode" name="chkFail">
                <children xsi:type="mathematica:ASTNode" name="domLexLower">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="nonStrict"/>
              <children xsi:type="mathematica:ASTNode" name="chkFail">
                <children xsi:type="mathematica:ASTNode" name="domLexLower">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:IntLeaf"/>
                  </children>
                </children>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="lexGreaterOrLowerQ">
            <children xsi:type="mathematica:SymbolLeaf" name="a"/>
            <children xsi:type="mathematica:SymbolLeaf" name="b"/>
            <children xsi:type="mathematica:SymbolLeaf" name="p"/>
            <children xsi:type="mathematica:SymbolLeaf" name="strict"/>
            <children xsi:type="mathematica:SymbolLeaf" name="nonStrict"/>
            <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrEqualQ"/>
            <children xsi:type="mathematica:SymbolLeaf" name="True"/>
          </children>
        </children>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="lexGreaterOrEqualQ">
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
            <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrEqualQ"/>
            <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          </children>
        </children>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
    <children xsi:type="mathematica:SymbolLeaf" name="lexLowerQ"/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexLowerQ"/>
      <children xsi:type="mathematica:StringLeaf" value="failed"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value=""/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexLowerQ"/>
      <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="Lexicographic"/>
      <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexLowerQ"/>
      <children xsi:type="mathematica:StringLeaf" value="dim"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value="matrices mismatch."/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexLowerQ"/>
      <children xsi:type="mathematica:StringLeaf" value="param"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value="matrices and param mismatch."/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexLowerQ"/>
      <children xsi:type="mathematica:StringLeaf" value="domimage"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value="failed."/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="lexLowerQ">
      <children xsi:type="mathematica:ASTNode" name="Condition">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="MatrixQ">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:SymbolLeaf" name="IntegerQ"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Condition">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="b"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="MatrixQ">
          <children xsi:type="mathematica:SymbolLeaf" name="b"/>
          <children xsi:type="mathematica:SymbolLeaf" name="IntegerQ"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="p"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
          <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:ASTNode" name="verbFail">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="lexLowerQ"/>
        <children xsi:type="mathematica:StringLeaf" value="failed"/>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:BuiltInNode" keyword="With">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="strict"/>
              <children xsi:type="mathematica:ASTNode" name="chkFail">
                <children xsi:type="mathematica:ASTNode" name="domLexGreater">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="nonStrict"/>
              <children xsi:type="mathematica:ASTNode" name="chkFail">
                <children xsi:type="mathematica:ASTNode" name="domLexGreater">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:IntLeaf"/>
                  </children>
                </children>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="lexGreaterOrLowerQ">
            <children xsi:type="mathematica:SymbolLeaf" name="a"/>
            <children xsi:type="mathematica:SymbolLeaf" name="b"/>
            <children xsi:type="mathematica:SymbolLeaf" name="p"/>
            <children xsi:type="mathematica:SymbolLeaf" name="strict"/>
            <children xsi:type="mathematica:SymbolLeaf" name="nonStrict"/>
            <children xsi:type="mathematica:SymbolLeaf" name="lexLowerQ"/>
            <children xsi:type="mathematica:SymbolLeaf" name="False"/>
          </children>
        </children>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="lexLowerQQ">
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
            <children xsi:type="mathematica:SymbolLeaf" name="lexLowerQ"/>
            <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          </children>
        </children>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
    <children xsi:type="mathematica:SymbolLeaf" name="lexLowerOrEqualQ"/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexLowerOrEqualQ"/>
      <children xsi:type="mathematica:StringLeaf" value="failed"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value=""/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexLowerOrEqualQ"/>
      <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="Lexicographic"/>
      <children xsi:type="mathematica:StringLeaf" value="wrongArg"/>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexLowerOrEqualQ"/>
      <children xsi:type="mathematica:StringLeaf" value="dim"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value="matrices mismatch."/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
      <children xsi:type="mathematica:SymbolLeaf" name="lexLowerOrEqualQ"/>
      <children xsi:type="mathematica:StringLeaf" value="param"/>
    </children>
    <children xsi:type="mathematica:StringLeaf" value="matrices and param mismatch."/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="lexLowerOrEqualQ">
      <children xsi:type="mathematica:ASTNode" name="Condition">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="MatrixQ">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:SymbolLeaf" name="IntegerQ"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Condition">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="b"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="MatrixQ">
          <children xsi:type="mathematica:SymbolLeaf" name="b"/>
          <children xsi:type="mathematica:SymbolLeaf" name="IntegerQ"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="p"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
          <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:ASTNode" name="verbFail">
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="lexLowerOrEqualQ"/>
        <children xsi:type="mathematica:StringLeaf" value="failed"/>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Catch">
        <children xsi:type="mathematica:BuiltInNode" keyword="With">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="strict"/>
              <children xsi:type="mathematica:ASTNode" name="chkFail">
                <children xsi:type="mathematica:ASTNode" name="domLexGreater">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="nonStrict"/>
              <children xsi:type="mathematica:ASTNode" name="chkFail">
                <children xsi:type="mathematica:ASTNode" name="domLexGreater">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:IntLeaf"/>
                  </children>
                </children>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="lexGreaterOrLowerQ">
            <children xsi:type="mathematica:SymbolLeaf" name="a"/>
            <children xsi:type="mathematica:SymbolLeaf" name="b"/>
            <children xsi:type="mathematica:SymbolLeaf" name="p"/>
            <children xsi:type="mathematica:SymbolLeaf" name="strict"/>
            <children xsi:type="mathematica:SymbolLeaf" name="nonStrict"/>
            <children xsi:type="mathematica:SymbolLeaf" name="lexLowerOrEqualQ"/>
            <children xsi:type="mathematica:SymbolLeaf" name="True"/>
          </children>
        </children>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="lexLowerOrEqualQ">
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
            <children xsi:type="mathematica:SymbolLeaf" name="lexLowerOrEqualQ"/>
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
    <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrLowerQ"/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
    <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrLowerQ"/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="lexGreaterOrLowerQ">
      <children xsi:type="mathematica:ASTNode" name="Condition">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="MatrixQ">
          <children xsi:type="mathematica:SymbolLeaf" name="a"/>
          <children xsi:type="mathematica:SymbolLeaf" name="IntegerQ"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Condition">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="b"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="MatrixQ">
          <children xsi:type="mathematica:SymbolLeaf" name="b"/>
          <children xsi:type="mathematica:SymbolLeaf" name="IntegerQ"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="p"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
          <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="strict"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
          <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="nonStrict"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
          <children xsi:type="mathematica:SymbolLeaf" name="domain"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="function"/>
        <children xsi:type="mathematica:ASTNode" name="Alternatives">
          <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterQ"/>
          <children xsi:type="mathematica:SymbolLeaf" name="lexLowerQ"/>
          <children xsi:type="mathematica:SymbolLeaf" name="lexGreaterOrEqualQ"/>
          <children xsi:type="mathematica:SymbolLeaf" name="lexLowerOrEqualQ"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="orEqual"/>
        <children xsi:type="mathematica:ASTNode" name="Alternatives">
          <children xsi:type="mathematica:SymbolLeaf" name="True"/>
          <children xsi:type="mathematica:SymbolLeaf" name="False"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:ASTNode" name="Catch">
      <children xsi:type="mathematica:BuiltInNode" keyword="With">
        <children xsi:type="mathematica:BuiltInNode" keyword="List">
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="pdim"/>
            <children xsi:type="mathematica:ASTNode" name="Part">
              <children xsi:type="mathematica:SymbolLeaf" name="p"/>
              <children xsi:type="mathematica:IntLeaf" value="1"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
          <children xsi:type="mathematica:ASTNode" name="If">
            <children xsi:type="mathematica:ASTNode" name="UnsameQ">
              <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                <children xsi:type="mathematica:SymbolLeaf" name="a"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                <children xsi:type="mathematica:SymbolLeaf" name="b"/>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
              <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="function"/>
                  <children xsi:type="mathematica:StringLeaf" value="dim"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="Throw"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:ASTNode" name="If">
          <children xsi:type="mathematica:ASTNode" name="Not">
            <children xsi:type="mathematica:ASTNode" name="SameQ">
              <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                <children xsi:type="mathematica:ASTNode" name="First">
                  <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                <children xsi:type="mathematica:ASTNode" name="First">
                  <children xsi:type="mathematica:SymbolLeaf" name="b"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                <children xsi:type="mathematica:SymbolLeaf" name="pdim"/>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Message">
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="function"/>
                <children xsi:type="mathematica:StringLeaf" value="param"/>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="Throw"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="With">
        <children xsi:type="mathematica:BuiltInNode" keyword="List">
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="v"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
              <children xsi:type="mathematica:ASTNode" name="First">
                <children xsi:type="mathematica:SymbolLeaf" name="a"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                <children xsi:type="mathematica:ASTNode" name="First">
                  <children xsi:type="mathematica:SymbolLeaf" name="b"/>
                </children>
              </children>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Module">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
            <children xsi:type="mathematica:SymbolLeaf" name="strictly"/>
            <children xsi:type="mathematica:SymbolLeaf" name="nonStrictly"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
              <children xsi:type="mathematica:ASTNode" name="matrix">
                <children xsi:type="mathematica:IntLeaf" value="2"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                  <children xsi:type="mathematica:SymbolLeaf" name="pdim"/>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Part">
                  <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:SymbolLeaf" name="v"/>
                  <children xsi:type="mathematica:ASTNode" name="Append">
                    <children xsi:type="mathematica:ASTNode" name="Array">
                      <children xsi:type="mathematica:ASTNode" name="Function">
                        <children xsi:type="mathematica:IntLeaf"/>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="pdim"/>
                    </children>
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
              <children xsi:type="mathematica:ASTNode" name="DomImage">
                <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
              <children xsi:type="mathematica:SymbolLeaf" name="strictly"/>
              <children xsi:type="mathematica:ASTNode" name="DomEmptyQ">
                <children xsi:type="mathematica:ASTNode" name="DomIntersection">
                  <children xsi:type="mathematica:SymbolLeaf" name="strict"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
              <children xsi:type="mathematica:SymbolLeaf" name="nonStrictly"/>
              <children xsi:type="mathematica:ASTNode" name="DomEmptyQ">
                <children xsi:type="mathematica:ASTNode" name="DomIntersection">
                  <children xsi:type="mathematica:SymbolLeaf" name="nonStrict"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="If">
              <children xsi:type="mathematica:ASTNode" name="SameQ">
                <children xsi:type="mathematica:ASTNode" name="Rest">
                  <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="If">
                <children xsi:type="mathematica:SymbolLeaf" name="orEqual"/>
                <children xsi:type="mathematica:SymbolLeaf" name="nonStrictly"/>
                <children xsi:type="mathematica:SymbolLeaf" name="strictly"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="Or">
                <children xsi:type="mathematica:SymbolLeaf" name="strictly"/>
                <children xsi:type="mathematica:ASTNode" name="And">
                  <children xsi:type="mathematica:SymbolLeaf" name="nonStrictly"/>
                  <children xsi:type="mathematica:ASTNode" name="lexGreaterOrLowerQ">
                    <children xsi:type="mathematica:ASTNode" name="Rest">
                      <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Rest">
                      <children xsi:type="mathematica:SymbolLeaf" name="b"/>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="p"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="strict"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="nonStrict"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="function"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="orEqual"/>
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
