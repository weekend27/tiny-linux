# <center>my_tiny_linux</center>
*name:Huang Weijian     
*id:P14206019

#第一次工作(未裁剪版5862kB)
##1. 准备工作
裁剪内核过程中需要用到的一些库以及工具等，如果没有安装，在裁剪和编译过程将会提示出错，可以根据error log来安装。

    1). gcc (for building linux kernel and busybox)
    2). curl (for download)
    3). ncurses (for linux menuconfig)
        
新建工作文件夹tiny_linux，下载的源码和裁剪之后的内核都在该文件夹下。

    mkdir $HOME/tiny_linux
    cd $HOME/tiny_linux
        
下载最新版本的linux kernel 以及busybox，解压到当前文件夹。
或者：

    curl https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.0.4.tar.xz | tar xJf -    
    curl http://busybox.net/downloads/busybox-1.23.2.tar.bz2 | tar xjf -
         
##2. 编译内核
编译内核之前先新建一个文件夹obj，为了使得之前获取的源代码不被修改。
采用默认配置裁剪，由于我的机器是64位，所以选择的是x86_64_defconfig。

    cd $HOME/tiny_linux
    mkdir obj
    cd obj
    mkdir linux_defconfig
    cd $HOME/tiny_linux/linux-4.0.4
    make O=../obj/linux_defconfig x86_64_defconfig
        
完成之后，配置文件就被写入到$HOME/tiny_linux/obj/linux_defconfig，进入该目录，编译之。

    cd $HOME/tiny_linux/obj/linux_defconfig
    make
       
经历过漫长的编译后，看到下面的提示：

> Setup is 15676 bytes (padded to 15872 bytes). 

> System is 5862 kB

> CRC 2626b6c3

