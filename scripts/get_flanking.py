# coding: utf-8
from pyfaidx import Fasta
# Set size of flanks
fsize=2000
# Read fasta file using pyfaidx
white=Fasta('umalinha.fasta')
# Read coordinates files
with open('gene_white_coords.csv') as tabela:
    tabela=tabela.readlines()
    for coord in tabela:
        coord=coord.strip()
        if not coord.startswith('id'):
            # Get coordinates
            contig, sstart, send = coord.split(',')
            sstart=int(sstart)
            send=int(send)
            # Size of fragment
            tamanho = send - sstart
            # Total sequence size
            seq_len = len(white[contig])
            # Check strand orientation
            if tamanho < 0:
                rend = sstart
                rstart = send
                # Set flanking coordinates
                rflank_up = rstart - fsize
                rflank_down = rend + fsize
                if rflank_up <= 0:
                    rflank_up = 1
                if rflank_down > seq_len:
                    rflank_down = seq_len
                # Get sequence with flanking regions
                anti_senso_up=white.get_seq(contig,rflank_up,rstart,rc=True)
                anti_senso_down=white.get_seq(contig,rend,rflank_down,rc=True)
                print(f'>{contig}:{rflank_up}-{rstart}_up_rc')
                print(anti_senso_up)
                print(f'>{contig}:{rend}-{rflank_down}_down_rc')
                print(anti_senso_down)
            else:
                # Set flanking coordinates
                flank_up = sstart - fsize
                flank_down = send + fsize
                if flank_up <= 0:
                    flank_up = 1
                if flank_down > seq_len:
                    flank_down = seq_len
                # Get sequence with flanking regions
                senso_up=white.get_seq(contig,flank_up,sstart)
                senso_down=white.get_seq(contig,send,flank_down)
                print(f'>{contig}:{flank_up}-{sstart}_up')
                print(senso_up)
                print(f'>{contig}:{send}-{flank_down}_down')
                print(senso_down)