---
title: Markdown
date:
  - 2024-07-22 18:09:46
tags:
  - 语法
  - 基础
author: 临渊
categories:
  - 基础
cover: 
feature: true
---

# Markdown

## 字体

```
*斜体文本*
_斜体文本_
**粗体文本**
__粗体文本__
***粗斜体文本***
___粗斜体文本___
~~删除线~~
<u>带下划线文本</u>
[^要注明的文本]
```

## 分隔线

```
***

* * *

*****

- - -

----------
```

## Markdown 列表

 Markdown 支持有序列表和无序列表。
无序列表使用星号(*)、加号(+)或是减号(-)作为列表标记，这些标记后面要添加一个空格，然后再填写内容：

```
* 第一项
* 第二项
* 第三项

+ 第一项
+ 第二项
+ 第三项


- 第一项
- 第二项
- 第三项
```

有序列表使用数字并加上 . 号来表示，如：

```
1. 第一项
2. 第二项
3. 第三项
```

### 列表嵌套

列表嵌套只需在子列表中的选项前面添加两个或四个空格即可：

```
1. 第一项：
    - 第一项嵌套的第一个元素
    - 第一项嵌套的第二个元素
2. 第二项：
    - 第二项嵌套的第一个元素
    - 第二项嵌套的第二个元素
```

## Markdown 区块

Markdown 区块引用是在段落开头使用 > 符号 ，然后后面紧跟一个**空格**符号：

```
> 区块引用
> 菜鸟教程
> 学的不仅是技术更是梦想
```

另外区块是可以嵌套的，一个 > 符号是最外层，两个 > 符号是第一层嵌套，以此类推：

```
> 最外层
> > 第一层嵌套
> > > 第二层嵌套
```

### 区块中使用列表

```
> 区块中使用列表
> 1. 第一项
> 2. 第二项
> + 第一项
> + 第二项
> + 第三项
```

### 列表中使用区块

```
* 第一项
    > 菜鸟教程
    > 学的不仅是技术更是梦想
* 第二项
```

## Markdown 代码

### 函数或片段

如果是段落上的一个函数或片段的代码可以用反引号把它包起来（`），例如：

```
`printf()` 函数
```

### 代码区块

代码区块使用 **4 个空格**或者一个**制表符（Tab 键）**。

你也可以用 ``` 包裹一段代码，并指定一种语言（也可以不指定）



## Markdown 链接

```
[链接名称](链接地址)  或者   <链接地址>

这个链接用 1 作为网址变量 [Google][1]
这个链接用 runoob 作为网址变量 [Runoob][runoob]
然后在文档的结尾为变量赋值（网址）

  [1]: http://www.google.com/
  [runoob]: http://www.runoob.com/
```

## Markdown 图片

```
![RUNOOB 图标](https://static.jyshare.com/images/runoob-logo.png)
```

![RUNOOB 图标](https://static.jyshare.com/images/runoob-logo.png)

```
<img src="https://static.jyshare.com/images/runoob-logo.png" width="50%">
```

<img src="https://static.jyshare.com/images/runoob-logo.png" width="50%">

### Markdown 表格

Markdown 制作表格使用 | 来分隔不同的单元格，使用 - 来分隔表头和其他行

```
|  表头   | 表头  |
|  ----  | ----  |
| 单元格  | 单元格 |
| 单元格  | 单元格 |
```

### 对齐方式

```
| 左对齐 | 右对齐 | 居中对齐 |
| :-----| ----: | :----: |
| 单元格 | 单元格 | 单元格 |
| 单元格 | 单元格 | 单元格 |
```

## Markdown 高级技巧

### 支持的 HTML 元素

不在 Markdown 涵盖范围之内的标签，都可以直接在文档里面用 HTML 撰写。

目前支持的 HTML 元素有：`<kbd> <b> <i> <em> <sup> <sub> <br>`等 ，如：

```
使用 <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Del</kbd> 重启电脑
```

使用 <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Del</kbd> 重启电脑

### 转义

```
**文本加粗** 
\*\* 正常显示星号 \*\*
```

### 公式

**Markdown Preview Enhanced** 使用 [KaTeX](https://github.com/Khan/KaTeX) 或者 [MathJax](https://github.com/mathjax/MathJax) 来渲染数学表达式。

KaTeX 拥有比 MathJax 更快的性能，但是它却少了很多 MathJax 拥有的特性。你可以查看 KaTeX supported functions/symbols 来了解 KaTeX 支持那些符号和函数。

默认下的分隔符：

- `$...$` 或者 `\(...\)` 中的数学表达式将会在行内显示。
- `$$...$$` 或者 `\[...\]` 或者 ````math` 中的数学表达式将会在块内显示。

