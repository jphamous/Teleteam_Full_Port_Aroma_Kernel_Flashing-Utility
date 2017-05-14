#!/sbin/sh

mount /dev/block/sda14 /system
mount /dev/block/sda16 /data
mount /dev/block/sda3 /efs

# Restoring The EFS
/sbin/busybox dd if=/sdcard/EFS_BACKUP/efs.img of=/dev/block/sda3 bs=4096

unmount /system
unmount /data
unmount /efs

exit 10