 #!/usr/bin/env bash

# Mariana cancian master's pipeline 

# Set default working directory
export WD="."

# Softwares settings
BLAST="/home/labdros/software/ncbi-blast-2.10.0+/bin/blastn"
FQTOFA="$(which fastq_to_fasta)"

# Directories
FASTQIN="$WD/01_FASTQ"
MOSFQ="$WD/02_MOSFQ"
MOSFA="$WD/03_MOSFA"
CLEANFISH="$WD/04_CLEANFISH"
CLEANADAPT="$WD/05_CLEANADAPT"
LONGLEN="$WD/06_LONGLENGTH"
SELFBLAST="$WD/07_SELFBLAST"
ONEHIT="$WD/08.01_ONEHIT"
MULTIHIT="$WD/08.02_MULTIHIT"
FILTHIT="$WD/09_FILTHIT"
SCOV="$WD/10_SCOV"
QSCOV70="$WD/11_QSCOV70"
IDSEQ="$WD/12_IDSEQ"
FILTER3="$WD/13_FILTREDUNDANCE"
SAMPLEBLAST="$WD/14_SAMPLEBLAST"
TMPIDS="$WD/.tmp-ids"
CACT="$WD/15.1_CACT"
SEMCACT="$WD/15.2_SEMCACT"
RBHBLAST="$WD/16_RBHBLAST"

# Files
REF1="$WD/00_reference/Mos_3.fasta"
REF2="$WD/00_reference/Mos_5.fasta"
GPAT1="$WD/00_reference/gpat1.tmp"
GPAT2="$WD/00_reference/gpat2.tmp"
ADAPTTOTAL="$WD/00_reference/adapt_total_limpo.txt"

# Fastafinal_clean input
r1_159_mos5="$FILTER3/r1_159_mos5_fastafinal_clean.fa"
r1_159_mos3="$FILTER3/r1_159_mos3_fastafinal_clean.fa"
r1_160_mos3="$FILTER3/r1_160_mos3_fastafinal_clean.fa"
r1_160_mos5="$FILTER3/r1_160_mos5_fastafinal_clean.fa"
r1_161_mos3="$FILTER3/r1_161_mos3_fastafinal_clean.fa"
r1_161_mos5="$FILTER3/r1_161_mos5_fastafinal_clean.fa"
r1_300_mos3="$FILTER3/r1_300_mos3_fastafinal_clean.fa"
r1_300_mos5="$FILTER3/r1_300_mos5_fastafinal_clean.fa"
r1_301_mos3="$FILTER3/r1_301_mos3_fastafinal_clean.fa"
r1_301_mos5="$FILTER3/r1_301_mos5_fastafinal_clean.fa"
r1_302_mos3="$FILTER3/r1_302_mos3_fastafinal_clean.fa"
r1_302_mos5="$FILTER3/r1_302_mos5_fastafinal_clean.fa"
r1_303_mos3="$FILTER3/r1_303_mos3_fastafinal_clean.fa"
r1_303_mos5="$FILTER3/r1_303_mos5_fastafinal_clean.fa"
r1_304_mos3="$FILTER3/r1_304_mos3_fastafinal_clean.fa"
r1_304_mos5="$FILTER3/r1_304_mos5_fastafinal_clean.fa"
r1_305_mos3="$FILTER3/r1_305_mos3_fastafinal_clean.fa"
r1_305_mos5="$FILTER3/r1_305_mos5_fastafinal_clean.fa"
r1_306_mos3="$FILTER3/r1_306_mos3_fastafinal_clean.fa"
r1_306_mos5="$FILTER3/r1_306_mos5_fastafinal_clean.fa"
r1_307_mos3="$FILTER3/r1_307_mos3_fastafinal_clean.fa"
r1_307_mos5="$FILTER3/r1_307_mos5_fastafinal_clean.fa"
r1_308_mos3="$FILTER3/r1_308_mos3_fastafinal_clean.fa"
r1_308_mos5="$FILTER3/r1_308_mos5_fastafinal_clean.fa"

