---
output:
    html_document:
      keep_md: TRUE
---


```r
library(tidyverse)
library(gapminder)
```

- drop Oceania, which only has two countries  
- sort the country factor based on population  


```r
data <- gapminder %>%
	filter(continent != "Oceania") %>%
	droplevels() %>%
	mutate(country = fct_reorder(country, -1 * pop)) %>%
	arrange(year, country)
```

simple scatterplot for a single year


```r
data %>% 
	filter(year == 2007) %>%
	ggplot(aes(y = lifeExp, x = gdpPercap)) +
	geom_point()
```

![](chap26_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```r
data %>% 
	filter(year == 2007) %>%
	ggplot(aes(y = lifeExp, x = gdpPercap)) +
	geom_point() + 
	scale_x_log10()
```

![](chap26_files/figure-html/unnamed-chunk-3-2.png)<!-- -->

```r
p <- data %>% 
	filter(year == 2007) %>%
	ggplot(aes(y = lifeExp, x = gdpPercap)) +
	scale_x_log10()

p + geom_point(pch = 21, size = 8, fill = I("darkorchid1"))
```

![](chap26_files/figure-html/unnamed-chunk-3-3.png)<!-- -->

size of the circle reflects population


```r
p + geom_point(aes(size = pop), pch = 21)
```

![](chap26_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

```r
p + geom_point(aes(size = pop), pch = 21, show.legend = FALSE) +
	scale_size_continuous(range = c(1, 40))
```

![](chap26_files/figure-html/unnamed-chunk-4-2.png)<!-- -->

```r
p + geom_point(aes(size = pop), pch = 21, show.legend = FALSE) +
	scale_size_continuous(range = c(1, 40)) +
	facet_wrap(~ continent)
```

![](chap26_files/figure-html/unnamed-chunk-4-3.png)<!-- -->

```r
p + geom_point(aes(size = pop), pch = 21, show.legend = FALSE) +
	scale_size_continuous(range = c(1, 40)) +
	facet_wrap(~ continent) +
	ylim(c(39, 90))
```

![](chap26_files/figure-html/unnamed-chunk-4-4.png)<!-- -->

```r
p + geom_point(aes(size = pop, fill = continent),
	     pch = 21,
	     show.legend = FALSE) +
	scale_size_continuous(range = c(1, 40)) +
	facet_wrap(~ continent) +
	ylim(c(39, 90))
```

![](chap26_files/figure-html/unnamed-chunk-4-5.png)<!-- -->

```r
p + geom_point(aes(size = pop, fill = country),
	     pch = 21,
	     show.legend = FALSE) +
	scale_size_continuous(range = c(1, 40)) +
	facet_wrap(~ continent) +
	ylim(c(39, 90))
```

![](chap26_files/figure-html/unnamed-chunk-4-6.png)<!-- -->

```r
p + geom_point(aes(size = pop, fill = country),
	     pch = 21,
	     show.legend = FALSE) +
	scale_size_continuous(range = c(1, 40)) +
	facet_wrap(~ continent) +
	ylim(c(39, 90)) +
	scale_fill_manual(values = country_colors)
```

![](chap26_files/figure-html/unnamed-chunk-4-7.png)<!-- -->

altogether


```r
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
```

![](chap26_files/figure-html/unnamed-chunk-5-1.png)<!-- -->



---
title: chap26.R
author: LY
date: '2022-05-12'

---
