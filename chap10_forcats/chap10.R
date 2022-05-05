#' ---
#' output:
#'    html_document:
#'      keep_md: TRUE
#' ---

#+ message=FALSE
library(tidyverse)
library(gapminder)

#' Factor inspection
str(gapminder$continent)

class(gapminder$continent)

levels(gapminder$continent)

nlevels(gapminder$continent)

#' Use `forcats`
gapminder %>% count(continent)

fct_count(gapminder$continent)

#' Drop unused levels  
#' Filter the gapminder data down to rows where population is less than 
#' a quarter of a million, i.e. 250,000. 
#' Drop unused factor levels for country and continent in different ways:
#' `droplevels()`
#' `fct_drop()` inside `mutate()`
#' `fct_drop()` with `mutate_at()` or `mutate_if()`
drop_df <- gapminder %>%
	filter(pop < 250000)

drop_df %>% count(continent, country)

nlevels(drop_df$continent)
drop_df$continent %>% 
	droplevels() %>%
	nlevels()

nlevels(drop_df$country)
drop_df$country %>%
	droplevels() %>%
	nlevels()

drop_df1 = drop_df %>%
	mutate(drop_continent = fct_drop(continent),
	       drop_country = fct_drop(country))
levels(drop_df1$drop_continent)
levels(drop_df1$drop_country)

drop_df2 = drop_df %>%
	mutate_if(is.factor, fct_drop)
levels(drop_df2$country)
levels(drop_df2$continent)

drop_df3 = drop_df %>%
	mutate_at(vars(country, continent), fct_drop)
levels(drop_df3$country)
levels(drop_df3$continent)

#' Change order of the levels
gapminder %>%
	ggplot(aes(continent)) +
	geom_bar() +
	coord_flip()

gapminder %>%
	ggplot(aes(fct_infreq(continent))) +
	geom_bar() +
	coord_flip()

gapminder %>%
	ggplot(aes(fct_rev(fct_infreq(continent)))) +
	geom_bar() +
	coord_flip()

gapminder %>%
	filter(year == 2007, continent == "Asia") %>%
	ggplot(aes(y = country,
		 x = lifeExp)) +
	geom_point()

gapminder %>%
	filter(year == 2007, continent == "Asia") %>%
	ggplot(aes(y = fct_reorder(country, lifeExp),
		 x = lifeExp)) +
	geom_point()

#' Isolate the data for "Australia", "Korea, Dem. Rep.", and "Korea, Rep." 
#' in the 2000x. 
#' Revalue the country factor levels to "Oz", "North Korea", and "South Korea"
gapminder %>%
	filter(country %in% c("Australia", "Korea, Dem. Rep.", "Korea, Rep."),
	       year >= 2000) %>%
	mutate_if(is.factor, fct_drop) %>%
	mutate(country = fct_recode(country,
			        "Oz" = "Australia",
			        "North Korea" = "Korea, Dem. Rep.",
			        "South Korea" = "Korea, Rep."))

#' create two data frames, each with data from two countries in 2000x,
#' dropping unused factor levels
df1 <- gapminder %>%
	filter(country %in% c("Vietnam", "Japan"),
	       year >= 2000) %>%
	mutate_if(is.factor, fct_drop)

df2 <- gapminder %>%
	filter(country %in% c("China", "France"),
	       year > 2000) %>%
	mutate_if(is.factor, fct_drop)

#' combine them: `fct_c()`
fct_c(df1$country, df2$country)

bind_rows(df1, df2)

rbind(df1, df2)

