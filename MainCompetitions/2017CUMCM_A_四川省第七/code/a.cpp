#include <iostream>
#include <cstdio>
#include <string>
#include <fstream>
#include <cerrno>
typedef long long ll;
using namespace std;
int main(int argc, const char * argv[]) {
    
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
    return 0;
}
