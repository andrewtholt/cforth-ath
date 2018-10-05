# . this

export IDF_PATH=/home/andrewh/esp/esp-idf

CNT=$(echo $PATH | grep xtensa  | wc -l)
if [ $CNT -eq 0 ]; then
    echo "Add Path"
else
    echo "Compilers in path"
fi
