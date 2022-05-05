#' ---
#' output:
#'   html_document:
#'     keep_md: TRUE
#' ---

#+ message=FALSE
library(here)
library(tidyverse)
library(readxl)

#' Import untidy data: `Female.csv`, `Male.csv`
female <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/Female.csv")
female

male <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/Male.csv")
male

#' Tidying the data
lotr_tidy <- bind_rows(female, male) %>%
	pivot_longer(cols = Elf:Man,
		   names_to = "Race",
		   values_to = "Words")
lotr_tidy

#' total number of words spoken in each film
lotr_tidy %>%
	group_by(Film) %>%
	summarise(total_word = sum(Words))

