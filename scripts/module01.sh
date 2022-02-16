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

# Check if current working directory exists
echo -e "\e[01m### STARTING MODULE 01 ###\e[0m"
echo -e "\e[01m## Step 01\e[0m"
    step01 "$CONTROL" &&
    step01 "$TREATMENT" &&
echo -e "## Step 01 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

# M02 remove <25nt
echo -e "\e[01m## Step 02\e[0m"
echo -e "## Removing short sequences from:"
    step02 "$MOSFA/$FPCONTROL.fa"
    step02 "$MOSFA/$FPTREATMENT.fa"
echo -e "## Step 02 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________


# M03: remove mariner and adapters (and "fish" sequence)
# echo -e "\e[01m## Step 02\e[0m"
# echo -e "## Removing sequencing artifacts from:"
# mkdir -p $CLEANFISH
# for FMOSFA in $MOSFA/*.fa
# do
#     checkIfFile $FMOSFA $MOSFA
#     echo "   $(basename $FMOSFA)"
# 	# Remove mariner and "fish" from mos3 and mos5
# 	sed -e "s/TTATTCTAAGTATTTGCCGTCGC.*//;s/AAGTAGGGAATGTCGGTTCG.*//" $FMOSFA > ${FMOSFA%.fa}_clnfs.fa &&
# 	mv $MOSFA/*clnfs.fa $CLEANFISH
# done && echo -e "## Step 02 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________
