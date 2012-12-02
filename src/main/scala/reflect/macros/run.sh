#!/bin/sh

rm *.class 2>/dev/null
ln -s Macros.txt Macros.scala
ln -s Test.txt Test.scala
echo '==== Macros ===='
scalac Macros.scala || exit 1
echo '==== Prog ===='
scalac Test.scala || exit 1
echo '==== Exec ===='
scala TestMacros
rm *.class 2>/dev/null
rm Macros.scala Test.scala 2>/dev/null

