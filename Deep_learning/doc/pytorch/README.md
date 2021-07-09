<!--ts-->
* [关于nn.Linear()的一点理解：](#关于nnlinear的一点理解)
* [计算机视觉](#计算机视觉)
   * [知识点记录](#知识点记录)
      * [保持输出不变](#保持输出不变)
      * [卷积核与全连层](#卷积核与全连层)
      * [特征图的生成过程](#特征图的生成过程)
   * [参考教程](#参考教程)
* [自然语言处理](#自然语言处理)
* [教程推荐](#教程推荐)
<!-- Added by: zwl, at: 2021年 6月22日 星期二 20时45分41秒 CST -->

<!--te-->
# 关于nn.Linear()的一点理解：

这里假设nn.Linear(3, 4), 表示输入的神经元个数为3， 输出的神经元个数为4，
后面4个神经元，每个都会被前面三个所连接。因此权重矩阵为(3, 4), 偏置的长度为4

因此nn.Linear就相当于矩阵变换,初始化一个权重矩阵，然后与输入向量相乘，输入为1\*3, 输出为1\*4

<a href="https://sm.ms/image/nIbV7M2JcyU6oBP" target="_blank"><img src="https://i.loli.net/2021/06/02/nIbV7M2JcyU6oBP.png" ></a>

# 计算机视觉

## 知识点记录

### 内核，步长，填充，通道数的作用

内核大小的作用：

- 在神经网络中， 我们通常使用奇数大小的卷积核如7\*7，9\*9, 卷积核的设置需要自
  己调节，如果认为数据中有比较小的特征，通常用小卷积核取卷积。如3\*3, 5\*5。较
  小的卷积核可以提取更多局部的特征，较大的卷积核可以提取比较有代表的特征.

填充的作用：

- 填充指的是padding，也就是在输入的两边填充0或者其他数值。这样的好处是可以保留
  数据的边缘特征.

步长的作用：

- 步长的作用主要是帮助减小输入的特征，如果除不尽的话，内部会做四舍五入的处理。

通道数:

- 通道越多，使用的滤波器也就越多，这样可以让模型学习更多特征。

池化层：

- 对数据进行下采样，如Maxpooling，会取数据中的最大值，降低数据的维度

批归一化：

- 通常归一化后的输入，经过神经网络中的某一层后，输入变得太大或太小，所以引入批
  量归一化

- 批归一化的位置：激活函数层如ReLU之后，dropout层之前

### 保持输出不变

- 我们在卷积神经网络中使用奇数高宽的核，比如3×3，5×5的卷积核，对于高度（或宽度）为大小为2k+1的核，令步幅为1，在高（或宽）两侧选择大小为k的填充，便可保持输入与输出尺寸相同。

- 要想输出为输入的一半，可以设置卷机核大小等于步长大小，padding 设置为0即可

### 卷积核与全连层

卷积层的输入和输出通常是四维数组（样本，通道，高，宽），而全连接层的输入和输出
则通常是二维数组（样本，特征）。如果想在全连接层后再接上卷积层，则需要将全连接
层的输出变换为四维，1×1卷积层可以看成全连接层，其中空间维度（高和宽）上的每个
元素相当于样本，通道相当于特征。因此，NiN使用1×1卷积层来替代全连接层，从而使空
间信息能够自然传递到后面的层中去。

### 特征图的生成过程

参考2，假如是RGB三个颜色通道，那么每个卷积核都是3通道的，每个通道对RGB分别卷积再相加，就变成一维度了，假如有3个卷积核，那么
最后输出三个特征图。

### 搭建CNN的技巧

参考：
https://towardsdatascience.com/a-guide-to-an-efficient-way-to-build-neural-network-architectures-part-ii-hyper-parameter-42efca01e5d7

1. 首先使用较小的卷积核来提取局部特征，然后使用较大的卷积核提取高级的，全局的
   特征
2. 刚开始使用比较少的通道来提取特征，然后慢慢增加通道数。通道学习时候，通常是
   保持通道数量不变
3. 如果数据的边缘信息觉得很重要，使用padding参数
4. 不断增加网络的层数，直到过拟合，然后使用dropout或者正则来减小过拟合。
5. 构建模型时候，使用结构 conv-pool-conv-pool or
   conv-conv-pool-conv-conv-pool的结构，通道数使用32-64-64 or 32-64-128

## 参考教程

参考:
1. https://tianchi.aliyun.com/course/337/3988
2. https://blog.csdn.net/xys430381_1/article/details/82529397
3. https://towardsdatascience.com/a-guide-to-an-efficient-way-to-build-neural-network-architectures-part-ii-hyper-parameter-42efca01e5d7

# 自然语言处理

## 神经网络正则化

参考：https://github.com/GokuMohandas/MadeWithML/blob/main/notebooks/06_Linear_Regression.ipynb

```
# 神经网络的正则化，其实是优化器的一个参数, 默认是0，就不带惩罚
optimizer = Adam(model.parameters(), lr=0.01, weight_decay=1e-2)
```

在数据量比较大的时候，使用惩罚可以防止过拟合，同时提高准确率

# 教程推荐

**这里有个教程挺好的：**

https://www.jianshu.com/u/898c7641f6ea

**官网教程查询：**

https://pytorch.org/docs/stable/index.html

**pytorch中文文档：**

https://pytorch-cn.readthedocs.io/zh/latest/package_references/torch-optim/