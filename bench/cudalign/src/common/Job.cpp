/* 
 * File:   Job.cpp
 * Author: edans
 * 
 * Created on April 8, 2010, 11:00 PM
 */

#include "Job.hpp"

#include <iostream>
using namespace std;

#include <stdio.h>
#include <string.h>
#include <algorithm>
#include <sys/stat.h>
#include <errno.h>
#include <sys/types.h>
#include "Properties.hpp"
#include "SpecialRowWriter.hpp"
#include "buffer/SocketBuffer.hpp"
#include "buffer/FileBuffer.hpp"

Job::Job() {
	alignment = new Alignment(this);
}

Job::Job(const Job& orig) {
	alignment = new Alignment(this);
}

Job::~Job() {
}

void Job::setWorkPath(string workPath) {
    this->work_path = workPath;
}

void Job::createPath(string path) {
	if (mkdir(path.c_str(), 0774)) {
		if (errno != EEXIST) {
			fprintf(stderr, "Path (%s) could not be created. Try to create it manually.\n", path.c_str());
			exit(1);
		}
	}
}

void Job::initializeWorkPath() {
    if (gpu >= 0) {
        createPath(this->work_path);
		
        char suffix[20];
        sprintf ( suffix, "/GPU.%d", gpu);
        work_path = work_path + "/" + suffix;
    }
    fprintf(stderr, "Work Path: %s\n", work_path.c_str());

    this->alignment_text_filename = work_path + "/alignment.txt";
    this->alignment_binary_filename = work_path + "/alignment.bin";
    this->alignment_svg_filename = work_path + "/alignment.svg";
    this->midpoints_path = work_path + "/midpoints";
    this->special1_path = work_path + "/special1";
    this->special2_path = work_path + "/special2";
    this->info_filename = work_path + "/info";
    this->status_filename = work_path + "/status";
    this->statistics_filename = work_path + "/statistics";
    
	createPath(this->work_path);
    createPath(this->midpoints_path);
    createPath(this->special1_path);
    createPath(this->special2_path);
}


string Job::getWorkPath() {
    return this->work_path;
}


int Job::initialize() {
    initializeWorkPath();

    Properties prop;
    if (prop.initialize(this->info_filename.c_str())) {
        /*if (this->phase == 0) {
            this->phase = prop.get_property_int("phase");
        }
        this->progress = prop.get_property_int("progress");*/
        string file0 = prop.get_property("seq0");
        string file1 = prop.get_property("seq1");
        int file0_mismatch = (file0.compare(this->seq[0].name));
        int file1_mismatch = (file1.compare(this->seq[1].name));
        if (file0_mismatch || file1_mismatch) {
            printf("Sequence mismatch from previous run. Try cleaning work directory (--clean)\n");
        }
        if (file0_mismatch) {
            printf("%s != %s\n", file0.c_str(), this->seq[0].name.c_str());
        }
        if (file1_mismatch) {
            printf("%s != %s\n", file1.c_str(), this->seq[1].name.c_str());
        }
        if (file0_mismatch || file1_mismatch) {
            return 0;  // TODO retornar excecao
        }
    } else {
        //this->progress = 0;

		FILE* f = fopen(this->info_filename.c_str(), "wt");
        fprintf(f, "seq0=%s\n", this->seq[0].name.c_str());
        fprintf(f, "seq1=%s\n", this->seq[1].name.c_str());
        fclose(f);
    }

    //cout << this->phase << endl;
    //cout << this->progress << endl;
    cout << this->midpoints_path << endl;
    cout << this->special1_path << endl;
    cout << this->special2_path << endl;
    return 1; // TODO remover quando for retornar excecao
}


//static int sortf1(point_t a, point_t b) {
//    return a.i < b.i;
//}
//static int sortf2(point_t a, point_t b) {
//    return a.j < b.j;
//}

/**
* Return all list of all files and directories in "path",
* as a malloc'd array. All strings inside the array are
* also malloc'd; it is the caller's responsibility to free
* both.
*
* Returns NULL if the path cannot be opened, or an allocation
* failure occurs.
*/
void Job::loadSpecialRows(int stage_id) {
    if (stage_id == STAGE_1) {
        this->special_lines1 = SpecialRowReader::loadSpecialRows(this->special1_path, true);
    } else if (stage_id == STAGE_2) {
        this->special_lines2 = SpecialRowReader::loadSpecialRows(this->special2_path, false);
    } else {
        // exit ERROR
    }
}


