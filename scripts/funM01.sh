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
# Run sequence trimming
prePro () {
    INARQ00=$1
    checkTrimmer
    checkIfFile $INARQ00
    $TRIMMER --no_report_file --suppress_warn --illumina $INARQ00 -o $FASTQIN &&
    echo "   $(basename $INARQ00) trimmed."
}

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
    INARQ02LEN="${INARQ02%trimmed.fa}length.fa"
    mkdir -p $LONGLEN
    echo "   $(basename $INARQ02)"
    $FCHECKNT $INARQ02 > $INARQ02LEN &&
    mv $INARQ02LEN $LONGLEN
}
