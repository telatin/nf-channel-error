#!/bin/bash -ue
ls | sort > B.metabat.inputs.fa
echo B > B.metabat.id.fa
echo "Contigs: T8.contigs.fa" >  B.metabat.ctgs.fa  

if [[ ! -e B.contigs.fa ]]; then
    echo "Processing B we found the contigs from another sample: $(ls *.contigs.fa)" | tee B.metabat.error.fa
    if [[ true == true ]]; then
        echo "Crashing"
        exit 1
    fi
fi