void Job::loadMidpoints(int id) {
    FILE* file = NULL;
    if (id==-1) {
        for (id=0; id<100; id++) {
            file = fopenMidpoints(id, "r");
            if (file == NULL) {
                id--;
                break;
            } else {
                fclose(file);
            }
        }
		this->last_midpoint_id = id;
    }
    file = fopenMidpoints(id, "r");
    if (file == NULL) {
        this->midpoints.clear();
        printf("NO MIDPOINTS: id %d\n", id);
        return;
    }
	printf("LOAD MIDPOINTS: %X  id: %d\n", file, id);

    char line[500];
    int started = 0;
    while (fgets(line, sizeof(line), file) != NULL) {
        if (strcmp(line, "END\n")==0) break;
        if (started) {
            midpoint_t temp;
            sscanf(line, "%d,%d,%d,%d", &temp.type, &temp.i, &temp.j, &temp.score);
            this->midpoints.push_back(temp);

        }
        if(strcmp(line, "START\n")==0) {
            started = 1;
            this->midpoints.clear();
        }
    }

	printf("LOAD MIDPOINTS: count %d\n", this->midpoints.size());
    if (midpoints.front().i < midpoints.back().i) {
        std::reverse(midpoints.begin(),midpoints.end());
    }
}

int Job::getLargestMidpointSize(int* max_i, int* max_j) {
    int max_size_i = 0;
	int max_size_j = 0;
	for (int i=1; i < midpoints.size(); i++) {
        midpoint_t curr = midpoints[i];
        midpoint_t prev = midpoints[i-1];
        if (max_size_i < prev.i-curr.i) max_size_i = prev.i-curr.i;
        if (max_size_j < prev.j-curr.j) max_size_j = prev.j-curr.j;
    }
	if (max_i != NULL) *max_i = max_size_i;
	if (max_j != NULL) *max_j = max_size_j;
	if (max_size_i > max_size_j) {
		return max_size_i;
	} else {
		return max_size_j;
	}
}

int Job::getLargestSpecialRowInterval(int stage_id, int* max_i, int* max_j) {
	vector<SpecialRowReader*>* special_row;
	if (stage_id == STAGE_1) {
		special_row = this->special_lines1;
	} else if (stage_id == STAGE_2) {
		special_row = this->special_lines2;
	} else {
		// exit ERROR
	}
	
	int max_size_i = 0;
	int max_size_j = 0;
	for (int i=1; i < special_row->size(); i++) {
		SpecialRowReader* curr = special_row->at(i);
		SpecialRowReader* prev = special_row->at(i-1);
		int delta_i = prev->getRow()-curr->getRow();
		int delta_j = prev->getCol()-curr->getCol();
		if (delta_i !=0 && delta_j != 0) {
			// TODO conferir. Principalmente se estiver no stage 3!! pois teriamos que contar o crosspoint.
			// TODO talvez devessemos salvar um special row dummy pra evitar isso.
			continue;
		}
		if (max_size_i < delta_i) max_size_i = delta_i;
		if (max_size_j < delta_j) max_size_j = delta_j;
	}
	if (max_i != NULL) *max_i = max_size_i;
	if (max_j != NULL) *max_j = max_size_j;
	if (max_size_i > max_size_j) {
		return max_size_i;
	} else {
		return max_size_j;
	}
}

void Job::writeMidpoints(int id) {
    if (id <= -1) {
		id = this->last_midpoint_id+1;
    }
    FILE* midpoints_file = this->fopenMidpoints(id, "w");

    fprintf(midpoints_file, "START\n");
    for (int i=0; i<midpoints.size(); i++) {
		fprintf(midpoints_file, "%d,%d,%d,%d\n", midpoints[i].type, midpoints[i].i, midpoints[i].j, midpoints[i].score);
		//fflush(midpoints_file);
    }

    fprintf(midpoints_file, "END\n");
    fclose(midpoints_file);
}

Buffer* Job::loadBufferFromURL(string url) {
	int pos1 = url.find_first_of("://");
	if (pos1 == -1) return NULL;
	string type = url.substr(0, pos1);
	string file = url.substr(pos1+3);
	
	
	fprintf(stderr, "%s:   %s - %s\n", url.c_str(), type.c_str(), file.c_str());
	if (type == "socket") {
		int port;
		string hostname;
		int pos2 = file.find_first_of(":");
		if (pos2 > 0) {
			port = atoi(file.substr(pos2+1).c_str());
			hostname = file.substr(0, pos2);
		} else {
			hostname = file;
		}
		return new SocketBuffer(hostname, port);
	} else if (type == "file") {
		return new FileBuffer(file);
	} else {
		return NULL;
	}
}


