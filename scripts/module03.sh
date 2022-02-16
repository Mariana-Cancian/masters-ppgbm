#!/usr/bin/env bash
# Pipeline configuration file
FCONFIG="pipe.conf"
# Check if configuration file exists
if [ -e $FCONFIG ] && [ -e $FFUNCS ]
then
    source $FCONFIG
    source $FFUNCS
    source $FFUNM03
else
    echo "Missing $FCONFIG and/or $FFUNCS"
    exit 1
fi
#_______________________________________________________________________________________________________________________________

M08: Filter 1 (redundance)
echo -e "\e[01m### STARTING MODULE 03 ###\e[0m"
echo -e "\e[01m## Step 05\e[0m"
echo -e "## Selecting onehit and multihit:"
    step05 "$MULTIHIT/$FPCONTROL"_multihit.tsv &&
    step05 "$MULTIHIT/$FPTREATMENT"_multihit.tsv &&
echo -e "## Step 05 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

# M09: scov table creation
echo -e "\e[01m## Step 06\e[0m"
echo -e "## Creating scov column:"
  step06 "$FILTHIT/$FPCONTROL"_mhit_filt.tsv &&
  step06 "$FILTHIT/$FPTREATMENT"_mhit_filt.tsv &&
echo -e "## Step 06 done!\n" && sleep 0.2
# _______________________________________________________________________________________________________________________________
#
# # M10: get a representative sequence (q/scov>=70)
# checkIfDir "$SCOV"
# echo -e "\e[01m## Step 10\e[0m"
# echo -e "## Filtering by scov:"
# mkdir -p $QSCOV70
# for QSCOV in $SCOV/*scov.tsv
# do
#     checkIfFile $QSCOV $SCOV
#     echo "   $(basename $QSCOV)"
#     python3 $FQCOV $QSCOV ${QSCOV%_scov.tsv}_qscov70.tsv &&
# 	mv $SCOV/*qscov70.tsv $QSCOV70
# done && echo -e "## Step 10 done!\n" && sleep 0.2
# #_______________________________________________________________________________________________________________________________
#
# # M11: get sequences from list of ids
# checkIfDir "$QSCOV70"
# echo -e "\e[01m## Step 11\e[0m"
# mkdir -p $IDSEQ
# mkdir -p $TMPIDS
# # Get ids
# echo -e "## Getting sequence ids for:"
# for FIDS in $QSCOV70/*qscov70.tsv;
# do
#     checkIfFile $FIDS $QSCOV70
#     echo "   $(basename $FIDS)"
# 	cut -f1 $FIDS | sed "/qseqid/d" | sort | uniq > ${FIDS%_qscov70.tsv}_ids.txt &&
# 	mv ${FIDS%_qscov70.tsv}_ids.txt $TMPIDS
# done &&
# # Get sequences
# echo -e "## Retrieving sequences for:"
# for FIDSEQ in $LONGLEN/*_length.fa
# do
#     checkIfFile $FIDSEQ $LONGLEN
#     echo "   $(basename $FIDSEQ)"
# 	FID=${FIDSEQ%_length.fa}_ids.txt
# 	grep -A1 -f $TMPIDS/${FID#\.\/06_LONGLENGTH\/} $FIDSEQ | sed '/^--$/d' > ${FIDSEQ%_length.fa}_fastafinal.fa &&
# 	mv $LONGLEN/*fastafinal.fa $IDSEQ
# done && echo -e "## Step 11 done!\n" && sleep 0.2
# #---------------------------------------------------------------------------------------------------------------------------------
# # M12: Filter 2 (new redundance clear)
# checkIfDir "$IDSEQ"
# echo -e "\e[01m## Step 12\e[0m"
# echo -e "## Cleaning redudant sequences:"
# mkdir -p $FILTER3
# for FILT3 in $IDSEQ/*fastafinal.fa
# do
#     checkIfFile $FILT3 $IDSEQ
#     echo "   $(basename $FIDSEQ)"
# 	python3 $FUNIQ $FILT3 > ${FILT3%.fa}_clean.fa &&
# 	mv $IDSEQ/*clean.fa $FILTER3
# done && echo -e "## Step 12 done!\n" && sleep 0.2
# #---------------------------------------------------------------------------------------------------------------------------------