# Blastout
r1_159_161_mos3="$SAMPLEBLAST/r1_159_161_mos3.tsv"
r1_159_161_mos5="$SAMPLEBLAST/r1_159_161_mos5.tsv"
r1_160_161_mos3="$SAMPLEBLAST/r1_160_161_mos3.tsv"
r1_160_161_mos5="$SAMPLEBLAST/r1_160_161_mos5.tsv"
r1_160_306_mos3="$SAMPLEBLAST/r1_160_306_mos3.tsv"
r1_160_306_mos5="$SAMPLEBLAST/r1_160_306_mos5.tsv"
r1_161_159_mos3="$SAMPLEBLAST/r1_161_159_mos3.tsv"
r1_161_159_mos5="$SAMPLEBLAST/r1_161_159_mos5.tsv"
r1_161_160_mos3="$SAMPLEBLAST/r1_161_160_mos3.tsv"
r1_161_160_mos5="$SAMPLEBLAST/r1_161_160_mos5.tsv"
r1_300_304_mos3="$SAMPLEBLAST/r1_300_304_mos3.tsv"
r1_300_304_mos5="$SAMPLEBLAST/r1_300_304_mos5.tsv"
r1_301_305_mos3="$SAMPLEBLAST/r1_301_305_mos3.tsv"
r1_301_305_mos5="$SAMPLEBLAST/r1_301_305_mos5.tsv"
r1_302_304_mos3="$SAMPLEBLAST/r1_302_304_mos3.tsv"
r1_302_304_mos5="$SAMPLEBLAST/r1_302_304_mos5.tsv"
r1_302_307_mos3="$SAMPLEBLAST/r1_302_307_mos3.tsv"
r1_302_307_mos5="$SAMPLEBLAST/r1_302_307_mos5.tsv"
r1_303_305_mos3="$SAMPLEBLAST/r1_303_305_mos3.tsv"
r1_303_305_mos5="$SAMPLEBLAST/r1_303_305_mos5.tsv"
r1_303_308_mos3="$SAMPLEBLAST/r1_303_308_mos3.tsv"
r1_303_308_mos5="$SAMPLEBLAST/r1_303_308_mos5.tsv"
r1_304_300_mos3="$SAMPLEBLAST/r1_304_300_mos3.tsv"
r1_304_300_mos5="$SAMPLEBLAST/r1_304_300_mos5.tsv"
r1_304_302_mos3="$SAMPLEBLAST/r1_304_302_mos3.tsv"
r1_304_302_mos5="$SAMPLEBLAST/r1_304_302_mos5.tsv"
r1_305_301_mos3="$SAMPLEBLAST/r1_305_301_mos3.tsv"
r1_305_301_mos5="$SAMPLEBLAST/r1_305_301_mos5.tsv"
r1_305_303_mos3="$SAMPLEBLAST/r1_305_303_mos3.tsv"
r1_305_303_mos5="$SAMPLEBLAST/r1_305_303_mos5.tsv"
r1_306_160_mos3="$SAMPLEBLAST/r1_306_160_mos3.tsv"
r1_306_160_mos5="$SAMPLEBLAST/r1_306_160_mos5.tsv"
r1_307_302_mos3="$SAMPLEBLAST/r1_307_302_mos3.tsv"
r1_307_302_mos5="$SAMPLEBLAST/r1_307_302_mos5.tsv"
r1_308_303_mos3="$SAMPLEBLAST/r1_308_303_mos3.tsv"
r1_308_303_mos5="$SAMPLEBLAST/r1_308_303_mos5.tsv"

