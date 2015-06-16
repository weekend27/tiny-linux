cmd_arch/x86/boot/header.o := gcc -Wp,-MD,arch/x86/boot/.header.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-linux-gnu/4.9/include -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include -Iarch/x86/include/generated/uapi -Iarch/x86/include/generated  -I/home/weekend27/diff_test/save/linux-4.0.4/include -Iinclude -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/uapi -Iarch/x86/include/generated/uapi -I/home/weekend27/diff_test/save/linux-4.0.4/include/uapi -Iinclude/generated/uapi -include /home/weekend27/diff_test/save/linux-4.0.4/include/linux/kconfig.h -D__KERNEL__ -m16 -g -Os -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -fno-strict-aliasing -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse -ffreestanding -fno-stack-protector -D_SETUP -D__ASSEMBLY__ -DSVGA_MODE=NORMAL_VGA  -I/home/weekend27/diff_test/save/linux-4.0.4/arch/x86/boot -Iarch/x86/boot   -c -o arch/x86/boot/header.o /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/boot/header.S

source_arch/x86/boot/header.o := /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/boot/header.S

deps_arch/x86/boot/header.o := \
    $(wildcard include/config/efi/stub.h) \
    $(wildcard include/config/x86/32.h) \
    $(wildcard include/config/physical/align.h) \
    $(wildcard include/config/relocatable.h) \
    $(wildcard include/config/x86/64.h) \
    $(wildcard include/config/efi/mixed.h) \
    $(wildcard include/config/efi.h) \
    $(wildcard include/config/kexec.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/asm/segment.h \
    $(wildcard include/config/kernel/mode/linux.h) \
    $(wildcard include/config/smp.h) \
    $(wildcard include/config/cc/stackprotector.h) \
    $(wildcard include/config/paravirt.h) \
    $(wildcard include/config/tracing.h) \
    $(wildcard include/config/x86/32/lazy/gs.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/include/uapi/linux/const.h \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/asm/cache.h \
    $(wildcard include/config/x86/l1/cache/shift.h) \
    $(wildcard include/config/x86/internode/cache/shift.h) \
    $(wildcard include/config/x86/vsmp.h) \
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
    $(wildcard include/config/x86/alignment/16.h) \
  include/generated/utsrelease.h \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/asm/boot.h \
    $(wildcard include/config/physical/start.h) \
    $(wildcard include/config/kernel/bzip2.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/asm/pgtable_types.h \
    $(wildcard include/config/kmemcheck.h) \
    $(wildcard include/config/mem/soft/dirty.h) \
    $(wildcard include/config/x86/pae.h) \
    $(wildcard include/config/proc/fs.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/asm/page_types.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/linux/types.h \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/arch/dma/addr/t/64bit.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/include/uapi/linux/types.h \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/uapi/asm/types.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/uapi/asm-generic/types.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/asm-generic/int-ll64.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/uapi/asm-generic/int-ll64.h \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/uapi/asm/bitsperlong.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/asm-generic/bitsperlong.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/uapi/asm-generic/bitsperlong.h \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/asm/page_64_types.h \
    $(wildcard include/config/kasan.h) \
    $(wildcard include/config/randomize/base.h) \
    $(wildcard include/config/randomize/base/max/offset.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/asm/pgtable_64_types.h \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/asm/sparsemem.h \
    $(wildcard include/config/sparsemem.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/uapi/asm/boot.h \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/asm/e820.h \
    $(wildcard include/config/hibernation.h) \
    $(wildcard include/config/memtest.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/uapi/asm/e820.h \
    $(wildcard include/config/nodes/shift.h) \
    $(wildcard include/config/intel/txt.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/include/linux/ioport.h \
    $(wildcard include/config/memory/hotremove.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/asm/setup.h \
    $(wildcard include/config/x86/intel/mid.h) \
    $(wildcard include/config/x86/intel/ce.h) \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/uapi/asm/setup.h \
  /home/weekend27/diff_test/save/linux-4.0.4/include/linux/pfn.h \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/include/uapi/asm/bootparam.h \
  /home/weekend27/diff_test/save/linux-4.0.4/arch/x86/boot/boot.h \
  arch/x86/boot/voffset.h \
  arch/x86/boot/zoffset.h \

arch/x86/boot/header.o: $(deps_arch/x86/boot/header.o)

$(deps_arch/x86/boot/header.o):