FILE* Job::fopenSpecialRow(int stage_id, int row, int col, const char* mode) {
    char str[500];
    if (stage_id == STAGE_1) {
        sprintf(str, "%s/%08X.%08X", this->special1_path.c_str(), row, col);
    } else if (stage_id == STAGE_2) {
        sprintf(str, "%s/%08X.%08X", this->special2_path.c_str(), row, col);
    }
    //printf("%s\n", str);
    FILE * file = fopen(str, mode);
    return file;
}

SpecialRowWriter* Job::fopenNewSpecialRow(int stage_id, int row, int col) {
    if (stage_id == STAGE_1) {
        return new SpecialRowWriter(this->special1_path, row, col);
    } else if (stage_id == STAGE_2) {
        return new SpecialRowWriter(this->special2_path, row, col);
    } else {
        // exit ERROR
        return NULL;
    }
}

SpecialRowReader* Job::fopenNextSpecialRow(int stage_id, int row, int col, int min_dist, int *id) {
    vector<SpecialRowReader*>* specialRows = NULL;
    int reverse;
    if (stage_id == STAGE_1) {
        specialRows = this->special_lines1;
        reverse = 1;
    } else if (stage_id == STAGE_2) {
        specialRows = this->special_lines2;
        reverse = 0;
    } else {
        // exit ERROR
    }
    /*if (*id == 0) {
        *id = specialRows->size()-1;
    }*/
    // TODO testar id negativo. abortar se isso ocorrer
    //printf("l: %d\n", *id);
    int count = specialRows->size();
    if (reverse) {
        while (*id<count && (*specialRows)[*id]->getRow() > row-min_dist) {
            printf("l: %d(%X)  (%d,%d) - (%d,%d)\n", *id, (*specialRows)[*id],
                    (*specialRows)[*id]->getRow(), (*specialRows)[*id]->getCol(),
                    row, col);
            (*id)++;
        }
    } else {
        while (*id<count && (*specialRows)[*id]->getCol() < col+min_dist) {
            printf("l: %d(%X)  (%d,%d) - (%d,%d)\n", *id, (*specialRows)[*id],
                    (*specialRows)[*id]->getRow(), (*specialRows)[*id]->getCol(),
                    row, col);
            (*id)++;
        }
    }
    printf("*id: %d\n", *id);
    if (*id >= count) {
        printf("End of Special Lines\n");
        return NULL;
    }
    /*if (reverse) {

    } else {
        if ((*specialRows)[*id]->getRow() > row) {
            printf("End of Partition: %d > %d\n", (*specialRows)[*id]->getRow(), row);
            return NULL;
        }
    }*/
    printf("-[%d.%d]\n", row, col);
    row = (*specialRows)[*id]->getRow();
    col = (*specialRows)[*id]->getCol();
    printf("+[%d.%d]\n", row, col);


    if (stage_id == STAGE_1) {
        return new SpecialRowReader(this->special1_path, row, col);
    } else if (stage_id == STAGE_2) {
        return new SpecialRowReader(this->special2_path, row, col);
    } else {
        // exit ERROR
        return NULL;
    }
}

FILE* Job::fopenMidpoints(int midpoint_id, const char* mode) {
    char str[500];
    sprintf(str, "%s/midpoint_%02d", this->midpoints_path.c_str(), midpoint_id);
    printf("%s\n", str);
    FILE * file = fopen(str, mode);
    return file;
}

FILE* Job::fopenFirstMidpoint() {
    return fopenMidpoints(0, "w");
}

FILE* Job::fopenStatistics(int stage_id) {
	char str[500];
	sprintf(str, "%s_%02d", this->statistics_filename.c_str(), stage_id);
	printf("%s\n", str);
	FILE * file = fopen(str, "wt");
	if (file == NULL) {
		fprintf(stderr, "Error opening statistics file: %s\n", str);
		exit(1);
	}
	return file;
}

MidpointsFile* Job::fopenMidpointsFile(int midpoint_id) {
    if (midpoint_id == -1) {
		midpoint_id = this->last_midpoint_id+1;
    }
    return new MidpointsFile(this->midpoints_path, midpoint_id);
}