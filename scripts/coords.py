# coding: utf-8
import sys

FILE=sys.argv[1]
with open(FILE) as arq:
    arq=arq.readlines()
    print('id,start,end')
    for linha in arq:
        linha=linha.strip()
        if not linha.startswith('#'):
            qname,sname,*_,sstart,send,_,_=linha.split()
            print(f'{sname},{sstart},{send}')
            
