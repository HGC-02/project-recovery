echo 'path to file:'
x=read
y=$(pwd)
z=


if [ -f ]
if [ -f "$x"]; then
    if [ -xwr "$x" ]; then
        if [ grep -q *img "$x" ]; then
            python3 funtion/unpack_bootimg.py --boot_img "$x" --out "$y"
            if [ grep -q *.cpio "$y" ]; then
                cd 
        else 
            echo 'not img file'
        fi
    else 
        echo 'not work'
    fi
else
    echo "File does not exist."
fi  