## Protocols

# Downloading data
* **conda env:** Ecoli_host
* NCBI Pathogen detector, https://www.ncbi.nlm.nih.gov/pathogens/isolates/#E.coli
* Filters:
	* 1-200 contigs
	* Organism group: E.coli and Shigella
	* Host: 
		* Canis lupus
		* Dog
		* canine
		* Homo_sapiens
		* Homo sapiens sapiens
		* dog
		* Canis lupus familiaris
		* Homo sapiens
	* File downloaded 7/17/24; Pathogen_browoser_Ecoli_meta.csv
* Filtering large metadata file:
	* Prepare_metadata.R

* Download genomes using NCBI datasets
``
datasets download genome accession --inputfile test_accession_list.txt --include gff3,genome
``

# format gffs
* move and rename fastas
``
find . -name "*genomic.fna" -exec cp {} ../../genomes/ \;
ls *.fna > fasta_name_list_long.txt
rename_fasta.sh
``

* move and rename gffs 
``copy_and_rename_gff.sh ``

* create prokka style annotations combining fasta + gff
``../../scrips/get_prokka_style_gff.sh ../test_accession_list.txt ``

# Running panaroo
* **conda env:** panaroo - has python 3.9, Bioconda does not support pythons versions >= 3.10 

``
panaroo -i *prokka.gff -o panaroo_results --clean-mode strict --remove-invalid-genes -t 10
``

# create alignment
* **conda env:** Ecoli_host
`` panaroo-msa --aligner mafft -a core -t 10 --verbose -o .``
* should run gblocks too

# create core tree
``iqtree -s core_gene_alignment_filtered.aln -m GTR+G -B 1000 -nt AUTO ``

# Issues
* some samples have non-gff3 annotations (GCA_029110485.1), need to figure out how to deal with that 

# Other
* scoary interpretation hint
Number_pos_present_in = number of cefovecin resistant isolates group_8535 was found in (27)
number_neg_present_in = number of cefovecin susceptible isolates group_8535 was found in  (28)
number_pos_not_present_in = number of cefovecin resistant isolates that don't have group_8535 (86)
number_neg_not_present_in = number of cefovecin susceptible isolates that don't have group_8535 (415)

 The odds of cefovecin resistance for isolates containing group_8535 is 27/86 = .31. The odds of cefovecin resistance for isolates without group_8535 = 28/415 = .07. Therefore the odds ratio is (27/86)/(28/415) = 4.65, meaning isolates with group_8535 are 4.65 x more likely to be cefovecin resistant than isolates without group_8535. 