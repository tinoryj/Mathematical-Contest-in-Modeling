//
//  main.cpp
//  jiaquanpaiming
//
//  Created by tinoryj on 06/05/2017.
//  Copyright © 2017 tinoryj. All rights reserved.
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

#define MAX 30 //关键字个数设置
#define type 6
#define outNum 3000
struct timeval start, end;

string getFileContents(const char *filename){
    
    ifstream in(filename, ios::in | ios::binary);
    if (in){
        
        std::string contents;
        in.seekg(0, ios::end);
        contents.resize(in.tellg());
        in.seekg(0, ios::beg);
        in.read(&contents[0], contents.size());
        in.close();
        return(contents);
    }
    throw(errno);
}
struct node{
    
    int name;
    int code;
};

bool cmp(node a, node b){
    if(a.code > b.code){
        return true;
    }
    else{
        return false;
    }
}

int main(int argc, const char * argv[]) {
    string typeName[6];
    typeName[0] = "民事";
    typeName[1] = "经济";
    typeName[2] = "刑事";
    typeName[3] = "公司";
    typeName[4] = "其他";
    typeName[5] = "涉外";
    
    freopen("/Users/tinoryj/Desktop/paimin", "w+", stdout);

    ifstream in1("/Users/tinoryj/Desktop/zhuanyefenshu");
    ifstream in2("/Users/tinoryj/Desktop/zhuanye.txt");
    
    
    node zhuanye[3000];
    node leibie[6][3000];
    for(int i = 0; i < 6; i++){
        for(int j = 0; j < 3000; j++){
            in1>>leibie[i][j].name>>leibie[i][j].code;
        }
    }
    for(int i = 0; i < 3000; i++){
        int temp1, temp2;
        in2>>zhuanye[i].name>>temp1>>temp2;
        zhuanye[i].code = 3000-i;
    }
    vector<node> type0;
    for(int i = 0; i < 3000; i++){
        for(int j = 0; j < 3000; j++){
            if(zhuanye[i].name == leibie[0][j].name){
                
                node tmp;
                tmp.name = zhuanye[i].name;
                tmp.code = zhuanye[i].code + leibie[0][j].code;
                type0.push_back(tmp);
            }
        }
    }
    sort(type0.begin(), type0.end(), cmp);
    cout<<typeName[0]<<":"<<"编号"<<" code"<<endl;
    for(int i = 0; i < outNum; i++){
        cout<<type0[i].name<<" "<<type0[i].code/2<<endl;
    }
    cout<<endl<<endl<<endl;
    vector<node> type1;
    for(int i = 0; i < 3000; i++){
        for(int j = 0; j < 3000; j++){
            if(zhuanye[i].name == leibie[1][j].name){
                
                node tmp;
                tmp.name = zhuanye[i].name;
                tmp.code = zhuanye[i].code + leibie[1][j].code;
                type1.push_back(tmp);
            }
        }
    }
    sort(type1.begin(), type1.end(), cmp);
    cout<<typeName[1]<<":"<<"编号"<<" code"<<endl;
    for(int i = 0; i < outNum; i++){
        cout<<type1[i].name<<" "<<type1[i].code/2<<endl;
    }
    cout<<endl<<endl<<endl;
    vector<node> type2;
    for(int i = 0; i < 3000; i++){
        for(int j = 0; j < 3000; j++){
            if(zhuanye[i].name == leibie[2][j].name){
                
                node tmp;
                tmp.name = zhuanye[i].name;
                tmp.code = zhuanye[i].code + leibie[2][j].code;
                type2.push_back(tmp);
            }
        }
    }
    sort(type2.begin(), type2.end(), cmp);
    cout<<typeName[2]<<":"<<"编号"<<" code"<<endl;
    for(int i = 0; i < outNum; i++){
        cout<<type2[i].name<<" "<<type2[i].code/2<<endl;
    }
    cout<<endl<<endl<<endl;
    vector<node> type3;
    for(int i = 0; i < 3000; i++){
        for(int j = 0; j < 3000; j++){
            if(zhuanye[i].name == leibie[3][j].name){
                
                node tmp;
                tmp.name = zhuanye[i].name;
                tmp.code = zhuanye[i].code + leibie[3][j].code;
                type3.push_back(tmp);
            }
        }
    }
    sort(type3.begin(), type3.end(), cmp);
    cout<<typeName[3]<<":"<<"编号"<<" code"<<endl;
    for(int i = 0; i < outNum; i++){
        cout<<type3[i].name<<" "<<type3[i].code/2<<endl;
    }
    cout<<endl<<endl<<endl;
    vector<node> type4;
    for(int i = 0; i < 3000; i++){
        for(int j = 0; j < 3000; j++){
            if(zhuanye[i].name == leibie[4][j].name){
                
                node tmp;
                tmp.name = zhuanye[i].name;
                tmp.code = zhuanye[i].code + leibie[4][j].code;
                type4.push_back(tmp);
            }
        }
    }
    sort(type4.begin(), type4.end(), cmp);
    cout<<typeName[4]<<":"<<"编号"<<" code"<<endl;
    for(int i = 0; i < outNum; i++){
        cout<<type4[i].name<<" "<<type4[i].code/2<<endl;
    }
    cout<<endl<<endl<<endl;
    vector<node> type5;
    for(int i = 0; i < 3000; i++){
        for(int j = 0; j < 3000; j++){
            if(zhuanye[i].name == leibie[5][j].name){
                
                node tmp;
                tmp.name = zhuanye[i].name;
                tmp.code = zhuanye[i].code + leibie[5][j].code;
                type5.push_back(tmp);
            }
        }
    }
    sort(type5.begin(), type5.end(), cmp);
    cout<<typeName[5]<<":"<<"编号"<<" code"<<endl;
    for(int i = 0; i < outNum; i++){
        cout<<type5[i].name<<" "<<type5[i].code/2<<endl;
    }
    return 0;
}
