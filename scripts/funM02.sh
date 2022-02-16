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
step03 () {
    INARQ03=$1
    mkdir -p $SELFBLAST
    checkBlast
    echo "   $(basename $INARQ03)"
	  $BLAST -query $INARQ03 -subject $INARQ03 -max_hsps 5 -max_target_seqs 5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out ${INARQ03%_length.fa}_blastout.tsv || exit 1 &&
	  mv $LONGLEN/*blastout.tsv $SELFBLAST
}
