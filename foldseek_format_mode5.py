"""
foldseek format-mode 5 for identifying residues to seach
"""

import os
import sys

#one pdb
QUERY_PDB = sys.argv[1]
#directory of pdbs
TARGET_DATABASE = sys.argv[2]

def exe_foldseek():
    os.system(f'foldseek easy-search {QUERY_PDB} {TARGET_DATABASE} superimpose_ tmp --format-mode 5')
    os.system('mkdir -p foldseek_ca_superimpose')
    #remove temp file and folder
    os.system('rm -rf tmp superimpose_')
    #move pdb to folder
    os.system('mv *.pdb foldseek_ca_superimpose')

if __name__ == '__main__':
    exe_foldseek()
