#!/bin/bash 
#usage ./change_ecoli_gff_names.sh results_wo_long_branch_DH_list.txt 

input=$1

while IFS= read -r line
do
	echo $line
	id=${line%_*_*_*}
	echo $id
	#newname=$(cut -d_ -f1,2 $line).gff
	#echo $newname
#	cp ${line} ./shortened_name_gffs/${id}.gff

done < "$input"
