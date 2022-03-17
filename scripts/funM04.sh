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

step10 () {
  INARQ101=$1
  INARQ102=$2
  OUTARQ10=$3
  mkdir -p $SAMPLEBLAST
  echo "   $(basename $INARQ101) vs $(basename $INARQ102)"
  $BLAST -query $INARQ101 -subject $INARQ102 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $OUTARQ10
  mv $FILTER3/*.tsv $SAMPLEBLAST
}

step11 () {
  INARQ111=$1
  INARQ112=$2
  OUTARQ11=$3
  mkdir -p $RBHBLAST
  python2 $FRBCT $INARQ111 $INARQ112 1 2 8 high $OUTARQ11 &&
  mv "$SAMPLEBLAST/$RBH_RES" $RBHBLAST
}
