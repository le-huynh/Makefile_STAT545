#'---
#' output:
#'    html_document:
#'      keep_md: TRUE
#'---

#+ message=FALSE
library(here)
library(tidyverse)
library(readxl)

#' Prepare untidy data: Lord of the Ring
# import data sets
path <- here("chap08_tidyr/lord_of_the_ring.xlsx")

data <- path %>% 
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path, skip = 1)

data

# add column `Film`
Film <- c("The Fellowship Of The Ring",
	"The Two Towers",
	"The Return Of The King")

for (i in seq_along(data)) {
	data[[i]] <- data[[i]] %>%
		add_column(Film = Film[[i]])
	
}

data

# write 3 dataframes
fship <- data[[1]]
fship

ttow <- data[[2]]
ttow

rking <- data[[3]]
rking

# bind 3 data sets
bind_rows(fship, ttow, rking)

rbind(fship, ttow, rking)

#' Exercises  

#' Change the order of variables.
#' Does row binding match variables by name or position? **by name**
rking2 <- rking %>% select(Film, everything())

bind_rows(rking2, ttow, fship)

rbind(rking2, ttow, fship)

bind_rows(ttow, rking2, fship)

rbind(ttow, rking2, fship)


#' Row bind data frames where the variable x is of one type in one data frame 
#' and another type in the other. 
#' Try combinations that you think should work and some that should not. 
#' What actually happens?

# factor and character: work
ttow2 <- ttow %>% 
	mutate(Race = factor(Race, levels = c("Elf", "Hobbit", "Man")))

bind_rows(ttow2, rking, fship)

rbind(ttow2, rking, fship)

#+ eval=FALSE
# bind_rows(): character and double: NOT work
ttow3 <- ttow %>% mutate(Race = if_else(Race == "Man", 1, 0))
ttow3

bind_rows(ttow3, rking, fship)

# rbind(): character and double: work
rbind(ttow3, rking, fship)

#' Row bind data frames in which the factor x has different levels in 
#' one data frame and different levels in the other. What happens?
fship2 <- fship %>% 
	mutate(Race = factor(Race, levels = c("Elf", "Man", "Hobbit")))

# bind_rows(): convert all into character
bind_rows(fship2, ttow2, rking)

# rbind(): use levels of 1st dataframe
test_factor = rbind(fship2, ttow2, rking)

levels(fship2$Race)
levels(ttow2$Race)
levels(test_factor$Race)

#' Join in dplyr

library(gapminder)
gapminder %>% 
	select(country, continent) %>% 
	group_by(country) %>% 
	slice(1) %>% 
	left_join(country_codes)

