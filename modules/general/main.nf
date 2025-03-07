#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process count {
    tag { "${job_id}.count" }
    publishDir "${params.out_dir}", mode: 'copy', overwrite: false
    label 'ubuntu'

    input:
        val(job_id)

    output:
        file("out.${job_id}.txt")

    script:
    """   
        for i in {1..10}; do echo \$i; sleep 2; done > out.${job_id}.txt 
    """ 
}

process combine {
    tag { "combine" }
    memory { 2.GB * task.attempt }
    publishDir "${params.out_dir}", mode: 'copy', overwrite: false
    label 'ubuntu'

    input:
       file('*') 

    output:
        file("combine.txt")

    script:
    """   
        cat * > combine.txt
    """ 
}

