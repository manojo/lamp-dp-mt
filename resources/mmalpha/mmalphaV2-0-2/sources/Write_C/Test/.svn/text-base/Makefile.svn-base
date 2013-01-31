# to ignore all failures and see all of the results, type
# make -i
SHELL=/usr/bin/sh

all_tests : general_tests
	-@\rm -f xyz
	-@\rm -f *.o
	@echo "\n----------------------------------------------------"
	@echo "All tests successful"
	@echo "----------------------------------------------------"


#=====================================================================
general_tests : general_greeting t1 test1 test2 test3 test4 \
		cosparam pdscal pdgeru1 pdgeru2 matmul useramr \
		conv florent inline convert R4 R5
	@echo "general tests successful"

general_greeting :
	@echo "\n----------------------------------------------------"
	@echo "Begin general tests"
	@echo "----------------------------------------------------"

t1 :
#	read_alpha <t1.alpha >t1.ast
	write_c <t1.ast 1>xyz 2>&1
	diff -w  xyz t1.c
	gcc -c t1.c

test1 :
#	read_alpha <test1.alpha >test1.ast
	write_c <test1.ast 1>xyz 2>&1
	diff -w  xyz test1.c
#	gcc -c test1.c			# there is an intentional error

test2 :
#	read_alpha <test2.alpha >test2.ast
	write_c <test2.ast 1>xyz 2>&1
	diff -w  xyz test2.c
	gcc -c test2.c

test3 :
#	read_alpha <test3.alpha >test3.ast
	write_c <test3.ast 1>xyz 2>&1
	diff -w  xyz test3.c
	gcc -c test3.c

test4 :
#	read_alpha <test4.alpha >test4.ast
	write_c <test4.ast 1>xyz 2>&1
	diff -w  xyz test4.c
	gcc -c test4.c

test5 :
#	read_alpha <test5.alpha >test5.ast
	write_c -p 3 5 <test5.ast 1>xyz 2>&1
	diff -w  xyz test5.c
	gcc -c test5.c

cosparam :
#	read_alpha <cosparam.alpha >cosparam.ast
	write_c <cosparam.ast 1>xyz 2>&1
	diff -w  xyz cosparam.c
	gcc -c cosparam.c

pdscal :
#	read_alpha <pdscal.alpha >pdscal.ast
	write_c <pdscal.ast 1>xyz 2>&1
	-diff -w  xyz pdscal.c
	gcc -c pdscal.c

pdgeru1 :
#	read_alpha <pdgeru1.alpha >pdgeru1.ast
	write_c -p 16 4 4 2 2 <pdgeru1.ast 1>xyz 2>&1
	diff -w  xyz pdgeru1.c
#	gcc -c pdgeru1.c	# problem with min(1,2,3,4)

pdgeru2 :
#	read_alpha <pdgeru2.alpha >pdgeru2.ast
	write_c <pdgeru2.ast 1>xyz 2>&1
	-diff -w  xyz pdgeru2.c
#	gcc -c pdgeru2.c	# problem with min(1,2,3,4)

matmul :
#	read_alpha <matmul.alpha >matmul.ast
	write_c -p 4 <matmul.ast 1>xyz 2>&1
	diff -w  xyz matmul.c
	gcc -c matmul.c

useramr :
#	read_alpha <useramr.alpha >useramr.ast
	write_c <useramr.ast 1>xyz 2>&1
	diff -w  xyz useramr.c
	gcc -c useramr.c

conv :
#	read_alpha <conv.alpha >conv.ast
	write_c -p 4 <conv.ast 1>xyz 2>&1
	diff -w  xyz conv.c
#	gcc -c conv.c		# there is an infinite domain

florent :
#	read_alpha <florent.alpha >florent.ast
#	write_c <florent.ast 1>xyz 2>&1		# Cannot do more than 1 system
#	diff -w  xyz florent.c
#	gcc -c florent.c

inline :
#	read_alpha <inline.alpha >inline.ast
	write_c -p 5 <inline.ast 1>xyz 2>&1
	-diff -w  xyz inline.c
	gcc -c inline.c

convert :
#	read_alpha <convert.alpha >convert.ast
	write_c -p 12 <convert.ast >xyz
	diff -w  xyz convert.c
	gcc -c convert.c

R4 :
	read_alpha <R4.alpha >R4.ast
	write_c -p 8 <R4.ast >xyz
	diff -w  xyz R4.c
	gcc -c R4.c
R5 :
	read_alpha <R5.alpha >R5.ast
	write_c -p 4 <R5.ast >xyz
	diff -w  xyz R5.c
	gcc -c R5.c
