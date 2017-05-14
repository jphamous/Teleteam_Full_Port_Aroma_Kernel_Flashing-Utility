#!/sbin/sh

mount /dev/block/sda14 /system
mount /dev/block/sda16 /data
mount /dev/block/sda3 /efs

# Creating Directories For EFS Backup Files

if [ ! -d /sdcard/EFS_BACKUP ];then
  mkdir /sdcard/EFS_BACKUP
  chmod 777 /sdcard/EFS_BACKUP
fi

# Backing Up The EFS
/sbin/busybox dd if=/dev/block/sda3 of=/sdcard/EFS_BACKUP/efs.img bs=4096

unmount /system
unmount /data
unmount /efs

exit 10