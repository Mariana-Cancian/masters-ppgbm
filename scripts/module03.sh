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

# MODULE 03
## step 05: Filter 1 (redundance)
echo -e "\e[01m### STARTING MODULE 03 ###\e[0m"
echo -e "\e[01m## Step 05\e[0m"
echo -e "## Selecting onehit and multihit:"
    step05 "$MULTIHIT/$FPCONTROL"_multihit.tsv &&
    step05 "$MULTIHIT/$FPTREATMENT"_multihit.tsv &&
echo -e "## Step 05 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

## step 06: scov table creation
echo -e "\e[01m## Step 06\e[0m"
echo -e "## Creating scov column:"
  step06 "$FILTHIT/$FPCONTROL"_mhit_filt.tsv &&
  step06 "$FILTHIT/$FPTREATMENT"_mhit_filt.tsv &&
echo -e "## Step 06 done!\n" && sleep 0.2
# _______________________________________________________________________________________________________________________________

## step 07: get a representative sequence (q/scov>=70)
echo -e "\e[01m## Step 07\e[0m"
echo -e "## Filtering by scov:"
  step07 "$SCOV/$FPCONTROL"_scov.tsv &&
  step07 "$SCOV/$FPTREATMENT"_scov.tsv &&
echo -e "## Step 07 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

## step 08: get sequences from list of ids
echo -e "\e[01m## Step 08\e[0m"
# Get ids
echo -e "## Getting sequence ids for:"
  step08.1 "$QSCOV70/$FPCONTROL"_qscov70.tsv &&
  step08.1 "$QSCOV70/$FPTREATMENT"_qscov70.tsv &&
# Get sequences
echo -e "## Retrieving sequences for:"
  step08.2 "$LONGLEN/$FPCONTROL"_length.fa &&
  step08.2 "$LONGLEN/$FPTREATMENT"_length.fa &&
echo -e "## Step 08 done!\n" && sleep 0.2
#---------------------------------------------------------------------------------------------------------------------------------

## step 09: Filter 2 (new redundance clear)
echo -e "\e[01m## Step 09\e[0m"
echo -e "## Cleaning redudant sequences:"
  step09 "$IDSEQ/$FPCONTROL"_fastafinal.fa &&
  step09 "$IDSEQ/$FPTREATMENT"_fastafinal.fa &&
echo -e "## Step 09 done!\n" && sleep 0.2
#---------------------------------------------------------------------------------------------------------------------------------
