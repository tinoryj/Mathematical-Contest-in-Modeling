#include <iostream>  
#include <algorithm>  
#include <fstream>
#include <vector>  
#include <queue>  
using namespace std;  
const int N = 1050;  
const int inf = 0x3f3f3f3f;
struct Edge {  
    int from, to, flow, cap, cost;  
};  
bool vis[N];  
int p[N], a[N], d[N];  
vector<int> g[N];//邻接表，G[i][j]表示结点i的第j条边在edges数组中存储的下标  
vector<Edge> edges;  
  
void init(int n) {

    for (int i = 0; i <= n; i++)  
        g[i].clear();  
    edges.clear();  
}  
void addedge(int from, int to, int cap, int cost) {

    Edge temp1 = { from,to,0,cap,cost };  
    Edge temp2 = { to,from,0,0,-cost };//允许反向增广  
    edges.push_back(temp1);  
    edges.push_back(temp2);  
    int len = edges.size();  
    g[from].push_back(len - 2);  
    g[to].push_back(len - 1);  
}  
bool bellmanford(int s, int t,int &flow,int &cost) {

    for (int i = 0; i < N; i++)  
        d[i] = inf;//这里一开始用memset结果出错，调试了半天才找出来  
    d[s] = 0;  
    memset(vis,false, sizeof(vis));   
    memset(p, -1, sizeof(p));  
    p[s] = -1;  
    a[s] = inf;  
    queue<int> que;  
    que.push(s);  
    vis[s] = true;  
    while (!que.empty()) {

        int u = que.front();  
        que.pop();  
        vis[u] = false;  
        for (int i = 0; i < g[u].size(); i++) {

            Edge& e = edges[g[u][i]];  
            if (e.cap > e.flow&&d[e.to] > d[u] + e.cost) { //进行松弛，寻找最短路径也就是最小费用  
  
                d[e.to] = d[u] + e.cost;  
                p[e.to] = g[u][i];  
                a[e.to] = min(a[u], e.cap - e.flow);  
                if (!vis[e.to]) {  
                    que.push(e.to);  
                    vis[e.to] = true;  
                }  
            }  
        }  
    }  
    if (d[t] == inf)  
        return false;  
    flow += a[t];  
    cost += d[t] * a[t];  
    for (int i = t; i != s; i = edges[p[i]].from) {

        edges[p[i]].flow += a[t];  
        edges[p[i]^1].flow -= a[t];  
    }  
    return true;  
}  
int mincost(int s, int t) {
      
    int flow = 0, cost = 0;  
    while (bellmanford(s, t, flow, cost))  
        continue;  
    return cost;  
}  
  
int main() {

    // 第一行包含两个整数n和m，n表示图中结点个数，m表示图中边的条数；
    // 接下来m行，每一行包含三个整数u,v,w，表示途中存在一条边(u,v)，并且其权重为w；
    ifstream in("/Users/tinoryj/data.txt");  
    int n,m;  
    in>>n>>m;
    init(n+1);  
    int u, v, w;  
    for (int i = 0; i < m; i++) {

        in >> u >> v >> w;  
        addedge(u, v, 1, w);  
        addedge(v, u, 1, w);//题目中是无向图  
    }  
    addedge(0, 1, 2, 0);  
    addedge(n, n + 1, 2, 0);  
    int ans = mincost(0, n + 1);  
    cout<<ans<<endl;    
    return 0;  
}  