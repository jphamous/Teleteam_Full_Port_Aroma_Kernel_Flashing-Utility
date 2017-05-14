#!/sbin/sh
for DETECT in USERDATA SYSTEM CACHE DATA userdata system cache data; do
	for PARTITION in $(ls -Rl /dev/block | grep -w $DETECT | cut -d">" -f2 | cut -d" " -f2); do /tmp/tune2fs -o journal_data_writeback $PARTITION; done
	for PARTITION in $(find /dev/block -name $DETECT); do /tmp/tune2fs -o journal_data_writeback $PARTITION; done
done
