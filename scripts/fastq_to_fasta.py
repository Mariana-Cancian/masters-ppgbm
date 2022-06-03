#!/usr/bin/env python3

import os
import sys
try:
    from Bio import SeqIO
except ModuleNotFoundError:
    #message=f"Biopython not found.\nCheck if it is installed or in PATH."
    sys.exit("## ERROR:\nBiopython not found.\nCheck if it is installed and in PATH.")

try:
# Input (fastq file)
    FASTQ=sys.argv[1]
    FASTA=os.path.splitext(FASTQ)[0]
    FASTA=f'{FASTA}.fa'
    # Convert
    #print('Converting...')
    SeqIO.convert(FASTQ,'fastq',FASTA,'fasta')
except IndexError:
    sys.exit("File(s) missing.")

#print('Done!')
