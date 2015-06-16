cmd_arch/x86/realmode/rm/stack.o := gcc -Wp,-MD,arch/x86/realmode/rm/.stack.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-linux-gnu/4.9/include -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include -Iarch/x86/include/generated/uapi -Iarch/x86/include/generated  -I/home/weekend27/diff_test/save/linux-4.0.4/include -Iinclude -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/uapi -Iarch/x86/include/generated/uapi -I/home/weekend27/diff_test/save/linux-4.0.4/include/uapi -Iinclude/generated/uapi -include /home/weekend27/diff_test/save/linux-4.0.4/include/linux/kconfig.h -D__KERNEL__   -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include  -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/generated/uapi -Iarch/x86/include/generated/uapi  -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/generated -Iarch/x86/include/generated   -I/home/weekend27/diff_test/save/linux-4.0.4/include  -I/home/weekend27/diff_test/save/linux-4.0.4/include -Iinclude   -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/uapi  -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/generated/uapi -Iarch/x86/include/generated/uapi   -I/home/weekend27/diff_test/save/linux-4.0.4/include/uapi  -I/home/weekend27/diff_test/save/linux-4.0.4/include/generated/uapi -Iinclude/generated/uapi -include /home/weekend27/diff_test/save/linux-4.0.4/include/linux/kconfig.h -m16 -g -Os -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -fno-strict-aliasing -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse -ffreestanding -fno-stack-protector -D_SETUP -D_WAKEUP   -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/boot -D__ASSEMBLY__   -c -o arch/x86/realmode/rm/stack.o /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/realmode/rm/stack.S

source_arch/x86/realmode/rm/stack.o := /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/realmode/rm/stack.S

deps_arch/x86/realmode/rm/stack.o := \
  /home/weekend27/diff_test/save/linux-4.0.4/include/linux/linkage.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/64bit.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
    $(wildcard include/config/kprobes.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/include/linux/stringify.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/linux/export.h \
    $(wildcard include/config/have/underscore/symbol/prefix.h) \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/modversions.h) \
    $(wildcard include/config/unused/symbols.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/asm/linkage.h \
    $(wildcard include/config/x86/32.h) \
    $(wildcard include/config/x86/64.h) \
    $(wildcard include/config/x86/alignment/16.h) \

arch/x86/realmode/rm/stack.o: $(deps_arch/x86/realmode/rm/stack.o)

$(deps_arch/x86/realmode/rm/stack.o):
