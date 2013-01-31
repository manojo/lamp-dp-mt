<?xml version="1.0" encoding="ASCII"?>
<mathematica:BuiltInNode xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mathematica="http://www.irisa.fr/cairn/model/xtext/Mathematica" keyword="Protect">
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="BeginPackage">
          <children xsi:type="mathematica:StringLeaf" value="Alpha`Uniformization`"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Domlib`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Options`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Matrix`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Tables`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`UniformizationTools`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Semantics`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Substitution`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Normalization`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Properties`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Static`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Pipeline`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Zpol`"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="Uniformization"/>
          <children xsi:type="mathematica:StringLeaf" value="usage"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="Package. Unifomization of&#xA; system of affine recurrence equations. &#xA;The uniformization implemented here assumes that&#xA;   the system is fully indexed and only computation equations&#xA;   are passed to any uniformization function"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="getDependences"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="getDependences[sys_]. Return the list of&#xA;non-uniform dependences."/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="whichRule"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="whichRule[sys_, dep_]. checks which rule should be&#xA;used for uniformization: local&#xA;uniformity, pipelining, routing, of the dependence &quot; dep &quot;. the&#xA;dependence &quot; dep &quot; is written in the format of the result of the&#xA;dep[]&#xA;function&#xA;"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="getPipeVecs"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value="getPipeVecs[ dep_]. returns a list of possible &#xA;pipeline vectors for the pipelining of dependence &quot; dep &quot;.  the&#xA;dependence &quot; dep &quot; is written in the format of the result of the&#xA;dep[] function"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="pipeDep"/>
                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                  <children xsi:type="mathematica:StringLeaf" value="pipeDep[sys_, dep_, pipevec_List]. returns a new system&#xA;after uniformizing dependence &quot; dep &quot; with the pipeline vector &quot;&#xA;pipevec &quot;. the&#xA;dependence &quot; dep &quot; is written in the format of the result of the&#xA;dep[] function&#xA;"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                    <children xsi:type="mathematica:SymbolLeaf" name="getRouteVecs"/>
                    <children xsi:type="mathematica:StringLeaf" value="usage"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:StringLeaf" value="getRouteVecs[sys_, dep_]. returns&#xA;a list of routing vectors and the routing coefficients for the routing&#xA;of dependence &quot; dep &quot;.  the dependence &quot; dep &quot; is written in the&#xA;format of the result of the dep[] function "/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                      <children xsi:type="mathematica:SymbolLeaf" name="routeDep"/>
                      <children xsi:type="mathematica:StringLeaf" value="usage"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:StringLeaf" value="routeDep[sys_, dep_, route_]. returns a new system &#xA; after uniformizing dependence &quot; dep &quot; with the routing&#xA;decomposition &quot; route &quot;. the structure of route is the one returned&#xA;by the getRouteVecs function"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="alignInput"/>
                        <children xsi:type="mathematica:StringLeaf" value="usage"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                        <children xsi:type="mathematica:StringLeaf" value=" alignInput[sys_, dep_]. returns a&#xA;new system after uniformizing the dependence &quot; dep &quot; with an input&#xA;equation. the dependence &quot; dep &quot; is written in the&#xA;format of the result of the dep[] function"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                          <children xsi:type="mathematica:SymbolLeaf" name="uniformizeLocal"/>
                          <children xsi:type="mathematica:StringLeaf" value="usage"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:StringLeaf" value="uniformizeLocal[sys_, dep_]. returns a new&#xA;system after re-writing the index mapping for dependence &quot; dep&quot; in&#xA;such a way that it is uniform."/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                            <children xsi:type="mathematica:SymbolLeaf" name="initUniformization"/>
                            <children xsi:type="mathematica:StringLeaf" value="usage"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                            <children xsi:type="mathematica:StringLeaf" value="initUniformization[sys_]. initializes the&#xA;system dependence cone and verifies if the cone is pointed. Outputs&#xA;the extremal rays of the cone (list of list)."/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                              <children xsi:type="mathematica:SymbolLeaf" name="verifyPipe"/>
                              <children xsi:type="mathematica:StringLeaf" value="usage"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                              <children xsi:type="mathematica:StringLeaf" value="verifyPipe[dep_, pipevec_]. checks if the&#xA;  dependence cone of &quot; dep&quot; and the chosen vector &quot; pipevec&quot; are pointed&#xA;  (necessary condition) and also if it is consistent with the current&#xA; system cone  (sufficient condition)."/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                <children xsi:type="mathematica:SymbolLeaf" name="verifyRoute"/>
                                <children xsi:type="mathematica:StringLeaf" value="usage"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                <children xsi:type="mathematica:StringLeaf" value="verifyRoute[sys_, dep_, route_]   checks if the&#xA;  dependence cone of &quot; dep &quot; and the chosen vectors &quot; route &quot; are pointed&#xA;  (necessary condition) and also if it is consistent with current system cone &#xA;  (sufficient condition)."/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                  <children xsi:type="mathematica:SymbolLeaf" name="depCone"/>
                                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                  <children xsi:type="mathematica:StringLeaf" value="depCone[depast_]. returns the data dependence cone of&#xA;the dependence depast in Alpha domain format. The dependence cone is ...."/>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                                    <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                    <children xsi:type="mathematica:StringLeaf" value="uniformize[sys_,dep_]. Attempts&#xA;to uniformize dep in  &quot; sys&quot; . The dependence &quot; dep &quot; is written in the&#xA;format of the result of the dep[] function"/>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                      <children xsi:type="mathematica:SymbolLeaf" name="callUniformize"/>
                                      <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                      <children xsi:type="mathematica:StringLeaf" value="callUniformize[file_String,options]. Loads &#xA;a system of equations from the `file'  &#xA; and invokes&#xA;uniformization routine  with default options. The uniformized system is written&#xA;back to a file named file.URE."/>
                                      <children xsi:type="mathematica:ASTNode" name="Begin">
                                        <children xsi:type="mathematica:StringLeaf" value="`Private`"/>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                        <children xsi:type="mathematica:SymbolLeaf" name="verifyRoute"/>
                                        <children xsi:type="mathematica:StringLeaf" value="invalid"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                        <children xsi:type="mathematica:StringLeaf" value="Choice of vectors `1` is invalid. Given vector&#xA;and dependence cones are not pointed. "/>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                          <children xsi:type="mathematica:SymbolLeaf" name="verifyPipe"/>
                                          <children xsi:type="mathematica:StringLeaf" value="invalid"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                          <children xsi:type="mathematica:StringLeaf" value="Choice of vectors `1` is invalid. Given vector&#xA;and dependence cones are not pointed. "/>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                            <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                                            <children xsi:type="mathematica:StringLeaf" value="dcomp"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                            <children xsi:type="mathematica:StringLeaf" value="routing decomposition not possible for this dependence."/>
                                            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                              <children xsi:type="mathematica:SymbolLeaf" name="initCone"/>
                                              <children xsi:type="mathematica:StringLeaf" value="msg"/>
                                            </children>
                                          </children>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                              <children xsi:type="mathematica:StringLeaf" value="Initialized system dependence cone. Cone is pointed with extremal rays `1` "/>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                <children xsi:type="mathematica:SymbolLeaf" name="initCone"/>
                                                <children xsi:type="mathematica:StringLeaf" value="invalid"/>
                                              </children>
                                            </children>
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                <children xsi:type="mathematica:StringLeaf" value="System dependence cone  is not pointed and has lines `1` "/>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="checkTimeCone"/>
                                                  <children xsi:type="mathematica:StringLeaf" value="valid"/>
                                                </children>
                                              </children>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                  <children xsi:type="mathematica:StringLeaf" value="Choice of vectors `1` valid "/>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                    <children xsi:type="mathematica:SymbolLeaf" name="checkTimeCone"/>
                                                    <children xsi:type="mathematica:StringLeaf" value="invalid"/>
                                                  </children>
                                                </children>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                    <children xsi:type="mathematica:StringLeaf" value="Choice of vectors `1` is invalid. System timing&#xA;cone is not pointed."/>
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                      <children xsi:type="mathematica:SymbolLeaf" name="extendSysIndex"/>
                                                      <children xsi:type="mathematica:StringLeaf" value="req"/>
                                                    </children>
                                                  </children>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                      <children xsi:type="mathematica:StringLeaf" value="Routing transformation Failed for variable `1`. The&#xA;equation defined by `2` and (possibly the entire system)&#xA;requires an additional index."/>
                                                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                        <children xsi:type="mathematica:SymbolLeaf" name="checkTimeCone"/>
                                                        <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                                      </children>
                                                    </children>
                                                    <children xsi:type="mathematica:StringLeaf" value="checkTimeCone[depCone, vecs]. Not to be used directly"/>
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
      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
        <children xsi:type="mathematica:SymbolLeaf" name="applyRule1"/>
        <children xsi:type="mathematica:StringLeaf" value="usage"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="empty"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="applyRule2"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="empty"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="applyRule3"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:StringLeaf" value="empty"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                <children xsi:type="mathematica:SymbolLeaf" name="applyRule4"/>
                <children xsi:type="mathematica:StringLeaf" value="usage"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                <children xsi:type="mathematica:StringLeaf" value="empty"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="addRaysToCone"/>
                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                  <children xsi:type="mathematica:StringLeaf" value="empty"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                    <children xsi:type="mathematica:SymbolLeaf" name="getIntBasis"/>
                    <children xsi:type="mathematica:StringLeaf" value="usage"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:StringLeaf" value="empty"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                      <children xsi:type="mathematica:SymbolLeaf" name="depVec"/>
                      <children xsi:type="mathematica:StringLeaf" value="usage"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:StringLeaf" value="empty"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                        <children xsi:type="mathematica:SymbolLeaf" name="depDomain"/>
                        <children xsi:type="mathematica:StringLeaf" value="usage"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                        <children xsi:type="mathematica:StringLeaf" value="empty"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                          <children xsi:type="mathematica:SymbolLeaf" name="showDepCone"/>
                          <children xsi:type="mathematica:StringLeaf" value="usage"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:StringLeaf" value="empty"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                            <children xsi:type="mathematica:SymbolLeaf" name="pipeVecs"/>
                            <children xsi:type="mathematica:StringLeaf" value="usage"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                            <children xsi:type="mathematica:StringLeaf" value="empty"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                              <children xsi:type="mathematica:SymbolLeaf" name="routeVecs"/>
                              <children xsi:type="mathematica:StringLeaf" value="usage"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                              <children xsi:type="mathematica:StringLeaf" value="empty"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                <children xsi:type="mathematica:SymbolLeaf" name="unimodularBasis"/>
                                <children xsi:type="mathematica:StringLeaf" value="usage"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                <children xsi:type="mathematica:StringLeaf" value="empty"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                  <children xsi:type="mathematica:SymbolLeaf" name="unimodularCone"/>
                                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                  <children xsi:type="mathematica:StringLeaf" value="empty"/>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                    <children xsi:type="mathematica:SymbolLeaf" name="checkVecInLinSpace"/>
                                    <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                    <children xsi:type="mathematica:StringLeaf" value="empty"/>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                      <children xsi:type="mathematica:SymbolLeaf" name="usePipeIO"/>
                                      <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                      <children xsi:type="mathematica:StringLeaf" value="empty"/>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                        <children xsi:type="mathematica:SymbolLeaf" name="affTransMat"/>
                                        <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                        <children xsi:type="mathematica:StringLeaf" value="empty"/>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                          <children xsi:type="mathematica:SymbolLeaf" name="localUniformQ"/>
                                          <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                          <children xsi:type="mathematica:StringLeaf" value="empty"/>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                            <children xsi:type="mathematica:SymbolLeaf" name="alignInputQ"/>
                                            <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                            <children xsi:type="mathematica:StringLeaf" value="empty"/>
                                            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                              <children xsi:type="mathematica:SymbolLeaf" name="getUniformizationVecs"/>
                                              <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                            </children>
                                          </children>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                              <children xsi:type="mathematica:StringLeaf" value="getUniformizationVecs[dep_,intbasis_]. &#xA;Returns a list of uniformizing vector "/>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                <children xsi:type="mathematica:SymbolLeaf" name="uniformdomQ"/>
                                                <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                              </children>
                                            </children>
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                <children xsi:type="mathematica:StringLeaf" value="uniformdomQ[dep_, dom_] applies a series&#xA;of tests to check if the dependence is uniform within a given domain(local uniformity)"/>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="pointedConeQ"/>
                                                  <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                                </children>
                                              </children>
                                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                  <children xsi:type="mathematica:StringLeaf" value="pointedConeQ[_Matrix] Returns True if the cone&#xA;defined by Matrix is pointed and false otherwise "/>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                    <children xsi:type="mathematica:SymbolLeaf" name="updateSysCone"/>
                                                    <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                                  </children>
                                                </children>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                    <children xsi:type="mathematica:StringLeaf" value="empty"/>
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                                      <children xsi:type="mathematica:SymbolLeaf" name="initCones"/>
                                                      <children xsi:type="mathematica:StringLeaf" value="usage"/>
                                                    </children>
                                                  </children>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                                    <children xsi:type="mathematica:StringLeaf" value="empty"/>
                                                    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                                      <children xsi:type="mathematica:SymbolLeaf" name="dropConst"/>
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
      <children xsi:type="mathematica:ASTNode" name="dropConst">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Return">
        <children xsi:type="mathematica:ASTNode" name="Drop">
          <children xsi:type="mathematica:BuiltInNode" keyword="Map">
            <children xsi:type="mathematica:ASTNode" name="Function">
              <children xsi:type="mathematica:ASTNode" name="Drop">
                <children xsi:type="mathematica:ASTNode" name="Slot">
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
                <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
              </children>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
          </children>
          <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="getConst">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Return">
        <children xsi:type="mathematica:ASTNode" name="Flatten">
          <children xsi:type="mathematica:ASTNode" name="Drop">
            <children xsi:type="mathematica:BuiltInNode" keyword="Map">
              <children xsi:type="mathematica:ASTNode" name="Function">
                <children xsi:type="mathematica:ASTNode" name="Take">
                  <children xsi:type="mathematica:ASTNode" name="Slot">
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                  <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                </children>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="mat"/>
            </children>
            <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="addRaysToCone"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="addRaysToCone">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="trays"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="Module">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
            <children xsi:type="mathematica:SymbolLeaf" name="mats"/>
            <children xsi:type="mathematica:SymbolLeaf" name="tcone"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="tcone"/>
              <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="mats"/>
              <children xsi:type="mathematica:ASTNode" name="matrix">
                <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                    <children xsi:type="mathematica:SymbolLeaf" name="trays"/>
                  </children>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="trays"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Part">
                  <children xsi:type="mathematica:SymbolLeaf" name="tcone"/>
                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Append">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                    <children xsi:type="mathematica:ASTNode" name="Function">
                      <children xsi:type="mathematica:ASTNode" name="Append">
                        <children xsi:type="mathematica:ASTNode" name="Prepend">
                          <children xsi:type="mathematica:ASTNode" name="Slot">
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                        </children>
                        <children xsi:type="mathematica:IntLeaf"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="trays"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Append">
                    <children xsi:type="mathematica:ASTNode" name="Table">
                      <children xsi:type="mathematica:IntLeaf"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                        <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                            <children xsi:type="mathematica:ASTNode" name="Part">
                              <children xsi:type="mathematica:SymbolLeaf" name="trays"/>
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="Return">
              <children xsi:type="mathematica:ASTNode" name="DomAddRays">
                <children xsi:type="mathematica:SymbolLeaf" name="tcone"/>
                <children xsi:type="mathematica:SymbolLeaf" name="mats"/>
              </children>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="idempotentQ"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="idempotentQ">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
          <children xsi:type="mathematica:ASTNode" name="depend">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="adom"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="adep"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="idempotentQ">
        <children xsi:type="mathematica:ASTNode" name="dropConst">
          <children xsi:type="mathematica:ASTNode" name="Part">
            <children xsi:type="mathematica:SymbolLeaf" name="adep"/>
            <children xsi:type="mathematica:IntLeaf" value="4"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="idempotentQ">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="depmat"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="SameQ">
        <children xsi:type="mathematica:SymbolLeaf" name="depmat"/>
        <children xsi:type="mathematica:ASTNode" name="Dot">
          <children xsi:type="mathematica:SymbolLeaf" name="depmat"/>
          <children xsi:type="mathematica:SymbolLeaf" name="depmat"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
      <children xsi:type="mathematica:SymbolLeaf" name="pointedConeQ"/>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="pointedConeQ">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="cone"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:ASTNode" name="Block">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:SymbolLeaf" name="sol"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="sol"/>
              <children xsi:type="mathematica:ASTNode" name="NullSpace">
                <children xsi:type="mathematica:SymbolLeaf" name="cone"/>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="If">
              <children xsi:type="mathematica:ASTNode" name="SameQ">
                <children xsi:type="mathematica:SymbolLeaf" name="sol"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="Return">
                <children xsi:type="mathematica:SymbolLeaf" name="True"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="Return">
                <children xsi:type="mathematica:ASTNode" name="Unequal">
                  <children xsi:type="mathematica:ASTNode" name="MemberQ">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                      <children xsi:type="mathematica:ASTNode" name="Function">
                        <children xsi:type="mathematica:ASTNode" name="FreeQ">
                          <children xsi:type="mathematica:ASTNode" name="Slot">
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="Condition">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                              <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Less">
                              <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                              <children xsi:type="mathematica:IntLeaf"/>
                            </children>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="sol"/>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                </children>
              </children>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="showDepCone"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="showDepCone">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
            <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:BuiltInNode" keyword="Module">
            <children xsi:type="mathematica:BuiltInNode" keyword="List">
              <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                <children xsi:type="mathematica:ASTNode" name="DepCone">
                  <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="Return">
                <children xsi:type="mathematica:ASTNode" name="Show">
                  <children xsi:type="mathematica:ASTNode" name="GraphicsArray">
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:ASTNode" name="showDomain">
                        <children xsi:type="mathematica:ASTNode" name="depDomain">
                          <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                        </children>
                        <children xsi:type="mathematica:StringLeaf" value="range"/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="showDomain">
                        <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                        <children xsi:type="mathematica:StringLeaf" value="cone"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                    <children xsi:type="mathematica:SymbolLeaf" name="PlotLabel"/>
                    <children xsi:type="mathematica:ASTNode" name="show">
                      <children xsi:type="mathematica:ASTNode" name="dtable">
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                        <children xsi:type="mathematica:SymbolLeaf" name="silent"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                      </children>
                    </children>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
            <children xsi:type="mathematica:SymbolLeaf" name="depDomain"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="depDomain">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
              <children xsi:type="mathematica:ASTNode" name="depend">
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="adom"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="depmat"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:BuiltInNode" keyword="Module">
            <children xsi:type="mathematica:BuiltInNode" keyword="List">
              <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
              <children xsi:type="mathematica:SymbolLeaf" name="dvec"/>
              <children xsi:type="mathematica:SymbolLeaf" name="theta"/>
              <children xsi:type="mathematica:SymbolLeaf" name="range"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="dvec"/>
                <children xsi:type="mathematica:ASTNode" name="depVec">
                  <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="theta"/>
                <children xsi:type="mathematica:ASTNode" name="mmaToAlphaMatrix">
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="dvec"/>
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="dvec"/>
                    <children xsi:type="mathematica:IntLeaf" value="2"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="theta"/>
                <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                  <children xsi:type="mathematica:SymbolLeaf" name="theta"/>
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="adom"/>
                    <children xsi:type="mathematica:IntLeaf" value="2"/>
                  </children>
                  <children xsi:type="mathematica:IntLeaf" value="3"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="range"/>
                <children xsi:type="mathematica:ASTNode" name="DomImage">
                  <children xsi:type="mathematica:SymbolLeaf" name="adom"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="theta"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="Return">
                <children xsi:type="mathematica:SymbolLeaf" name="range"/>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
            <children xsi:type="mathematica:SymbolLeaf" name="depCone"/>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="depCone">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
          <children xsi:type="mathematica:ASTNode" name="depend">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="adom"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="adep1"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="Module">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:SymbolLeaf" name="range"/>
            <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
            <children xsi:type="mathematica:SymbolLeaf" name="verticesAndRays"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="range"/>
              <children xsi:type="mathematica:ASTNode" name="depDomain">
                <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
              <children xsi:type="mathematica:ASTNode" name="DomEmpty">
                <children xsi:type="mathematica:ASTNode" name="Part">
                  <children xsi:type="mathematica:SymbolLeaf" name="adom"/>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
              <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                <children xsi:type="mathematica:ASTNode" name="Part">
                  <children xsi:type="mathematica:SymbolLeaf" name="adom"/>
                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                </children>
                <children xsi:type="mathematica:IntLeaf" value="2"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="verticesAndRays"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Union">
                <children xsi:type="mathematica:ASTNode" name="getVertices">
                  <children xsi:type="mathematica:SymbolLeaf" name="range"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="rays">
                  <children xsi:type="mathematica:SymbolLeaf" name="range"/>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="Return">
              <children xsi:type="mathematica:ASTNode" name="DomSimplify">
                <children xsi:type="mathematica:ASTNode" name="addRaysToCone">
                  <children xsi:type="mathematica:SymbolLeaf" name="verticesAndRays"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="DomUniverse">
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="adom"/>
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="hasLinesQ"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="hasLinesQ">
        <children xsi:type="mathematica:ASTNode" name="domain">
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="pl"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="Greater">
        <children xsi:type="mathematica:ASTNode" name="Part">
          <children xsi:type="mathematica:ASTNode" name="Part">
            <children xsi:type="mathematica:SymbolLeaf" name="pl"/>
            <children xsi:type="mathematica:IntLeaf" value="1"/>
          </children>
          <children xsi:type="mathematica:IntLeaf" value="4"/>
        </children>
        <children xsi:type="mathematica:IntLeaf"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="pipeVecs"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="pipeVecs">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
            <children xsi:type="mathematica:ASTNode" name="depend">
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="intbasis"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="Module">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
            <children xsi:type="mathematica:SymbolLeaf" name="conebasis"/>
            <children xsi:type="mathematica:SymbolLeaf" name="dmat"/>
            <children xsi:type="mathematica:SymbolLeaf" name="bmat"/>
            <children xsi:type="mathematica:SymbolLeaf" name="vecs"/>
            <children xsi:type="mathematica:SymbolLeaf" name="trays"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
              <children xsi:type="mathematica:ASTNode" name="depCone">
                <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="If">
              <children xsi:type="mathematica:ASTNode" name="SameQ">
                <children xsi:type="mathematica:ASTNode" name="properSubspaceQ">
                  <children xsi:type="mathematica:ASTNode" name="domainBasis">
                    <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="intbasis"/>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="True"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="Return">
                <children xsi:type="mathematica:ASTNode" name="rays">
                  <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="vecs"/>
              <children xsi:type="mathematica:ASTNode" name="getBasis">
                <children xsi:type="mathematica:SymbolLeaf" name="intbasis"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="trays"/>
              <children xsi:type="mathematica:ASTNode" name="rays">
                <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="bmat"/>
              <children xsi:type="mathematica:SymbolLeaf" name="trays"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="Do">
              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="bmat"/>
                  <children xsi:type="mathematica:ASTNode" name="Append">
                    <children xsi:type="mathematica:SymbolLeaf" name="bmat"/>
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="vecs"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="SameQ">
                    <children xsi:type="mathematica:ASTNode" name="pointedConeQ">
                      <children xsi:type="mathematica:ASTNode" name="Transpose">
                        <children xsi:type="mathematica:SymbolLeaf" name="bmat"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="bmat"/>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="bmat"/>
                      <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                        <children xsi:type="mathematica:SymbolLeaf" name="bmat"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                          <children xsi:type="mathematica:ASTNode" name="Last">
                            <children xsi:type="mathematica:SymbolLeaf" name="bmat"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                  <children xsi:type="mathematica:SymbolLeaf" name="vecs"/>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="Return">
              <children xsi:type="mathematica:ASTNode" name="Take">
                <children xsi:type="mathematica:SymbolLeaf" name="bmat"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                  <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                    <children xsi:type="mathematica:SymbolLeaf" name="vecs"/>
                  </children>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="makeStr"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="makeStr">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:ASTNode" name="Block">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:SymbolLeaf" name="v1"/>
            <children xsi:type="mathematica:SymbolLeaf" name="v2"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="v1"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                <children xsi:type="mathematica:SymbolLeaf" name="ToString"/>
                <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="v2"/>
              <children xsi:type="mathematica:ASTNode" name="Outer">
                <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                <children xsi:type="mathematica:SymbolLeaf" name="v1"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:StringLeaf" value=","/>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="v2"/>
              <children xsi:type="mathematica:ASTNode" name="Flatten">
                <children xsi:type="mathematica:SymbolLeaf" name="v2"/>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="Return">
              <children xsi:type="mathematica:ASTNode" name="StringDrop">
                <children xsi:type="mathematica:ASTNode" name="StringJoin">
                  <children xsi:type="mathematica:SymbolLeaf" name="v2"/>
                </children>
                <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
              </children>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="genPipeSubsystem"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="genPipeSubsystem">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
          <children xsi:type="mathematica:ASTNode" name="depend">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="pipe"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="genPipeSubsystem"/>
      <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
      <children xsi:type="mathematica:SymbolLeaf" name="pipe"/>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="genPipeSubsystem">
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
        <children xsi:type="mathematica:ASTNode" name="depend">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="pipe"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
        <children xsi:type="mathematica:BuiltInNode" keyword="List">
          <children xsi:type="mathematica:SymbolLeaf" name="alpha"/>
          <children xsi:type="mathematica:SymbolLeaf" name="phi"/>
          <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
          <children xsi:type="mathematica:SymbolLeaf" name="d1"/>
          <children xsi:type="mathematica:SymbolLeaf" name="d2"/>
          <children xsi:type="mathematica:SymbolLeaf" name="tmat"/>
          <children xsi:type="mathematica:SymbolLeaf" name="amat"/>
          <children xsi:type="mathematica:SymbolLeaf" name="rvar"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
            <children xsi:type="mathematica:ASTNode" name="Part">
              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
              <children xsi:type="mathematica:IntLeaf" value="2"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="tmat"/>
            <children xsi:type="mathematica:ASTNode" name="IdentityMatrix">
              <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="tmat"/>
            <children xsi:type="mathematica:ASTNode" name="Transpose">
              <children xsi:type="mathematica:ASTNode" name="Append">
                <children xsi:type="mathematica:SymbolLeaf" name="tmat"/>
                <children xsi:type="mathematica:SymbolLeaf" name="pipe"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="lastrow"/>
            <children xsi:type="mathematica:ASTNode" name="Append">
              <children xsi:type="mathematica:ASTNode" name="Table">
                <children xsi:type="mathematica:IntLeaf"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                    <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:IntLeaf" value="1"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="tmat"/>
            <children xsi:type="mathematica:ASTNode" name="Append">
              <children xsi:type="mathematica:SymbolLeaf" name="tmat"/>
              <children xsi:type="mathematica:SymbolLeaf" name="lastrow"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="amat"/>
            <children xsi:type="mathematica:ASTNode" name="matrix">
              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                  <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                </children>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                  <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                </children>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
              <children xsi:type="mathematica:SymbolLeaf" name="tmat"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="d1"/>
            <children xsi:type="mathematica:ASTNode" name="DomImage">
              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
              <children xsi:type="mathematica:SymbolLeaf" name="amat"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="d1"/>
            <children xsi:type="mathematica:ASTNode" name="DomIntersection">
              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
              <children xsi:type="mathematica:SymbolLeaf" name="d1"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="d2"/>
            <children xsi:type="mathematica:ASTNode" name="DomDifference">
              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
              <children xsi:type="mathematica:SymbolLeaf" name="d1"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="rvar"/>
            <children xsi:type="mathematica:ASTNode" name="getNewName">
              <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
              <children xsi:type="mathematica:ASTNode" name="ToString">
                <children xsi:type="mathematica:ASTNode" name="Unique">
                  <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                </children>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="newdep"/>
            <children xsi:type="mathematica:ASTNode" name="Append">
              <children xsi:type="mathematica:ASTNode" name="Transpose">
                <children xsi:type="mathematica:ASTNode" name="Append">
                  <children xsi:type="mathematica:ASTNode" name="IdentityMatrix">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                      <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="pipe"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="lastrow"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="newdep"/>
            <children xsi:type="mathematica:ASTNode" name="matrix">
              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                  <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                </children>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                  <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                </children>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
              <children xsi:type="mathematica:SymbolLeaf" name="newdep"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
            <children xsi:type="mathematica:ASTNode" name="equation">
              <children xsi:type="mathematica:SymbolLeaf" name="rvar"/>
              <children xsi:type="mathematica:ASTNode" name="restrict">
                <children xsi:type="mathematica:SymbolLeaf" name="d1"/>
                <children xsi:type="mathematica:ASTNode" name="affine">
                  <children xsi:type="mathematica:ASTNode" name="var">
                    <children xsi:type="mathematica:SymbolLeaf" name="rvar"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="newdep"/>
                </children>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
            <children xsi:type="mathematica:ASTNode" name="equation">
              <children xsi:type="mathematica:SymbolLeaf" name="rvar"/>
              <children xsi:type="mathematica:ASTNode" name="restrict">
                <children xsi:type="mathematica:SymbolLeaf" name="d2"/>
                <children xsi:type="mathematica:ASTNode" name="affine">
                  <children xsi:type="mathematica:ASTNode" name="var">
                    <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                </children>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="Return">
            <children xsi:type="mathematica:BuiltInNode" keyword="List">
              <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
              <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
            </children>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
        <children xsi:type="mathematica:SymbolLeaf" name="pipeVar"/>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="pipeVar">
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
        <children xsi:type="mathematica:ASTNode" name="depend">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="adep"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="pvect"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
        <children xsi:type="mathematica:BuiltInNode" keyword="List">
          <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
          <children xsi:type="mathematica:SymbolLeaf" name="psys"/>
          <children xsi:type="mathematica:SymbolLeaf" name="rpos"/>
          <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
          <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
          <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
          <children xsi:type="mathematica:SymbolLeaf" name="eqndom"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="subsys"/>
            <children xsi:type="mathematica:ASTNode" name="genPipeSubsystem">
              <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
              <children xsi:type="mathematica:SymbolLeaf" name="pvect"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
            <children xsi:type="mathematica:ASTNode" name="Part">
              <children xsi:type="mathematica:SymbolLeaf" name="subsys"/>
              <children xsi:type="mathematica:IntLeaf" value="1"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
            <children xsi:type="mathematica:ASTNode" name="Part">
              <children xsi:type="mathematica:SymbolLeaf" name="subsys"/>
              <children xsi:type="mathematica:IntLeaf" value="2"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="eqndom"/>
            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="rpos"/>
            <children xsi:type="mathematica:ASTNode" name="getOccursInDef">
              <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
              <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
              <children xsi:type="mathematica:ASTNode" name="affine">
                <children xsi:type="mathematica:ASTNode" name="var">
                  <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="adep"/>
              </children>
              <children xsi:type="mathematica:IntLeaf" value="1"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
            <children xsi:type="mathematica:ASTNode" name="getPart">
              <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
              <children xsi:type="mathematica:SymbolLeaf" name="rpos"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
            <children xsi:type="mathematica:ASTNode" name="ReplacePart">
              <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
              <children xsi:type="mathematica:ASTNode" name="IdentityMatrix">
                <children xsi:type="mathematica:ASTNode" name="Part">
                  <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:IntLeaf" value="2"/>
                <children xsi:type="mathematica:IntLeaf" value="4"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
            <children xsi:type="mathematica:ASTNode" name="ReplacePart">
              <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
              <children xsi:type="mathematica:ASTNode" name="Part">
                <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:IntLeaf" value="1"/>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="psys"/>
            <children xsi:type="mathematica:ASTNode" name="equation">
              <children xsi:type="mathematica:ASTNode" name="Part">
                <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="case">
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:ASTNode" name="restrict">
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                      <children xsi:type="mathematica:IntLeaf" value="2"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="affine">
                      <children xsi:type="mathematica:ASTNode" name="Part">
                        <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Part">
                        <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="restrict">
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                      <children xsi:type="mathematica:IntLeaf" value="2"/>
                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="affine">
                      <children xsi:type="mathematica:ASTNode" name="Part">
                        <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Part">
                        <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                      </children>
                    </children>
                  </children>
                </children>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
            <children xsi:type="mathematica:ASTNode" name="Insert">
              <children xsi:type="mathematica:ASTNode" name="Insert">
                <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                  <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="rpos"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="decl">
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="eqndom"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:IntLeaf" value="5"/>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="psys"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:IntLeaf" value="6"/>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="Return">
            <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
        <children xsi:type="mathematica:SymbolLeaf" name="usePipeall"/>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="usePipeall">
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
        <children xsi:type="mathematica:ASTNode" name="depend">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="depMat"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="pvect"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:ASTNode" name="Catch">
          <children xsi:type="mathematica:BuiltInNode" keyword="Module">
            <children xsi:type="mathematica:BuiltInNode" keyword="List">
              <children xsi:type="mathematica:SymbolLeaf" name="rpos"/>
              <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
              <children xsi:type="mathematica:SymbolLeaf" name="pexp"/>
              <children xsi:type="mathematica:SymbolLeaf" name="pvar"/>
              <children xsi:type="mathematica:SymbolLeaf" name="pipexpr"/>
              <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
              <children xsi:type="mathematica:SymbolLeaf" name="pipespec"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
                <children xsi:type="mathematica:ASTNode" name="affine">
                  <children xsi:type="mathematica:ASTNode" name="var">
                    <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="depMat"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="pexp"/>
                <children xsi:type="mathematica:ASTNode" name="translationMatrix">
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:ASTNode" name="Part">
                      <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
                      <children xsi:type="mathematica:IntLeaf" value="2"/>
                    </children>
                    <children xsi:type="mathematica:IntLeaf" value="3"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="pvect"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="pvar"/>
                <children xsi:type="mathematica:ASTNode" name="getNewName">
                  <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                  <children xsi:type="mathematica:ASTNode" name="ToString">
                    <children xsi:type="mathematica:ASTNode" name="Unique">
                      <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                    </children>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="pipexpr"/>
                <children xsi:type="mathematica:ASTNode" name="affine">
                  <children xsi:type="mathematica:ASTNode" name="var">
                    <children xsi:type="mathematica:SymbolLeaf" name="pvar"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="pexp"/>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="Return">
                <children xsi:type="mathematica:ASTNode" name="pipeall">
                  <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="pipexpr"/>
                </children>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:ASTNode" name="usePipeall">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="a"/>
            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="usePipeall"/>
          <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
        </children>
        <children xsi:type="mathematica:SymbolLeaf" name="a"/>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
    <children xsi:type="mathematica:SymbolLeaf" name="getPipeVecs"/>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="getPipeVecs">
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
        <children xsi:type="mathematica:ASTNode" name="depend">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
        <children xsi:type="mathematica:BuiltInNode" keyword="List">
          <children xsi:type="mathematica:SymbolLeaf" name="vecs"/>
          <children xsi:type="mathematica:SymbolLeaf" name="intbasis"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:SymbolLeaf" name="intbasis"/>
            <children xsi:type="mathematica:ASTNode" name="getIntBasis">
              <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
            </children>
          </children>
          <children xsi:type="mathematica:ASTNode" name="Return">
            <children xsi:type="mathematica:ASTNode" name="pipeVecs">
              <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
              <children xsi:type="mathematica:SymbolLeaf" name="intbasis"/>
            </children>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
        <children xsi:type="mathematica:SymbolLeaf" name="pipeDep"/>
      </children>
    </children>
  </children>
  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
    <children xsi:type="mathematica:ASTNode" name="pipeDep">
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
        <children xsi:type="mathematica:ASTNode" name="depend">
          <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="pipe"/>
        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
        <children xsi:type="mathematica:SymbolLeaf" name="options"/>
        <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
          <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:ASTNode" name="Catch">
            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
              <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                    <children xsi:type="mathematica:ASTNode" name="pipeDep">
                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="pipe"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="If">
                    <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                      <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                  </children>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
            </children>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
        </children>
      </children>
      <children xsi:type="mathematica:ASTNode" name="pipeDep">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
          <children xsi:type="mathematica:ASTNode" name="depend">
            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="pipe"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="options"/>
          <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
            <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:ASTNode" name="Catch">
            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
              <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:SymbolLeaf" name="tmpsys"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="optVerb"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="optVerf"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="optVerb"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                        <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Options">
                        <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="optVerf"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                        <children xsi:type="mathematica:SymbolLeaf" name="verifyCone"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Options">
                        <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="If">
                    <children xsi:type="mathematica:SymbolLeaf" name="optVerb"/>
                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                      <children xsi:type="mathematica:ASTNode" name="Print">
                        <children xsi:type="mathematica:StringLeaf" value="Pipelining dependence "/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="show">
                        <children xsi:type="mathematica:ASTNode" name="dtable">
                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                            <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Print">
                        <children xsi:type="mathematica:StringLeaf" value=" with vector "/>
                        <children xsi:type="mathematica:SymbolLeaf" name="pipe"/>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="tmpsys"/>
                    <children xsi:type="mathematica:ASTNode" name="usePipeall">
                      <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="pipe"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="If">
                    <children xsi:type="mathematica:SymbolLeaf" name="optVerf"/>
                    <children xsi:type="mathematica:ASTNode" name="updateSysCone">
                      <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                        <children xsi:type="mathematica:SymbolLeaf" name="pipe"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Return">
                    <children xsi:type="mathematica:SymbolLeaf" name="tmpsys"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                </children>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
            <children xsi:type="mathematica:SymbolLeaf" name="unimodularBasis"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="unimodularBasis">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="options"/>
              <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:ASTNode" name="Block">
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="erays"/>
                <children xsi:type="mathematica:SymbolLeaf" name="optDbug"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="erays"/>
                  <children xsi:type="mathematica:ASTNode" name="rays">
                    <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="optDbug"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                      <children xsi:type="mathematica:SymbolLeaf" name="debug"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                        <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Options">
                      <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:SymbolLeaf" name="optDbug"/>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:ASTNode" name="Print">
                      <children xsi:type="mathematica:StringLeaf" value="rays : "/>
                      <children xsi:type="mathematica:ASTNode" name="rays">
                        <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                      </children>
                      <children xsi:type="mathematica:StringLeaf" value=", erays : &#xA;"/>
                      <children xsi:type="mathematica:ASTNode" name="Take">
                        <children xsi:type="mathematica:ASTNode" name="unimodCompl">
                          <children xsi:type="mathematica:SymbolLeaf" name="erays"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                          <children xsi:type="mathematica:SymbolLeaf" name="erays"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Return">
                  <children xsi:type="mathematica:ASTNode" name="Take">
                    <children xsi:type="mathematica:ASTNode" name="unimodCompl">
                      <children xsi:type="mathematica:SymbolLeaf" name="erays"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                      <children xsi:type="mathematica:SymbolLeaf" name="erays"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
              <children xsi:type="mathematica:SymbolLeaf" name="unimodularCone"/>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="unimodularCone">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="Module">
          <children xsi:type="mathematica:BuiltInNode" keyword="List">
            <children xsi:type="mathematica:SymbolLeaf" name="urays"/>
            <children xsi:type="mathematica:SymbolLeaf" name="ucone"/>
          </children>
          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="urays"/>
              <children xsi:type="mathematica:ASTNode" name="unimodularBasis">
                <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="ucone"/>
              <children xsi:type="mathematica:ASTNode" name="DomEmpty">
                <children xsi:type="mathematica:ASTNode" name="Part">
                  <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="ucone"/>
              <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                <children xsi:type="mathematica:SymbolLeaf" name="ucone"/>
                <children xsi:type="mathematica:ASTNode" name="Part">
                  <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                </children>
                <children xsi:type="mathematica:IntLeaf" value="2"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
              <children xsi:type="mathematica:SymbolLeaf" name="ucone"/>
              <children xsi:type="mathematica:ASTNode" name="addRaysToCone">
                <children xsi:type="mathematica:SymbolLeaf" name="urays"/>
                <children xsi:type="mathematica:SymbolLeaf" name="ucone"/>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="Return">
              <children xsi:type="mathematica:SymbolLeaf" name="ucone"/>
            </children>
            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
          <children xsi:type="mathematica:SymbolLeaf" name="routeVecs"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
      <children xsi:type="mathematica:ASTNode" name="routeVecs">
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
          <children xsi:type="mathematica:ASTNode" name="depend">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
          <children xsi:type="mathematica:SymbolLeaf" name="options"/>
          <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
            <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:ASTNode" name="Catch">
            <children xsi:type="mathematica:BuiltInNode" keyword="Module">
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                <children xsi:type="mathematica:SymbolLeaf" name="erays"/>
                <children xsi:type="mathematica:SymbolLeaf" name="theta"/>
                <children xsi:type="mathematica:SymbolLeaf" name="alphas"/>
                <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                  <children xsi:type="mathematica:ASTNode" name="depCone">
                    <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="erays"/>
                  <children xsi:type="mathematica:ASTNode" name="unimodularBasis">
                    <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="theta"/>
                  <children xsi:type="mathematica:ASTNode" name="depVec">
                    <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="alphas"/>
                  <children xsi:type="mathematica:ASTNode" name="Check">
                    <children xsi:type="mathematica:ASTNode" name="LinearSolve">
                      <children xsi:type="mathematica:ASTNode" name="Transpose">
                        <children xsi:type="mathematica:SymbolLeaf" name="erays"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                        <children xsi:type="mathematica:ASTNode" name="Dot">
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:SymbolLeaf" name="theta"/>
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="Part">
                          <children xsi:type="mathematica:SymbolLeaf" name="theta"/>
                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="Throw">
                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                            <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                            <children xsi:type="mathematica:StringLeaf" value="dcomp"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
                  <children xsi:type="mathematica:ASTNode" name="MapThread">
                    <children xsi:type="mathematica:ASTNode" name="Function">
                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                        <children xsi:type="mathematica:ASTNode" name="Slot">
                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="Slot">
                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:SymbolLeaf" name="alphas"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="erays"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
                  <children xsi:type="mathematica:ASTNode" name="checkVecInLinSpace">
                    <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Return">
                  <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
            <children xsi:type="mathematica:SymbolLeaf" name="extendSysIndex"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:ASTNode" name="extendSysIndex">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
            <children xsi:type="mathematica:ASTNode" name="depend">
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="adep"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="rin"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:BuiltInNode" keyword="Module">
            <children xsi:type="mathematica:BuiltInNode" keyword="List">
              <children xsi:type="mathematica:SymbolLeaf" name="nvecs"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
              <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                  <children xsi:type="mathematica:SymbolLeaf" name="extendSysIndex"/>
                  <children xsi:type="mathematica:StringLeaf" value="req"/>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
            <children xsi:type="mathematica:SymbolLeaf" name="checkVecInLinSpace"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:ASTNode" name="checkVecInLinSpace">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
            <children xsi:type="mathematica:ASTNode" name="depend">
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="adep"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="rvecs"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:BuiltInNode" keyword="Module">
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="domb"/>
                <children xsi:type="mathematica:SymbolLeaf" name="nvecs"/>
                <children xsi:type="mathematica:SymbolLeaf" name="nalpha"/>
                <children xsi:type="mathematica:SymbolLeaf" name="nvect"/>
                <children xsi:type="mathematica:SymbolLeaf" name="rvectors"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:ASTNode" name="decomposeRoute">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="rin"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="nvec"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Block">
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:SymbolLeaf" name="dummy"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="nalpha"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                          <children xsi:type="mathematica:SymbolLeaf" name="nalpha"/>
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:SymbolLeaf" name="rin"/>
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Return">
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:SymbolLeaf" name="rin"/>
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                            <children xsi:type="mathematica:ASTNode" name="Part">
                              <children xsi:type="mathematica:SymbolLeaf" name="rin"/>
                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                              <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="nvec"/>
                            </children>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="nalpha"/>
                  <children xsi:type="mathematica:IntLeaf"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="domb"/>
                  <children xsi:type="mathematica:ASTNode" name="domainBasis">
                    <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="nvecs"/>
                  <children xsi:type="mathematica:ASTNode" name="NullSpace">
                    <children xsi:type="mathematica:ASTNode" name="getBasis">
                      <children xsi:type="mathematica:SymbolLeaf" name="domb"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="If">
                  <children xsi:type="mathematica:ASTNode" name="SameQ">
                    <children xsi:type="mathematica:ASTNode" name="And">
                      <children xsi:type="mathematica:ASTNode" name="Equal">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                          <children xsi:type="mathematica:SymbolLeaf" name="nvecs"/>
                        </children>
                        <children xsi:type="mathematica:IntLeaf"/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Greater">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                            <children xsi:type="mathematica:ASTNode" name="Function">
                              <children xsi:type="mathematica:ASTNode" name="vecInBasisQ">
                                <children xsi:type="mathematica:ASTNode" name="Part">
                                  <children xsi:type="mathematica:ASTNode" name="Slot">
                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  </children>
                                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="domb"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:SymbolLeaf" name="rvecs"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:IntLeaf"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Return">
                    <children xsi:type="mathematica:ASTNode" name="extendSysIndex">
                      <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="rvecs"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="nvect"/>
                      <children xsi:type="mathematica:ASTNode" name="Part">
                        <children xsi:type="mathematica:SymbolLeaf" name="nvecs"/>
                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="If">
                      <children xsi:type="mathematica:ASTNode" name="SameQ">
                        <children xsi:type="mathematica:ASTNode" name="pointedConeQ">
                          <children xsi:type="mathematica:ASTNode" name="Transpose">
                            <children xsi:type="mathematica:ASTNode" name="Append">
                              <children xsi:type="mathematica:ASTNode" name="Cases">
                                <children xsi:type="mathematica:SymbolLeaf" name="rvecs"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                      <children xsi:type="mathematica:SymbolLeaf" name="c"/>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                    </children>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                      <children xsi:type="mathematica:SymbolLeaf" name="r"/>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:SymbolLeaf" name="r"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:SymbolLeaf" name="nvect"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="nvect"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="nvect"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                          <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="nvect"/>
                        </children>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="rvectors"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                    <children xsi:type="mathematica:ASTNode" name="Function">
                      <children xsi:type="mathematica:ASTNode" name="If">
                        <children xsi:type="mathematica:ASTNode" name="vecInBasisQ">
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:ASTNode" name="Slot">
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                            </children>
                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="domb"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="nalpha"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                              <children xsi:type="mathematica:SymbolLeaf" name="nalpha"/>
                              <children xsi:type="mathematica:ASTNode" name="Part">
                                <children xsi:type="mathematica:ASTNode" name="Slot">
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:SymbolLeaf" name="nalpha"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="nvect"/>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:ASTNode" name="Part">
                                <children xsi:type="mathematica:ASTNode" name="Slot">
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                <children xsi:type="mathematica:ASTNode" name="Part">
                                  <children xsi:type="mathematica:ASTNode" name="Slot">
                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  </children>
                                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                  <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="nvect"/>
                                </children>
                              </children>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:ASTNode" name="Slot">
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:SymbolLeaf" name="rvecs"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Return">
                  <children xsi:type="mathematica:ASTNode" name="Flatten">
                    <children xsi:type="mathematica:SymbolLeaf" name="rvectors"/>
                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                  </children>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="checkVecInLinSpaceOld">
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="rvecs"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                <children xsi:type="mathematica:ASTNode" name="depend">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="adep"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                </children>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:BuiltInNode" keyword="Module">
              <children xsi:type="mathematica:BuiltInNode" keyword="List">
                <children xsi:type="mathematica:SymbolLeaf" name="domb"/>
                <children xsi:type="mathematica:SymbolLeaf" name="len1"/>
                <children xsi:type="mathematica:SymbolLeaf" name="len2"/>
                <children xsi:type="mathematica:SymbolLeaf" name="routesinlin"/>
                <children xsi:type="mathematica:SymbolLeaf" name="routesoutlin"/>
                <children xsi:type="mathematica:SymbolLeaf" name="nvecs"/>
              </children>
              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:ASTNode" name="decomposeRoutes">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="rin"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="rout"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Block">
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:SymbolLeaf" name="routvec"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="alpha"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="newrins"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="routvec"/>
                        <children xsi:type="mathematica:ASTNode" name="Part">
                          <children xsi:type="mathematica:SymbolLeaf" name="rout"/>
                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="alpha"/>
                        <children xsi:type="mathematica:ASTNode" name="Part">
                          <children xsi:type="mathematica:SymbolLeaf" name="routvec"/>
                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="newrins"/>
                        <children xsi:type="mathematica:ASTNode" name="Cases">
                          <children xsi:type="mathematica:SymbolLeaf" name="rin"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="c"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="r"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:SymbolLeaf" name="c"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                <children xsi:type="mathematica:SymbolLeaf" name="r"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                  <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                    <children xsi:type="mathematica:SymbolLeaf" name="routvec"/>
                                    <children xsi:type="mathematica:IntLeaf" value="2"/>
                                  </children>
                                </children>
                              </children>
                            </children>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="alpha"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                          <children xsi:type="mathematica:SymbolLeaf" name="alpha"/>
                          <children xsi:type="mathematica:ASTNode" name="Apply">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Plus"/>
                            <children xsi:type="mathematica:ASTNode" name="Cases">
                              <children xsi:type="mathematica:SymbolLeaf" name="rin"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                    <children xsi:type="mathematica:SymbolLeaf" name="c"/>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                    <children xsi:type="mathematica:SymbolLeaf" name="r"/>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="c"/>
                              </children>
                            </children>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Return">
                        <children xsi:type="mathematica:ASTNode" name="Join">
                          <children xsi:type="mathematica:ASTNode" name="Append">
                            <children xsi:type="mathematica:SymbolLeaf" name="newrins"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:SymbolLeaf" name="alpha"/>
                              <children xsi:type="mathematica:ASTNode" name="Part">
                                <children xsi:type="mathematica:SymbolLeaf" name="routvec"/>
                                <children xsi:type="mathematica:IntLeaf" value="2"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="Rest">
                            <children xsi:type="mathematica:SymbolLeaf" name="rout"/>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="domb"/>
                  <children xsi:type="mathematica:ASTNode" name="domainBasis">
                    <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="routesinlin"/>
                  <children xsi:type="mathematica:ASTNode" name="Select">
                    <children xsi:type="mathematica:SymbolLeaf" name="rvecs"/>
                    <children xsi:type="mathematica:ASTNode" name="Function">
                      <children xsi:type="mathematica:ASTNode" name="vecInBasisQ">
                        <children xsi:type="mathematica:ASTNode" name="Part">
                          <children xsi:type="mathematica:ASTNode" name="Slot">
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="domb"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="routesoutlin"/>
                  <children xsi:type="mathematica:ASTNode" name="Select">
                    <children xsi:type="mathematica:SymbolLeaf" name="rvecs"/>
                    <children xsi:type="mathematica:ASTNode" name="Function">
                      <children xsi:type="mathematica:ASTNode" name="Not">
                        <children xsi:type="mathematica:ASTNode" name="vecInBasisQ">
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:ASTNode" name="Slot">
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                            </children>
                            <children xsi:type="mathematica:IntLeaf" value="2"/>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="domb"/>
                        </children>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="len1"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                    <children xsi:type="mathematica:SymbolLeaf" name="routesinlin"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                  <children xsi:type="mathematica:SymbolLeaf" name="len2"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                    <children xsi:type="mathematica:SymbolLeaf" name="routesoutlin"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Which">
                  <children xsi:type="mathematica:ASTNode" name="Equal">
                    <children xsi:type="mathematica:SymbolLeaf" name="len1"/>
                    <children xsi:type="mathematica:IntLeaf"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Return">
                    <children xsi:type="mathematica:SymbolLeaf" name="rvecs"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Greater">
                    <children xsi:type="mathematica:SymbolLeaf" name="len1"/>
                    <children xsi:type="mathematica:IntLeaf"/>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="nvecs"/>
                      <children xsi:type="mathematica:ASTNode" name="NullSpace">
                        <children xsi:type="mathematica:ASTNode" name="getBasis">
                          <children xsi:type="mathematica:ASTNode" name="domainBasis">
                            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                          </children>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="If">
                      <children xsi:type="mathematica:ASTNode" name="Unequal">
                        <children xsi:type="mathematica:SymbolLeaf" name="nvecs"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Return">
                        <children xsi:type="mathematica:ASTNode" name="decomposeRoutes">
                          <children xsi:type="mathematica:SymbolLeaf" name="routesinlin"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:IntLeaf"/>
                              <children xsi:type="mathematica:ASTNode" name="Part">
                                <children xsi:type="mathematica:SymbolLeaf" name="nvecs"/>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                              </children>
                            </children>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="extendSysIndex">
                        <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="routesinlin"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
              <children xsi:type="mathematica:SymbolLeaf" name="depVec"/>
            </children>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:ASTNode" name="depVec">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
            <children xsi:type="mathematica:ASTNode" name="depend">
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="depmat"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:BuiltInNode" keyword="Module">
            <children xsi:type="mathematica:BuiltInNode" keyword="List">
              <children xsi:type="mathematica:SymbolLeaf" name="adep"/>
              <children xsi:type="mathematica:SymbolLeaf" name="A"/>
              <children xsi:type="mathematica:SymbolLeaf" name="b"/>
              <children xsi:type="mathematica:SymbolLeaf" name="theta"/>
            </children>
            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="adep"/>
                <children xsi:type="mathematica:ASTNode" name="DomMatrixSimplify">
                  <children xsi:type="mathematica:SymbolLeaf" name="depmat"/>
                  <children xsi:type="mathematica:ASTNode" name="DomEqualities">
                    <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="A"/>
                <children xsi:type="mathematica:ASTNode" name="dropConst">
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="adep"/>
                    <children xsi:type="mathematica:IntLeaf" value="4"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                <children xsi:type="mathematica:SymbolLeaf" name="b"/>
                <children xsi:type="mathematica:ASTNode" name="getConst">
                  <children xsi:type="mathematica:ASTNode" name="Part">
                    <children xsi:type="mathematica:SymbolLeaf" name="adep"/>
                    <children xsi:type="mathematica:IntLeaf" value="4"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="Return">
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                    <children xsi:type="mathematica:ASTNode" name="IdentityMatrix">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                        <children xsi:type="mathematica:SymbolLeaf" name="A"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="A"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="b"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
            <children xsi:type="mathematica:SymbolLeaf" name="getRouteVecs"/>
          </children>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
        <children xsi:type="mathematica:ASTNode" name="getRouteVecs">
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
            <children xsi:type="mathematica:ASTNode" name="depend">
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
            <children xsi:type="mathematica:SymbolLeaf" name="options"/>
            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
              <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:ASTNode" name="Catch">
              <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:SymbolLeaf" name="vecs"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                    <children xsi:type="mathematica:SymbolLeaf" name="vecs"/>
                    <children xsi:type="mathematica:ASTNode" name="routeVecs">
                      <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:ASTNode" name="Return">
                    <children xsi:type="mathematica:SymbolLeaf" name="vecs"/>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                </children>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
              <children xsi:type="mathematica:SymbolLeaf" name="usePipeIO"/>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
          <children xsi:type="mathematica:ASTNode" name="usePipeIO">
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
              <children xsi:type="mathematica:ASTNode" name="depend">
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="depmat"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
              <children xsi:type="mathematica:SymbolLeaf" name="options"/>
              <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:ASTNode" name="Catch">
                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:SymbolLeaf" name="rvecs"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="coeff"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="amats"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="newroutes"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                      <children xsi:type="mathematica:ASTNode" name="If">
                        <children xsi:type="mathematica:ASTNode" name="SameQ">
                          <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="Return">
                          <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="amats"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                          <children xsi:type="mathematica:ASTNode" name="Function">
                            <children xsi:type="mathematica:ASTNode" name="routeMat">
                              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                              <children xsi:type="mathematica:ASTNode" name="Slot">
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="newroutes"/>
                        <children xsi:type="mathematica:ASTNode" name="MapThread">
                          <children xsi:type="mathematica:ASTNode" name="Function">
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:ASTNode" name="Slot">
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="Part">
                                <children xsi:type="mathematica:ASTNode" name="Slot">
                                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                                </children>
                                <children xsi:type="mathematica:IntLeaf" value="2"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                            <children xsi:type="mathematica:SymbolLeaf" name="amats"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="Return">
                        <children xsi:type="mathematica:ASTNode" name="useAlphaPipeIO">
                          <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="newroutes"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                <children xsi:type="mathematica:SymbolLeaf" name="useAlphaPipeIO"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
            <children xsi:type="mathematica:ASTNode" name="useAlphaPipeIO">
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:ASTNode" name="BlankSequence">
                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                    <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                  <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:ASTNode" name="Catch">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                            <children xsi:type="mathematica:ASTNode" name="useAlphaPipeIO"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="options"/>
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
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                        </children>
                      </children>
                    </children>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:ASTNode" name="useAlphaPipeIO">
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                    <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                  <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                    <children xsi:type="mathematica:ASTNode" name="BlankSequence">
                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                      <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                    <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:ASTNode" name="Catch">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="curDepend"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="transfoDone"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="curRoute"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="curRouteUpdated"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="curVarList"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="newVarList"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="newVar"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="curTransMat"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="optVerb"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="optDbug"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="optRouteOnce"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="lenRoute"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="optVerb"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                              <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                  <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="Options">
                                <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="optDbug"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                              <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                <children xsi:type="mathematica:SymbolLeaf" name="debug"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                  <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="Options">
                                <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="optRouteOnce"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                              <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                <children xsi:type="mathematica:SymbolLeaf" name="routeOnce"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                  <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="Options">
                                <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="curDepend"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="transfoDone"/>
                            <children xsi:type="mathematica:ASTNode" name="idMatrix">
                              <children xsi:type="mathematica:ASTNode" name="Part">
                                <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                <children xsi:type="mathematica:IntLeaf" value="3"/>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="Part">
                                <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                <children xsi:type="mathematica:IntLeaf" value="3"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="If">
                            <children xsi:type="mathematica:SymbolLeaf" name="optVerb"/>
                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                              <children xsi:type="mathematica:ASTNode" name="show">
                                <children xsi:type="mathematica:SymbolLeaf" name="transfoDone"/>
                              </children>
                              <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="If">
                            <children xsi:type="mathematica:SymbolLeaf" name="optRouteOnce"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="lenRoute"/>
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="lenRoute"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="Do">
                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="curRoute"/>
                                <children xsi:type="mathematica:ASTNode" name="Part">
                                  <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="curRouteUpdated"/>
                                <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                                  <children xsi:type="mathematica:SymbolLeaf" name="curRoute"/>
                                  <children xsi:type="mathematica:ASTNode" name="composeAffines">
                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                      <children xsi:type="mathematica:SymbolLeaf" name="curRoute"/>
                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                    </children>
                                    <children xsi:type="mathematica:SymbolLeaf" name="transfoDone"/>
                                  </children>
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="curVarList"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                  <children xsi:type="mathematica:SymbolLeaf" name="First"/>
                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                    <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                    <children xsi:type="mathematica:IntLeaf" value="5"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                <children xsi:type="mathematica:ASTNode" name="normalize">
                                  <children xsi:type="mathematica:ASTNode" name="usePipeIOOnce">
                                    <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="curRouteUpdated"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="curDepend"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="newVarList"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                  <children xsi:type="mathematica:SymbolLeaf" name="First"/>
                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                    <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                    <children xsi:type="mathematica:IntLeaf" value="5"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="newVar"/>
                                <children xsi:type="mathematica:ASTNode" name="Complement">
                                  <children xsi:type="mathematica:SymbolLeaf" name="newVarList"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="curVarList"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="If">
                                <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                    <children xsi:type="mathematica:SymbolLeaf" name="newVar"/>
                                  </children>
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="Print">
                                  <children xsi:type="mathematica:StringLeaf" value="Warning,no var added"/>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                  <children xsi:type="mathematica:SymbolLeaf" name="curDepend"/>
                                  <children xsi:type="mathematica:ASTNode" name="First">
                                    <children xsi:type="mathematica:ASTNode" name="Select">
                                      <children xsi:type="mathematica:ASTNode" name="getDependences">
                                        <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="Function">
                                        <children xsi:type="mathematica:ASTNode" name="SameQ">
                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                            <children xsi:type="mathematica:ASTNode" name="Slot">
                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                            </children>
                                            <children xsi:type="mathematica:IntLeaf" value="3"/>
                                          </children>
                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                            <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                                            <children xsi:type="mathematica:IntLeaf" value="3"/>
                                          </children>
                                        </children>
                                      </children>
                                    </children>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="curTransMat"/>
                                <children xsi:type="mathematica:ASTNode" name="buildTranslMatFromVec">
                                  <children xsi:type="mathematica:SymbolLeaf" name="curRoute"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="transfoDone"/>
                                <children xsi:type="mathematica:ASTNode" name="composeAffines">
                                  <children xsi:type="mathematica:SymbolLeaf" name="transfoDone"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="curTransMat"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="If">
                                <children xsi:type="mathematica:SymbolLeaf" name="optVerb"/>
                                <children xsi:type="mathematica:ASTNode" name="Print">
                                  <children xsi:type="mathematica:StringLeaf" value="var added: "/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="newVar"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="lenRoute"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="curSys"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="usePipeIO">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                        <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                          <children xsi:type="mathematica:SymbolLeaf" name="usePipeIO"/>
                          <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
                        </children>
                        <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                        <children xsi:type="mathematica:SymbolLeaf" name="usePipeIOOnce"/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="usePipeIOOnce">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                          <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                            <children xsi:type="mathematica:SymbolLeaf" name="system"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                          <children xsi:type="mathematica:SymbolLeaf" name="routeOne"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                              <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                            <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
                            </children>
                          </children>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                            <children xsi:type="mathematica:ASTNode" name="Catch">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                  <children xsi:type="mathematica:SymbolLeaf" name="expr1"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="positionExpr1"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="contextDomList"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="contextDomExpr1"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="domExpr1"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="domSource"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="mat0mat"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="mat1mat"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="mat1"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="domGoal"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="equDomGoal"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="newEquDomGoal"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="domBound"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="newName"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="pipeVect"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="pipeVecAffine"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="pipeVecMat"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="optVerb"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="optDbug"/>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="optVerb"/>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                        <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                          <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="Options">
                                        <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                                      </children>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="optDbug"/>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                        <children xsi:type="mathematica:SymbolLeaf" name="debug"/>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                          <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="Options">
                                        <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                                      </children>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="newName"/>
                                    <children xsi:type="mathematica:ASTNode" name="getNewName">
                                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                      <children xsi:type="mathematica:ASTNode" name="ToString">
                                        <children xsi:type="mathematica:ASTNode" name="Unique">
                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                            <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                                            <children xsi:type="mathematica:IntLeaf" value="3"/>
                                          </children>
                                        </children>
                                      </children>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="expr1"/>
                                    <children xsi:type="mathematica:ASTNode" name="affine">
                                      <children xsi:type="mathematica:ASTNode" name="var">
                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                          <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                                          <children xsi:type="mathematica:IntLeaf" value="3"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                        <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                                        <children xsi:type="mathematica:IntLeaf" value="4"/>
                                      </children>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="positionExpr1"/>
                                    <children xsi:type="mathematica:ASTNode" name="Position">
                                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                      <children xsi:type="mathematica:SymbolLeaf" name="expr1"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="If">
                                    <children xsi:type="mathematica:ASTNode" name="Less">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                        <children xsi:type="mathematica:SymbolLeaf" name="positionExpr1"/>
                                      </children>
                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                    </children>
                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                          <children xsi:type="mathematica:SymbolLeaf" name="usePipeIOOnce"/>
                                          <children xsi:type="mathematica:StringLeaf" value="exprNotFound"/>
                                        </children>
                                        <children xsi:type="mathematica:SymbolLeaf" name="expr1"/>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="Throw">
                                        <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                      </children>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="contextDomList"/>
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                      <children xsi:type="mathematica:ASTNode" name="Function">
                                        <children xsi:type="mathematica:ASTNode" name="getContextDomain">
                                          <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                          <children xsi:type="mathematica:ASTNode" name="Slot">
                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                          </children>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:SymbolLeaf" name="positionExpr1"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="contextDomExpr1"/>
                                    <children xsi:type="mathematica:ASTNode" name="Fold">
                                      <children xsi:type="mathematica:SymbolLeaf" name="DomUnion"/>
                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                        <children xsi:type="mathematica:SymbolLeaf" name="contextDomList"/>
                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="Drop">
                                        <children xsi:type="mathematica:SymbolLeaf" name="contextDomList"/>
                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                      </children>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="domExpr1"/>
                                    <children xsi:type="mathematica:ASTNode" name="expDomain">
                                      <children xsi:type="mathematica:SymbolLeaf" name="expr1"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="mat1"/>
                                    <children xsi:type="mathematica:ASTNode" name="buildTranslMatFromVec">
                                      <children xsi:type="mathematica:SymbolLeaf" name="routeOne"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="If">
                                    <children xsi:type="mathematica:SymbolLeaf" name="optVerb"/>
                                    <children xsi:type="mathematica:ASTNode" name="Print">
                                      <children xsi:type="mathematica:StringLeaf" value="Routing "/>
                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                        <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                                        <children xsi:type="mathematica:IntLeaf" value="3"/>
                                      </children>
                                      <children xsi:type="mathematica:StringLeaf" value=" with new Var&#xA;      "/>
                                      <children xsi:type="mathematica:SymbolLeaf" name="newName"/>
                                      <children xsi:type="mathematica:StringLeaf" value="  along direction: "/>
                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                        <children xsi:type="mathematica:SymbolLeaf" name="routeOne"/>
                                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                                      </children>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="domSource"/>
                                    <children xsi:type="mathematica:ASTNode" name="DomIntersection">
                                      <children xsi:type="mathematica:SymbolLeaf" name="contextDomExpr1"/>
                                      <children xsi:type="mathematica:SymbolLeaf" name="domExpr1"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="domGoal"/>
                                    <children xsi:type="mathematica:ASTNode" name="DomImage">
                                      <children xsi:type="mathematica:SymbolLeaf" name="domSource"/>
                                      <children xsi:type="mathematica:SymbolLeaf" name="mat1"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="equDomGoal"/>
                                    <children xsi:type="mathematica:ASTNode" name="DomEqualities">
                                      <children xsi:type="mathematica:SymbolLeaf" name="domGoal"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="If">
                                    <children xsi:type="mathematica:ASTNode" name="Less">
                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                        <children xsi:type="mathematica:SymbolLeaf" name="equDomGoal"/>
                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                      </children>
                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                    </children>
                                    <children xsi:type="mathematica:ASTNode" name="Throw">
                                      <children xsi:type="mathematica:StringLeaf" value="ERROR"/>
                                    </children>
                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                        <children xsi:type="mathematica:SymbolLeaf" name="theEquality"/>
                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                          <children xsi:type="mathematica:SymbolLeaf" name="equDomGoal"/>
                                          <children xsi:type="mathematica:IntLeaf" value="4"/>
                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="If">
                                        <children xsi:type="mathematica:ASTNode" name="Less">
                                          <children xsi:type="mathematica:ASTNode" name="Dot">
                                            <children xsi:type="mathematica:ASTNode" name="Drop">
                                              <children xsi:type="mathematica:SymbolLeaf" name="theEquality"/>
                                              <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                            </children>
                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                              <children xsi:type="mathematica:SymbolLeaf" name="routeOne"/>
                                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                                            </children>
                                          </children>
                                          <children xsi:type="mathematica:IntLeaf"/>
                                        </children>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                          <children xsi:type="mathematica:SymbolLeaf" name="theEquality"/>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                            <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                            <children xsi:type="mathematica:SymbolLeaf" name="theEquality"/>
                                          </children>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                        <children xsi:type="mathematica:SymbolLeaf" name="newEquDomGoal"/>
                                        <children xsi:type="mathematica:ASTNode" name="matrix">
                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                            <children xsi:type="mathematica:ASTNode" name="Part">
                                              <children xsi:type="mathematica:SymbolLeaf" name="equDomGoal"/>
                                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                                            </children>
                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                          </children>
                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                            <children xsi:type="mathematica:SymbolLeaf" name="equDomGoal"/>
                                            <children xsi:type="mathematica:IntLeaf" value="3"/>
                                          </children>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                            <children xsi:type="mathematica:ASTNode" name="Prepend">
                                              <children xsi:type="mathematica:SymbolLeaf" name="theEquality"/>
                                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                                            </children>
                                          </children>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="domBound"/>
                                    <children xsi:type="mathematica:ASTNode" name="DomConstraints">
                                      <children xsi:type="mathematica:SymbolLeaf" name="newEquDomGoal"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="If">
                                    <children xsi:type="mathematica:SymbolLeaf" name="optDbug"/>
                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                      <children xsi:type="mathematica:ASTNode" name="Print">
                                        <children xsi:type="mathematica:StringLeaf" value="Bounding hyperplane: "/>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="show">
                                        <children xsi:type="mathematica:SymbolLeaf" name="domBound"/>
                                      </children>
                                      <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="pipeVecMat"/>
                                    <children xsi:type="mathematica:ASTNode" name="idMatrix">
                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                        <children xsi:type="mathematica:SymbolLeaf" name="equDomGoal"/>
                                        <children xsi:type="mathematica:IntLeaf" value="3"/>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                        <children xsi:type="mathematica:SymbolLeaf" name="equDomGoal"/>
                                        <children xsi:type="mathematica:IntLeaf" value="3"/>
                                      </children>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="pipeVect"/>
                                    <children xsi:type="mathematica:ASTNode" name="Append">
                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                        <children xsi:type="mathematica:SymbolLeaf" name="routeOne"/>
                                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                                      </children>
                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="If">
                                    <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                        <children xsi:type="mathematica:SymbolLeaf" name="pipeVect"/>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                        <children xsi:type="mathematica:SymbolLeaf" name="pipeVecMat"/>
                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                          <children xsi:type="mathematica:SymbolLeaf" name="usePipeIOOnce"/>
                                          <children xsi:type="mathematica:StringLeaf" value="pipeVectNotCorrect"/>
                                        </children>
                                        <children xsi:type="mathematica:SymbolLeaf" name="pipeVect"/>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="Throw">
                                        <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                      </children>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="pipeVecAffine"/>
                                    <children xsi:type="mathematica:ASTNode" name="MapThread">
                                      <children xsi:type="mathematica:SymbolLeaf" name="Append"/>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                          <children xsi:type="mathematica:ASTNode" name="Function">
                                            <children xsi:type="mathematica:ASTNode" name="Drop">
                                              <children xsi:type="mathematica:ASTNode" name="Slot">
                                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                                              </children>
                                              <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                            </children>
                                          </children>
                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                            <children xsi:type="mathematica:SymbolLeaf" name="pipeVecMat"/>
                                            <children xsi:type="mathematica:IntLeaf" value="4"/>
                                          </children>
                                        </children>
                                        <children xsi:type="mathematica:SymbolLeaf" name="pipeVect"/>
                                      </children>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="pipeVecMat"/>
                                    <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                                      <children xsi:type="mathematica:SymbolLeaf" name="pipeVecMat"/>
                                      <children xsi:type="mathematica:SymbolLeaf" name="pipeVecAffine"/>
                                      <children xsi:type="mathematica:IntLeaf" value="4"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                    <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                    <children xsi:type="mathematica:ASTNode" name="pipeIO">
                                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                        <children xsi:type="mathematica:SymbolLeaf" name="depend"/>
                                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                                      </children>
                                      <children xsi:type="mathematica:SymbolLeaf" name="expr1"/>
                                      <children xsi:type="mathematica:ASTNode" name="affine">
                                        <children xsi:type="mathematica:ASTNode" name="var">
                                          <children xsi:type="mathematica:SymbolLeaf" name="newName"/>
                                        </children>
                                        <children xsi:type="mathematica:SymbolLeaf" name="pipeVecMat"/>
                                      </children>
                                      <children xsi:type="mathematica:SymbolLeaf" name="domBound"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:SymbolLeaf" name="res"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="usePipeIOOnce">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                                <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                  <children xsi:type="mathematica:SymbolLeaf" name="usePipeIOOnce"/>
                                  <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                <children xsi:type="mathematica:SymbolLeaf" name="buildTranslMatFromVec"/>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="buildTranslMatFromVec">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                  <children xsi:type="mathematica:SymbolLeaf" name="routeOne"/>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                      <children xsi:type="mathematica:SymbolLeaf" name="mat0mat"/>
                                      <children xsi:type="mathematica:SymbolLeaf" name="mat1mat"/>
                                      <children xsi:type="mathematica:SymbolLeaf" name="mat1"/>
                                    </children>
                                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                        <children xsi:type="mathematica:SymbolLeaf" name="mat0mat"/>
                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                          <children xsi:type="mathematica:SymbolLeaf" name="routeOne"/>
                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                          <children xsi:type="mathematica:IntLeaf" value="4"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                        <children xsi:type="mathematica:SymbolLeaf" name="mat1mat"/>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                          <children xsi:type="mathematica:ASTNode" name="IdentityMatrix">
                                            <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                              <children xsi:type="mathematica:SymbolLeaf" name="mat0mat"/>
                                            </children>
                                          </children>
                                          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                            <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                            <children xsi:type="mathematica:ASTNode" name="Append">
                                              <children xsi:type="mathematica:ASTNode" name="Drop">
                                                <children xsi:type="mathematica:SymbolLeaf" name="mat0mat"/>
                                                <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                              </children>
                                              <children xsi:type="mathematica:ASTNode" name="Table">
                                                <children xsi:type="mathematica:IntLeaf"/>
                                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                                  <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                                    <children xsi:type="mathematica:SymbolLeaf" name="mat0mat"/>
                                                  </children>
                                                </children>
                                              </children>
                                            </children>
                                          </children>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                        <children xsi:type="mathematica:SymbolLeaf" name="mat1"/>
                                        <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                                          <children xsi:type="mathematica:ASTNode" name="Part">
                                            <children xsi:type="mathematica:SymbolLeaf" name="routeOne"/>
                                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                                          </children>
                                          <children xsi:type="mathematica:SymbolLeaf" name="mat1mat"/>
                                          <children xsi:type="mathematica:IntLeaf" value="4"/>
                                        </children>
                                      </children>
                                      <children xsi:type="mathematica:SymbolLeaf" name="mat1"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="buildTranslMatFromVec">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                      <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                                      <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                                    </children>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Message">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
                                      <children xsi:type="mathematica:SymbolLeaf" name="buildTranslMatFromVec"/>
                                      <children xsi:type="mathematica:StringLeaf" value="WrongArg"/>
                                    </children>
                                    <children xsi:type="mathematica:SymbolLeaf" name="a"/>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                                    <children xsi:type="mathematica:SymbolLeaf" name="affTransMat"/>
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
                    <children xsi:type="mathematica:ASTNode" name="affTransMat">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                        <children xsi:type="mathematica:ASTNode" name="domain">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="alphas"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="phi"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:ASTNode" name="Repeated">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                  <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                </children>
                              </children>
                            </children>
                          </children>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:SymbolLeaf" name="tmat"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="tcon"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="amat"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                            <children xsi:type="mathematica:ASTNode" name="getCoeffs">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="lindi"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                              <children xsi:type="mathematica:ASTNode" name="Function">
                                <children xsi:type="mathematica:ASTNode" name="Coefficient">
                                  <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                                  <children xsi:type="mathematica:ASTNode" name="Slot">
                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:SymbolLeaf" name="lindi"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                            <children xsi:type="mathematica:ASTNode" name="getConsts">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="lindi"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                              <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                <children xsi:type="mathematica:ASTNode" name="Function">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                    <children xsi:type="mathematica:ASTNode" name="Slot">
                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                    </children>
                                    <children xsi:type="mathematica:IntLeaf"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="lindi"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="tmat"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                              <children xsi:type="mathematica:ASTNode" name="Function">
                                <children xsi:type="mathematica:ASTNode" name="getCoeffs">
                                  <children xsi:type="mathematica:ASTNode" name="Slot">
                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  </children>
                                  <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                <children xsi:type="mathematica:SymbolLeaf" name="alphas"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="phi"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="tcon"/>
                            <children xsi:type="mathematica:ASTNode" name="getConsts">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                <children xsi:type="mathematica:SymbolLeaf" name="alphas"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="phi"/>
                              </children>
                              <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="amat"/>
                            <children xsi:type="mathematica:ASTNode" name="mmaToAlphaMatrix">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                <children xsi:type="mathematica:ASTNode" name="IdentityMatrix">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                    <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                  <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="tmat"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="tcon"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="Return">
                            <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                              <children xsi:type="mathematica:SymbolLeaf" name="amat"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                              <children xsi:type="mathematica:IntLeaf" value="3"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                        <children xsi:type="mathematica:SymbolLeaf" name="routeMat"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                    <children xsi:type="mathematica:ASTNode" name="routeMat">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                        <children xsi:type="mathematica:ASTNode" name="domain">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="alphas"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="phi"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:ASTNode" name="Repeated">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank">
                                  <children xsi:type="mathematica:SymbolLeaf" name="Integer"/>
                                </children>
                              </children>
                            </children>
                          </children>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                        <children xsi:type="mathematica:BuiltInNode" keyword="List">
                          <children xsi:type="mathematica:SymbolLeaf" name="tmat"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="tcon"/>
                          <children xsi:type="mathematica:SymbolLeaf" name="amat"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                            <children xsi:type="mathematica:ASTNode" name="getCoeffs">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="lindi"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                              <children xsi:type="mathematica:ASTNode" name="Function">
                                <children xsi:type="mathematica:ASTNode" name="Coefficient">
                                  <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                                  <children xsi:type="mathematica:ASTNode" name="Slot">
                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:SymbolLeaf" name="lindi"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                            <children xsi:type="mathematica:ASTNode" name="getConsts">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="lindi"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                              <children xsi:type="mathematica:SymbolLeaf" name="x"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                                <children xsi:type="mathematica:ASTNode" name="Function">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                                    <children xsi:type="mathematica:ASTNode" name="Slot">
                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                    </children>
                                    <children xsi:type="mathematica:IntLeaf"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="lindi"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="tmat"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                              <children xsi:type="mathematica:ASTNode" name="Function">
                                <children xsi:type="mathematica:ASTNode" name="getCoeffs">
                                  <children xsi:type="mathematica:ASTNode" name="Slot">
                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  </children>
                                  <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                <children xsi:type="mathematica:SymbolLeaf" name="alphas"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="phi"/>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="tcon"/>
                            <children xsi:type="mathematica:ASTNode" name="getConsts">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                <children xsi:type="mathematica:SymbolLeaf" name="alphas"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="phi"/>
                              </children>
                              <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="amat"/>
                            <children xsi:type="mathematica:ASTNode" name="mmaToAlphaMatrix">
                              <children xsi:type="mathematica:SymbolLeaf" name="tmat"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="tcon"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="Return">
                            <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                              <children xsi:type="mathematica:SymbolLeaf" name="amat"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                              <children xsi:type="mathematica:IntLeaf" value="3"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                        <children xsi:type="mathematica:SymbolLeaf" name="genRouteSubsystem"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                    <children xsi:type="mathematica:ASTNode" name="genRouteSubsystem">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                        <children xsi:type="mathematica:ASTNode" name="depend">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="genRouteSubsystem"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:ASTNode" name="genRouteSubsystem">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                      <children xsi:type="mathematica:ASTNode" name="depend">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                          <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                          <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                          <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                          <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                        <children xsi:type="mathematica:SymbolLeaf" name="alpha"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="phi"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="d1"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="d2"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="amat"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="rvar"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="lastrow"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="newdep"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="If">
                        <children xsi:type="mathematica:ASTNode" name="SameQ">
                          <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="Return">
                          <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="alpha"/>
                            <children xsi:type="mathematica:ASTNode" name="Part">
                              <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="phi"/>
                            <children xsi:type="mathematica:ASTNode" name="Part">
                              <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                            <children xsi:type="mathematica:ASTNode" name="Part">
                              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                              <children xsi:type="mathematica:IntLeaf" value="2"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="amat"/>
                            <children xsi:type="mathematica:ASTNode" name="TransMat">
                              <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="route"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="d2"/>
                            <children xsi:type="mathematica:ASTNode" name="DomImage">
                              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="amat"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="d1"/>
                            <children xsi:type="mathematica:ASTNode" name="DomDifference">
                              <children xsi:type="mathematica:ASTNode" name="DomConvex">
                                <children xsi:type="mathematica:ASTNode" name="DomUnion">
                                  <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="d2"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:SymbolLeaf" name="d2"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="rvar"/>
                            <children xsi:type="mathematica:ASTNode" name="getNewName">
                              <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                              <children xsi:type="mathematica:ASTNode" name="ToString">
                                <children xsi:type="mathematica:ASTNode" name="Unique">
                                  <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                                </children>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="lastrow"/>
                            <children xsi:type="mathematica:ASTNode" name="Append">
                              <children xsi:type="mathematica:ASTNode" name="Table">
                                <children xsi:type="mathematica:IntLeaf"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                    <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:IntLeaf" value="1"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="newdep"/>
                            <children xsi:type="mathematica:ASTNode" name="Append">
                              <children xsi:type="mathematica:ASTNode" name="Transpose">
                                <children xsi:type="mathematica:ASTNode" name="Append">
                                  <children xsi:type="mathematica:ASTNode" name="IdentityMatrix">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                      <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                                    </children>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                                    <children xsi:type="mathematica:IntLeaf" signed="-" value="1"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="phi"/>
                                  </children>
                                </children>
                              </children>
                              <children xsi:type="mathematica:SymbolLeaf" name="lastrow"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="newdep"/>
                            <children xsi:type="mathematica:ASTNode" name="matrix">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                  <children xsi:type="mathematica:SymbolLeaf" name="phi"/>
                                </children>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Plus">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Length">
                                  <children xsi:type="mathematica:SymbolLeaf" name="phi"/>
                                </children>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                              </children>
                              <children xsi:type="mathematica:SymbolLeaf" name="indi"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="newdep"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                            <children xsi:type="mathematica:ASTNode" name="equation">
                              <children xsi:type="mathematica:SymbolLeaf" name="rvar"/>
                              <children xsi:type="mathematica:ASTNode" name="restrict">
                                <children xsi:type="mathematica:SymbolLeaf" name="d1"/>
                                <children xsi:type="mathematica:ASTNode" name="affine">
                                  <children xsi:type="mathematica:ASTNode" name="var">
                                    <children xsi:type="mathematica:SymbolLeaf" name="rvar"/>
                                  </children>
                                  <children xsi:type="mathematica:SymbolLeaf" name="newdep"/>
                                </children>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="newdep"/>
                            <children xsi:type="mathematica:ASTNode" name="inverseInContext">
                              <children xsi:type="mathematica:SymbolLeaf" name="amat"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                            <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                            <children xsi:type="mathematica:ASTNode" name="equation">
                              <children xsi:type="mathematica:SymbolLeaf" name="rvar"/>
                              <children xsi:type="mathematica:ASTNode" name="restrict">
                                <children xsi:type="mathematica:SymbolLeaf" name="d2"/>
                                <children xsi:type="mathematica:ASTNode" name="affine">
                                  <children xsi:type="mathematica:ASTNode" name="var">
                                    <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="composeAffines">
                                    <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="newdep"/>
                                  </children>
                                </children>
                              </children>
                            </children>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="Return">
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                            </children>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                      <children xsi:type="mathematica:SymbolLeaf" name="routeVar"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:ASTNode" name="routeVar">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                      <children xsi:type="mathematica:ASTNode" name="depend">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                          <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                          <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                          <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                          <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                        </children>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="rvects"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                      <children xsi:type="mathematica:BuiltInNode" keyword="List">
                        <children xsi:type="mathematica:SymbolLeaf" name="dumdep"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="rpos"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="rsys"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="curroute"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="subsys"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="eqndom"/>
                        <children xsi:type="mathematica:SymbolLeaf" name="adep"/>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                          <children xsi:type="mathematica:SymbolLeaf" name="curroute"/>
                          <children xsi:type="mathematica:ASTNode" name="First">
                            <children xsi:type="mathematica:SymbolLeaf" name="rvects"/>
                          </children>
                        </children>
                        <children xsi:type="mathematica:ASTNode" name="If">
                          <children xsi:type="mathematica:ASTNode" name="SameQ">
                            <children xsi:type="mathematica:SymbolLeaf" name="curroute"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="Return">
                            <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="subsys"/>
                              <children xsi:type="mathematica:ASTNode" name="genRouteSubsystem">
                                <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="curroute"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                              <children xsi:type="mathematica:ASTNode" name="Part">
                                <children xsi:type="mathematica:SymbolLeaf" name="subsys"/>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                              <children xsi:type="mathematica:ASTNode" name="Part">
                                <children xsi:type="mathematica:SymbolLeaf" name="subsys"/>
                                <children xsi:type="mathematica:IntLeaf" value="2"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="eqndom"/>
                              <children xsi:type="mathematica:ASTNode" name="DomConvex">
                                <children xsi:type="mathematica:ASTNode" name="DomUnion">
                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                    <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                                    <children xsi:type="mathematica:IntLeaf" value="2"/>
                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                    <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                                    <children xsi:type="mathematica:IntLeaf" value="2"/>
                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  </children>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="rpos"/>
                              <children xsi:type="mathematica:ASTNode" name="getOccursInDef">
                                <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                                <children xsi:type="mathematica:ASTNode" name="affine">
                                  <children xsi:type="mathematica:ASTNode" name="var">
                                    <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                </children>
                                <children xsi:type="mathematica:IntLeaf" value="1"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
                              <children xsi:type="mathematica:ASTNode" name="getPart">
                                <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="rpos"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
                              <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                                <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
                                <children xsi:type="mathematica:ASTNode" name="IdentityMatrix">
                                  <children xsi:type="mathematica:ASTNode" name="Part">
                                    <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
                                    <children xsi:type="mathematica:IntLeaf" value="2"/>
                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                                  <children xsi:type="mathematica:IntLeaf" value="4"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
                              <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                                <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
                                <children xsi:type="mathematica:ASTNode" name="Part">
                                  <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="rsys"/>
                              <children xsi:type="mathematica:ASTNode" name="equation">
                                <children xsi:type="mathematica:ASTNode" name="Part">
                                  <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="case">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                    <children xsi:type="mathematica:ASTNode" name="restrict">
                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                        <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="affine">
                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                          <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                        </children>
                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                          <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                                        </children>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:ASTNode" name="restrict">
                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                        <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                                        <children xsi:type="mathematica:IntLeaf" value="1"/>
                                      </children>
                                      <children xsi:type="mathematica:ASTNode" name="affine">
                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                          <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                                          <children xsi:type="mathematica:IntLeaf" value="1"/>
                                        </children>
                                        <children xsi:type="mathematica:ASTNode" name="Part">
                                          <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                                          <children xsi:type="mathematica:IntLeaf" value="2"/>
                                        </children>
                                      </children>
                                    </children>
                                  </children>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                              <children xsi:type="mathematica:ASTNode" name="Insert">
                                <children xsi:type="mathematica:ASTNode" name="Insert">
                                  <children xsi:type="mathematica:ASTNode" name="ReplacePart">
                                    <children xsi:type="mathematica:SymbolLeaf" name="sys"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="rexp"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="rpos"/>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="decl">
                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                      <children xsi:type="mathematica:SymbolLeaf" name="eqn1"/>
                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                    </children>
                                    <children xsi:type="mathematica:SymbolLeaf" name="integer"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="eqndom"/>
                                  </children>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                    <children xsi:type="mathematica:IntLeaf" value="5"/>
                                    <children xsi:type="mathematica:IntLeaf" value="1"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="rsys"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                  <children xsi:type="mathematica:IntLeaf" value="6"/>
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="dumdep"/>
                              <children xsi:type="mathematica:ASTNode" name="depend">
                                <children xsi:type="mathematica:ASTNode" name="Part">
                                  <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="Part">
                                  <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                                  <children xsi:type="mathematica:IntLeaf" value="1"/>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                                <children xsi:type="mathematica:ASTNode" name="Part">
                                  <children xsi:type="mathematica:SymbolLeaf" name="eqn2"/>
                                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                                  <children xsi:type="mathematica:IntLeaf" value="2"/>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Return">
                              <children xsi:type="mathematica:ASTNode" name="routeVar">
                                <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="dumdep"/>
                                <children xsi:type="mathematica:ASTNode" name="Rest">
                                  <children xsi:type="mathematica:SymbolLeaf" name="rvects"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                          </children>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                      <children xsi:type="mathematica:SymbolLeaf" name="routeDep"/>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:ASTNode" name="routeDep">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                      <children xsi:type="mathematica:ASTNode" name="depend">
                        <children xsi:type="mathematica:ASTNode" name="BlankNullSequence"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                      <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                      <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                        <children xsi:type="mathematica:ASTNode" name="Catch">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                            <children xsi:type="mathematica:BuiltInNode" keyword="List">
                              <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                              <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                <children xsi:type="mathematica:ASTNode" name="routeDep">
                                  <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                </children>
                              </children>
                              <children xsi:type="mathematica:ASTNode" name="If">
                                <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                                  <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                  <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                </children>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                          </children>
                          <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="routeDep">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                        <children xsi:type="mathematica:ASTNode" name="depend">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="dom"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                            <children xsi:type="mathematica:SymbolLeaf" name="dep"/>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                          </children>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                        <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                        <children xsi:type="mathematica:ASTNode" name="BlankNullSequence">
                          <children xsi:type="mathematica:BuiltInNode" keyword="Rule"/>
                        </children>
                      </children>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                      <children xsi:type="mathematica:ASTNode" name="Catch">
                        <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                          <children xsi:type="mathematica:BuiltInNode" keyword="List">
                            <children xsi:type="mathematica:SymbolLeaf" name="tmpsys"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="optVerb"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="optVerf"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="optInpAlign"/>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="optVerb"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                  <children xsi:type="mathematica:SymbolLeaf" name="verbose"/>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                    <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="Options">
                                  <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="optVerf"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                  <children xsi:type="mathematica:SymbolLeaf" name="verifyCone"/>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                    <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="Options">
                                  <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="optInpAlign"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                <children xsi:type="mathematica:BuiltInNode" keyword="ReplaceAll">
                                  <children xsi:type="mathematica:SymbolLeaf" name="alignInp"/>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                    <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="Options">
                                  <children xsi:type="mathematica:SymbolLeaf" name="uniformize"/>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="If">
                              <children xsi:type="mathematica:SymbolLeaf" name="optInpAlign"/>
                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                                  <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                  <children xsi:type="mathematica:ASTNode" name="checkRule2">
                                    <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                                    <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="If">
                                  <children xsi:type="mathematica:ASTNode" name="SameQ">
                                    <children xsi:type="mathematica:ASTNode" name="Part">
                                      <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                      <children xsi:type="mathematica:IntLeaf" value="1"/>
                                    </children>
                                    <children xsi:type="mathematica:SymbolLeaf" name="True"/>
                                  </children>
                                  <children xsi:type="mathematica:ASTNode" name="Return">
                                    <children xsi:type="mathematica:ASTNode" name="applyRule2">
                                      <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                                      <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                                      <children xsi:type="mathematica:ASTNode" name="Part">
                                        <children xsi:type="mathematica:SymbolLeaf" name="tmp"/>
                                        <children xsi:type="mathematica:IntLeaf" value="2"/>
                                      </children>
                                      <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                                    </children>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="If">
                              <children xsi:type="mathematica:SymbolLeaf" name="optVerb"/>
                              <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                                <children xsi:type="mathematica:ASTNode" name="Print">
                                  <children xsi:type="mathematica:StringLeaf" value="Routing dependence "/>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="show">
                                  <children xsi:type="mathematica:ASTNode" name="dtable">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                      <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                                    </children>
                                  </children>
                                </children>
                                <children xsi:type="mathematica:ASTNode" name="Print">
                                  <children xsi:type="mathematica:StringLeaf" value=" with vectors "/>
                                  <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                              <children xsi:type="mathematica:SymbolLeaf" name="tmpsys"/>
                              <children xsi:type="mathematica:ASTNode" name="usePipeIO">
                                <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
                                <children xsi:type="mathematica:SymbolLeaf" name="options"/>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="If">
                              <children xsi:type="mathematica:SymbolLeaf" name="optVerf"/>
                              <children xsi:type="mathematica:ASTNode" name="updateSysCone">
                                <children xsi:type="mathematica:SymbolLeaf" name="depast"/>
                                <children xsi:type="mathematica:ASTNode" name="Cases">
                                  <children xsi:type="mathematica:SymbolLeaf" name="routes"/>
                                  <children xsi:type="mathematica:BuiltInNode" keyword="RuleDelayed">
                                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                        <children xsi:type="mathematica:SymbolLeaf" name="c"/>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                      </children>
                                      <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                        <children xsi:type="mathematica:SymbolLeaf" name="r"/>
                                        <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                                      </children>
                                    </children>
                                    <children xsi:type="mathematica:SymbolLeaf" name="r"/>
                                  </children>
                                </children>
                              </children>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="Return">
                              <children xsi:type="mathematica:SymbolLeaf" name="tmpsys"/>
                            </children>
                            <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                        <children xsi:type="mathematica:SymbolLeaf" name="initUniformization"/>
                      </children>
                    </children>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                  <children xsi:type="mathematica:ASTNode" name="initUniformization"/>
                  <children xsi:type="mathematica:ASTNode" name="initUniformization"/>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                <children xsi:type="mathematica:ASTNode" name="initUniformization">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                    <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Times">
                  <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                    <children xsi:type="mathematica:BuiltInNode" keyword="List">
                      <children xsi:type="mathematica:SymbolLeaf" name="fulldeptab"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="deptab"/>
                      <children xsi:type="mathematica:SymbolLeaf" name="locals"/>
                    </children>
                    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="fulldeptab"/>
                        <children xsi:type="mathematica:ASTNode" name="dep">
                          <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                          <children xsi:type="mathematica:BuiltInNode" keyword="Rule">
                            <children xsi:type="mathematica:SymbolLeaf" name="equalitySimpl"/>
                            <children xsi:type="mathematica:SymbolLeaf" name="False"/>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="locals"/>
                        <children xsi:type="mathematica:ASTNode" name="getLocalVars">
                          <children xsi:type="mathematica:SymbolLeaf" name="asys"/>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="deptab"/>
                        <children xsi:type="mathematica:ASTNode" name="Cases">
                          <children xsi:type="mathematica:ASTNode" name="Part">
                            <children xsi:type="mathematica:SymbolLeaf" name="fulldeptab"/>
                            <children xsi:type="mathematica:IntLeaf" value="1"/>
                          </children>
                          <children xsi:type="mathematica:ASTNode" name="Condition">
                            <children xsi:type="mathematica:ASTNode" name="depend">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                              <children xsi:type="mathematica:ASTNode" name="Intersection">
                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                  <children xsi:type="mathematica:SymbolLeaf" name="lhs"/>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="locals"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                            </children>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                        <children xsi:type="mathematica:SymbolLeaf" name="deptab"/>
                        <children xsi:type="mathematica:ASTNode" name="Cases">
                          <children xsi:type="mathematica:SymbolLeaf" name="deptab"/>
                          <children xsi:type="mathematica:ASTNode" name="Condition">
                            <children xsi:type="mathematica:ASTNode" name="depend">
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                                <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                              <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
                            </children>
                            <children xsi:type="mathematica:ASTNode" name="UnsameQ">
                              <children xsi:type="mathematica:ASTNode" name="Intersection">
                                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                                  <children xsi:type="mathematica:SymbolLeaf" name="rhs"/>
                                </children>
                                <children xsi:type="mathematica:SymbolLeaf" name="locals"/>
                              </children>
                              <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                            </children>
                          </children>
                        </children>
                      </children>
                      <children xsi:type="mathematica:ASTNode" name="initSysCone">
                        <children xsi:type="mathematica:SymbolLeaf" name="deptab"/>
                      </children>
                    </children>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
                    <children xsi:type="mathematica:SymbolLeaf" name="initCones"/>
                  </children>
                </children>
              </children>
              <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
                <children xsi:type="mathematica:ASTNode" name="initCones"/>
                <children xsi:type="mathematica:ASTNode" name="Block">
                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
                      <children xsi:type="mathematica:SymbolLeaf" name="conelist"/>
                      <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                    </children>
                    <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                  </children>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="Return"/>
                <children xsi:type="mathematica:SymbolLeaf" name="Null"/>
              </children>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Clear">
            <children xsi:type="mathematica:SymbolLeaf" name="initSysCone"/>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="SetDelayed">
            <children xsi:type="mathematica:ASTNode" name="initSysCone">
              <children xsi:type="mathematica:BuiltInNode" keyword="Pattern">
                <children xsi:type="mathematica:SymbolLeaf" name="alldeps"/>
                <children xsi:type="mathematica:BuiltInNode" keyword="Blank"/>
              </children>
            </children>
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:BuiltInNode" keyword="Module">
                <children xsi:type="mathematica:BuiltInNode" keyword="List">
                  <children xsi:type="mathematica:SymbolLeaf" name="dcone"/>
                </children>
                <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
                  <children xsi:type="mathematica:ASTNode" name="initCones"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                  <children xsi:type="mathematica:BuiltInNode" keyword="Map">
                    <children xsi:type="mathematica:SymbolLeaf" name="depCone"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="alldeps"/>
                  </children>
                </children>
                <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
                <children xsi:type="mathematica:ASTNode" name="Part"/>
                <children xsi:type="mathematica:IntLeaf" value="1"/>
              </children>
            </children>
            <children xsi:type="mathematica:ASTNode" name="Do">
              <children xsi:type="mathematica:BuiltInNode" keyword="Set"/>
              <children xsi:type="mathematica:ASTNode" name="addRaysToCone">
                <children xsi:type="mathematica:BuiltInNode" keyword="Union">
                  <children xsi:type="mathematica:ASTNode" name="getVertices">
                    <children xsi:type="mathematica:ASTNode" name="Part"/>
                    <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                  </children>
                </children>
                <children xsi:type="mathematica:ASTNode" name="rays">
                  <children xsi:type="mathematica:ASTNode" name="Part"/>
                  <children xsi:type="mathematica:SymbolLeaf" name="i"/>
                </children>
              </children>
            </children>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="List">
          <children xsi:type="mathematica:SymbolLeaf" name="i"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="Length"/>
        </children>
      </children>
    </children>
    <children xsi:type="mathematica:ASTNode" name="If">
      <children xsi:type="mathematica:ASTNode" name="Equal">
        <children xsi:type="mathematica:ASTNode" name="hasLinesQ"/>
      </children>
      <children xsi:type="mathematica:SymbolLeaf" name="True"/>
    </children>
    <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
      <children xsi:type="mathematica:BuiltInNode" keyword="Message">
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="initCone"/>
          <children xsi:type="mathematica:StringLeaf" value="invalid"/>
        </children>
        <children xsi:type="mathematica:ASTNode" name="getLines"/>
      </children>
    </children>
    <children xsi:type="mathematica:BuiltInNode" keyword="List"/>
  </children>
  <children xsi:type="mathematica:ASTNode" name="rays"/>
</mathematica:BuiltInNode>
