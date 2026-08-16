# ask
echo 'path to file:'
read x

# ask/

#var
y=$(pwd)
t='temp'

#var/


if [ ! -d "$t" ]; then
    mkdir "$t"
fi

if [ -f "$x"]; then
    if [ -xwr "$x" ]; then
        if [ ls "$x"|grep -q *img  ]; then
            python3 funtion/unpack_bootimg.py --boot_img "$x" --out "$t"
            cd "$t"
            if [ ls|grep -q '.cpio' ]; then
                cpio -imv < $( find *.cpio )
                mv init init.real
                chmod +x init.real
                cp init/init .
                cp bin-for-app/busybox-arm64 /system/bin
                chmod +x /system/bin/busybox-arm64
                find . -print | cpio -o -H newc > ../my-archive.cpio
                python3 funtion/repack_bootimg.py --boot_img ../ --out ../repack.img --ramdisk ../"$y"/my-archive.cpio
            fi
        else 
            echo 'not img file'
        fi
    else 
        echo 'not work'
    fi
else
    echo "File does not exist."
fi  