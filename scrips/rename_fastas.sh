#!/bin/bash 
#usage ../../scrips/rename_fastas.sh fasta_name_list_long.txt 

input=$1

while IFS= read -r line
do
	echo $line
	id=${line%_*_*}
	echo $id
	newname=$id.fna
	echo $newname
	mv ${line} $newname
	#newname=$(cut -d_ -f1,2 $line).gff
	#echo $newname
#	cp ${line} ./shortened_name_gffs/${id}.gff

done < "$input"
