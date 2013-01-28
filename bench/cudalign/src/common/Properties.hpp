/* 
 * File:   Properties.hpp
 * Author: edans
 *
 * Created on April 11, 2010, 2:48 AM
 */

#ifndef _PROPERTIES_HPP
#define	_PROPERTIES_HPP

#include <string>
#include <map>
using namespace std;

class Properties {
public:
    Properties();
    Properties(const Properties& orig);
    virtual ~Properties();

    int initialize(string filename);
    string get_property(string key);
    int get_property_int(string key);
private:
    map<string, string> propertyMap;
};

#endif	/* _PROPERTIES_HPP */

