#!/bin/bash -ue
ls | sort > B.metabat.inputs.fa
echo B > B.metabat.id.fa
echo "Contigs: B.contigs.fa" >  B.metabat.ctgs.fa  

if [[ ! -e B.contigs.fa ]]; then
    echo "Processing B we found the contigs from another sample: $(ls *.contigs.fa)" | tee B.metabat.error.fa
    if [[ false == true ]]; then
        echo "Crashing"
        exit 1
    fi
fi
