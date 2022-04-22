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

step04 () {
    INARQ04=$1
    mkdir -p $ONEHIT $MULTIHIT
    #for FSBLAST in $SELFBLAST/*blastout.tsv;
    echo "   $(basename $INARQ04)"
  	# Cria arquivo com sequências com só um hit (elas mesmas)
  	grep "# 1 hits found" -A1 $INARQ04 | sed '/^--$/d;/^#/d' > ${INARQ04%_blastout.tsv}_onehit.tsv &&
  	sed -i '1i qseqid\tsseqid\tpident\tlen\tqlen\tslen\tevalue\tbitscore\tqcovs\tqstart\tqend\tsstart\tsend\tqseq\tsseq' ${INARQ04%_blastout.tsv}_onehit.tsv &&
  	mv $SELFBLAST/*onehit.tsv $ONEHIT
  	# Cria arquivo com as sequências com mais de um hit
  	sed '/# 1 hits found/,+1 d;/^# /d' $INARQ04 > ${INARQ04%_blastout.tsv}_multihit.tsv &&
  	sed -i '1i qseqid\tsseqid\tpident\tlen\tqlen\tslen\tevalue\tbitscore\tqcovs\tqstart\tqend\tsstart\tsend\tqseq\tsseq' ${INARQ04%_blastout.tsv}_multihit.tsv &&
  	mv $SELFBLAST/*multihit.tsv $MULTIHIT

}