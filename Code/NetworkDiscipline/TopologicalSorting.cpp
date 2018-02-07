#include <iostream>
#include <fstream>  
#include <stack>  
#include <vector>  
#include <list>  
using namespace std;  
  
vector< list<int> > Adj; //邻接表  
vector<int> inDegree; //保存每个节点的入度  
stack<int> stk; //保存当前入度为0的节点编号  

void tpSort() {

    vector<int> vec;  
    int v;  
    while (!stk.empty()) {

        v = stk.top();  
        stk.pop();  
        //inDegree[v] = -1;  
        //遍历与节点v相连的节点  
        for (auto it = Adj[v].begin(); it != Adj[v].end(); it++) {

            inDegree[*it]--;  
            if (inDegree[*it] == 0) stk.push(*it);  
        }  
        vec.push_back(v);  
    }  
    if (vec.size() != inDegree.size()) {

        cout<<"图中存在环路，不能进行拓扑排序"<<endl;  
        exit(0);  
    }  
    for (auto item : vec)  
        cout<<item<<" ";  
    cout<<endl;  
}  
int main() {

    // 第一行输入两个整数n和m，n表示途中节点数，m表示图中边数；
    // 接下来输入m行，每一行有两个整数v1和v2，v1和v2分别代表编号为v1、v2的节点，每行代表一条由v1指向v2的边（节点编号从0开始);
    ifstream in("/Users/tinoryj/data.txt");  
    int n, m, v1, v2;  
    in>>n>>m;  
    Adj.assign(n, list<int>());  
    inDegree.assign(n, 0);  
    while (m--) {

        in >> v1 >> v2;  
        Adj[v1].push_back(v2);  
        inDegree[v2]++;  
    }  
    for (int i = 0; i < n;i++)  
        if (inDegree[i] == 0) stk.push(i);  
    tpSort();  
    return 0;  
}  