# RMSD-per-residue
This bash script extracts matching atoms in two PDBs and calculates RMSD for them. It writes a new PDB file having atom coordinates from the first PDB and per atom RMSD in the b-factor column.

**Requirements**:

1. bash with gawk

2. In the two PDBs, same protein/nucleic acid chains should have the same chain IDs. Chain IDs can be changed through Pymol, Chimera, Phenix, etc. 

3. PDB files should NOT have SegID column. The majority of PDB files downloaded from PDBdatabase do not have this column by default. 

4. PDB files should have b-factor column set to 0 (in ChimeraX, setattr atoms bfactor 0) 

**Example of use** (with the help of ChimeraX):

1. I aligned two models of ribosome to find the relative orientation of small subunits. I set b-factors to 0 (setattr atoms bfactor 0) and saved both small subunits as separate PDB files. 
<img width="1341" alt="image2" src="https://user-images.githubusercontent.com/106203779/170151769-3c5d02a3-fc1f-4f2f-9bcf-e1cf26454751.png">
2. I run the script and got firstpdb-RMSD.pdb. When the PDB is colored by b-factor (in ChimeraX toolbar, molecule display->b-factor) it represents differences in RMSD.
<img width="1341" alt="image3" src="https://user-images.githubusercontent.com/106203779/170151773-de68d24a-70c2-44a8-8cc5-af239d771cfe.png">
3. I needed to select atoms which have the highest RMSD to design a mask for the most flexible parts of the molecule. To select the atoms I used the command  "select #2@@bfactor>2.5 & mainchain" in ChimeraX (I selected atoms with RMSD>2.5 Angstrom using only backbones).
<img width="1341" alt="image4" src="https://user-images.githubusercontent.com/106203779/170151780-7ed11408-4617-49e9-8bb7-876d57a3e649.png">
