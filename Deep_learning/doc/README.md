<!--ts-->
   * [关于nn.Linear()的一点理解：](#关于nnlinear的一点理解)

<!-- Added by: mikizhu, at: 2021年 6月 3日 星期四 16时23分15秒 CST -->

<!--te-->
## 关于nn.Linear()的一点理解：

这里假设nn.Linear(3, 4), 表示输入的神经元个数为3， 输出的神经元个数为4，
后面4个神经元，每个都会被前面三个所连接。因此权重矩阵为(3, 4), 偏置的长度为4

因此nn.Linear就相当于矩阵变换,初始化一个权重矩阵，然后与输入向量相乘，输入为1\*3, 输出为1\*4

<a href="https://sm.ms/image/nIbV7M2JcyU6oBP" target="_blank"><img src="https://i.loli.net/2021/06/02/nIbV7M2JcyU6oBP.png" ></a>


**这里有个教程挺好的：**

https://www.jianshu.com/u/898c7641f6ea

**官网教程查询：**

https://pytorch.org/docs/stable/index.html

**pytorch中文文档：**

https://pytorch-cn.readthedocs.io/zh/latest/package_references/torch-optim/