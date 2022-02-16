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

step06 () {
  INARQ06=$1
  mkdir -p $SCOV
  #for FSCOV in $FILTHIT/*filt.tsv;
  echo "   $(basename $INARQ06)"
  sed '1d' $INARQ06 |
	awk '{$16=int(($4/$6)*100)}1' |
	sed '1i qseqid\tsseqid\tpident\tlen\tqlen\tslen\tevalue\tbitscore\tqcovs\tqstart\tqend\tsstart\tsend\tqseq\tsseq\tscov' |
	awk '{ print $1,$2,$3,$4,$5,$6,$7,$8,$9,$16,$10,$11,$12,$13,$14,$15 }' |
	sed 's/ /\t/g' > ${INARQ06%_mhit_filt.tsv}_scov.tsv &&
	mv $FILTHIT/*scov.tsv $SCOV

}
