# <center>my_tiny_linux</center>
*name:Huang Weijian     
*id:P14206019

#第一次裁剪linux kernel
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






