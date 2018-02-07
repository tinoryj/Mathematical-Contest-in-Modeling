# 网络科学通用算法

### 图与网络-C++
1. [最短路径](./ShortestPath.cpp)
2. [拓扑排序](./TopologicalSorting.cpp)
3. [最大流](./EdmondKarpMaximumFlow.cpp)
4. [最小费用最大流](./MinimumCostLargestFlow.cpp)
5. [最小生成树](./MinimumSpanningTree.cpp)

### 信息传播(SIR模型)-Matlab


SIR传染病模型，也就是三个微分方程:
$$
\frac{dS}{dt} = -aS(t)I(t)
$$

$$
\frac{dI}{dt} = aS(t)I(t) - bI(t)
$$

$$
\frac{dR}{dt} = bI(t)
$$

其中中的S表示易感者，I表示感染者，R表示移出者。a表示易感者的感染概率，b表示感染者的恢复概率,也就是移出率。

```
function y=ill(t,x)
    a=1;
    b=0.3;
    y=[a*x(1)*x(2)-b*x(1),-a*x(1)*x(2)]';
    ts=0:50;
    x0=[0.02,0.98];
    [t,x] = ode45('ill',ts,x0);
    plot(t,x(:,1),t,x(:,2))
    grid
    pause
    plot(x(:,2),x(:,1)),grid on;
end
```


