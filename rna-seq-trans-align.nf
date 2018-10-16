/*
===============================================================
 RNA sequence analysis pipeline with Kallisto and Sleuth
===============================================================
 ##   Kallisto+Sleuth pipeline.  Sept 2018.
 ##   ---------------------------------------------------------------
 ##   The pipeline is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY.
 ##   --------------------------------------------------
 ##   Authors
 ##   Bala Desinghu <dmbala@gmail.com>
 ##   https://github.com/dmbala
 */


log.info "kallisto-rna-seq "
log.info "========================"
log.info "reads                  : ${params.reads}"
log.info "transcriptome          : ${params.transcriptome}"
log.info "experimental design    : ${params.experiment}"
log.info "output                 : ${params.output}"
log.info "fragment length        : ${params.fragment_len} nt"
log.info "fragment SD            : ${params.fragment_sd} nt"
log.info "bootstraps             : ${params.bootstrap}"
log.info "\n"

/*
 * Create a channel for read files 
 */

Channel
    .fromFilePairs( params.reads, size: params.SingleEnd ? 1 : 2 )
    .ifEmpty { exit 1, "Cannot find any reads matching: ${params.reads}\nNB" }
    .into {read_files; ch_print }
ch_print.subscribe {println "ch_print: $it"}


/*
 * Input parameters validation
 */

transcriptome_file     = file(params.transcriptome)
exp_file               = file(params.experiment) 

/*
 * validate input files
 */
if( !transcriptome_file.exists() ) exit 1, "Missing transcriptome file: ${transcriptome_file}"
if( !exp_file.exists() ) exit 1, "Missing experimental design file: ${exp_file}"

process index {
    input:
    file transcriptome_file
    
    output:
    file "transcriptome.index" into transcriptome_index
      
    script:
    """
    kallisto index -i transcriptome.index ${transcriptome_file}
    """
}

 
process mapping {
    tag "reads"

    input:
    file index from transcriptome_index
    set val(name), file(reads) from read_files

    output:
    file "kallisto_out_${name}" into kallisto_out_dirs 

    script:
    //
    // Kallisto tools mapper
    //
    def single = reads instanceof Path
    if( !single ) {
        """
        mkdir -p kallisto_output
        kallisto quant -l ${params.fragment_len} -s ${params.fragment_sd} -b ${params.bootstrap} -i ${index} -t ${task.cpus} -o kallisto_out_${name} ${reads}
        """
    }  
    else {
        """
        mkdir -p kallisto_output
        #kallisto quant --single -l ${params.fragment_len} -s ${params.fragment_sd} -b ${params.bootstrap} -i ${index} -t ${task.cpus} -o kallisto_output ${reads}
        kallisto quant --single -l ${params.fragment_len} -s ${params.fragment_sd} -b ${params.bootstrap} -i ${index} -o kallisto_out_${name} ${reads}
        """
    }
}

process sleuth {
    input:
    file "kallisto/*" from kallisto_out_dirs.collect()   
    file exp_file

    output: 
    file 'sleuth_object.so'
    file 'gene_table_results.txt'
    file 'SleuthResults.pdf'
 

    script:
    """
    sleuth.R kallisto ${exp_file}
    """
}

