---
title: CUPS
author: 临渊
date:
  - 2024-08-09 13:33:28
tags:
  - cups
  - 网络打印
  - opwrt
category:
  - 折腾
feature: false
---


# 一、打印功能

家里有一台 HP LaserJet M1005 MFP 古董打印机，只有usb接口，本来是通过windows电脑实现家庭局域网共享的。在电脑上安装Air Printert软件，可以实现苹果手机无线打印。不过每次打印都要开电脑，比较麻烦。也不可能为了个打印机电脑24小时开机。最近折腾了一下，通过N1盒子安装cups，实现了无线打印，记录一下，以免以后自己忘了怎么操作。

过程主要参考恩山论坛大佬jysky的文章[《[N1盒子] docker安装cups让打印机实现无线打印（支持PC、IOS、安卓airprint）》](https://www.right.com.cn/forum/thread-8220309-1-1.html)

另外还参考了这篇文章：openwrt软路由（x86）做打印服务器，用docker安装cups/airprint_NAS存储_什么值得买

将打印机连接到N1的usb接口。

进入openwrt——系统——TTYD终端，输入以下代码：

```bash
docker run \
       --name=cups \
       --restart=always \
       --net=host \
       -v /var/run/dbus:/var/run/dbus \
       -v ~/airprint_data/config:/config \
       -v ~/airprint_data/services:/services \
       --device /dev/bus \
       --device /dev/usb \
       -e CUPSADMIN="admin" \
       -e CUPSPASSWORD="password" \
       jysky007/cups:v1
```


此容器只支持N1、贝壳云、我家云、粒子云、等arm处理器的机器。

浏览器打开192.168.XXX.XXX:631 （前面为N1盒子ip地址，端口631）进入cups管理界面。cups的默认用户名和密码是print/print，不过看上面的代码，大佬已经把用户名和密码改成admin/password了。

之后点击Add Printer，选择自己的打印机，再选择驱动，N1等ARM处理器的要选带Foomatic/foo2xqx字样的驱动，别的驱动是适配X86的。

![img](https://raw.githubusercontent.com/anaconda110/MyPic/img/img/a0661f0e6e3ef787932c54e8100a4a79.png)

后面全部默认，最后完成打印机添加。

大佬的帖子中PC端直接搜索打印机就能搜到，我自己的情况不行，需要手动添加，win7和win10方法一样：

设备和打印机——添加打印机——添加网络、无线或Bluetooth打印机——我需要的打印机不再列表中——按名称选择共享打印机——http://192.168.XXX.XXX:631/printers/HP_LaserJet_M1005——添加驱动。 

如果windows提供的列表中没有匹配的驱动（比如我的古董打印机），可以去[Microsoft Update Catalog](http://catalog.update.microsoft.com/) 搜索打印机型号，我搜索的是M1005，选择合适的驱动下载。



下载下来的cab文件解压缩，里边包含inf安装文件。

接着上面的添加驱动——从磁盘安装——浏览找到cab文件里的HPLJM1005.INF——完成驱动安装。如此windows电脑端打印机就添加成功了。

HP打印机的驱动安装方法可以参考下面的文章：HP LaserJet - 在 Windows 10 电脑上，通过网络安装面向 HP 打印机的 Windows 驱动程序 | HP®客户支持

iOS端能直接搜索到打印机，不用安装第三方软件。没有安卓手机，未测试，大佬帖子里说也能直接搜到。

最后，大佬帖子中提到打印机如果断电再开机， 发送打印任务就无法打印了，必须重启cups。

# 二、扫描功能

最近发现上述操作只能实现无线打印，但无法使用扫描功能。网上搜了一下，也有能实现扫描的docker镜像，是通过SANE实现的。

网址如下，里面有详细介绍：

https://github.com/sbs20/scanservjs

项目SANE的网址如下：

[SANE - Scanner Access Now Easy](http://www.sane-project.org/)

安装方法一样，进入openwrt——系统——TTYD终端，输入以下代码：



```bash
docker pull sbs20/scanservjs:latest
docker rm --force scanservjs-container 2> /dev/null
docker run -d \
  -p 8080:8080 \
  -v /var/run/dbus:/var/run/dbus \
  --net=host \  #此行是我自己添加的，默认bridge模式貌似无法访问，改成host模式可行
  --restart unless-stopped \
  --name scanservjs-container \
  --privileged sbs20/scanservjs:latest
```


浏览器打开192.168.XXX.XXX:8080 （前面为N1盒子ip地址，端口8080）进入扫描管理界面，即可直接扫描。

另外docker网络模式参看下文：[Docker学习：容器五种(3+2)网络模式 | bridge模式 | host模式 | none模式 | container 模式 | 自定义网络模式详解_docker的五种网络模式总结_血煞长虹的博客-CSDN博客](https://blog.csdn.net/succing/article/details/122433770?spm=1001.2014.3001.5506)

# 三、常见问题

问题1：打印机一旦关机再开机默认就不能用了，必须重新去luci里面重启cups服务才行，如何解决？

/etc/hotplug.d/usb/10-usb_printer文件里面添加

```bash
sleep 10
    /root/cupsstart.sh
```

然后到/root目录添加脚本cupsstart.sh

```bash 
#!/bin/sh
docker restart cups
```


把脚本的权限改为0777

问题2：N1在openwrt的docker中运行的cups，如何实现开启打印机自动启动？

第一步：找到目录/etc/hotplug.d/usb，里面有一个10-usb_printer的文件，使用命令：



```bash
vi /etc/hotplug.d/usb/10-usb_printer
```



打开文件后修改里面的内容为：

```bash
if [ x"$INTERFACE" = x"7/1/1" ] || [ x"$INTERFACE" = x"7/1/2" ]; then
        /usr/bin/usb_printer_hotplug "$PRODUCT" "$ACTION"
              sleep 10
                  /root/cupsstart.sh
fi
```


第二步：进入root目录，新建cupsstart.sh文件，命令为：vi cupsstart.sh，然后修改其内容为

```bash
#!/bin/sh
docker restart cups
```

保存，设置文件权限为0775，命令为：```chmod 0775 cupsstart.sh```
第三步，把打印机关闭后再开机，等待十几秒后，再看看是不是又可以愉快的打印了！
此方法在打印机开机时，会触发docker中的cups自动运行，关机时，cups也会自动运行，但是因为找不到打印机，所以此时的cups是不能正常工作的，相当于打印机关机的效果。

问题3：docker容器时区不对导致时间不对

最近又遇到一个问题，docker容器部署cups，发现时间少了8个小时，于是想到是docker容器的内部时区问题。docker容器一般是debian系统，默认是UTC标准时间。可通过以下命令修改docker时区：

```bash
# 1.先进容器内部
docker exec -it 容器ID bash   
# 2.设置上海时间
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```
如果进入容器修改的时候总是报/etc/localtime 文件只读，不让修改，也可以用以下命令：

```docker cp /etc/localtime:容器ID/etc/localtime```
