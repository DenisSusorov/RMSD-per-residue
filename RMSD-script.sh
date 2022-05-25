#!/bin/bash
echo "1.PDBs to compare should have the same chain naming"
echo "2.Should have NO SegIDs"
echo "3.Should have bfactor column set to 0 (in ChimeraX, setattr atoms bfactor 0 )"
echo
echo "Enter fisrt pdb"
read fpdb
echo "Enter second pdb"
read spdb
pdb1=${fpdb%.*}
pdb2=${spdb%.*}
mkdir $PWD/$pdb1-$pdb2-RMSD-scratch
cd $PWD/$pdb1-$pdb2-RMSD-scratch
grep ATOM ../$fpdb > pdba.pdb
grep ATOM ../$spdb > pdbb.pdb
awk 'NR==FNR{b[$(NF-6)$(NF-7)$(NF-8)]++;next};b[$(NF-6)$(NF-7)$(NF-8)] > 0' pdbb.pdb pdba.pdb | awk '{print $(NF-5),$(NF-4),$(NF-3)}'>$pdb2-coordinates
awk 'NR==FNR{c[$(NF-6)$(NF-7)$(NF-8)]++;next};c[$(NF-6)$(NF-7)$(NF-8)] > 0' pdba.pdb pdbb.pdb | awk '{print $(NF-5),$(NF-4),$(NF-3)}'>$pdb1-coordinates
paste  $pdb1-coordinates $pdb2-coordinates> $pdb1-$pdb2-coordinates
awk '{print(sqrt(($1-$4)^2+($2-$5)^2+($3-$6)^2))}' $pdb1-$pdb2-coordinates >RMSD
awk 'NR==FNR{b[$(NF-6)$(NF-7)$(NF-8)]++;next};b[$(NF-6)$(NF-7)$(NF-8)] > 0' pdbb.pdb pdba.pdb > $pdb1-commonAtoms.pdb
gawk 'NR==FNR { pdb[NR]=$0; next }{n=split(pdb[FNR],flds,FS,seps); flds[n-1]=sprintf("%6.2f", $1);for (i=1;i in flds;i++) {printf "%s%s", flds[i], seps[i]}; print ""}' $pdb1-commonAtoms.pdb RMSD> $pdb1-RMSD.pdb
echo "Your files are in $pdb1-$pdb2-RMSD-scratch"
echo "4.in ChimeraX, select atoms (probably, only mainchain) with desirable RMSD (select #2@@bfactor>2.5 & mainchain)"

