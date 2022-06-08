#!/usr/bin/env python
# coding: utf-8

import sys
import pandas as pd

try:
    controle = sys.argv[1]
    tratamento = sys.argv[2]
    saida = sys.argv[3]
except IndexError:
    print("Missing argument.")
    exit()

try:
    df1 = pd.read_table(controle,comment='#',header=None,usecols=[0,1,7])
    df2 = pd.read_table(tratamento,comment='#',header=None,usecols=[0,1,7])
except FileNotFoundError as e1:
    print(e1)
    exit()

df1.rename(columns={0:'control',1:'treatment',7:'score'},inplace=True)
df2.rename(columns={1:'control',0:'treatment',7:'score'},inplace=True)

mergido = df1.merge(df2,on=['control','treatment'],suffixes=[' control',' treatment']).drop_duplicates().reset_index(drop=True)

grupos = mergido.groupby(['control','treatment'])[['score control','score treatment']].max().reset_index()
grupos = grupos.sort_values(['score control','score treatment'],ascending=False).reset_index(drop=True)

grupos.to_csv(saida, index=False, sep='\t')
