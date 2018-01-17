# Mathematical-Contest-in-Modeling

## Main Object

- [MCM algorithm template with Matlab](/Code)

- [优秀论文集Excellent essaies](/Excellent-essaies.md)

- [Basic Models in MCM](/BasicModelsinMCM)

## Content

> 本章节内容中NaN代表不适用通用模型/代码框架-需根据实际问题进行编程。

### 目标规划问题

> Optimization Toolbox (GUI)

#### 线性规划

函数格式:

```
[x,fval] = linprog(f,a,b,a1,b1,xstart,xend)
```

`f`:求解最小函数的表达式系数矩阵是`m*1`的矩阵
`a`:≤不等式条件约束矩阵其均为形式
`b`:a对应不等式右边的常数项
`a1`:=等式条件约束矩阵
`b1`:a1对应不等式右边的常数项
`xstart`:x的取值范围的最小值的系数矩阵为`n*1`的矩阵
`xend`:x的取值范围的最大值的系数矩阵为`n*1`的矩阵
函数说明:不存在的项填写[]即可


#### 整数规划

函数格式:

```
[x,fval,exitflag,output] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub,options)
```

>用于进行整数规划和整数非整数的混合规划

`f`:为规划目标
`intcon`:为包含整数变量下标的向量
`A`、`b`:不等式约束条件
`Aeq`、`Beq`:等式约束条件

> `intcon`参数:包含整数变量下标的向量，即规划变量{x1，x2，x3，...，xn}中哪一项是整数，intcon里就加上哪一项。如x2，x3是整数，`intcon=[2 3]`。



#### 非线性规划

函数格式：

```
fmincon(‘fun’,x0,A,b,Aeq,beq,lb,ub,’nonlinearcondition’)
```

`fun`:目标函数(以求最小值为目标函数)
`x0`:最优解迭代的初始值
`A`,`b`:线性约束不等式`A*x<= b`
`Aeq`,`beq`:线性约束等式`Aeq*x = beq`
`lb`,`ub`:自变量的上下界
`nonlinearcondition`:非线性约束函数，它有两个返回值，其中一个为非线性不等式约
束，另一个是非线性等式约束


### 动态规划

- NaN


### 图论/网络

#### Matlab计算前准备

##### 构建图的稀疏矩阵

```
G = sparse(R,C,W);
```

> 行向量R（边起点），列向量C（边终点），边权值W（与R、C次序对应）

```
G = sparse(W);
for i=1:length(W)
    for j=1:length(W)
        if G(i,j) == inf
            G(i,j) = 0;
        end
    end
end
```

> W为图的邻接矩阵

##### 查看结构图

```
view(biograph(G,[],'ShowW','ON'))
```



### 相关算法的使用

- 最短路径（内置）

```
[dist path]=graphshortestpath(G,start,end)
```

求图G中start点到end点的最短路径，返回值dist为最短路径权值和，path为其路径。

```
graphallshortestpaths(G)
```

求图G中任意两点的最短路径，结果为权值和矩阵


- 最小生成树（内置）

```
[ST,pred] = graphminspantree(G)
```
ST为取出的边及其权值

- 最小费用最大流（内置）

```
[M,F,C]=graphmaxflow(G,start,end)
```

求图G中start点到end点的最大流，返回值M为最大流，F为其方案，C为其最小割集。


- AOE图的关键路径（非内置 | [criticalPath](/Code/criticalPath.m)）


```
[earliestST, latestET, route, freetime, worktime] = criticalPath(G)
```


 
### 排队论

该部分形成3\*4\*4种组合（模拟法编程）

- 三种制度
    - 损失制
    - 等待制
    - 混合制
- 四种服务
    - 先到先服务
    - 后到先服务
    - 随机服务
    - 优先服务
- 服务台结构
    - 单服务台
    - 多服务台并行
    - 多服务台串行
    - 混合

#### 模拟方法

[模拟方法-有服务优先级](/Code/sim_multiserver_proi.m)

[模拟方法-无服务优先级](/Code/sim_multiserver.m)

#### 理论计算

