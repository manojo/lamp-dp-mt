/* 
 * File:   Properties.cpp
 * Author: edans
 * 
 * Created on April 11, 2010, 2:48 AM
 */

#include <stdlib.h>

#include "Properties.hpp"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

Properties::Properties() {

}

Properties::Properties(const Properties& orig) {
}

Properties::~Properties() {
}

int Properties::initialize(string filename) {
    FILE* f = fopen(filename.c_str(), "r");
    if (f == NULL) {
        return 0; // TODO lancar excecao
    }
    char str[500];
    while (fgets(str, sizeof(str), f) != NULL) {
        string line(str);
        line.resize(line.size()-1); // Remove white space
        int pos = line.find('=');
        if (pos > 0) {
            string key = line.substr(0, pos);
            string value = line.substr(pos+1, string::npos);
            printf("%s  =  %s\n", key.c_str(), value.c_str());
            propertyMap[key] = value;
        }
    }
    fclose(f);
    return 1;
}

string Properties::get_property(string key) {
    return propertyMap[key];
}

int Properties::get_property_int(string key) {
    return atoi(propertyMap[key].c_str());
}