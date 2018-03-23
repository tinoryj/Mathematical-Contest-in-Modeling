#include <iostream>
#include <cstdio>
#include <string>
#include <fstream>
#include <cerrno>
typedef long long ll;
using namespace std;

string get_file_contents(const char *filename)
{
    std::ifstream in(filename, std::ios::in | std::ios::binary);
    if (in)
    {
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
int main(int argc, const char * argv[]) {
    
    //freopen("/Users/tinoryj/Desktop/cData.txt", "w+", stdout);
    string dataRead;
    cin>>dataRead;
    //string dataRead = get_file_contents("/Users/tinoryj/Desktop/mData.txt");
    string dataM;
    ll cCountOfDataM[26] = {0};
    ll dataReadLen = dataRead.size();
    for(ll i = 0; i < dataReadLen; i++){
        
        if(dataRead[i] >= 'A' && dataRead[i] <= 'Z'){
            
            dataM += (dataRead[i] + 32);
            cCountOfDataM[dataRead[i] - 65]++;
        }
        if(dataRead[i] >= 'a' && dataRead[i] <= 'z'){
            
            dataM += dataRead[i];
            cCountOfDataM[dataRead[i] - 97]++;
        }
    }
    for(int i = 0; i < 26; i++){
        
        cout<<cCountOfDataM[i]<<" ";
    }
    cout<<endl;
    /*
     int keyA[] = {1,3,5,7,9,11,15,17,19,21,23,25};
     for(int a = 0; a < 12; a++){
     
     for(int b = 0; b < 26; b++){
     
     string dataC;
     ll cCountOfDataC[26] = {0};
     for(ll i = 0; i < dataM.size(); i++){
     
     char temp = (char)(((dataM[i] - 97) * keyA[a] + b)%26 + 97);
     cCountOfDataC[temp - 'a']++;
     dataC += temp;
     }
     for(int i = 0; i < 26; i++){
     
     cout<<cCountOfDataC[i]<<" ";
     }
     cout<<endl;
     }
     }
     */
    return 0;
}
