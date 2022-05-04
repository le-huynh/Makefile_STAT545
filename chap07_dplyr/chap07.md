---
output: 
  html_document:
    keep_md: TRUE
---


```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
```

```
## v ggplot2 3.3.5     v purrr   0.3.4
## v tibble  3.1.6     v dplyr   1.0.8
## v tidyr   1.2.0     v stringr 1.4.0
## v readr   2.1.2     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(gapminder)
```

`summarize_at()` applies same summary function(s) to multiple variables
compute average and median life expectancy and GDP per capita by continent 
by year 1992 and 2002


```r
gapminder %>%
	filter(year %in% c(1992, 2002)) %>%
	group_by(continent, year) %>%
	summarise_at(vars(lifeExp, gdpPercap),
		   list(~mean(.), ~median(.)))
```

```
## # A tibble: 10 x 6
## # Groups:   continent [5]
##    continent  year lifeExp_mean gdpPercap_mean lifeExp_median gdpPercap_median
##    <fct>     <int>        <dbl>          <dbl>          <dbl>            <dbl>
##  1 Africa     1992         53.6          2282.           52.4            1162.
##  2 Africa     2002         53.3          2599.           51.2            1216.
##  3 Americas   1992         69.6          8045.           69.9            6619.
##  4 Americas   2002         72.4          9288.           72.0            6995.
##  5 Asia       1992         66.5          8640.           68.7            3726.
##  6 Asia       2002         69.2         10174.           71.0            4091.
##  7 Europe     1992         74.4         17062.           75.5           17550.
##  8 Europe     2002         76.7         21712.           77.5           23675.
##  9 Oceania    1992         76.9         20894.           76.9           20894.
## 10 Oceania    2002         79.7         26939.           79.7           26939.
```

What are the minimum and maximum life expectancies seen by year in Asia?


```r
gapminder %>%
	filter(continent == "Asia") %>%
	group_by(year) %>%
	summarise_at(vars(lifeExp),
		   list(~max(.), ~min(.)))
```

```
## # A tibble: 12 x 3
##     year   max   min
##    <int> <dbl> <dbl>
##  1  1952  65.4  28.8
##  2  1957  67.8  30.3
##  3  1962  69.4  32.0
##  4  1967  71.4  34.0
##  5  1972  73.4  36.1
##  6  1977  75.4  31.2
##  7  1982  77.1  39.9
##  8  1987  78.7  40.8
##  9  1992  79.4  41.7
## 10  1997  80.7  41.8
## 11  2002  82    42.1
## 12  2007  82.6  43.8
```

Which country contributed these extreme observations?


```r
gapminder %>%
	filter(continent == "Asia") %>%
	select(year, country, lifeExp) %>%
	group_by(year) %>%
	filter(min_rank(lifeExp) == 1 | min_rank(desc(lifeExp)) == 1) %>%
	arrange(year)
```

```
## # A tibble: 24 x 3
## # Groups:   year [12]
##     year country     lifeExp
##    <int> <fct>         <dbl>
##  1  1952 Afghanistan    28.8
##  2  1952 Israel         65.4
##  3  1957 Afghanistan    30.3
##  4  1957 Israel         67.8
##  5  1962 Afghanistan    32.0
##  6  1962 Israel         69.4
##  7  1967 Afghanistan    34.0
##  8  1967 Japan          71.4
##  9  1972 Afghanistan    36.1
## 10  1972 Japan          73.4
## # ... with 14 more rows
```

which country experienced the sharpest 5-year drop in life expectancy?


```r
gapminder %>%
	select(continent, year, country, lifeExp) %>%
	group_by(country) %>%
	mutate(drop_lifeExp = lifeExp - lag(lifeExp)) %>%
	group_by(continent) %>%
	filter(min_rank(drop_lifeExp) == 1) %>%
	arrange(continent)
```

```
## # A tibble: 5 x 5
## # Groups:   continent [5]
##   continent  year country     lifeExp drop_lifeExp
##   <fct>     <int> <fct>         <dbl>        <dbl>
## 1 Africa     1992 Rwanda         23.6      -20.4  
## 2 Americas   1977 El Salvador    56.7       -1.51 
## 3 Asia       1977 Cambodia       31.2       -9.10 
## 4 Europe     2002 Montenegro     74.0       -1.46 
## 5 Oceania    1967 Australia      71.1        0.170
```



---
title: chap07.R
author: LY
date: '2022-05-04'

---
