---
output:
   html_document:
     keep_md: TRUE
---


```r
library(tidyverse)
library(gapminder)
```

Factor inspection


```r
str(gapminder$continent)
```

```
##  Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
```

```r
class(gapminder$continent)
```

```
## [1] "factor"
```

```r
levels(gapminder$continent)
```

```
## [1] "Africa"   "Americas" "Asia"     "Europe"   "Oceania"
```

```r
nlevels(gapminder$continent)
```

```
## [1] 5
```

Use `forcats`


```r
gapminder %>% count(continent)
```

```
## # A tibble: 5 x 2
##   continent     n
##   <fct>     <int>
## 1 Africa      624
## 2 Americas    300
## 3 Asia        396
## 4 Europe      360
## 5 Oceania      24
```

```r
fct_count(gapminder$continent)
```

```
## # A tibble: 5 x 2
##   f            n
##   <fct>    <int>
## 1 Africa     624
## 2 Americas   300
## 3 Asia       396
## 4 Europe     360
## 5 Oceania     24
```

Drop unused levels  
Filter the gapminder data down to rows where population is less than 
a quarter of a million, i.e. 250,000. 
Drop unused factor levels for country and continent in different ways:
`droplevels()`
`fct_drop()` inside `mutate()`
`fct_drop()` with `mutate_at()` or `mutate_if()`


```r
drop_df <- gapminder %>%
	filter(pop < 250000)

drop_df %>% count(continent, country)
```

```
## # A tibble: 7 x 3
##   continent country                   n
##   <fct>     <fct>                 <int>
## 1 Africa    Comoros                   4
## 2 Africa    Djibouti                  6
## 3 Africa    Equatorial Guinea         4
## 4 Africa    Sao Tome and Principe    12
## 5 Asia      Bahrain                   5
## 6 Asia      Kuwait                    2
## 7 Europe    Iceland                   8
```

```r
nlevels(drop_df$continent)
```

```
## [1] 5
```

```r
drop_df$continent %>% 
	droplevels() %>%
	nlevels()
```

```
## [1] 3
```

```r
nlevels(drop_df$country)
```

```
## [1] 142
```

```r
drop_df$country %>%
	droplevels() %>%
	nlevels()
```

```
## [1] 7
```

```r
drop_df1 = drop_df %>%
	mutate(drop_continent = fct_drop(continent),
	       drop_country = fct_drop(country))
levels(drop_df1$drop_continent)
```

```
## [1] "Africa" "Asia"   "Europe"
```

```r
levels(drop_df1$drop_country)
```

```
## [1] "Bahrain"               "Comoros"               "Djibouti"             
## [4] "Equatorial Guinea"     "Iceland"               "Kuwait"               
## [7] "Sao Tome and Principe"
```

```r
drop_df2 = drop_df %>%
	mutate_if(is.factor, fct_drop)
levels(drop_df2$country)
```

```
## [1] "Bahrain"               "Comoros"               "Djibouti"             
## [4] "Equatorial Guinea"     "Iceland"               "Kuwait"               
## [7] "Sao Tome and Principe"
```

```r
levels(drop_df2$continent)
```

```
## [1] "Africa" "Asia"   "Europe"
```

```r
drop_df3 = drop_df %>%
	mutate_at(vars(country, continent), fct_drop)
levels(drop_df3$country)
```

```
## [1] "Bahrain"               "Comoros"               "Djibouti"             
## [4] "Equatorial Guinea"     "Iceland"               "Kuwait"               
## [7] "Sao Tome and Principe"
```

```r
levels(drop_df3$continent)
```

```
## [1] "Africa" "Asia"   "Europe"
```

Change order of the levels


```r
gapminder %>%
	ggplot(aes(continent)) +
	geom_bar() +
	coord_flip()
```