> Kernel: arch/x86/boot/bzImage is ready  (#1)

这样顺利就得到了5862kB的kernel Image。

    cp $HOME/tiny_linux/obj/linux_defconfig/arch/x86/boot/bzImage $HOME/tiny_linux/obj
    KERNEL=$HOME/tiny_linux/bzImage

##3.建立根文件系统
现在来关注到用户态，这个阶段将会使用到busybox。busybox结合了很多我们常见的UNIX工具形成了一个微型的可执行文件系统。许多GNU fileutils, shellutils等等都可以在busybox中找到替代品。我们就是要用它来替代裁剪掉的那部分命令。

首先去编译busybox：

    cd $HOME/tiny_linux
    mkdir obj/busybox
    cd $HOME/tiny_linux/busybox-1.23.2
    make O=../obj/busybox defconfig
        
要记住的是，配置busybox时要建立静态链接。
        
    make O=../obj/busybox/ menuconfig
        
在配置过程中，选择：

    Busybox Setting:
        Build Option
            Build Busybox as a static binary
        
然后，编译，安装。

    cd ../obj/busybox
    make 
    make install

可以简单运行busybox看看是否运行正确。

    ./busybox ls
        
成功的话，会显示出相应的busybox的各种文件。

下一步，要建立新的文件目录去保存所需要的文件系统层次结构，现在先把busybox复制进去。

    cd $HOME/tiny_linux
    mkdir ramdisk
    cd ramdisk
    cp -av $HOME/tiny_linux/obj/busybox/_install/* .

然后去创建一个简单的初始化脚本文件，用于调试。

    echo -e '#!/bin/sh \n /bin/sh' > init
    chmod +x init

然后将busybox作为初始化的文件，将整个文件系统打包成cpio文件。

    cd $HOME/tiny_linux/ramdisk
    find . -print0 | cpio --null -ov --format=newc | gzip -9 > $HOME/tiny_linux/obj/initramfs.cpio.gz
    RAMDISK=$HOME/tiny_linux/obj/initramfs.cpio.gz

用qemu虚拟机测试一下能否正常启动。

    qemu -kernel $KERNEL -initrd $RAMDISK

能够正常启动之后，看到如下信息：

> /bin/sh: can't access tty; job control turned off

这是由于我们的初始化系统只是启动一个脚本而没有进行一些必要的配置，下面就进行相应的配置。

##4.用户态：初始化与挂载

先将刚才测试的脚本删除，建立与busybox的符号链接，作为初始化文件。

    cd $HOME/tiny_linux/ramdisk
    rm init
    ln -s bin/busybox init
        
接下来建立一系列的目录：

    cd $HOME/tiny_linux/ramdisk
    mkdir -pv {bin,sbin,etc,proc,sys,usr/{bin,sbin},dev}
        
然后开始配置busybox：

    cd $HOME/tiny_linux/ramdisk
    cd etc
    vim inittab

将下面的内容写进去：

    ::sysinit:/etc/init.d/rcS

    ::askfirst:-/bin/sh

    ::restart:/sbin/init

    ::ctrlaltdel:/sbin/reboot

    ::shutdown:/bin/umount -a -r

    ::shutdown:/sbin/swapoff -a

现在去创建rcS：

    mkdir init.d
    cd init.d
    vim rcS

rcS的内容如下：

    #!/bin/sh

    mount proc
    mount -o remount,rw /
    mount -a

    clear                               
    echo "Welcome to Weekend27's Tiny Linux"

记得要：

    chmod +x rcS
        
从rcS中可以看到’mount -a‘，它会去检查etc/fstab，现在去创建它：

    cd $TOP/ramdisk/etc
    vim fstab

将下面的内容加进去：

    # /etc/fstab
    proc            /proc        proc    defaults          0       0
    sysfs           /sys         sysfs   defaults          0       0
    devtmpfs        /dev         devtmpfs  defaults          0       0
        
完成啦，现在再次进行打包，运行。

    cd $HOME/tiny_linux/ramdisk
    find . -print0 | cpio --null -ov --format=newc | gzip -9 > $HOME/tiny_linux/obj/initramfs.cpio.gz
    qemu -kernel $KERNEL -initrd $RAMDISK

在虚拟机上，看到如下信息：

    Welcome to Weekend27's Tiny Linux
    Please press Enter to activate this console.
        
进去系统之后，可以去查看相应的文件夹是否已经存在。

    ls /dev
    ls /proc
    ls /sys
    
最后看看ethernet card driver是不是正常工作：

    ifconfig -a
        
顺利地看到了eht0，说明ethernet card driver成功啦！
接下来将要进行network的配置。

![enter](https://github.com/weekend27/my_tiny_linux/raw/master/save/pic/pic1.png)

##5.网络配置

在刚才的rcS文件末尾加上下面这段代码：

    /sbin/ifconfig lo 127.0.0.1 up
    /sbin/route add 127.0.0.1 lo &

    ifconfig eth0 up
    ip addr add 10.0.2.15/24 dev eth0
    ip route add default via 10.0.2.2

搞定，重新打包，运行系统。

    cd $HOME/tiny_linux/ramdisk
    find . -print0 | cpio --null -ov --format=newc | gzip -9 > $HOME/tiny_linux/obj/initramfs.cpio.gz
    qemu -kernel $KERNEL -initrd $RAMDISK
        
进入系统之后，验证网络是否配置成功。（本地建立了端口为8000的服务器,根目录下有index.html文件）

    wget http://10.0.2.2:8000/index.html
        
显示成功，OK!

![network](https://github.com/weekend27/my_tiny_linux/blob/master/save/pic/pic2.png?raw=true)


##问题与小结
1). 要根据个人机器的不同选择不同的默认配置文件，我这里选择的是x86_64_defconfig。如果想要一个更小的linux kernel，可以选择加载allnoconfig，再在此基础上添加各个功能模块。

2). 编译内核出错时，我根据提示回到linux-4.0.4文件夹下面make mrproper一下，清除了各个链接关系，编译成功通过。

3). 创建init文件之后，由于没有修改文件执行权限，没有+x，导致在虚拟机中读取不出来。修改了chmod +x init就好了。

4). 每次修改了ramdisk里的内容，一定要记得将其重新打包，否则加载的还是上一个压缩包。一开始写完了rcS，没有进行网络配置，后来加上了网络配置代码，忘记了重新打包，找了好久才发现是没有重新打包（低级错误！！！）。

5). 在linux下建立本地服务器代码：python -m SimpleHTTPServer 8000，其中8000是自己设定的端口号。

#第二次裁剪linux kernel(984kB)chmod +x init
##修改配置
这次裁剪kernel不再使用defconfig，而是使用menuconfig，在menuconfig中导入我的配置文件.config。
这里的配置文件参考了杨海宇同学的配置文件，但是，由于杨海宇的配置文件是基于32位机器进行的，所以并不能直接拿来导入运行，在一些关键的地方，做了相应的修改，最终得到的系统大小是984kB，能够顺利地跑起来。

##问题与小结
1). 对configure文件的配置，很多时候需要一边google，一边参考别人的配置，一项一项的琢磨选还是不选，很耗时，不过在琢磨的过程中，也更加加深了对linux的理解。

2). driver部分我还不知道该如何优化和选择，有待以后研究源码。最终使用的系统是984kB。

3). 在裁剪后的系统里无法进行ping，究其原因是qemu的以太网驱动是不支持ICMP的。

#Kernel Mode Linux
参考：[http://www.yl.is.s.u-tokyo.ac.jp/~tosh/kml/](http://www.yl.is.s.u-tokyo.ac.jp/~tosh/kml/)

实验目的：在Linux内核态执行用户程序。在Kernel Mode Linux中，用户的程序可以作为用户进程进行，也同时拥有kernel mode的相应权限。

实验过程：

1). 下载参考网页提供的patch，将其放到984kB的kernel/source文件夹中。

2). 给内核打上补丁。命令行：patch -p1 < kml.diff   

3). 重新编译内核。

4). 在ramdisk文件夹中创建trusted文件夹，并将测试程序放入trusted路径中，进行测试。

测试程序：

    #include<stdio.h>
    int main(int argc, char*argv[])
    {
        __asm__ __volatile__("cli");
        int i;
        for (i = 0; i < 100000; i++)
        {
            printf("%d\n", i);
        }
        return 0;
    }

这段测试代码通过查看程序是否能够关中断来判断是否是内核权限。根据结果可知，测试代码在用户态下因为中断保护而无法执行，放在trusted里获得内核权限后可以执行，正确打印所有结果。

![kernel mode linux test](https://github.com/weekend27/my_tiny_linux/blob/master/save/pic/pic3.png?raw=true)
![test result](https://github.com/weekend27/my_tiny_linux/blob/master/save/pic/pic4.png?raw=true)

记得要在原来机器的ramdisk中先进行静态编译，要不然没法在虚拟机kernel中运行该程序。因为裁剪后的kernel里面缺少gcc，显然无法编译生成可执行文件。

    gcc -static test.c -o test

##问题和小结
1). 静态编译，否则没法在裁剪后的系统中执行。

2). 选择的测试代码有讲究，应该是在用户态中无法执行，但是在内核态中可以顺利执行，这样就说明了用户程序确实在内核态中执行了。

3). 通过这次linux kernel实验，学到了如何编译内核，裁剪内核，给内核打补丁，将用户程序泡在内核态等等，真正将操作系统通过实战理解得更深刻。










