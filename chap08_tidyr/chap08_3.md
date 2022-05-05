---
output:
  html_document:
    keep_md: TRUE
---


```r
library(here)
library(tidyverse)
library(readxl)
```

Import data: tidy_lord.csv


```r
data <- read_csv(here("chap08_tidyr/tidy_lord.csv"))
```

```
## Rows: 18 Columns: 4
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (3): Film, Race, Gender
## dbl (1): Words
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
data
```

```
## # A tibble: 18 x 4
##    Film                       Race   Gender Words
##    <chr>                      <chr>  <chr>  <dbl>
##  1 The Fellowship Of The Ring Elf    Female  1229
##  2 The Fellowship Of The Ring Elf    Male     971
##  3 The Fellowship Of The Ring Hobbit Female    14
##  4 The Fellowship Of The Ring Hobbit Male    3644
##  5 The Fellowship Of The Ring Man    Female     0
##  6 The Fellowship Of The Ring Man    Male    1995
##  7 The Two Towers             Elf    Female   331
##  8 The Two Towers             Elf    Male     513
##  9 The Two Towers             Hobbit Female     0
## 10 The Two Towers             Hobbit Male    2463
## 11 The Two Towers             Man    Female   401
## 12 The Two Towers             Man    Male    3589
## 13 The Return Of The King     Elf    Female   183
## 14 The Return Of The King     Elf    Male     510
## 15 The Return Of The King     Hobbit Female     2
## 16 The Return Of The King     Hobbit Male    2673
## 17 The Return Of The King     Man    Female   268
## 18 The Return Of The King     Man    Male    2459
```

Spread data


```r
data %>% spread(key = Gender, value = Words)
```

```
## # A tibble: 9 x 4
##   Film                       Race   Female  Male
##   <chr>                      <chr>   <dbl> <dbl>
## 1 The Fellowship Of The Ring Elf      1229   971
## 2 The Fellowship Of The Ring Hobbit     14  3644
## 3 The Fellowship Of The Ring Man         0  1995
## 4 The Return Of The King     Elf       183   510
## 5 The Return Of The King     Hobbit      2  2673
## 6 The Return Of The King     Man       268  2459
## 7 The Two Towers             Elf       331   513
## 8 The Two Towers             Hobbit      0  2463
## 9 The Two Towers             Man       401  3589
```

```r
data %>% spread(key = Race, value = Words)
```

```
## # A tibble: 6 x 5
##   Film                       Gender   Elf Hobbit   Man
##   <chr>                      <chr>  <dbl>  <dbl> <dbl>
## 1 The Fellowship Of The Ring Female  1229     14     0
## 2 The Fellowship Of The Ring Male     971   3644  1995
## 3 The Return Of The King     Female   183      2   268
## 4 The Return Of The King     Male     510   2673  2459
## 5 The Two Towers             Female   331      0   401
## 6 The Two Towers             Male     513   2463  3589
```

```r
untidy_df <- data %>% 
	unite(Race_Gender, Race:Gender) %>%
	spread(key = Race_Gender, value = Words)
untidy_df
```

```
## # A tibble: 3 x 7
##   Film         Elf_Female Elf_Male Hobbit_Female Hobbit_Male Man_Female Man_Male
##   <chr>             <dbl>    <dbl>         <dbl>       <dbl>      <dbl>    <dbl>
## 1 The Fellows~       1229      971            14        3644          0     1995
## 2 The Return ~        183      510             2        2673        268     2459
## 3 The Two Tow~        331      513             0        2463        401     3589
```

```r
untidy_df %>%
	pivot_longer(cols = !Film,
		   names_to = c("Race", "Gender"),
		   names_pattern = "(.*)_(.*)",
		   values_to = "Words")
```

```
## # A tibble: 18 x 4
##    Film                       Race   Gender Words
##    <chr>                      <chr>  <chr>  <dbl>
##  1 The Fellowship Of The Ring Elf    Female  1229
##  2 The Fellowship Of The Ring Elf    Male     971
##  3 The Fellowship Of The Ring Hobbit Female    14
##  4 The Fellowship Of The Ring Hobbit Male    3644
##  5 The Fellowship Of The Ring Man    Female     0
##  6 The Fellowship Of The Ring Man    Male    1995
##  7 The Return Of The King     Elf    Female   183
##  8 The Return Of The King     Elf    Male     510
##  9 The Return Of The King     Hobbit Female     2
## 10 The Return Of The King     Hobbit Male    2673
## 11 The Return Of The King     Man    Female   268
## 12 The Return Of The King     Man    Male    2459
## 13 The Two Towers             Elf    Female   331
## 14 The Two Towers             Elf    Male     513
## 15 The Two Towers             Hobbit Female     0
## 16 The Two Towers             Hobbit Male    2463
## 17 The Two Towers             Man    Female   401
## 18 The Two Towers             Man    Male    3589
```

```r
# splitting into film-specific data frames
data %>%
	group_split(Film)
```

```
## <list_of<
##   tbl_df<
##     Film  : character
##     Race  : character
##     Gender: character
##     Words : double
##   >
## >[3]>
## [[1]]
## # A tibble: 6 x 4
##   Film                       Race   Gender Words
##   <chr>                      <chr>  <chr>  <dbl>
## 1 The Fellowship Of The Ring Elf    Female  1229
## 2 The Fellowship Of The Ring Elf    Male     971
## 3 The Fellowship Of The Ring Hobbit Female    14
## 4 The Fellowship Of The Ring Hobbit Male    3644
## 5 The Fellowship Of The Ring Man    Female     0
## 6 The Fellowship Of The Ring Man    Male    1995
## 
## [[2]]
## # A tibble: 6 x 4
##   Film                   Race   Gender Words
##   <chr>                  <chr>  <chr>  <dbl>
## 1 The Return Of The King Elf    Female   183
## 2 The Return Of The King Elf    Male     510
## 3 The Return Of The King Hobbit Female     2
## 4 The Return Of The King Hobbit Male    2673
## 5 The Return Of The King Man    Female   268
## 6 The Return Of The King Man    Male    2459
## 
## [[3]]
## # A tibble: 6 x 4
##   Film           Race   Gender Words
##   <chr>          <chr>  <chr>  <dbl>
## 1 The Two Towers Elf    Female   331
## 2 The Two Towers Elf    Male     513
## 3 The Two Towers Hobbit Female     0
## 4 The Two Towers Hobbit Male    2463
## 5 The Two Towers Man    Female   401
## 6 The Two Towers Man    Male    3589
```



---
title: chap08_3.R
author: LY
date: '2022-05-05'

---
