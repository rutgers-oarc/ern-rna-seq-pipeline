
# RNA sequence analysis pipeline using nextflow. 
<img src="https://github.com/rutgers-oarc/ern-rna-seq-pipeline/blob/master/flowchart.png" width="450px" height="350px" />

Nextflow pipeline to run a sample RNA sequence pipeline. Software packages are packed in a singularity image. In this RNA sequence analysis, the mapping step was done using pseudo alignment appoach combined with sleuth package for differential gene expression analysis. 

## Major steps 

To submit the pipeline, run the following
```
sbatch job-rna-seq.sbatch
```

The pipeline reads the fastq files in the directory `./InputData/reads`, performs the analysis, and stores the output data in the directory `./results`. 

## Files in the repo
    * InputData
    * RNA-seq-nf-timeline.html
    * RNA-seq-nf.html
    * ern_status_geoIP.png
    * flowchart.dot
    * index.html
    * job-rna-seq.sbatch
    * job-rna-seq.sh
    * nextflow.config
    * rna-seq-trans-align.nf
    * sleuth.R
    * sleuth_live.R
    * sleuth_live.sh
    * sleuth_pdfplots.R
    * trace.txt


