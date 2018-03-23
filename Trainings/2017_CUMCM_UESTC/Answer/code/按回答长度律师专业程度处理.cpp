//
//  main.cpp
//  20170506-3
//
//  Created by tinoryj on 2017/5/6.
//  Copyright © 2017年 tinoryj. All rights reserved.
//
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <stdlib.h>
#include <string>
#include <fstream>
#include <cerrno>
#include <vector>
#include <cstring>
#include <time.h>
typedef long long ll;
using namespace std;

string get_file_contents(const char *filename){
    
    std::ifstream in(filename, std::ios::in | std::ios::binary);
    if (in){
        
        std::string contents;
        in.seekg(0, std::ios::end);
        contents.resize(in.tellg());
        in.seekg(0, std::ios::beg);
        in.read(&contents[0], contents.size());
        in.close();
        return(contents);
    }
    throw(errno);
}
struct node{
    int name = 0;
    int sum = 0;
    int avr = 0;
};
bool cmp(node a, node b){
    
    if(a.avr > b.avr){
        return true;
    }
    else{
        return false;
    }
}
int main(int argc, const char * argv[]) {
    
    char fileName[10];
    
    freopen("/Users/tinoryj/Desktop/zhuanye.txt", "w+", stdout);
    
    string dir = "/Users/tinoryj/Downloads/data/";
    int fileCount = 3000; //参与统计的文件数目
    vector<node> la;
    cout<<"律师编号  "<<"回答总长度  "<<"平均回答长度"<<endl;
    for(int n = 1; n <= fileCount; n++){
        sprintf(fileName, "%d", n);
        string file = dir + fileName;
        string dataRead = get_file_contents(file.c_str()); //文件绝对路径
        string temp;
        string len;
        node tmp;
        tmp.name = n;
        for(int i = 0; i < dataRead.length(); i++){
            
            if(dataRead[i] == '\"' && (dataRead[i+1] == '\r' || dataRead[i+1] == '\0')){
                
                
                if(!strstr(temp.c_str(),"答")){
                    continue;
                }
                len = strstr(temp.c_str(),"答");
                
                tmp.sum += len.length();
                temp.clear();
                len.clear();
            }
            temp.push_back(dataRead[i]);
        }
        tmp.avr = tmp.sum/400;
        la.push_back(tmp);
    }
    sort(la.begin(), la.end(), cmp);
    for(int i = 0; i < la.size(); i++){
        cout<<la[i].name<<"  "<<la[i].sum<<"  "<<la[i].avr<<endl;
    }
    return 0;
}
