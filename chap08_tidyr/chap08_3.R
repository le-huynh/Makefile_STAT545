#' ---
#' output:
#'   html_document:
#'     keep_md: TRUE
#' ---

#+ message=FALSE
library(here)
library(tidyverse)
library(readxl)

#' Import data: tidy_lord.csv
data <- read_csv(here("chap08_tidyr/tidy_lord.csv"))

data

#' Spread data
data %>% spread(key = Gender, value = Words)

data %>% spread(key = Race, value = Words)

untidy_df <- data %>% 
	unite(Race_Gender, Race:Gender) %>%
	spread(key = Race_Gender, value = Words)
untidy_df

untidy_df %>%
	pivot_longer(cols = !Film,
		   names_to = c("Race", "Gender"),
		   names_pattern = "(.*)_(.*)",
		   values_to = "Words")

# splitting into film-specific data frames
data %>%
	group_split(Film)

