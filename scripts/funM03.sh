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
  echo "   $(basename $INARQ05)"
  python3 $FRBH $INARQ05 ${INARQ05%_multihit.tsv}_mhit_filt.tsv &&
  mv $MULTIHIT/*filt.tsv $FILTHIT
}

step06 () {
  INARQ06=$1
  mkdir -p $SCOV
  echo "   $(basename $INARQ06)"
  sed '1d' $INARQ06 |
	awk '{$16=int(($4/$6)*100)}1' |
	sed '1i qseqid\tsseqid\tpident\tlen\tqlen\tslen\tevalue\tbitscore\tqcovs\tqstart\tqend\tsstart\tsend\tqseq\tsseq\tscov' |
	awk '{ print $1,$2,$3,$4,$5,$6,$7,$8,$9,$16,$10,$11,$12,$13,$14,$15 }' |
	sed 's/ /\t/g' > ${INARQ06%_mhit_filt.tsv}_scov.tsv &&
	mv $FILTHIT/*scov.tsv $SCOV
}

step07 () {
  INARQ07=$1
  mkdir -p $QSCOV70
  echo "   $(basename $INARQ07)"
  python3 $FQCOV $INARQ07 ${INARQ07%_scov.tsv}_qscov70.tsv &&
  mv $SCOV/*qscov70.tsv $QSCOV70
}

step08.1 () {
  INARQ081=$1
  mkdir -p $IDSEQ
  mkdir -p $TMPIDS
  echo "   $(basename $INARQ081)"
  cut -f1 $INARQ081 | sed "/qseqid/d" | sort | uniq > ${INARQ081%_qscov70.tsv}_ids.txt &&
  mv ${INARQ081%_qscov70.tsv}_ids.txt $TMPIDS
}

step08.2 () {
  INARQ082=$1
  echo "   $(basename $INARQ082)"
  FID=${INARQ082%_length.fa}_ids.txt
  grep -A1 -f $TMPIDS/${FID#\.\/06_LONGLENGTH\/} $INARQ082 | sed '/^--$/d' > ${INARQ082%_length.fa}_fastafinal.fa &&
  mv $LONGLEN/*fastafinal.fa $IDSEQ
}

step09 () {
  INARQ09=$1
  mkdir -p $FILTER3
  echo "   $(basename $INARQ09)"
  python3 $FUNIQ $INARQ09 > ${INARQ09%.fa}_clean.fa &&
  mv $IDSEQ/*clean.fa $FILTER3
}