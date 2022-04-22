#!/usr/bin/env bash
# Pipeline configuration file
FCONFIG="pipe.conf"
# Check if configuration file exists
if [ -e $FCONFIG ] && [ -e $FFUNCS ]
then
    source $FCONFIG
    source $FFUNCS
else
    echo "Missing $FCONFIG and/or $FFUNCS"
    exit 1
fi
#_______________________________________________________________________________________________________________________________
# Convert fastq to fasta
step01 () {
    INARQ01=$1
    mkdir -p $MOSFA
	  python3 $FQTOFA $INARQ01 &&
    mv ${INARQ01%.*}.fa $MOSFA &&
    echo "   $(basename $INARQ01) converted to fasta."
}

step02 () {
    INARQ02=$1
    INARQ02LEN="${INARQ02%.fa}_length.fa"
    mkdir -p $LONGLEN
    echo "   $(basename $INARQ02)"
    $FCHECKNT $INARQ02 > $INARQ02LEN &&
    mv $INARQ02LEN $LONGLEN
}
