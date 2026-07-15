#!/system/bin/busybox-arm64 sh
export PATH="/sbin:/bin:/system/bin"
x=0
# don't remove from:
/system/bin/busybox-arm64 setenforce 0 2>/dev/null
# dont remove end

while [ ! -e "/data/" ]; do
	sleep (1)
	x=$((x+1))
	if [ "$x" -gt 10 ]; then
		exec ./init.real
	fi
done

#------- add if need error finder-----

if [ ! -e "/data/error/count.txt" ]; then
	touch /data/error/count.txt 
fi
	
#---------------------------

#--mount btrfs
	#var of btrfs
A="/data/adb/pr-btrfs.img"
T_D="/data/adb/ksu"
T_D_BACKUP="/data/adb/modules"
ERR_DIR="/data/error"
z=0
	#------------
while [ "$z" -lt 4 ]; do

	if [ "$(cat /data/error/count.txt 2>/dev/null)" = "xxxx"  ]; then
		/system/bin/busybox-arm64 mount -t btrfs -o loop,subvol=@modules-old "$A" "$T_D" 2>/dev/null
		
		if [ $? -ne 0 ]; then 
			/system/bin/busybox-arm64 mount -t btrfs -o loop,subvol=@modules-old "$A" "$T_D_BACKUP" 2>/dev/null
			if [ $? -eq 0];then
				break
			fi
		else
			break
		fi

	else
		/system/bin/busybox-arm64 mount -t btrfs -o loop,subvol=@modules-curr "$A" "$T_D" 2>/dev/null

		if [ $? -ne 0 ]; then 
			/system/bin/busybox-arm64 mount -t btrfs -o loop,subvol=@modules-curr "$A" "$T_D_BACKUP" 2>/dev/null
			if [ $? -eq 0];then
				break
			fi
		else
			break
		fi
	fi
	if [ "$z" -eq 3 ]; then
		exec ./init.real
	fi
	z=$((z+1))

done
if [ ! -e "/data/error/count.txt" ]; then
	touch "/data/error/count.txt" 
fi

echo -n "x" >> "/data/error/count.txt"

exec ./init.real

