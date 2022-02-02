#!/usr/bin/env python3
from pyfaidx import Fasta

mariner = Fasta('mariner_updown.fasta')
mariner_coords = 'mariner_coords_20220202.csv'

f_antes = 'flanco_antes.fasta'
f_depois = 'flanco_depois.fasta'

with open(mariner_coords) as tabela, open(f_antes,'w') as antes, open(f_depois,'w') as depois:
    tabela=tabela.readlines()
    for coord in tabela:
        coord = coord.strip()
        fid,sstart,send=coord.split(',')
        sstart = int(sstart)
        send = int(send)
        sequencia_antes = mariner.get_seq(fid,1,sstart)
        sequencia_depois = mariner.get_seq(fid,send,len(mariner[fid]))
        antes.write(f'>{fid}\n{sequencia_antes}\n')
        depois.write(f'>{fid}\n{sequencia_depois}\n')
