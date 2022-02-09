#!/usr/bin/env
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
step01 () {
for FMOSFQ in $MOSFQ/*.fastq;
do
    checkIfFile $FMOSFQ $MOSFQ
	  python3 $FQTOFA $FMOSFQ &&
        mv $MOSFQ/*.fa $MOSFA &&
        echo "   $(basename $FMOSFQ) converted."
done
}
