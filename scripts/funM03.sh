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

step05 () {
  INARQ05=$1
  mkdir -p $FILTHIT
  #for MHIT in $MULTIHIT/*multihit.tsv;
  echo "   $(basename $INARQ05)"
  python3 $FRBH $INARQ05 ${INARQ05%_multihit.tsv}_mhit_filt.tsv &&
  mv $MULTIHIT/*filt.tsv $FILTHIT
}
