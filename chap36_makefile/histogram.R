#---
# histogram.R
#
# This Rscript:
# * generate a table of word length frequency
# Note: this is an example for Makefile
#
# Dependencies...
# chap36_makefile/words.txt
#
# Produces...
# chap36_makefile/histogram.tsv
#---

library(tidyverse)

# import data
data <- read_table("chap36_makefile/words.txt", col_names = FALSE)

data %>% 
	rename(word = X1) %>%
	mutate(length = nchar(word)) %>%
	count(length, name = "freq") %>%
	write_tsv("chap36_makefile/histogram.tsv")

