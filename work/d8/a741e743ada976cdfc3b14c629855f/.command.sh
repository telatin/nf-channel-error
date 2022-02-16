#!/bin/bash -ue
ls | sort > T8.metabat.inputs.fa
echo T8 > T8.metabat.id.fa
echo "Contigs: GTA9375293.contigs.fa" >  T8.metabat.ctgs.fa  

if [[ ! -e T8.contigs.fa ]]; then
    echo "Processing T8 we found the contigs from another sample: $(ls *.contigs.fa)" | tee T8.metabat.error.fa
    if [[ true == true ]]; then
        echo "Crashing"
        exit 1
    fi
fi
