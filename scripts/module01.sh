#!/usr/bin/env
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

# Check if current working directory exists
checkIfDir "$FASTQIN"
echo -e "\e[01m### STARTING MODULE 01 ###\e[0m"
echo -e "\e[01m## Step 01\e[0m"
echo -e "## Searching \e[3mmariner\e[0m in:"
## Create directory
mkdir -p $MOSFQ
## Iterate over files
for FASTQ in $FASTQIN/*.fastq;
do
    checkIfFile $FASTQ $FASTQIN
    echo "   $(basename $FASTQ)"
    # Grep mos3 and mos5 patterns
    grep -v '>' $REF1 > $GPAT1
    grep -v '>' $REF2 > $GPAT2
    # Grep sequences with mos3 pattern
    grep -f $GPAT1 $FASTQ -B1 -A2 | sed '/^--$/d' > ${FASTQ%.fastq}_mos3.fastq &&
    mv $FASTQIN/*_mos3.fastq $MOSFQ && rm $GPAT1
    # Grep sequences with mos5 pattern
    grep -f $GPAT2 $FASTQ -B1 -A2 | sed '/^--$/d' > ${FASTQ%.fastq}_mos5.fastq &&
    mv $FASTQIN/*_mos5.fastq $MOSFQ && rm $GPAT2
done &&
echo -e "## Step 01 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

# M02: fastq to fasta
checkIfDir "$MOSFQ"
echo -e "\e[01m## Step 02\e[0m"
echo -e "## Converting fastq to fasta..."
mkdir -p $MOSFA
for FMOSFQ in $MOSFQ/*.fastq;
do
    checkIfFile $FMOSFQ $MOSFQ
	  python3 $FQTOFA $FMOSFQ &&
        mv $MOSFQ/*.fa $MOSFA &&
        echo "   $(basename $FMOSFQ) converted."
done && echo -e "## Step 02 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

# M03: remove mariner and adapters (and "fish" sequence)
checkIfDir "$MOSFA"
echo -e "\e[01m## Step 03\e[0m"
echo -e "## Removing sequencing artifacts from:"
mkdir -p $CLEANFISH
for FMOSFA in $MOSFA/*.fa
do
    checkIfFile $FMOSFA $MOSFA
    echo "   $(basename $FMOSFA)"
	# Remove mariner and "fish" from mos3 and mos5
	sed -e "s/TTATTCTAAGTATTTGCCGTCGC.*//;s/AAGTAGGGAATGTCGGTTCG.*//" $FMOSFA > ${FMOSFA%.fa}_clnfs.fa &&
	mv $MOSFA/*clnfs.fa $CLEANFISH
done && echo -e "## Step 03 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

# M04: Remove adapters and arctifacts from sequences
checkIfDir "$CLEANFISH"
echo -e "\e[01m## Step 04\e[0m"
echo -e "## Removing adapters from:"
mkdir -p $CLEANADAPT
for FCLNFS in $CLEANFISH/*.fa
do
    checkIfFile $FCLNFS $CLEANFISH
    echo "   $(basename $FCLNFS)"
	sed -f <(sort -r "$ADAPTTOTAL" | sed 's/.*/s|&||/') $FCLNFS > ${FCLNFS%_clnfs.fa}_"clean.fa" &&
	mv $CLEANFISH/*clean.fa $CLEANADAPT
done && echo -e "## Step 04 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________

# M05 remove <25nt
checkIfDir "$CLEANADAPT"
echo -e "\e[01m## Step 05\e[0m"
echo -e "## Removing short sequences from:"
mkdir -p $LONGLEN
for FLONGLEN in $CLEANADAPT/*clean.fa
do
    checkIfFile $FLONGLEN $CLEANADAPT
    echo "   $(basename $FLONGLEN)"
	$FCHECKNT $FLONGLEN > ${FLONGLEN%_clean.fa}_length.fa &&
	mv $CLEANADAPT/*length.fa $LONGLEN
done && echo -e "## Step 05 done!\n" && sleep 0.2
#_______________________________________________________________________________________________________________________________
