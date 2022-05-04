#' ---
#' output: 
#'   html_document:
#'     keep_md: TRUE
#' ---

library(tidyverse)
library(gapminder)

#' `summarize_at()` applies same summary function(s) to multiple variables
#' compute average and median life expectancy and GDP per capita by continent 
#' by year 1992 and 2002
gapminder %>%
	filter(year %in% c(1992, 2002)) %>%
	group_by(continent, year) %>%
	summarise_at(vars(lifeExp, gdpPercap),
		   list(~mean(.), ~median(.)))

#' What are the minimum and maximum life expectancies seen by year in Asia?
gapminder %>%
	filter(continent == "Asia") %>%
	group_by(year) %>%
	summarise_at(vars(lifeExp),
		   list(~max(.), ~min(.)))

#' Which country contributed these extreme observations?
gapminder %>%
	filter(continent == "Asia") %>%
	select(year, country, lifeExp) %>%
	group_by(year) %>%
	filter(min_rank(lifeExp) == 1 | min_rank(desc(lifeExp)) == 1) %>%
	arrange(year)

#' which country experienced the sharpest 5-year drop in life expectancy?
gapminder %>%
	select(continent, year, country, lifeExp) %>%
	group_by(country) %>%
	mutate(drop_lifeExp = lifeExp - lag(lifeExp)) %>%
	group_by(continent) %>%
	filter(min_rank(drop_lifeExp) == 1) %>%
	arrange(continent)
	




