#'---
#' output:
#'     html_document:
#'       keep_md: TRUE
#'---

#+ message=FALSE
library(tidyverse)
library(gapminder)

#' - drop Oceania, which only has two countries  
#' - sort the country factor based on population  

data <- gapminder %>%
	filter(continent != "Oceania") %>%
	droplevels() %>%
	mutate(country = fct_reorder(country, -1 * pop)) %>%
	arrange(year, country)

#' simple scatterplot for a single year
data %>% 
	filter(year == 2007) %>%
	ggplot(aes(y = lifeExp, x = gdpPercap)) +
	geom_point()

data %>% 
	filter(year == 2007) %>%
	ggplot(aes(y = lifeExp, x = gdpPercap)) +
	geom_point() + 
	scale_x_log10()

p <- data %>% 
	filter(year == 2007) %>%
	ggplot(aes(y = lifeExp, x = gdpPercap)) +
	scale_x_log10()

p + geom_point(pch = 21, size = 8, fill = I("darkorchid1"))

#' size of the circle reflects population

p + geom_point(aes(size = pop), pch = 21)

p + geom_point(aes(size = pop), pch = 21, show.legend = FALSE) +
	scale_size_continuous(range = c(1, 40))

p + geom_point(aes(size = pop), pch = 21, show.legend = FALSE) +
	scale_size_continuous(range = c(1, 40)) +
	facet_wrap(~ continent)

p + geom_point(aes(size = pop), pch = 21, show.legend = FALSE) +
	scale_size_continuous(range = c(1, 40)) +
	facet_wrap(~ continent) +
	ylim(c(39, 90))

p + geom_point(aes(size = pop, fill = continent),
	     pch = 21,
	     show.legend = FALSE) +
	scale_size_continuous(range = c(1, 40)) +
	facet_wrap(~ continent) +
	ylim(c(39, 90))

p + geom_point(aes(size = pop, fill = country),
	     pch = 21,
	     show.legend = FALSE) +
	scale_size_continuous(range = c(1, 40)) +
	facet_wrap(~ continent) +
	ylim(c(39, 90))

p + geom_point(aes(size = pop, fill = country),
	     pch = 21,
	     show.legend = FALSE) +
	scale_size_continuous(range = c(1, 40)) +
	facet_wrap(~ continent) +
	ylim(c(39, 90)) +
	scale_fill_manual(values = country_colors)

#' altogether
data %>%
	filter(year == 2007) %>%
	ggplot(aes(x = gdpPercap, y = lifeExp, fill = country)) +
	scale_x_log10() +
	geom_point(aes(size = pop),
		 pch = 21,
		 show.legend = FALSE) +
	scale_size_continuous(range = c(1, 40)) +
	facet_wrap(~ continent) +
	scale_fill_manual(values = country_colors) +
	ylim(c(39, 90))



