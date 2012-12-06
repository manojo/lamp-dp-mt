#!/bin/sh

cd "`dirname $0`"
gcc -Wall -O2 -I../vienna *.c ../vienna/*.c '-DVERSION="VERSION"' -o RNAfold && \
echo guacgucaguacguacgugacugucagucaac | ./RNAfold
