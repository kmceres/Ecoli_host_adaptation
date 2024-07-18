#!/bin/bash 
#usage ./copy_gff.sh phenDogs_sample_wanted.txt dir
input=$1
dir=$2
while IFS= read -r line
do
	echo $line
#	mv  $line/genomic.gff $line/$line.gff
	cp $line/$line.gff $dir/$line.gff
done < "$input"
