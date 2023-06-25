obj-m += dl.o
dl-objs := bitmap.o itree_v1.o itree_v2.o namei.o inode.o file.o dir.o

KDIR ?= /lib/modules/$(shell uname -r)/build

all: mkfs.dl
	make -C $(KDIR) M=$(PWD) modules

mkfs.dl:
	gcc -O2 -o mkfs.dl mkfs/disk-utils/mkfs.minix.c mkfs/lib/blkdev.c \
	mkfs/lib/ismounted.c mkfs/lib/strutils.c -I mkfs/include -DHAVE_FSYNC \
	-DHAVE_NANOSLEEP

clean:
	make -C $(KDIR) M=$(PWD) clean
	rm -f *~ $(PWD)/*.ur-safe
	rm -f mkfs.dl

.PHONY: all clean
