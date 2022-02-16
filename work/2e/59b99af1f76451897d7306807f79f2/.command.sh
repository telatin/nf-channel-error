#!/bin/bash -ue
echo "Reads: S01_R1.fastq.gz,S01_R2.fastq.gz" > S01.bam
echo "Index: B.contigs.fa" >> S01.bam
ls -l >> S01.bam
