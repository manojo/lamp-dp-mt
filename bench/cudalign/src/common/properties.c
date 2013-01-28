#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "properties.h"

properties_t* load_properties(char* filename) {
    FILE* f = fopen(filename, "r");
    if (f == NULL) {
        return NULL;
    }
    char str[500];
    properties_t* properties = NULL;
    int count = 0;
    while (fgets(str, sizeof(str), f) != NULL) {
        int key_size = strchr(str, '=')-str;
        if (key_size>0) {
            int value_size = (strlen(str)-1) - (key_size+1);
            properties = (properties_t*)realloc(properties, sizeof(properties_t)*(count+2));

            properties[count].key = (char*)malloc(key_size+1);
            strncpy(properties[count].key, str, key_size);
            properties[count].key[key_size] = 0;

            properties[count].value = (char*)malloc(value_size+1);
            strncpy(properties[count].value, str+key_size+1, value_size);
            properties[count].value[value_size] = 0;

            count++;
        }
    }
    properties[count].key = NULL;
    properties[count].value = NULL;
    return properties;
}

char* get_property(properties_t* property, char* key) {
    for (properties_t* p=property; p->key; p++) {
        if (strcmp(p->key, key)==0) {
            return p->value;
        }
    }
    return "";
}

int get_property_int(properties_t* property, char* key) {
    char* value = get_property(property, key);
    return atoi(value);
}

void unload_properties(properties_t* property) {
    for (properties_t* p=property; p->key; p++) {
        free(p->key);
        free(p->value);
    }
    free(property);
}
