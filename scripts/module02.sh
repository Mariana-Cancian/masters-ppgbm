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
