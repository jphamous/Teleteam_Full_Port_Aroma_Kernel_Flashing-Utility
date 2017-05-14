#!/sbin/sh
mount /data
mount -o rw,remount /data
for FILE in /data/*; do
	if [ "$FILE" != "/data/media" ]
		then rm -rf "$FILE"
	fi
done
