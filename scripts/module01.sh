#!/usr/bin/env
# Pipeline configuration file
FCONFIG="pipe.conf"
# Check if configuration file exists
if [ -e $FCONFIG ] && [ -e $FFUNCS ]
then
    source $FCONFIG
    source $FFUNCS
    source $FFUNM01
else
    echo "Missing $FCONFIG and/or $FFUNCS"
    exit 1
fi
#_______________________________________________________________________________________________________________________________
# PREPROCESSING
## step 00: sequence trimming
echo -e "\e[01m### STARTING PREPROCESSING ###\e[0m"
echo -e "\e[01m## Running Trim Galore\e[0m"
    prePro "$CONTROL" &&
    prePro "$TREATMENT" &&
echo -e "## Trimming done!\n" && sleep 0.2
# MODULE 01
## step 01: fastq to fasta
echo -e "\e[01m### STARTING MODULE 01 ###\e[0m"
echo -e "\e[01m## Step 01\e[0m"
    step01 "${CONTROL%.*}_trimmed.fq" &&
    step01 "${TREATMENT%.*}_trimmed.fq" &&
echo -e "## Step 01 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

## step 02: remove <25nt
echo -e "\e[01m## Step 02\e[0m"
echo -e "## Removing short sequences from:"
    step02 "$MOSFA/$FPCONTROL"_trimmed.fa
    step02 "$MOSFA/$FPTREATMENT"_trimmed.fa
echo -e "## Step 02 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________