![](chap10_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

```r
gapminder %>%
	ggplot(aes(fct_infreq(continent))) +
	geom_bar() +
	coord_flip()
```

![](chap10_files/figure-html/unnamed-chunk-5-2.png)<!-- -->

```r
gapminder %>%
	ggplot(aes(fct_rev(fct_infreq(continent)))) +
	geom_bar() +
	coord_flip()
```

![](chap10_files/figure-html/unnamed-chunk-5-3.png)<!-- -->

```r
gapminder %>%
	filter(year == 2007, continent == "Asia") %>%
	ggplot(aes(y = country,
		 x = lifeExp)) +
	geom_point()
```

![](chap10_files/figure-html/unnamed-chunk-5-4.png)<!-- -->

```r
gapminder %>%
	filter(year == 2007, continent == "Asia") %>%
	ggplot(aes(y = fct_reorder(country, lifeExp),
		 x = lifeExp)) +
	geom_point()
```

![](chap10_files/figure-html/unnamed-chunk-5-5.png)<!-- -->

Isolate the data for "Australia", "Korea, Dem. Rep.", and "Korea, Rep." 
in the 2000x. 
Revalue the country factor levels to "Oz", "North Korea", and "South Korea"


```r
gapminder %>%
	filter(country %in% c("Australia", "Korea, Dem. Rep.", "Korea, Rep."),
	       year >= 2000) %>%
	mutate_if(is.factor, fct_drop) %>%
	mutate(country = fct_recode(country,
			        "Oz" = "Australia",
			        "North Korea" = "Korea, Dem. Rep.",
			        "South Korea" = "Korea, Rep."))
```

```
## # A tibble: 6 x 6
##   country     continent  year lifeExp      pop gdpPercap
##   <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
## 1 Oz          Oceania    2002    80.4 19546792    30688.
## 2 Oz          Oceania    2007    81.2 20434176    34435.
## 3 North Korea Asia       2002    66.7 22215365     1647.
## 4 North Korea Asia       2007    67.3 23301725     1593.
## 5 South Korea Asia       2002    77.0 47969150    19234.
## 6 South Korea Asia       2007    78.6 49044790    23348.
```

create two data frames, each with data from two countries in 2000x,
dropping unused factor levels


```r
df1 <- gapminder %>%
	filter(country %in% c("Vietnam", "Japan"),
	       year >= 2000) %>%
	mutate_if(is.factor, fct_drop)

df2 <- gapminder %>%
	filter(country %in% c("China", "France"),
	       year > 2000) %>%
	mutate_if(is.factor, fct_drop)
```

combine them: `fct_c()`


```r
fct_c(df1$country, df2$country)
```

```
## [1] Japan   Japan   Vietnam Vietnam China   China   France  France 
## Levels: Japan Vietnam China France
```

```r
bind_rows(df1, df2)
```

```
## # A tibble: 8 x 6
##   country continent  year lifeExp        pop gdpPercap
##   <fct>   <fct>     <int>   <dbl>      <int>     <dbl>
## 1 Japan   Asia       2002    82    127065841    28605.
## 2 Japan   Asia       2007    82.6  127467972    31656.
## 3 Vietnam Asia       2002    73.0   80908147     1764.
## 4 Vietnam Asia       2007    74.2   85262356     2442.
## 5 China   Asia       2002    72.0 1280400000     3119.
## 6 China   Asia       2007    73.0 1318683096     4959.
## 7 France  Europe     2002    79.6   59925035    28926.
## 8 France  Europe     2007    80.7   61083916    30470.
```

```r
rbind(df1, df2)
```

```
## # A tibble: 8 x 6
##   country continent  year lifeExp        pop gdpPercap
##   <fct>   <fct>     <int>   <dbl>      <int>     <dbl>
## 1 Japan   Asia       2002    82    127065841    28605.
## 2 Japan   Asia       2007    82.6  127467972    31656.
## 3 Vietnam Asia       2002    73.0   80908147     1764.
## 4 Vietnam Asia       2007    74.2   85262356     2442.
## 5 China   Asia       2002    72.0 1280400000     3119.
## 6 China   Asia       2007    73.0 1318683096     4959.
## 7 France  Europe     2002    79.6   59925035    28926.
## 8 France  Europe     2007    80.7   61083916    30470.
```



---
title: chap10.R
author: LY
date: '2022-05-05'

---
