#!/bin/bash -ue
ls | sort > A.metabat.inputs.fa
echo A > A.metabat.id.fa
echo "Contigs: T8.contigs.fa" >  A.metabat.ctgs.fa  

if [[ ! -e A.contigs.fa ]]; then
    echo "Processing A we found the contigs from another sample: $(ls *.contigs.fa)" | tee A.metabat.error.fa
    if [[ false == true ]]; then
        echo "Crashing"
        exit 1
    fi
fi
