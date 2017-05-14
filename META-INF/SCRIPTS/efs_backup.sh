#!/sbin/sh
BACKUP_NAME=EFS_BACKUP_$(date +%d%b%Y-%H%M).tar.gz
if [ ! -d "/efs" ]; then mkdir /efs; fi
mount /data
mount -o rw,remount /data
grep_efs() {
	PATH_1=
	PATH_2=
	PATH_3=
	for EFS in $(cat /etc/$1 | grep -w "/efs"); do
		if [ -z "$PATH_1" ]; then
			PATH_1=$EFS
		elif [ -z "$PATH_2" ]; then
			PATH_2=$EFS
		elif [ -z "$PATH_3" ]; then
			PATH_3=$EFS
		fi
	done
}
grep_efs recovery.fstab
if [ "$PATH_1" = "/efs" ]; then mount $PATH_3 /efs; fi
if [ "$PATH_2" = "/efs" ]; then mount $PATH_1 /efs; fi
grep_efs fstab
if [ "$PATH_1" = "/efs" ]; then mount $PATH_3 /efs; fi
if [ "$PATH_2" = "/efs" ]; then mount $PATH_1 /efs; fi
for EFS in $(find /dev/block -name efs); do mount $EFS /efs; done
for EFS in $(ls -Rl /dev/block | grep -w efs | cut -d">" -f2 | cut -d" " -f2); do mount $EFS /efs; done
if [ ! -d /sdcard/EFS_Backup ]; then
	mkdir /sdcard/EFS_Backup
	chmod 777 /sdcard/EFS_Backup
fi
if [ ! -d /data/media/0/EFS_Backup ]; then
	mkdir /data/media/0/EFS_Backup
	chmod 777 /data/media/0/EFS_Backup
fi
tar zcf /sdcard/EFS_Backup/$BACKUP_NAME /efs
if [ ! -f "/data/media/0/EFS_Backup/$BACKUP_NAME" ]; then tar zcf /data/media/0/EFS_Backup/$BACKUP_NAME /efs; fi
umount /efs
exit 0