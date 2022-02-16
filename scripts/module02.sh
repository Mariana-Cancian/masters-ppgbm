#!/usr/bin/env bash
# Pipeline configuration file
FCONFIG="pipe.conf"
# Check if configuration file exists
if [ -e $FCONFIG ] && [ -e $FFUNCS ]
then
    source $FCONFIG
    source $FFUNCS
    source $FFUNM02
else
    echo "Missing $FCONFIG and/or $FFUNCS"
    exit 1
fi
#_______________________________________________________________________________________________________________________________

# M06: Selfblast
echo -e "\e[01m### STARTING MODULE 02 ###\e[0m"
echo -e "\e[01m## Step 03\e[0m"
echo -e "## Selfblasting file:"
    step03 "$LONGLEN/$FPCONTROL"_length.fa
    step03 "$LONGLEN/$FPTREATMENT"_length.fa
echo -e "## Step 03 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

# # M07: separate onehit files from multihit files
# checkIfDir "$SELFBLAST"
# echo -e "\e[01m## Step 07\e[0m"
# echo -e "## Selecting onehit and multihit:"
# mkdir -p $ONEHIT $MULTIHIT
# for FSBLAST in $SELFBLAST/*blastout.tsv;
# do
#     checkIfFile $FSBLAST $SELFBLAST
#     echo "   $(basename $FSBLAST)"
# 	# Cria arquivo com sequências com só um hit (elas mesmas)
# 	grep "# 1 hits found" -A1 $FSBLAST | sed '/^--$/d;/^#/d' > ${FSBLAST%_blastout.tsv}_onehit.tsv &&
# 	sed -i '1i qseqid\tsseqid\tpident\tlen\tqlen\tslen\tevalue\tbitscore\tqcovs\tqstart\tqend\tsstart\tsend\tqseq\tsseq' ${FSBLAST%_blastout.tsv}_onehit.tsv &&
# 	mv $SELFBLAST/*onehit.tsv $ONEHIT
# 	# Cria arquivo com as sequências com mais de um hit
# 	sed '/# 1 hits found/,+1 d;/^# /d' $FSBLAST > ${FSBLAST%_blastout.tsv}_multihit.tsv &&
# 	sed -i '1i qseqid\tsseqid\tpident\tlen\tqlen\tslen\tevalue\tbitscore\tqcovs\tqstart\tqend\tsstart\tsend\tqseq\tsseq' ${FSBLAST%_blastout.tsv}_multihit.tsv &&
# 	mv $SELFBLAST/*multihit.tsv $MULTIHIT
# done && echo -e "## Step 07 done!\n" && sleep 0.2
# #_______________________________________________________________________________________________________________________________
