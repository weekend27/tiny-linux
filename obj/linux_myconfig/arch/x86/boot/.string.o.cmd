cmd_arch/x86/boot/string.o := gcc -Wp,-MD,arch/x86/boot/.string.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-linux-gnu/4.9/include -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include -Iarch/x86/include/generated/uapi -Iarch/x86/include/generated  -I/home/weekend27/diff_test/save/linux-4.0.4/include -Iinclude -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/uapi -Iarch/x86/include/generated/uapi -I/home/weekend27/diff_test/save/linux-4.0.4/include/uapi -Iinclude/generated/uapi -include /home/weekend27/diff_test/save/linux-4.0.4/include/linux/kconfig.h  -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/boot -Iarch/x86/boot -D__KERNEL__ -m16 -g -Os -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -fno-strict-aliasing -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse -ffreestanding -fno-stack-protector -D_SETUP    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(string)"  -D"KBUILD_MODNAME=KBUILD_STR(string)" -c -o arch/x86/boot/string.o /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/boot/string.c

source_arch/x86/boot/string.o := /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/boot/string.c

deps_arch/x86/boot/string.o := \
  /home/weekend27/diff_test/save/linux-4.0.4/include/linux/types.h \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/arch/dma/addr/t/64bit.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
    $(wildcard include/config/64bit.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/include/uapi/linux/types.h \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/uapi/asm/types.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/uapi/asm-generic/types.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/asm-generic/int-ll64.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/uapi/asm-generic/int-ll64.h \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/uapi/asm/bitsperlong.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/asm-generic/bitsperlong.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/uapi/asm-generic/bitsperlong.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/uapi/linux/posix_types.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/linux/stddef.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/uapi/linux/stddef.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
    $(wildcard include/config/kprobes.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/include/linux/compiler-gcc.h \
    $(wildcard include/config/arch/supports/optimized/inlining.h) \
    $(wildcard include/config/optimize/inlining.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/include/linux/compiler-gcc4.h \
    $(wildcard include/config/arch/use/builtin/bswap.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/asm/posix_types.h \
    $(wildcard include/config/x86/32.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/uapi/asm/posix_types_64.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/uapi/asm-generic/posix_types.h \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/boot/ctype.h \

arch/x86/boot/string.o: $(deps_arch/x86/boot/string.o)

$(deps_arch/x86/boot/string.o):
