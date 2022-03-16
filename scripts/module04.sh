#!/usr/bin/env bash
# Pipeline configuration file
FCONFIG="pipe.conf"
# Check if configuration file exists
if [ -e $FCONFIG ] && [ -e $FFUNCS ]
then
    source $FCONFIG
    source $FFUNCS
    source $FFUNM04
else
    echo "Missing $FCONFIG and/or $FFUNCS"
    exit 1
fi
#_______________________________________________________________________________________________________________________________

# M13: Filter 1 (redundance)
checkIfDir "$MULTIHIT"
echo -e "\e[01m### STARTING MODULE 13 ###\e[0m"
echo -e "\e[01m## Step 13\e[0m"
echo -e "## Running reciprocal blast:"
mkdir -p $SAMPLEBLAST
for FILT in $FILTER3/*clean.fa;
do
    checkIfFile $FILT $FILTER3
    echo "   $(basename $FILT)"
	$BLAST -query $CONTROL -subject $TREATMENT -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $RBH_CT
	$BLAST -query $TREATMENT -subject $CONTROL -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $RBH_TC
 &&
	mv $FILTER3/*.tsv $SAMPLEBLAST
done && echo -e "## Step 13 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________
# M15: reciprocal blast
checkIfDir "$SAMPLEBLAST"
echo -e "\e[01m### STARTING MODULE 14 ###\e[0m"
echo -e "\e[01m## Step 13\e[0m"
echo -e "## Running reciprocal blast filtering:"
mkdir -p $RBHBLAST

python2 M15_rbh.py $RBH_CT $RBH_TC 1 2 10 high $RBH_RES
