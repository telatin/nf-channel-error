#!/bin/bash -ue
ls | sort > A.metabat.inputs.fa
echo A > A.metabat.id.fa
echo "Contigs: A.contigs.fa" >  A.metabat.ctgs.fa  

if [[ ! -e A.contigs.fa ]]; then
    echo "Processing A we found the contigs from another sample: $(ls *.contigs.fa)" | tee A.metabat.error.fa
    if [[ true == true ]]; then
        echo "Crashing"
        exit 1
    fi
fi
