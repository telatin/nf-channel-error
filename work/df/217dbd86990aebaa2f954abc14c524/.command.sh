#!/bin/bash -ue
echo "Reads: B_R1.fastq.gz,B_R2.fastq.gz" > B.bam
echo "Index: A.contigs.fa" >> B.bam
ls -l >> B.bam