[在线排队论主要模型计算](http://www.supositorio.com/rcalc/rcalclite.htm)

>为了避免使用时该网站无法正常访问，所有资源保存在[在线排队论主要模型计算-资源](/Code/Queueing-theory-models-calculator-files.zip)

### 对策论

- NaN


### 层次分析法

- NaN


### 插值与拟合

#### Matlab自带插值方法

```
y = interp1(x, y, xx, 'TYPE')
```

>其中x，y为原有数据点的坐标，xx为插值间隔与插值的点的x坐标）

当TYPE关键字缺省时，为默认的分段线性插值。
`TYPE = nearest` 为临近值插值
`TYPE = spline` 为分段三次样条插值
`TYPE = pchip`、`TYPE = cubic` 为保形分段三次插值

#### 其他插值算法

- 拉格朗日多项式插值
    
    waiting。。。。。

- 牛顿插值

 相较于拉格朗日插值具有承袭性

 [newton插值](/Code/newtonInterp.m)

- Hermite插值

 Hermite插值满足在节点上等于给定函数值，而且在节点上的导数值也等于给定的导数值。 

 [Hermite插值](/Code/HermiteInterp.m)



### 数据统计/分析

- Statistics Toolbox
- SPSS (IBM Statistics software)

### 方差分析

####  单因素方差分析

```
[P,ANOVATAB,STATS] = anova1(X) 
```

根据样本观测值矩阵X进行单因素一元方差分析，检验矩阵X的各列所对应的总体是否具有相同的均值，原假设是X的各列所对应的总体具有相同的均值。输出参数p是检验的p值，对于给定的显著性水平，如果p<=显著性水平，则拒绝原假设，认为X的各列所对应的总体具有不完全相同的均值，否则接受原假设，认为X的各列所对应的总体具有相同的均值。

生成2个图形：标准的单因一元方差分析表和箱线图

#### 双因素方差分析

```
[P,ANOVATAB,STATS] = anova2(X,reps) 
```

根据样本观测值矩阵X进行均衡实验的双因素一元方差分析。X的每一列对应因素A的一个水平，每行对应因素B的一个水平，X还应满足方差分析的基本假定。reps表示因素A和B下的每一个水平组合下重复实验的次数。
  
原假设为：
`H0A`:X的各列具有相同的均值（或因素A对实验指标的影响不显著）
`H0B`:X的各行有相同的均值（或因素B对实验指标的影响不显著）
`H0AB`:A和B的交互作用不显著

返回检验的p值，若参数reps的取值等于1，则p是一个包含2个元素的行向量；若参数是reps的取值大于1，则p是一个包含3个元素的行向量，其元素粉笔是与H0A，H0B，H0AB对应的检验的p值。当检验的p值小于或等于给定的显著性水平时，应拒绝原假设。
  


### 回归分析


#### 线性回归

- 一元线性
- 多元线性
- 多项式回归

以上三种回归可统一使用以下函数：

```
[B,BINT,R,RINT,STATS] = regress(Y,X,ALPHA)
```

`B`: 回归系数向量
`BINT`: 回归系数的区间估计
`R`: 残差
`RINT`: 置信区间
`STATS`: 用于检验回归模型的统计量。有4个数值：判定系数R^2，F统计量观测值，检验的p的值，误差方差的估计
`ALPHA`: 显著性水平（缺少时为默认值0.05）




#### 逐步回归

```
stepwise(X,Y)
```
使用方法与`regress`函数相同


### 微分方程建模

- NaN


### 稳定状态模型

- NaN

### 常微分方程模型

- 常微分方程数值解
    - Euler
    - Runge-Kutta

- 常微分方程分析解（内置函数）

### 差分方程模型

- 差分方程求解（算法/工具）
    - 蛛网模型
    - 遗传模型

    
### 马式链模型

- Matlab hmm toolbox

参考资料：[隐马尔科夫模型matlab工具箱说明](http://blog.csdn.net/whiteinblue/article/details/40625291)


### 变分法模型

- NaN 

### 神经网络模型

- Matlab BP工具箱
- Tensorflow （Python）

### 偏微分方程数值解

- 差分解法
- pdetool 解法


### 模糊数学

- 模糊集合计算
 
#### ToolBox

```
fuzzy
```

#### 相关中文资料

[Matlab模糊控制工具箱](http://blog.sina.com.cn/s/blog_86186c970102wbc2.html)


### 优化算法

- 模拟退火算法
- 遗传算法
- 禁忌搜索算法
- 蚁群算法


### 时间序列

- 移动平均

 [movAverage](/Code/movAverage.m)

- 指数平滑

    - 一次指数平滑
    
     [indexSmooth1](/Code/indexSmooth1.m)
    - 二次指数平滑

     [indexSmooth2](/Code/indexSmooth2.m)
    - 三次指数平滑

     [indexSmooth3](/Code/indexSmooth3.m)


- 自适应滤波

 [AdaptiveFilter](/Code/AdaptiveFilter.m)


### 存贮论

**参照目标规划问题，根据实际情况编程**

- 无约束确定型存贮(NaN)
- 有约束确定型存贮(NaN)

>资料第25章内容

### 经济/金融分析

- NaN

### 生产服务分析

- NaN


### 灰色系统

- 因素关联度（子因素与母因素的关联度）

    [GMCorrelation](/Code/GMCorrelation.m)

- GM(2,1)

    适用于非单调的摆动发展序列或具有饱和状态的S形序列
    
    [GM(2,1)](/Code/GM21.m)
    
    
- GM(1,1)

    适用于具有较强指数规律的序列，只能描述单调的变化过程
    
    [GM(1,1)](/Code/GM11.m)
    
- GM(0,N)

    GM(0,N)模型不含导数，为静态模型
    
    [GM(0,N)](/Code/GM0N.m)

### 多元分析

#### 工具与方法

- SPSS - 导入数据后，在GUI界面上点击即可
- Matlab

#### 相关内容(Matlab)

- 样本距离计算

    ```
    样本点(0,0)、(1,0)、(0,2)
    X = [0 0 ; 1 0 ; 0 2]
    ```
    
    - 欧式距离

    ```
    D = pdist(X,'euclidean')
    ```
    
    - Chebyshev距离

    ```
    D = pdist(X, 'chebychev')
    ```
    
    - 马式距离

    ```
    D = pdist(X,'mahalanobis')
    ```
    
    - 闵可夫斯基距离（组间距离）

    ```
    D = pdist(X,'minkowski',2)
    ```
    
    - 曼哈顿距离（城市街区街区距离）
    
    ```
    D = pdist(X, 'cityblock')
    ```
    
    - 标准化欧氏距离
    
    ```
    D = pdist(X, 'seuclidean',[0.5,1])
    ```
    
    - 相关距离/相关系数

    ```
    C = corrcoef( X' );
    D = pdist( X , 'correlation');
    ```
    其中C返回相关系数矩阵，D返回相关距离
    
- 类间相似度
    - 最短距离法
    - 最长距离法
    - 重心法
    - 类平均法
- 系统聚类方法
- 变量聚类方法
- 主成分分析
- 因子分析
- 距离判断
    - Mahalanobis距离
    - Fisher判别
    - Bayes判别


### 偏最小二乘

- 偏最小二乘回归

    偏最小二乘回归≈多元线性回归分析+典型相关分析+主成分分析

    [偏最小二乘回归(pzRegress)](/Code/pzRegress.m)


