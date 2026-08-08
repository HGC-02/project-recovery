echo 'path to file:'
x=read
if [ -f "$x"]; then
    if [ -xwr "$x" ]; then
        if [ grep -q *img "$x" ]; then
            python3 unpack_bootimg.py --boot_img "$x" --out output_dir/
        else 
            echo 'not img file'
        fi
    else 
        echo 'not work'
    fi
else
    echo "File does not exist."
fi  