#include <iostream>  
#include <fstream>  
#include <vector>  
#include <list>  
#include <queue>  
using namespace std;  
struct Node {  
    int v;  
    int w;  
    Node(int a, int b) :v(a), w(b){}  
};  
struct Edge {  
    int u;  
    int v;  
    int w;  
    Edge(int a, int b, int c) :u(a), v(b), w(c){}  
    friend bool operator<(const Edge& E1, const Edge& E2) {

        return E1.w>E2.w;  
    }  
};  

int n, m;  
vector<list<Node> > Adj;  
priority_queue<Edge> Q;  
  
int FindSet(vector<int>& uset, int v) {

    int i = v;  
    while (i != uset[i]) i = uset[i];  
    return i;  
}  

void Prim() {

    int Cost = 0; //用于统计最小生成树的权值之和  
    vector<Edge> SpanTree; //用于保存最小生成树的边  
    vector<int> uset(n,0); //用数组来实现并查集  
    Edge E(0, 0, 0);  
    for (int i = 0; i < n; i++) 
        uset[i] = i; //并查集初始化  
    for (auto it = Adj[0].begin(); it != Adj[0].end(); it++)   
        Q.push(Edge(0, it->v, it->w)); //根据Prim算法，开始时选取结点0，并将结点0与剩余部分的边保存在优先队列中  
    //循环中每次选取优先队列中权值最小的边，并更新优先队列  
    while (!Q.empty()) {

        E = Q.top();  
        Q.pop();  
        if (0 != FindSet(uset, E.v)) {

            Cost += E.w;  
            SpanTree.push_back(E);  
            uset[E.v] = E.u;  
            for (auto it = Adj[E.v].begin(); it != Adj[E.v].end(); it++)  
                if (0 != FindSet(uset, it->v)) Q.push(Edge(E.v, it->v, it->w));  
        }  
    }  
    cout<<"Result:\n";  
    cout<<"Cost: "<<Cost<<endl;  
    cout<<"Edges:\n";  
    for (int j = 0; j < SpanTree.size(); j++)  
        cout<<SpanTree[j].u<<" "<<SpanTree[j].v<<" "<<SpanTree[j].w<<endl;  
    cout<<endl;  
}  

int main() {

    // 第一行包含两个整数n和m，n表示图中结点个数，m表示图中边的条数；
    // 接下来m行，每一行包含三个整数u,v,w，表示途中存在一条边(u,v)，并且其权重为w；
    ifstream in("/Users/tinoryj/data.txt");  
    int u, v, w;  
    in>>n>>m;  
    Adj.assign(n, list<Node>());  
    for (int i = 0; i < m; i++) {

        in>>u>>v>> w;  
        Adj[u].push_back(Node(v,w));  
        Adj[v].push_back(Node(u,w));  
    }  
    Prim();  
    in.close();  
    return 0;  
} 