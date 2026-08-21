# ask
echo 'path to file name:'
read x

# ask/

#var
y=$(pwd)
t='temp'

#var/


if [ -d "$t" ]; then
    rm -rf "$t"
    mkdir "$t"
else
    mkdir "$t"
fi

if [ -f "$x" ]; then
    if [ True ]; then
        if [[ "$x" == *img* ]]; then
            ./funtion/magiskboot unpack "$x"
            
            mv ramdisk.cpio "$t"
            cd "$t"
            if  ls|grep -q '\.cpio' ; then
                z=$( find *.cpio )
                echo "find cpio file: $z"
                cpio -imv < "$z"
                echo "cpio file unpacked $z"
                rm -rf "$z"
                mv init init.real
                echo "init file renamed to init.real"
                chmod +x init.real
                cp ../init/init ./
                echo "ctrl+c init file and ctrl+v into it"
                cp ../bin-for-app/busybox-arm64 system/bin
                echo "ctrl+c busybox-arm64 file and ctrl+v into system/bin"
                chmod +x system/bin/busybox-arm64
                find . -print | cpio -o -H newc > "$z"
                echo "cpio file repacked $z"
                mkdir -p ../ramdisk
                mv "$z" ../ramdisk
                cd ..
                cp "$x" ramdisk
                cd ramdisk
                ./../funtion/magiskboot repack "$x" new_init_boot.img
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