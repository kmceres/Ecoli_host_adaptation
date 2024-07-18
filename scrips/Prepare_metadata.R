library(dplyr)
library(tidyr)

# read in metadata downloaded from NCBI Pathogen Browser on 7.17.24
setwd("~/Postgrad/Goodman_Ecoli/Ecoli_host_adaptation/")
meta <- read.csv("Pathogen_browser_Ecoli_meta.csv")

# Filter by location --> US, Canada
View(table(meta$Location))
View(table(meta$Host))

meta <- meta %>% separate(Location, into=c("Country","State"), sep=":") 
meta <- meta %>% filter(Country == "USA" | Country == "Canada")

# correct host
meta <- meta %>% mutate (Host_corrected = case_when(
  Host %in% c("canine", "Canis lupus", "Canis lupus familiaris", "dog") ~"Dog",
  Host %in% c("Homo sapiens", "Homo_sapiens") ~ "Human"
))

# filter only urine samples and remove samples without an assembly number
urine_samples <- meta %>% filter(grepl('URINE|urine|Urine|urinary|Urinary', Isolation.source)) %>%
  filter(Assembly != "")

# create a small sample for developing pipeline
sample <- urine_samples %>% group_by(Host_corrected) %>% sample_n(10)
acc_list <- sample %>% ungroup() %>% select(Assembly)
write.table(acc_list, "test_samples/test_accession_list.txt", row.names = F, quote=F,col.names = F)
