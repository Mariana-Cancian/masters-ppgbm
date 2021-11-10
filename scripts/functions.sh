#!/usr/bin/env bash
# Check if directory exists
checkIfDir () {
    DIR=$1
    if [ ! -d $DIR ];then
        echo "ERROR: $(basename $DIR) does not exist"
        exit 1
    fi
}
# Check if file exists in directory
checkIfFile () {
    ARQ=$1
    DIR=$2
    if [ ! -f $ARQ ];then
        echo "ERROR: $(basename $DIR) is empty."
        exit 1
    fi
}
# Check if blastn is in PATH
checkBlast () {
    if [ ! $BLAST ];then
        echo ""
        echo "ERROR: blastn not found."
        echo "Please, set path to blastn in $FCONFIG"
        exit 1
    fi
}
