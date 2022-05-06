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

# MODULE 04
## step 10: Filter 1 (redundance)
echo -e "\e[01m### STARTING MODULE 04 ###\e[0m"
echo -e "\e[01m## Step 10\e[0m"
echo -e "## Running reciprocal blast:"
  step10 "$FILTER3/$FPCONTROL"_fastafinal_clean.fa "$FILTER3/$FPTREATMENT"_fastafinal_clean.fa "$FILTER3/$RBH_CT" &&
  step10 "$FILTER3/$FPTREATMENT"_fastafinal_clean.fa "$FILTER3/$FPCONTROL"_fastafinal_clean.fa "$FILTER3/$RBH_TC" &&
echo -e "## Step 10 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

## step 11: reciprocal blast
echo -e "\e[01m## Step 11\e[0m"
echo -e "## Running reciprocal blast filtering..."
  step11 "$SAMPLEBLAST/$RBH_CT" "$SAMPLEBLAST/$RBH_TC" "$SAMPLEBLAST/$RBH_RES" &&
echo -e "## ALL DONE!"
