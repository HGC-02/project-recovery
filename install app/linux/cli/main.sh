# ask
echo 'path to file:'
x=read

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
            if [[ ls|grep -q '.cpio' && find ramdisk.cpio]]; then
            cpio -imv < $( find *.cpio )
            

                

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