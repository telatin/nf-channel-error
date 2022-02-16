#!/bin/bash -ue
echo "Reads: T8_R1.fastq.gz,T8_R2.fastq.gz" > T8.bam
echo "Index: GTA9375293.contigs.fa" >> T8.bam
ls -l >> T8.bam
