#include <iostream>
#include <vector>
#include <cstdio>
#include <fstream>
using namespace std;

typedef int DATA_TYPE;  // 权值为int型
const DATA_TYPE NO_EDGE = 0x3f3f3f;  // 表示没有该边

// 图的结构体定义
struct MatrixGraph {

    vector<vector<DATA_TYPE> > weights;
    int vertexNum;  // 其实定义了邻接矩阵，这个也可以省
};

// 路径格式转换(从点对链接式转换到序列式)
vector<int> getVisitPath(vector<int> path, int startNode, int endNode) {

    vector<int> visitPath;
    visitPath.push_back(endNode);

    if (path[endNode] != -1) {

        while (path[endNode] != startNode) {

            visitPath.insert(visitPath.begin(), path[endNode]);
            endNode = path[endNode];
        }
    }

    visitPath.insert(visitPath.begin(), startNode);
    return visitPath;
}

// 输出各条最短路径
void displayPath(vector<DATA_TYPE> distance, vector<int> path, int startNode) {

    for (size_t i = 0; i < path.size(); i++) {

        // 排除自己和自己 以及 不可达的路径
        if (i != startNode && distance[i] < NO_EDGE) {

            vector<int> visitPath = getVisitPath(path, startNode, i);
            cout << "From " << visitPath[0] << " to " << visitPath[visitPath.size() - 1] << "||  ";
            cout << "Distance: " << distance[i] << "  ||  Path:  ";

            for (size_t j = 0; j < visitPath.size() - 1; ++j) {

                cout << visitPath[j] << "->";
            }
            cout << visitPath[visitPath.size() - 1] << endl;
        }
    }
}

// Dijkstra算法
vector<DATA_TYPE> dijkstra(vector<vector<DATA_TYPE> > weights, int startNode) {

    vector<DATA_TYPE> distance;  // 从源节点到其余各个节点的最短路径数组
    vector<int> path;  // 访问路径(点对)
    vector<int> S;  // 已访问的
    DATA_TYPE minDistance;  // 单次循环的最小值

    int vertexNum = weights.size();

    for (size_t i = 0; i < vertexNum; ++i) {

        // 最短路径初始化
        distance.push_back(weights[startNode][i]);
        // 已访问标记数组初始化
        S.push_back(0);  // 0表示未访问

        // 路径初始化
        if (weights[startNode][i] != NO_EDGE)

            path.push_back(startNode);  // 可达
        else

            path.push_back(-1);  // 不可达记为-1
    }

    S[startNode] = 1;  // 源节点放入S中
    path[startNode] = startNode;  // 路径开始为startNode 该值可随意

    size_t k;  // 最近顶点
    for (size_t i = 0; i < vertexNum; i++) {

        minDistance = NO_EDGE;
        for (size_t j = 0; j < vertexNum; j++) {

            if ((S[j] == 0) && (distance[j] < minDistance)) {

                k = j;
                minDistance = distance[j];
            }
        }
        S[k] = 1;  // 最小 则将顶点k加入S

        for (size_t j = 0; j < vertexNum; j++) {

            if (S[j] == 0) {
                // 对于所有与k相邻的节点(即可从k到达这些节点)
                if ((weights[k][j] < NO_EDGE) && (distance[k] + weights[k][j] < distance[j])) {
                    // 若新路径的长度小于最初判断时的长度，则更新
                    distance[j] = distance[k] + weights[k][j];
                    path[j] = k;  // 添加k到路径中
                }
            }
        }
    }
    // 输出路径情况
    displayPath(distance, path, startNode);
    return distance;
}


int main() {

    // 文件第一行:节点个数 
    // 文件后续内容:有向图的邻接矩阵
    freopen("/Users/tinoryj/data.txt", "r", stdin);
    // 图的初始化
    // 顶点编号必须为从0开始的连续的整数(若不是，先转换)
    MatrixGraph graph;
    int nodeNum;
    cin>>nodeNum;
    for (int i = 0; i < nodeNum; i++) {
        vector<DATA_TYPE> tmp;
        for (int j = 0; j < nodeNum; j++) {
            DATA_TYPE weight;
            cin>>weight;
            tmp.push_back(weight);
        }
        graph.weights.push_back(tmp);
        tmp.clear();
    }
    /*
    graph.weights.push_back(vector<DATA_TYPE>{0, 4, 6, 6, NO_EDGE, NO_EDGE, NO_EDGE});
    graph.weights.push_back(vector<DATA_TYPE>{NO_EDGE, 0, 1, NO_EDGE, 7, NO_EDGE, NO_EDGE});
    graph.weights.push_back(vector<DATA_TYPE>{NO_EDGE, NO_EDGE, 0, NO_EDGE, 6, 4, NO_EDGE});
    graph.weights.push_back(vector<DATA_TYPE>{NO_EDGE, NO_EDGE, 2, 0, NO_EDGE, 5, NO_EDGE});
    graph.weights.push_back(vector<DATA_TYPE>{NO_EDGE, NO_EDGE, NO_EDGE, NO_EDGE, 0, NO_EDGE, 6});
    graph.weights.push_back(vector<DATA_TYPE>{NO_EDGE, NO_EDGE, NO_EDGE, NO_EDGE, 1, 0, 8});
    graph.weights.push_back(vector<DATA_TYPE>{NO_EDGE, NO_EDGE, NO_EDGE, NO_EDGE, NO_EDGE, NO_EDGE, 0});
    */
    vector<DATA_TYPE> distance = dijkstra(graph.weights, 1);
    return 0;
}