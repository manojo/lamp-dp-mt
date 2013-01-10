#!/bin/sh

cd "`dirname $0`"
gcc -Wall -O2 -Ilibs -I../vienna *.c ../vienna/energy_par.c libs/*.c '-DVERSION="VERSION"' -o RNAfold && \
echo guacgucaguacguacgugacugucagucaac | ./RNAfold