#semcact
sc_159_161_mos3="$SEMCACT/r1_159_161_mos3_semadapt.tsv"
sc_159_161_mos5="$SEMCACT/r1_159_161_mos5_semadapt.tsv"
sc_160_161_mos3="$SEMCACT/r1_160_161_mos3_semadapt.tsv"
sc_160_161_mos5="$SEMCACT/r1_160_161_mos5_semadapt.tsv"
sc_160_306_mos3="$SEMCACT/r1_160_306_mos3_semadapt.tsv"
sc_160_306_mos5="$SEMCACT/r1_160_306_mos5_semadapt.tsv"
sc_161_159_mos3="$SEMCACT/r1_161_159_mos3_semadapt.tsv"
sc_161_159_mos5="$SEMCACT/r1_161_159_mos5_semadapt.tsv"
sc_161_160_mos3="$SEMCACT/r1_161_160_mos3_semadapt.tsv"
sc_161_160_mos5="$SEMCACT/r1_161_160_mos5_semadapt.tsv"
sc_300_304_mos3="$SEMCACT/r1_300_304_mos3_semadapt.tsv"
sc_300_304_mos5="$SEMCACT/r1_300_304_mos5_semadapt.tsv"
sc_301_305_mos3="$SEMCACT/r1_301_305_mos3_semadapt.tsv"
sc_301_305_mos5="$SEMCACT/r1_301_305_mos5_semadapt.tsv"
sc_302_304_mos3="$SEMCACT/r1_302_304_mos3_semadapt.tsv"
sc_302_304_mos5="$SEMCACT/r1_302_304_mos5_semadapt.tsv"
sc_302_307_mos3="$SEMCACT/r1_302_307_mos3_semadapt.tsv"
sc_302_307_mos5="$SEMCACT/r1_302_307_mos5_semadapt.tsv"
sc_303_305_mos3="$SEMCACT/r1_303_305_mos3_semadapt.tsv"
sc_303_305_mos5="$SEMCACT/r1_303_305_mos5_semadapt.tsv"
sc_303_308_mos3="$SEMCACT/r1_303_308_mos3_semadapt.tsv"
sc_303_308_mos5="$SEMCACT/r1_303_308_mos5_semadapt.tsv"
sc_304_300_mos3="$SEMCACT/r1_304_300_mos3_semadapt.tsv"
sc_304_300_mos5="$SEMCACT/r1_304_300_mos5_semadapt.tsv"
sc_304_302_mos3="$SEMCACT/r1_304_302_mos3_semadapt.tsv"
sc_304_302_mos5="$SEMCACT/r1_304_302_mos5_semadapt.tsv"
sc_305_301_mos3="$SEMCACT/r1_305_301_mos3_semadapt.tsv"
sc_305_301_mos5="$SEMCACT/r1_305_301_mos5_semadapt.tsv"
sc_305_303_mos3="$SEMCACT/r1_305_303_mos3_semadapt.tsv"
sc_305_303_mos5="$SEMCACT/r1_305_303_mos5_semadapt.tsv"
sc_306_160_mos3="$SEMCACT/r1_306_160_mos3_semadapt.tsv"
sc_306_160_mos5="$SEMCACT/r1_306_160_mos5_semadapt.tsv"
sc_307_302_mos3="$SEMCACT/r1_307_302_mos3_semadapt.tsv"
sc_307_302_mos5="$SEMCACT/r1_307_302_mos5_semadapt.tsv"
sc_308_303_mos3="$SEMCACT/r1_308_303_mos3_semadapt.tsv"
sc_308_303_mos5="$SEMCACT/r1_308_303_mos5_semadapt.tsv"

#rbh
rbh_159_161_mos3="$RBHBLAST/rbh_159_161_mos3.tsv"
rbh_159_161_mos5="$RBHBLAST/rbh_159_161_mos5.tsv"
rbh_160_161_mos3="$RBHBLAST/rbh_160_161_mos3.tsv"
rbh_160_161_mos5="$RBHBLAST/rbh_160_161_mos5.tsv"
rbh_304_300_mos3="$RBHBLAST/rbh_304_300_mos3.tsv"
rbh_304_300_mos5="$RBHBLAST/rbh_304_300_mos5.tsv"
rbh_305_301_mos3="$RBHBLAST/rbh_305_301_mos3.tsv"
rbh_305_301_mos5="$RBHBLAST/rbh_305_301_mos5.tsv"
rbh_304_302_mos3="$RBHBLAST/rbh_304_302_mos3.tsv"
rbh_304_302_mos5="$RBHBLAST/rbh_304_302_mos5.tsv"
rbh_305_303_mos3="$RBHBLAST/rbh_305_303_mos3.tsv"
rbh_305_303_mos5="$RBHBLAST/rbh_305_303_mos5.tsv"
rbh_302_307_mos3="$RBHBLAST/rbh_302_307_mos3.tsv"
rbh_302_307_mos5="$RBHBLAST/rbh_302_307_mos5.tsv"
rbh_303_308_mos3="$RBHBLAST/rbh_303_308_mos3.tsv"
rbh_303_308_mos5="$RBHBLAST/rbh_303_308_mos5.tsv"
rbh_160_306_mos3="$RBHBLAST/rbh_160_306_mos3.tsv"
rbh_160_306_mos5="$RBHBLAST/rbh_160_306_mos5.tsv"

