//
//  main.cpp
//  建模校赛
//
//  Created by tinoryj on 2017/5/4.
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

#define MAX 30 //关键字个数设置
#define type 6
#define outNum 1500
struct timeval start, end;

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
    
    int name;
    int times;
};

bool cmp(node a, node b){
    if(a.times > b.times){
        return true;
    }
    else{
        return false;
    }
}

int main(int argc, const char * argv[]) {
    
    int start = clock();
    string typeName[6];
    typeName[0] = "民事";
    typeName[1] = "经济";
    typeName[2] = "刑事";
    typeName[3] = "公司";
    typeName[4] = "其他";
    typeName[5] = "涉外";
    string keyWord[type][MAX];
    keyWord[0][0] = "婚";
    keyWord[0][1] = "交通";
    keyWord[0][2] = "车";
    keyWord[0][3] = "同居"; 
    keyWord[0][4] = "出轨"; 
    keyWord[0][5] = "疗"; 
    keyWord[0][6] = "假"; 
    keyWord[0][7] = "贷"; 
    keyWord[0][8] = "借"; 
    keyWord[0][9] = "拆";

    keyWord[1][0] = "房";
    keyWord[1][1] = "公积金";
    keyWord[1][2] = "首付";  
    keyWord[1][3] = "分期"; 
    keyWord[1][4] = "产权"; 
    keyWord[1][5] = "交易"; 
    keyWord[1][6] = "基金"; 
    keyWord[1][7] = "利率"; 
    keyWord[1][8] = "发票"; 
    keyWord[1][9] = "集资";

    keyWord[2][0] = "刑";
    keyWord[2][1] = "政";
    keyWord[2][2] = "贿";
    keyWord[2][3] = "判";
    keyWord[2][4] = "狱"; 
    keyWord[2][5] = "公安"; 
    keyWord[2][6] = "局"; 
    keyWord[2][7] = "委"; 
    keyWord[2][8] = "暴"; 
    keyWord[2][9] = "犯";

    keyWord[3][0] = "公司";
    keyWord[3][1] = "企";
    keyWord[3][2] = "股";
    keyWord[3][3] = "收购"; 
    keyWord[3][4] = "税";
    keyWord[3][5] = "万元"; 
    keyWord[3][6] = "资产";
    keyWord[3][7] = "份额"; 
    keyWord[3][8] = "执照"; 
    keyWord[3][9] = "裁员"; 

    keyWord[4][0] = "函";
    keyWord[4][1] = "文书";
    keyWord[4][2] = "委托";
    keyWord[4][3] = "短信"; 
    keyWord[4][4] = "移动";
    keyWord[4][5] = "联动"; 
    keyWord[4][6] = "电信"; 
    keyWord[4][7] = "广告"; 
    keyWord[4][8] = "环境"; 
    keyWord[4][9] = "代理";
    
    keyWord[5][0] = "仲裁";
    keyWord[5][1] = "台资";
    keyWord[5][2] = "贸易";
    keyWord[5][3] = "加拿大";
    keyWord[5][4] = "美国";
    keyWord[5][5] = "大使";
    keyWord[5][6] = "国外";
    keyWord[5][7] = "合资";
    keyWord[5][8] = "外资";
    keyWord[5][9] = "海";


    char fileName[10];
    string dir = "/Users/tinoryj/Downloads/data/";
    int fileCount = 3000;
    int wordCount[fileCount][type];
    memset(wordCount, 0, sizeof(wordCount));
    for(int n = 1; n <= fileCount; n++){
        int countQ = 0;
        int cnt = 0;
        sprintf(fileName, "%d", n);
        string file = dir + fileName;
        string dataRead = get_file_contents(file.c_str()); //文件绝对路径
        cout<<"文件名: "<<fileName<<"  总字符数: "<<dataRead.length()<<endl;
        string temp;
        for(int i = 0; i < dataRead.length(); i++){
            
            if(dataRead[i] == '\"' && (dataRead[i+1] == '\r' || dataRead[i+1] == '\0')){
                
                for(int j = 0; j < type; j++){
                    
                    if(strstr(temp.c_str(),keyWord[j][0].c_str()) || strstr(temp.c_str(),keyWord[j][1].c_str()) || strstr(temp.c_str(),keyWord[j][2].c_str()) || strstr(temp.c_str(),keyWord[j][3].c_str()) || strstr(temp.c_str(),keyWord[j][4].c_str()) || strstr(temp.c_str(),keyWord[j][5].c_str()) || strstr(temp.c_str(),keyWord[j][6].c_str()) || strstr(temp.c_str(),keyWord[j][7].c_str()) || strstr(temp.c_str(),keyWord[j][8].c_str()) || strstr(temp.c_str(),keyWord[j][9].c_str())){
                        
                        wordCount[n-1][j]++;
                        cnt++;
                    }
                }
                //cout<<temp<<endl;
                temp.clear();
                countQ++;
            }
            temp.push_back(dataRead[i]);
        }
        /*
        cout<<"问答数: "<<countQ<<endl;
        cout<<cnt<<endl;
        for(int i = 0; i < type; i++){
            
            cout<<i<<":"<<wordCount[n-1][i]<<endl; //输出含有关键字的问答的数目
        }
         */
    }
    
    vector<node> type0;
    for(int i = 0; i < fileCount; i++){
        
        node temp;
        temp.name = i;
        temp.times = wordCount[i][0];
        type0.push_back(temp);
    }
    sort(type0.begin(), type0.end(), cmp);
    cout<<typeName[0]<<":"<<"编号"<<" 频数"<<endl;
    for(int i = 0; i < outNum; i++){
        cout<<type0[i].name<<" "<<type0[i].times<<endl;
    }

    vector<node> type1;
    for(int i = 0; i < fileCount; i++){
        
        node temp;
        temp.name = i;
        temp.times = wordCount[i][1];
        type1.push_back(temp);
    }
    sort(type1.begin(), type1.end(), cmp);
    cout<<typeName[1]<<":"<<"编号"<<" 频数"<<endl;
    for(int i = 0; i < outNum; i++){
        cout<<type1[i].name<<" "<<type1[i].times<<endl;
    }
    
    vector<node> type2;
    for(int i = 0; i < fileCount; i++){
        
        node temp;
        temp.name = i;
        temp.times = wordCount[i][2];
        type2.push_back(temp);
    }
    sort(type2.begin(), type2.end(), cmp);
    cout<<typeName[2]<<":"<<"编号"<<" 频数"<<endl;
    for(int i = 0; i < outNum; i++){
        cout<<type2[i].name<<" "<<type2[i].times<<endl;
    }
    vector<node> type3;
    for(int i = 0; i < fileCount; i++){
        
        node temp;
        temp.name = i;
        temp.times = wordCount[i][3];
        type3.push_back(temp);
    }
    sort(type3.begin(), type3.end(), cmp);
    cout<<typeName[3]<<":"<<"编号"<<" 频数"<<endl;
    for(int i = 0; i < outNum; i++){
        cout<<type3[i].name<<" "<<type3[i].times<<endl;
    }
    vector<node> type4;
    for(int i = 0; i < fileCount; i++){
        
        node temp;
        temp.name = i;
        temp.times = wordCount[i][4];
        type4.push_back(temp);
    }
    sort(type4.begin(), type4.end(), cmp);
    cout<<typeName[4]<<":"<<"编号"<<" 频数"<<endl;
    for(int i = 0; i < outNum; i++){
        cout<<type4[i].name<<" "<<type4[i].times<<endl;
    }
    
    vector<node> type5;
    for(int i = 0; i < fileCount; i++){
        
        node temp;
        temp.name = i;
        temp.times = wordCount[i][5];
        type5.push_back(temp);
    }
    sort(type5.begin(), type5.end(), cmp);
    cout<<typeName[5]<<":"<<"编号"<<" 频数"<<endl;
    for(int i = 0; i < outNum; i++){
        cout<<type5[i].name<<" "<<type5[i].times<<endl;
    }
    int end = clock();
    cout<<(end - start)/1000000;
    return 0;
}
