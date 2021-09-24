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

# M06: Selfblast
checkIfDir "$LONGLEN"
echo -e "\e[01m### STARTING MODULE 02 ###\e[0m"
echo -e "\e[01m## Step 06\e[0m"
checkBlast
echo -e "## Selfblasting file:"
## Create directory
mkdir -p $SELFBLAST

# if [ ! $BLAST ];then
#     echo ""
#     echo "ERROR: blastn not found"
#     echo "Please, set path to blastn in $FCONFIG"
#     exit 1
# fi
## Iterate over files
for CLEANFA in $LONGLEN/*length.fa
do
    checkIfFile $CLEANFA $LONGLEN
    echo "   $(basename $CLEANFA)"
	  $BLAST -query $CLEANFA -subject $CLEANFA -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out ${CLEANFA%_length.fa}_blastout.tsv || exit 1 &&
	  mv $LONGLEN/*blastout.tsv $SELFBLAST
done && echo -e "## Step 06 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

# M07: separate onehit files from multihit files
checkIfDir "$SELFBLAST"
echo -e "\e[01m## Step 07\e[0m"
echo -e "## Selecting onehit and multihit:"
mkdir -p $ONEHIT $MULTIHIT
for FSBLAST in $SELFBLAST/*blastout.tsv;
do
    checkIfFile $FSBLAST $SELFBLAST
    echo "   $(basename $FSBLAST)"
	# Cria arquivo com sequências com só um hit (elas mesmas)
	grep "# 1 hits found" -A1 $FSBLAST | sed '/^--$/d;/^#/d' > ${FSBLAST%_blastout.tsv}_onehit.tsv &&
	sed -i '1i qseqid\tsseqid\tpident\tlen\tqlen\tslen\tevalue\tbitscore\tqcovs\tqstart\tqend\tsstart\tsend\tqseq\tsseq' ${FSBLAST%_blastout.tsv}_onehit.tsv &&
	mv $SELFBLAST/*onehit.tsv $ONEHIT
	# Cria arquivo com as sequências com mais de um hit
	sed '/# 1 hits found/,+1 d;/^# /d' $FSBLAST > ${FSBLAST%_blastout.tsv}_multihit.tsv &&
	sed -i '1i qseqid\tsseqid\tpident\tlen\tqlen\tslen\tevalue\tbitscore\tqcovs\tqstart\tqend\tsstart\tsend\tqseq\tsseq' ${FSBLAST%_blastout.tsv}_multihit.tsv &&
	mv $SELFBLAST/*multihit.tsv $MULTIHIT
done && echo -e "## Step 07 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

# M08: Filter 1 (redundance)
checkIfDir "$MULTIHIT"
echo -e "\e[01m## Step 08\e[0m"
echo -e "## Selecting onehit and multihit:"
mkdir -p $FILTHIT
for MHIT in $MULTIHIT/*multihit.tsv;
do
    checkIfFile $MHIT $MULTIHIT
    echo "   $(basename $MHIT)"
	$FRBH $MHIT ${MHIT%_multihit.tsv}_mhit_filt.tsv &&
	mv $MULTIHIT/*filt.tsv $FILTHIT
done && echo -e "## Step 08 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

## M09: scov table creation
#mkdir -p $SCOV
#for FSCOV in $FILTHIT/*filt.tsv;
#do
#	sed '1d' $FSCOV |
#	awk '{$16=int(($4/$6)*100)}1' |
#	sed '1i qseqid\tsseqid\tpident\tlen\tqlen\tslen\tevalue\tbitscore\tqcovs\tqstart\tqend\tsstart\tsend\tqseq\tsseq\tscov' |
#	awk '{ print $1,$2,$3,$4,$5,$6,$7,$8,$9,$16,$10,$11,$12,$13,$14,$15 }' |
#	sed 's/ /\t/g' > ${FSCOV%_mhit_filt.tsv}_scov.tsv &&
#	mv $FILTHIT/*scov.tsv $SCOV
#done
## _______________________________________________________________________________________________________________________________
#
## M10: get a representative sequence (q/scov>=70)
#mkdir -p $QSCOV70
#for QSCOV in $SCOV/*scov.tsv
#do
#	$FQCOV $QSCOV ${QSCOV%_scov.tsv}_qscov70.tsv &&
#	mv $SCOV/*qscov70.tsv $QSCOV70
#done
##_______________________________________________________________________________________________________________________________
#
## M11: get sequences from list of ids
#mkdir -p $IDSEQ
#mkdir -p $TMPIDS
## Get ids
#for FIDS in $QSCOV70/*qscov70.tsv;
#do
#	cut -f1 $FIDS | sed "/qseqid/d" | sort | uniq > ${FIDS%_qscov70.tsv}_ids.txt &&
#	mv ${FIDS%_qscov70.tsv}_ids.txt $TMPIDS
#done
## Get sequences
#for FIDSEQ in $LONGLEN/*_length.fa
#do
#	FID=${FIDSEQ%_length.fa}_ids.txt
#	grep -A1 -f $TMPIDS/${FID#\.\/06_LONGLENGTH\/} $FIDSEQ | sed '/^--$/d' > ${FIDSEQ%_length.fa}_fastafinal.fa &&
#	mv $LONGLEN/*fastafinal.fa $IDSEQ
#done
##---------------------------------------------------------------------------------------------------------------------------------
## M12: Filter 2 (new redundance clear)
#mkdir -p $FILTER3
#for FILT3 in $IDSEQ/*fastafinal.fa
#do
#	 $FUNIQ $FILT3 > ${FILT3%.fa}_clean.fa &&
#	mv $IDSEQ/*clean.fa $FILTER3
#done
##---------------------------------------------------------------------------------------------------------------------------------
