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

M06: Selfblast
echo -e "\e[01m### STARTING MODULE 02 ###\e[0m"
echo -e "\e[01m## Step 03\e[0m"
echo -e "## Selfblasting file:"
    step03 "$LONGLEN/$FPCONTROL"_length.fa &&
    step03 "$LONGLEN/$FPTREATMENT"_length.fa &&
echo -e "## Step 03 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

# M07: separate onehit files from multihit files
echo -e "\e[01m## Step 04\e[0m"
echo -e "## Selecting onehit and multihit:"
    step04 "$SELFBLAST/$FPCONTROL"_blastout.tsv &&
    step04 "$SELFBLAST/$FPTREATMENT"_blastout.tsv &&
echo -e "## Step 04 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________
