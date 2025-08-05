---
title: 爬虫开发+APP逆向超级大神班
author: 临渊
date:
  - 2025-07-19 16:29:38
tags:
  - 路飞
category:
  - 培训班
cover: https://cover.png
feature: false
---
## 一、Python语法

>字符串  “”
>列表 []
>元组()
>集合{}          s = set()
>字典{key:value, key2:value, key3:value}   dic = dict()


字节
        1. ascii: 8bit, 1byte
        2. gbk: 16bit,  2byte  windows默认
        3. unicode: 32bit, 4byte(没法用, 只是一个标准)
        4. utf-8:       mac默认
            英文: 8bit, 1byte
            欧洲: 16bit, 2byte
            中文: 24bit, 3byte
### 闭包
---
闭包: 本质, 内层函数对外层函数的局部变量的使用. 此时内层函数被称为闭包函数
   1. 可以让一个变量常驻与内存
   2. 可以避免全局变量被修改
```python
def func():
    a = 10
    def inner():
        nonlocal a
        a += 1
        return a
    return inner
```

### 装饰器
---


