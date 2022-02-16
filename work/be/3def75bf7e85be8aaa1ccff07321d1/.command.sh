#!/bin/bash -ue
ls | sort > S01.metabat.inputs.fa
echo S01 > S01.metabat.id.fa
echo "Contigs: B.contigs.fa" >  S01.metabat.ctgs.fa  

if [[ ! -e S01.contigs.fa ]]; then
    echo "Processing S01 we found the contigs from another sample: $(ls *.contigs.fa)" | tee S01.metabat.error.fa
    if [[ true == true ]]; then
        echo "Crashing"
        exit 1
    fi
fi
