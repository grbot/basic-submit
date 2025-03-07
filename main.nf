#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// For general use
include { count; combine } from './modules/general/main.nf'

nr_jobs = params.nr_jobs

def range = (1..nr_jobs)

jobs = Channel.from(range)

workflow {
        out = count(jobs)
        combine(out.collect())
 }

 workflow.onComplete {
        println ( workflow.success ? """
        Pipeline execution summary
        ---------------------------
        Completed at: ${workflow.complete}
        Duration    : ${workflow.duration}
        Success     : ${workflow.success}
        workDir     : ${workflow.workDir}
        exit status : ${workflow.exitStatus}
        """ : """
        Failed: ${workflow.errorReport}
        exit status : ${workflow.exitStatus}
        """
        )
}
