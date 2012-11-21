#!/bin/sh

rm *.class 2>/dev/null
cp Macros.txt Macros.scala
cp Test.txt Test.scala
echo '==== Macros ===='
scalac Macros.scala
echo '==== Prog ===='
scalac Test.scala
echo '==== Exec ===='
scala TestMacros
rm *.class 2>/dev/null
rm *.scala 2>/dev/null
