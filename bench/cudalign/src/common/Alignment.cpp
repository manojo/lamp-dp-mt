/* 
 * File:   Alignment.cpp
 * Author: edans
 * 
 * Created on April 11, 2010, 6:51 PM
 */

#include <vector>

#include "Alignment.hpp"
#include "sw_configs.hpp"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

//#define USE_CAIRO

Alignment::Alignment(Job* _job) : job(_job) {
	alignmentFinalized = false;
}

Alignment::Alignment(const Alignment& orig) {
	alignmentFinalized = false;	
}

Alignment::~Alignment() {
}

void Alignment::addGapInSeq0(int i) {
    addGap(0, i);
}

void Alignment::addGapInSeq1(int j) {
    addGap(1, j);
}

vector<gap_sequence_t>* Alignment::getGapSequences() {
	if (gap_sequences.size() > 0) {
		return &gap_sequences;
	}
	
	int c0 = gaps[0].size()-1;
	int c1 = gaps[1].size()-1;
	
	int i = this->i0;
	int j = this->j0;
	
	int next_gap_i = c0==-1?-1:gaps[0][c0].pos;
	int next_gap_j = c1==-1?-1:gaps[1][c1].pos;
	
	gap_sequences.resize(gaps[0].size() + gaps[1].size());
	int k=0;
	while (c0 >= 0 || c1 >= 0) {
		// Calcula a distancia do ponto atual até o proxy gap do tipo 0 e do tipo 1
		int diff_i = next_gap_i<=0?0x7FFFFFFF:(next_gap_i-i);
		int diff_j = next_gap_j<=0?0x7FFFFFFF:(next_gap_j-j);
		/*printf("(%d %d) (%d %d) = (%d %d) (%d:%d %d:%d)\n", 
			   i, j, next_gap_i, next_gap_j, diff_i, diff_j, c0, gaps[0][c0].len, c1, gaps[1][c1].len);*/
		gap_sequence_t gap_sequence;
		
		// Processa o gap mais proximo
		if (diff_j < diff_i) {
			i += diff_j;
			j = next_gap_j;
			gap_sequences[k].i0 = i;
			gap_sequences[k].j0 = j;
			i += gaps[1][c1--].len;
		} else {
			i = next_gap_i;
			j += diff_i;
			gap_sequences[k].i0 = i;
			gap_sequences[k].j0 = j;
			j += gaps[0][c0--].len;
		}
		gap_sequences[k].i1 = i;
		gap_sequences[k].j1 = j;
		k++;
		next_gap_i = c0==-1?-1:gaps[0][c0].pos;
		next_gap_j = c1==-1?-1:gaps[1][c1].pos;
	}
	printf("%d/%d: (%d %d) (%d %d)\n", k, gaps[0].size() + gaps[1].size(), i, j, i1, j1);
	printf("count: %d\n", gap_sequences.size());	
	
	return &gap_sequences;
}

void Alignment::finalize(int i0, int j0, int i1, int j1) {
    this->i0 = i0;
    this->j0 = j0;
    this->i1 = i1;
    this->j1 = j1;
	this->alignmentFinalized = true;
}


bool Alignment::isFinalized() {
	return alignmentFinalized;
}

void Alignment::fwrite_str(const char* str, FILE* file) {
    int len = strlen(str);
    fwrite(&len, sizeof(int), 1, file);
    fwrite(str, sizeof(char), len, file);
}

void Alignment::fread_str(string str, FILE* file) {
    int len;
    fread(&len, sizeof(int), 1, file);
	const int max_len = 1000;
	if (len > max_len) {
		fprintf(stderr, "Sanity Check: string too large during file read (%d > %d).", len, max_len);
		exit(0);
	}
	char cstr[max_len+5];
    fread(cstr, sizeof(char), len, file);
    cstr[len] = '\0';
	str.assign(cstr);
}

void Alignment::fwrite_gaps(vector<gap_t>* gaps, FILE* file) {
    int count = gaps->size();
    fwrite(&count, sizeof(int), 1, file);
    fwrite(&gaps->front(), sizeof(gap_t), count, file);
}

void Alignment::fread_gaps(vector<gap_t>* gaps, FILE* file) {
	int count;
	fread(&count, sizeof(int), 1, file);
	gaps->clear();
	for (int i=0; i<count; i++) {
		gap_t gap;
		fread(&gap, sizeof(gap_t), 1, file);
		gaps->push_back(gap);
	}
}

void Alignment::printBinary(string filename) {
    FILE* file = fopen(filename.c_str(), "wb");

    fwrite_str(job->seq[0].name.c_str(), file);
    fwrite_str(job->seq[1].name.c_str(), file);

    fwrite(&i0, sizeof(int), 1, file);
    fwrite(&j0, sizeof(int), 1, file);
    fwrite(&i1, sizeof(int), 1, file);
    fwrite(&j1, sizeof(int), 1, file);
    fwrite_gaps(&gaps[0], file);
    fwrite_gaps(&gaps[1], file);
    fclose(file);
}

void Alignment::loadBinary(string filename) {
	FILE* file = fopen(filename.c_str(), "rb");
	
	fread_str(job->seq[0].name, file);
	fread_str(job->seq[1].name, file);
	
	fread(&i0, sizeof(int), 1, file);
	fread(&j0, sizeof(int), 1, file);
	fread(&i1, sizeof(int), 1, file);
	fread(&j1, sizeof(int), 1, file);
	fread_gaps(&gaps[0], file);
	fread_gaps(&gaps[1], file);
	fclose(file);
}

void Alignment::addGap(int seq, int i) {
    if (gaps[seq].size() != 0 && gaps[seq].back().pos == i) {
        gaps[seq].back().len++;
        //printf("-seq: %d  i: %d  (%d)   [%d]\n", seq, i, gaps[seq].back().len, gaps[seq].size());
    } else {
        gap_t new_gap;
        new_gap.pos = i;
        new_gap.len = 1;
        gaps[seq].push_back(new_gap);
        //printf("+seq: %d  i: %d  (%d)   [%d]\n", seq, i, gaps[seq].back().len, gaps[seq].size());
    }

    /*int* c = &gaps[seq][0];
    int* s = &gaps[seq][(*c)*2+1];
    int* e = &gaps[seq][(*c)*2+2];

    //printf("seq: %d  i: %d  [%d/%d]\n", seq, i, *s, *e);
    if (*c>0 && i == *s) {
        (*e)++;
    } else {
        (*c)++;
        gaps[seq][(*c)*2+1] = i;
        gaps[seq][(*c)*2+2] = 1;
    } */
}