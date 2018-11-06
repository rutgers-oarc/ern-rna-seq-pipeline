#!/bin/bash
export PATH=$PATH:/usr/local/bin:.
echo "DATE" >> job-hostnames.out
date >> job-hostnames.out
echo "COMPUTE-NODE" >> job-hostnames.out
echo "==================" >> job-hostnames.out
hostname  >> job-hostnames.out
echo "==================" >> job-hostnames.out
echo $PATH 
nextflow run rna-seq-trans-align.nf -with-trace -with-report RNA-seq-nf.html  -with-timeline RNA-seq-nf-timeline.html
rm -rf work
exit
