#!/bin/bash -ue
ls | sort > GTA9375293.metabat.inputs.fa
echo GTA9375293 > GTA9375293.metabat.id.fa
echo "Contigs: A.contigs.fa" >  GTA9375293.metabat.ctgs.fa  

if [[ ! -e GTA9375293.contigs.fa ]]; then
    echo "Processing GTA9375293 we found the contigs from another sample: $(ls *.contigs.fa)" | tee GTA9375293.metabat.error.fa
    if [[ false == true ]]; then
        echo "Crashing"
        exit 1
    fi
fi
