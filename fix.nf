/* 
 
 */
nextflow.enable.dsl = 2
params.reads = "$baseDir/data/*_R{1,2}.fastq.gz"
params.outdir = "$baseDir/test-mess/"
params.crash = false
 
reads = Channel
        .fromFilePairs(params.reads, checkIfExists: true)

        
// prints to the screen and to the log
log.info """
         WatchMyMess
         ===================================
         reads        : ${params.reads}
         outdir       : ${params.outdir}

         Specs        : ${params.max_cpus} CPUs, ${params.max_memory} RAM
         """
         .stripIndent()


process FILT {
    tag "${sample_id}"
    
    input:
    tuple val(sample_id), path(reads) 

    output:
    tuple val(sample_id), path("filt/${sample_id}_R{1,2}.fastq.gz")  

    script:
    """
    mkdir filt
    touch filt/${sample_id}_R1.fastq.gz
    touch filt/${sample_id}_R2.fastq.gz
    """     
}
process ASSEMBLE {
    tag "$sample_id"
    publishDir "$params.outdir/", 
        mode: 'copy'

    input:
    tuple val(sample_id), path(reads) 

    
    output:
    tuple val(sample_id), path("${sample_id}.contigs.fa")  

    script:
    """
    ls ${reads[0]} ${reads[1]} > ${sample_id}.contigs.fa
    """ 
}
 


process MAXBIN {
    tag "$sample_id"
    label "process_medium"
    publishDir "$params.outdir/maxbin/", 
        pattern: "*.fasta",
        mode: 'copy'

    input:
    tuple val(sample_id), path(reads) 
    tuple val(sample_id), path(contigs) 
    
    output:
    tuple val(sample_id), path("*.maxbin.*.fasta"), optional: true, emit: bins    //Mock1.maxbin.001.fasta

    script:
    """
    echo "MaxBin" > ${sample_id}.maxbin.001.fasta
    echo "Contigs: ${contigs}" >> ${sample_id}.maxbin.CTGS.fasta
    echo "Reads: ${reads[0]} ${reads[1]}" >> ${sample_id}.maxbin.READS.fasta
    """     
}

process DEPTHS {
    tag "$sample_id"
    label "process_medium"
 

    input:
    tuple val(sample_id), path(bamfile) 
    
    output:
    tuple val(sample_id), path("${sample_id}.depth.txt")

    script:
    """
    echo "jgi_summarize_bam_contig_depths:${sample_id}.bam" > ${sample_id}.depth.txt 
        
 
    """     
}


process METABAT2 {
    tag "$sample_id"
    label "process_medium"
    publishDir "$params.outdir/metabat/",
        mode: 'copy'
 

    input:
    tuple val(sample_id), path(contigs)
    tuple val(sample_id), path(depth) 
    val(crash)
    
    
    output:
    tuple val(sample_id), path("*metabat.*.fa"), optional: true, emit: bins //Mock1.metabat.5.fa

    script:
    """
    ls | sort > ${sample_id}.metabat.inputs.fa
    echo ${sample_id} > ${sample_id}.metabat.id.fa
    echo "Contigs: ${contigs}" >  ${sample_id}.metabat.ctgs.fa  
    
    if [[ ! -e ${sample_id}.contigs.fa ]]; then
        echo "Processing ${sample_id} we found the contigs from another sample: \$(ls *.contigs.fa)" | tee ${sample_id}.metabat.error.fa
        if [[ ${crash} == true ]]; then
            echo "Crashing"
            exit 1
        fi
    fi

    """     
}
 
 
process INDEX {
    /*   input.amb
         input.ann
         input.bwt
         input.pac
         input.sa
    */
    tag "$sample_id"
    label "process_medium"
 
    input:
    tuple val(sample_id), path(contigs) 

    
    output:
    tuple val("${contigs}"), path("${contigs}.*")  

    script:
    """
    touch ${contigs}.amb
    touch ${contigs}.ann
    touch ${contigs}.bwt
    touch ${contigs}.pac
    touch ${contigs}.sa
    """    
}

process MAP {
    tag "$sample_id"
    label "process_medium"
 
    input:
    tuple val(sample_id), path(reads) 
    tuple val(index_name), path(index)
    
    output:
    tuple val(sample_id), path("${sample_id}.bam*")  

    script:
    """
    echo "Reads: ${reads[0]},${reads[1]}" > ${sample_id}.bam
    echo "Index: ${index_name}" >> ${sample_id}.bam
    ls -l >> ${sample_id}.bam



    """    
}

workflow {
    FILT( reads )
    ASSEMBLE( FILT.out )
    INDEX( ASSEMBLE.out )
    MAP( FILT.out, INDEX.out )
    MAXBIN( FILT.out, ASSEMBLE.out )
    DEPTHS( MAP.out )
    METABAT2(  ASSEMBLE.out, DEPTHS.out, params.crash )

}
