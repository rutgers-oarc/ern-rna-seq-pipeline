#!/bin/bash
n=$((1 + RANDOM % 9))
for i in $(seq 1 $n)
do 
    sbatch job-rna-seq.sbatch
    sleep 10 
done



