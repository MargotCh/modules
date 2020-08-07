#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

params.outdir = "output/"
params.publish_dir_mode = "copy"
params.conda = false

include { FASTQC } from '../main.nf'

/*
 * Test with single-end data
 */
workflow test_single_end {

    def input = []
    input = [ [ id:'test', single_end:true ],
              [ file('input/test_single_end.fastq.gz', checkIfExists: true) ] ]

    FASTQC ( input, [ publish_dir:'test_single_end' ] )
}

/*
 * Test with paired-end data
 */
workflow test_paired_end {

    def input = []
    input = [ [ id:'test', single_end:false ],
              [ file('input/test_R1.fastq.gz', checkIfExists: true), file('input/test_R2.fastq.gz', checkIfExists: true) ] ]

    FASTQC ( input, [ publish_dir:'test_paired_end' ] )
}

workflow {
    test_single_end()
    test_paired_end()
}
