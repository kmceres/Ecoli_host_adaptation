#!/bin/bash 
#usage ./copy_gff.sh phenDogs_sample_wanted.txt dir
input=$1
dir=$2
mkdir prokka_out 
while IFS= read -r line
do
	echo $line
	cp $line.gff dir
done < "$input"
