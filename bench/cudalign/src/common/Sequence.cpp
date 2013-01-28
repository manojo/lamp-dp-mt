/* 
 * File:   Sequence.cpp
 * Author: edans
 * 
 * Created on April 11, 2010, 3:22 AM
 */

#include "Sequence.hpp"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

Sequence::Sequence() {
}

Sequence::Sequence(const Sequence& orig, int reverse) {
	this->name = orig.name;
	this->accession = orig.accession;
	this->original_len = orig.original_len;
	this->len = orig.original_len;
	this->offset0 = 1;
	this->offset1 = orig.original_len;
	
	// TODO remover, e utilizar o método reverse
	if (reverse) {
		this->original_forward_data = orig.original_reverse_data;
		this->original_reverse_data = orig.original_forward_data;
		this->trim(orig.original_len - orig.offset1 + 1, 
				   orig.original_len - orig.offset0 + 1);
	} else {
		this->original_forward_data = orig.original_forward_data;
		this->original_reverse_data = orig.original_reverse_data;
		this->trim(orig.offset0, 
				   orig.offset1);
	}
}

void Sequence::reverse() {
	// UNTESTED
	char* temp = original_reverse_data;
	original_reverse_data = original_forward_data;
	original_forward_data = temp;

	int old_offset0 = offset0;
	int old_offset1 = offset1;
	this->untrim();
	this->trim(original_len - old_offset1 + 1, 
			   original_len - old_offset0 + 1);
}

Sequence::~Sequence() {
    free(reverse_data);
}

int Sequence::getLen() const {
    return len;
}

void Sequence::trim (int delta0, int delta1) {
	//printf("TRIM: %d-%d\n", delta0, delta1);
	if (delta0 <= 0) {
		delta0 = 1;
	}
	if (delta1 <= 0) {
		delta1 = len;
	}
	//printf("TRIM: past %d-%d\n", offset0, offset1);
	offset0 += (delta0-1);
	offset1 -= (len-delta1);
	printf("TRIM: curr %d-%d\n", offset0, offset1);
	len = delta1-delta0+1;
	this->forward_data = this->original_forward_data + (offset0-1);
	this->reverse_data = this->original_reverse_data + (original_len-offset1);
	//printf("TRIM: %X %x\n", forward_data, reverse_data);
}

void Sequence::untrim () {
	this->len = this->original_len;
	this->offset0 = 1;
	this->offset1 = this->original_len;
	this->forward_data = this->original_forward_data;
	this->reverse_data = this->original_reverse_data;
}

void Sequence::readFile(char* filename, const int flags) {
    FILE* file = fopen(filename, "rt");

    fseek(file, 0L, SEEK_END);
    long fileSize = ftell(file);
    rewind(file);

    char line[500];
    fgets(line, sizeof(line), file);
    char tmp[500];
    sscanf(line, ">%s", tmp);
    name = tmp;
	char* tok=strtok(tmp, "|");
	for (int i=1; i<4 && tok != NULL; i++) {
		tok = strtok (NULL, "|");
	}
	if (tok == NULL) {
		accession = name;
	} else {
		accession = tok;
	}
	
    data_vector.reserve(fileSize);

    int i;
    int pos=0;
	char complement_map[256];
	for (int i=0; i<256; i++) {
		complement_map[i] = toupper(i);
	}
	if (flags & FLAG_COMPLEMENT) {
		complement_map['A'] = complement_map['a'] = 'T';
		complement_map['T'] = complement_map['t'] = 'A';
		complement_map['C'] = complement_map['c'] = 'G';
		complement_map['G'] = complement_map['g'] = 'C';
	}
	
    while ((i=fgetc(file)) != EOF) {
        if (i == '\r' || i == '\n' || i == ' ') continue;
		if ((flags & FLAG_CLEAR_N) && ((char)i == 'N' || (char)i == 'n')) continue;
        pos++;
		data_vector.push_back(complement_map[(char)i]);
    }
    this->original_len = data_vector.size();
    data_vector.push_back((char)0);
	original_forward_data = &data_vector[0];

    // TODO otimizar usando cuda
	original_reverse_data = (char*)malloc(this->original_len+1);
	for (int i=0; i<this->original_len; i++) {
		original_reverse_data[this->original_len-1-i] = original_forward_data[i];
    }
	original_reverse_data[this->original_len] = 0;

    fclose(file);
	
	if (flags & FLAG_REVERSE) {
		char* temp = original_reverse_data;
		original_reverse_data = original_forward_data;
		original_forward_data = temp;
	}

	untrim();
}