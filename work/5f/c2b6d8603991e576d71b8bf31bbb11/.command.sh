#!/bin/bash -ue
echo "Reads: A_R1.fastq.gz,A_R2.fastq.gz" > A.bam
echo "Index: T8.contigs.fa" >> A.bam
ls -l >> A.bam