# M01: get sequences with mariner
mkdir -p $MOSFQ
for FASTQ in $FASTQIN/*.fastq;
do
	# Grep mos3 and mos5 patterns
	grep -v '>' $REF1 > $GPAT1
	grep -v '>' $REF2 > $GPAT2
	# Grep sequences with mos3 pattern
	grep -f $GPAT1 $FASTQ -B1 -A2 | sed '/^--$/d' > ${FASTQ%.fastq}_mos3.fastq &&
	mv $FASTQIN/*_mos3.fastq $MOSFQ && rm $GPAT1
	# Grep sequences with mos5 pattern
	grep -f $GPAT2 $FASTQ -B1 -A2 | sed '/^--$/d' > ${FASTQ%.fastq}_mos5.fastq &&
	mv $FASTQIN/*_mos5.fastq $MOSFQ && rm $GPAT2
done
#_______________________________________________________________________________________________________________________________

# M02: fastq to fasta
mkdir -p $MOSFA
for FMOSFQ in $MOSFQ/*.fastq;
do 
	$FQTOFA -i $FMOSFQ -o ${FMOSFQ%.fastq}."fa" &&
	mv $MOSFQ/*.fa $MOSFA
done
#_______________________________________________________________________________________________________________________________

# M03: remove mariner and adapters (and "fish" sequence)
mkdir -p $CLEANFISH
for FMOSFA in $MOSFA/*.fa
do
	# Remove mariner and "fish" from mos3 and mos5
	sed -e "s/TTATTCTAAGTATTTGCCGTCGC.*//;s/AAGTAGGGAATGTCGGTTCG.*//" $FMOSFA > ${FMOSFA%.fa}_clnfs.fa &&
	mv $MOSFA/*clnfs.fa $CLEANFISH
done
#_______________________________________________________________________________________________________________________________

# M04: Remove adapters and arctifacts from sequences
mkdir -p $CLEANADAPT
for FCLNFS in $CLEANFISH/*.fa
do
	sed -f <(sort -r "$ADAPTTOTAL" | sed 's/.*/s|&||/') $FCLNFS > ${FCLNFS%_clnfs.fa}_"clean.fa" &&
	mv $CLEANFISH/*clean.fa $CLEANADAPT
done
#_______________________________________________________________________________________________________________________________

# M05 remove <25nt
mkdir -p $LONGLEN
for FLONGLEN in $CLEANADAPT/*clean.fa
do
	python3 M05_check_nt_vanilla.py $FLONGLEN > ${FLONGLEN%_clean.fa}_length.fa &&
	mv $CLEANADAPT/*length.fa $LONGLEN
done
#_______________________________________________________________________________________________________________________________

# M06: Selfblast 
mkdir -p $SELFBLAST
for CLEANFA in $LONGLEN/*length.fa
do
	$BLAST -query $CLEANFA -subject $CLEANFA -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out ${CLEANFA%_length.fa}_blastout.tsv &&
	mv $LONGLEN/*blastout.tsv $SELFBLAST
done
#_______________________________________________________________________________________________________________________________

# M07: separate onehit files from multihit files 
mkdir -p $ONEHIT $MULTIHIT
for FSBLAST in $SELFBLAST/*blastout.tsv;
do
	# Cria arquivo com sequências com só um hit (elas mesmas)
	grep "# 1 hits found" -A1 $FSBLAST | sed '/^--$/d;/^#/d' > ${FSBLAST%_blastout.tsv}_onehit.tsv &&
	sed -i '1i qseqid\tsseqid\tpident\tlen\tqlen\tslen\tevalue\tbitscore\tqcovs\tqstart\tqend\tsstart\tsend\tqseq\tsseq' ${FSBLAST%_blastout.tsv}_onehit.tsv &&
	mv $SELFBLAST/*onehit.tsv $ONEHIT
	# Cria arquivo com as sequências com mais de um hit
	sed '/# 1 hits found/,+1 d;/^# /d' $FSBLAST > ${FSBLAST%_blastout.tsv}_multihit.tsv &&
	sed -i '1i qseqid\tsseqid\tpident\tlen\tqlen\tslen\tevalue\tbitscore\tqcovs\tqstart\tqend\tsstart\tsend\tqseq\tsseq' ${FSBLAST%_blastout.tsv}_multihit.tsv &&
	mv $SELFBLAST/*multihit.tsv $MULTIHIT	
done
#_______________________________________________________________________________________________________________________________

# M08: Filter 1 (redundance)
mkdir -p $FILTHIT
for MHIT in $MULTIHIT/*multihit.tsv;
do
	python3 M08_filter_reciprocal_hits.py $MHIT ${MHIT%_multihit.tsv}_mhit_filt.tsv &&
	mv $MULTIHIT/*filt.tsv $FILTHIT
done
#_______________________________________________________________________________________________________________________________

# M09: scov table creation
mkdir -p $SCOV
for FSCOV in $FILTHIT/*filt.tsv;
do
	sed '1d' $FSCOV | 
	awk '{$16=int(($4/$6)*100)}1' |
	sed '1i qseqid\tsseqid\tpident\tlen\tqlen\tslen\tevalue\tbitscore\tqcovs\tqstart\tqend\tsstart\tsend\tqseq\tsseq\tscov' |
	awk '{ print $1,$2,$3,$4,$5,$6,$7,$8,$9,$16,$10,$11,$12,$13,$14,$15 }' |
	sed 's/ /\t/g' > ${FSCOV%_mhit_filt.tsv}_scov.tsv &&
	mv $FILTHIT/*scov.tsv $SCOV
done
# _______________________________________________________________________________________________________________________________

# M10: get a representative sequence (q/scov>=70)
mkdir -p $QSCOV70
for QSCOV in $SCOV/*scov.tsv
do
	python3 M10_qcov70_filtro.py $QSCOV ${QSCOV%_scov.tsv}_qscov70.tsv &&
	mv $SCOV/*qscov70.tsv $QSCOV70
done
#_______________________________________________________________________________________________________________________________

# M11: get sequences from list of ids
mkdir -p $IDSEQ
mkdir -p $TMPIDS
# Get ids
for FIDS in $QSCOV70/*qscov70.tsv;
do
	cut -f1 $FIDS | sed "/qseqid/d" | sort | uniq > ${FIDS%_qscov70.tsv}_ids.txt &&
	mv ${FIDS%_qscov70.tsv}_ids.txt $TMPIDS
done
# Get sequences
for FIDSEQ in $LONGLEN/*_length.fa
do
	FID=${FIDSEQ%_length.fa}_ids.txt
	grep -A1 -f $TMPIDS/${FID#\.\/06_LONGLENGTH\/} $FIDSEQ | sed '/^--$/d' > ${FIDSEQ%_length.fa}_fastafinal.fa &&
	mv $LONGLEN/*fastafinal.fa $IDSEQ
done
#---------------------------------------------------------------------------------------------------------------------------------
# M12: Filter 2 (new redundance clear) 
mkdir -p $FILTER3
for FILT3 in $IDSEQ/*fastafinal.fa
do
	python3 M12_uniqs_seqs.py $FILT3 > ${FILT3%.fa}_clean.fa &&
	mv $IDSEQ/*clean.fa $FILTER3
done
#---------------------------------------------------------------------------------------------------------------------------------
# M13: blast between samples
mkdir -p $SAMPLEBLAST 
$BLAST -query $r1_159_mos3 -subject $r1_161_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_159_161_mos3
$BLAST -query $r1_159_mos5 -subject $r1_161_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_159_161_mos5
$BLAST -query $r1_161_mos3 -subject $r1_159_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_161_159_mos3
$BLAST -query $r1_161_mos5 -subject $r1_159_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_161_159_mos5
$BLAST -query $r1_160_mos3 -subject $r1_161_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_160_161_mos3
$BLAST -query $r1_160_mos5 -subject $r1_161_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_160_161_mos5
$BLAST -query $r1_161_mos3 -subject $r1_160_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_161_160_mos3
$BLAST -query $r1_161_mos5 -subject $r1_160_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_161_160_mos5
$BLAST -query $r1_304_mos3 -subject $r1_300_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_304_300_mos3
$BLAST -query $r1_304_mos5 -subject $r1_300_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_304_300_mos5
$BLAST -query $r1_300_mos3 -subject $r1_304_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_300_304_mos3
$BLAST -query $r1_300_mos5 -subject $r1_304_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_300_304_mos5
$BLAST -query $r1_305_mos3 -subject $r1_301_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_305_301_mos3
$BLAST -query $r1_305_mos5 -subject $r1_301_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_305_301_mos5
$BLAST -query $r1_301_mos3 -subject $r1_305_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_301_305_mos3
$BLAST -query $r1_301_mos5 -subject $r1_305_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_301_305_mos5
$BLAST -query $r1_304_mos3 -subject $r1_302_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_304_302_mos3
$BLAST -query $r1_304_mos5 -subject $r1_302_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_304_302_mos5
$BLAST -query $r1_302_mos3 -subject $r1_304_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_302_304_mos3
$BLAST -query $r1_302_mos5 -subject $r1_304_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_302_304_mos5
$BLAST -query $r1_305_mos3 -subject $r1_303_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_305_303_mos3
$BLAST -query $r1_305_mos5 -subject $r1_303_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_305_303_mos5
$BLAST -query $r1_303_mos3 -subject $r1_305_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_303_305_mos3
$BLAST -query $r1_303_mos5 -subject $r1_305_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_303_305_mos5
$BLAST -query $r1_302_mos3 -subject $r1_307_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_302_307_mos3
$BLAST -query $r1_302_mos5 -subject $r1_307_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_302_307_mos5
$BLAST -query $r1_307_mos3 -subject $r1_302_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_307_302_mos3
$BLAST -query $r1_307_mos5 -subject $r1_302_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_307_302_mos5
$BLAST -query $r1_303_mos3 -subject $r1_308_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_303_308_mos3
$BLAST -query $r1_303_mos5 -subject $r1_308_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_303_308_mos5
$BLAST -query $r1_308_mos3 -subject $r1_303_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_308_303_mos3
$BLAST -query $r1_308_mos5 -subject $r1_303_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_308_303_mos5
$BLAST -query $r1_160_mos3 -subject $r1_306_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_160_306_mos3
$BLAST -query $r1_160_mos5 -subject $r1_306_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_160_306_mos5
$BLAST -query $r1_306_mos3 -subject $r1_160_mos3 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_306_160_mos3
$BLAST -query $r1_306_mos5 -subject $r1_160_mos5 -outfmt "7 qseqid sseqid pident length qlen slen evalue bitscore qcovs qstart qend sstart send qseq sseq" -out $r1_306_160_mos5

#_______________________________________________________________________________________________________________________________

# M14: Remove blast with adapt
mkdir -p $CACT $SEMCACT
for FCACT in $SAMPLEBLAST/*.tsv
do
	# get sequences with adapter
	grep CACTCTT $FCACT > ${FCACT%.tsv}_comadapt.tsv &&
	mv $SAMPLEBLAST/*comadapt.tsv $CACT
	# get sequences without adapter
	grep -v CACTCTT $FCACT > ${FCACT%.tsv}_semadapt.tsv &&
	mv $SAMPLEBLAST/*semadapt.tsv $SEMCACT
done
#_______________________________________________________________________________________________________________________________

# M15: reciprocal blast
mkdir -p $RBHBLAST

python2 M15_rbh.py $sc_159_161_mos3 $sc_161_159_mos3 1 2 10 high $rbh_159_161_mos3
python2 M15_rbh.py $sc_159_161_mos5 $sc_161_159_mos5 1 2 10 high $rbh_159_161_mos5
python2 M15_rbh.py $sc_160_161_mos3 $sc_161_160_mos3 1 2 10 high $rbh_160_161_mos3
python2 M15_rbh.py $sc_160_161_mos5 $sc_161_160_mos5 1 2 10 high $rbh_160_161_mos5
python2 M15_rbh.py $sc_304_300_mos3 $sc_300_304_mos3 1 2 10 high $rbh_304_300_mos3
python2 M15_rbh.py $sc_304_300_mos5 $sc_300_304_mos5 1 2 10 high $rbh_304_300_mos5
python2 M15_rbh.py $sc_305_301_mos3 $sc_301_305_mos3 1 2 10 high $rbh_305_301_mos3
python2 M15_rbh.py $sc_305_301_mos5 $sc_301_305_mos5 1 2 10 high $rbh_305_301_mos5
python2 M15_rbh.py $sc_304_302_mos3 $sc_302_304_mos3 1 2 10 high $rbh_304_302_mos3
python2 M15_rbh.py $sc_304_302_mos5 $sc_302_304_mos5 1 2 10 high $rbh_304_302_mos5
python2 M15_rbh.py $sc_305_303_mos3 $sc_303_305_mos3 1 2 10 high $rbh_305_303_mos3
python2 M15_rbh.py $sc_305_303_mos5 $sc_303_305_mos5 1 2 10 high $rbh_305_303_mos5
python2 M15_rbh.py $sc_302_307_mos3 $sc_307_302_mos3 1 2 10 high $rbh_302_307_mos3
python2 M15_rbh.py $sc_302_307_mos5 $sc_307_302_mos5 1 2 10 high $rbh_302_307_mos5
python2 M15_rbh.py $sc_303_308_mos3 $sc_308_303_mos3 1 2 10 high $rbh_303_308_mos3
python2 M15_rbh.py $sc_303_308_mos5 $sc_308_303_mos5 1 2 10 high $rbh_303_308_mos5
python2 M15_rbh.py $sc_160_306_mos3 $sc_306_160_mos3 1 2 10 high $rbh_160_306_mos3
python2 M15_rbh.py $sc_160_306_mos5 $sc_306_160_mos5 1 2 10 high $rbh_160_306_mos5
