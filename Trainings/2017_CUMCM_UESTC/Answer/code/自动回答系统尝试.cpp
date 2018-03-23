//
//  main.cpp
//  20170506-4
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

#define MAX 30 //关键字个数设置
#define type 6
#define outNum 1500
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
int main(int argc, const char * argv[]) {
    
    ifstream in("/Users/tinoryj/Desktop/data");//使用时请添加数据集data路径
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
    
    int data[6];
    data[0] = 2899;
    data[1] = 1142;
    data[2] = 2315;
    data[3] = 2583;
    data[4] = 998;
    data[5] = 2839;
    

    string dir = "/Users/tinoryj/Downloads/data/";
    char fileName[10];
    while(1){
        cout<<"您的咨询内容是？(输入-1以结束咨询)"<<endl;
        string temp;
        cin>>temp;
        int select = -1;
        if(strstr(temp.c_str(),"-1")){
            break;
        }
        for(int j = 0; j < type; j++){
            
            if(strstr(temp.c_str(),keyWord[j][0].c_str()) || strstr(temp.c_str(),keyWord[j][1].c_str()) || strstr(temp.c_str(),keyWord[j][2].c_str()) || strstr(temp.c_str(),keyWord[j][3].c_str()) || strstr(temp.c_str(),keyWord[j][4].c_str()) || strstr(temp.c_str(),keyWord[j][5].c_str()) || strstr(temp.c_str(),keyWord[j][6].c_str()) || strstr(temp.c_str(),keyWord[j][7].c_str()) || strstr(temp.c_str(),keyWord[j][8].c_str()) || strstr(temp.c_str(),keyWord[j][9].c_str())){
                
                select = j;
                break;
            }
        }
        if(select == -1){
            cout<<"抱歉，没能匹配到合适的答案"<<endl;
            continue;
        }
        sprintf(fileName, "%d",data[select]);
        string file = dir + fileName;
        string dataRead = getFileContents(file.c_str()); //文件绝对路径
        string tempans;
        for(int i = 0; i < dataRead.length(); i++){
            
            if(dataRead[i] == '\"' && (dataRead[i+1] == '\r' || dataRead[i+1] == '\0')){
                
                
                if(!strstr(tempans.c_str(),"答")){
                    continue;
                }
                string len = strstr(tempans.c_str(),"答");
                if(strstr(len.c_str(),keyWord[select][0].c_str()) || strstr(len.c_str(),keyWord[select][1].c_str()) || strstr(len.c_str(),keyWord[select][2].c_str()) || strstr(len.c_str(),keyWord[select][3].c_str()) || strstr(len.c_str(),keyWord[select][4].c_str()) || strstr(len.c_str(),keyWord[select][5].c_str()) || strstr(len.c_str(),keyWord[select][6].c_str()) || strstr(len.c_str(),keyWord[select][7].c_str()) || strstr(len.c_str(),keyWord[select][8].c_str()) || strstr(len.c_str(),keyWord[select][9].c_str())){
                    cout<<len<<endl;
                    break;
                }
                tempans.clear();
                len.clear();
            }
            tempans.push_back(dataRead[i]);
        }
    }
    cout<<"感谢您的支持，祝您生活愉快"<<endl;
    return 0;
}
