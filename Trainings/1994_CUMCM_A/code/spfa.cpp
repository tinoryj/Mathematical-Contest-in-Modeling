#include <cstdio>
#include <iostream>
using namespace std;
struct node{
    int x;
    int value;
    int next;
};
node e[60000];
int visited[1000000],dis[500000],st[1000000],queue[1000000];
int main(){
    
    int n,m,u,v,w,start,h,r,cur;
    freopen("c.in","r",stdin);
    freopen("c.out","w",stdout);
    while(scanf("%d%d",&n,&m) != EOF){
        
        for(int i = 1; i <= 1000000; i++){
            
            visited[i]=0;
            dis[i]=-1;
            st[i]=-1;
        }
        for(int i = 1; i <= m; i++){
            
            cin>>u>>v>>w;
            e[i].x = v;
            e[i].value = w;
            e[i].next = st[u];
            st[u] = i;
        }
        start = 1;
        visited[start] = 1;
        dis[start] = 0;
        h = 0;
        r = 1;
        queue[r] = start;
        while(h != r){
            
            h = (h + 1) % 1000;
            cur = queue[h];
            long int tmp = st[cur];
            visited[cur] = 0;
            while(tmp != -1){
                
                if (dis[e[tmp].x] < dis[cur] + e[tmp].value){
                    
                    dis[e[tmp].x] = dis[cur] + e[tmp].value;
                    if(visited[e[tmp].x] == 0){
                        
                        visited[e[tmp].x] = 1;
                        r = (r + 1) % 1000;
                        queue[r] = e[tmp].x;
                    }
                }
                tmp = e[tmp].next;
            }
        } 
        cout<<dis[n];
    }
    return 0;   
}
