<?xml version="1.0" encoding="ASCII"?>
<mathematica:BuiltInNode xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mathematica="http://www.irisa.fr/cairn/model/xtext/Mathematica" keyword="Protect">
  <children xsi:type="mathematica:ASTNode" name="CompoundExpression">
    <children xsi:type="mathematica:BuiltInNode" keyword="Set">
      <children xsi:type="mathematica:BuiltInNode" keyword="Times">
        <children xsi:type="mathematica:BuiltInNode" keyword="BeginPackage">
          <children xsi:type="mathematica:StringLeaf" value="Alpha`Schedule`"/>
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
            <children xsi:type="mathematica:StringLeaf" value="Alpha`Static`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`SubSystems`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`ScheduleTools`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`VertexSchedule`"/>
            <children xsi:type="mathematica:StringLeaf" value="Alpha`FarkasSchedule`"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
          <children xsi:type="mathematica:SymbolLeaf" name="Schedule"/>
          <children xsi:type="mathematica:StringLeaf" value="usage"/>
        </children>
      </children>
      <children xsi:type="mathematica:BuiltInNode" keyword="Set">
        <children xsi:type="mathematica:BuiltInNode" keyword="Times">
          <children xsi:type="mathematica:StringLeaf" value="Package.  Schedule for  alpha program The only function used is :&#xA;schedule[]"/>
          <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
            <children xsi:type="mathematica:SymbolLeaf" name="structSched"/>
            <children xsi:type="mathematica:StringLeaf" value="usage"/>
          </children>
        </children>
        <children xsi:type="mathematica:BuiltInNode" keyword="Set">
          <children xsi:type="mathematica:BuiltInNode" keyword="Times">
            <children xsi:type="mathematica:StringLeaf" value="structSched[] try to find a structured&#xA;scheduling for $result, using $scheduleLibrary for schedule of&#xA;subsystems. The default mode is linear, i.e. no dimension is added for &#xA;subsystems. By setting the option structSchedType to multi, the&#xA;schedule of the subsystems will be in an additionnal&#xA;dimension. Warning, in that case, you MUST set the depth of the&#xA;schedule expected with the multSchedDepth options. Example:&#xA;structSched[structSchedType->multi,multiSchedDepth->2]&#xA;finds the schedule of $result and puts"/>
            <children xsi:type="mathematica:BuiltInNode" keyword="MessageName">
              <children xsi:type="mathematica:SymbolLeaf" name="schedule"/>
              <children xsi:type="mathematica:StringLeaf" value="usage"/>
            </children>
          </children>
          <children xsi:type="mathematica:BuiltInNode" keyword="Set">
            <children xsi:type="mathematica:BuiltInNode" keyword="Times">
              <children xsi:type="mathematica:SymbolLeaf" name="UnknownGlyph"/>
            </children>
          </children>
          <children xsi:type="mathematica:SymbolLeaf" name="options___Rule"/>
        </children>
      </children>
    </children>
  </children>
</mathematica:BuiltInNode>
