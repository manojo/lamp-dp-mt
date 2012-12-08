#!/bin/sh

OUT=bin
mkdir -p $OUT
sc() { #$1=file
	md5 $1 > $OUT/$1.tmp
	if ! diff $OUT/$1.md5 $OUT/$1.tmp 1>/dev/null 2>/dev/null; then
		echo "====== $1 ======"
		scalac -cp $OUT -d $OUT $1 && md5 $1 > $OUT/$1.md5 || exit 1
	fi
}

# hack to avoid SBT compilation
ln -s Macros.txt Macros.scala 2>/dev/null
ln -s Test.txt Test.scala 2>/dev/null

sc Macros.scala
sc Test.scala

rm Macros.scala Test.scala 2>/dev/null

scala -cp bin TestMacros
