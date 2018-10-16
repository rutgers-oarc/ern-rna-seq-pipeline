#!/bin/bash
cd /home/bd387/RNA-Seq-Jobs
pwd
ls /home/bd387/simg-repo/
export PATH=$PATH:/usr/local/bin:.
echo "HOSTNAME"
echo "=================="
hostname 
echo "=================="
echo $PATH 
echo $PATH 
kallisto --help
nextflow run rna-seq-trans-align.nf -with-trace -with-report RNA-seq-nf.html  -with-timeline RNA-seq-nf-timeline.html -with-dag flowchart.png 
rm -rf /home/bd387/RNA-Seq-Jobs/work
exit
