#snakefile for executing pocket occupancy analysis
#first requirement: directory of single-chain pdbs of interest
#TODO: environemnt config. Currently fpocket is not in an environment with snakemake

rule foldseek_format5:
    input:
        directory('one_chain_pdbs')
    output:
        directory('foldseek_ca_superimpose')
    shell:
        "python3 foldseek_format_mode5.py {input}/6YD0.pdb {input}" 

#To fix later: naming issue 
rule get_residue_number:
    input:
        ca_backbone_structures = directory('fold_seek_ca_superimpose')
        #lose param, might need to rethink
        #selected residues are sampled from res which have many atoms contacting alpha spheres vertices (more exposed)
        res_number = '106,350,180,289,179,214,114,188,282,212'
    output: 
        directory('get_residue_number_output')
    shell:
        'python3 get_residue_number.py {input.ca_backbone_structures}/superimpose_6YD0.pdb_6YD0.pdb.pdb {input.ca_backbone_structure}/ {input.res_number}'

rule fpocket:
    #Require that all relevant .pdb gets downloaded already
    input:
        pdb_directory=directory('one_chain_pdbs/')
        mapping='mapping.txt'
    output:
        directory('fpocket_output')
    shell:
        'python3 fpocket.py {input.mapping} {input.pdb_directory} 3 5'

rule process_pocket:
    input:
        mapping_file='get_residue_number_output/residue_table.csv'
        pdb_directory=directory('one_chain_pdbs')
        fpocket_output=directory('fpocket_output')
    output:
        directory('process_pocket_output')
    shell:
        'python3 process_pocket_v2.py fpocket_output get_residue_number_output/residue_table.csv 5 process_pocket_output one_chain_pdbs'

    
