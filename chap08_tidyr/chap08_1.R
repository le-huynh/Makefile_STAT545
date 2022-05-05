#' ---
#' output:
#'   html_document:
#'     keep_md: TRUE
#' ---

#' [Tidy data using Lord of the Rings](https://github.com/jennybc/lotr-tidy)

#+ message=FALSE
library(here)
library(tidyverse)
library(readxl)

#' Import data: .xlsx, multiple sheets
path <- here("chap08_tidyr/lord_of_the_ring.xlsx")

data <- path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path, skip = 1)
data

#' Tidying data
film <- c("The Fellowship Of The Ring",
	"The Two Towers",
	"The Return Of The King")

for (i in seq_along(data)) {
	data[[i]] <- data[[i]] %>%
		add_column(film = film[[i]]) %>%
		pivot_longer(cols = c(Female, Male),
			   names_to = "Gender",
			   values_to = "Words")
}
data

data <- data %>%
	reduce(full_join) %>%
	select(Film = film, everything())
data

#' What’s the total number of words spoken by male hobbits?
data %>%
	filter(Gender == "Male", Race == "Hobbit") %>%
	summarise(total_word = sum(Words))

#' Does a certain race dominate a movie?
#' Does the dominant race differ across the movies?
data %>%
	group_by(Film, Race) %>%
	summarise(Words = sum(Words)) %>%
	ggplot(aes(x = Film, y = Words, fill = Race)) +
	geom_bar(stat = "identity", position = "dodge") +
	coord_flip()

#' Save data: .csv
#+ eval=FALSE
write_csv(data,
	file = "chap08_tidyr/tidy_lord.csv")
