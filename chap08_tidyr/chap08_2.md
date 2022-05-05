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

Import untidy data: `Female.csv`, `Male.csv`


```r
female <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/Female.csv")
```

```
## Rows: 3 Columns: 5
## -- Column specification ------------------------------------------------------------
## Delimiter: ","
## chr (2): Gender, Film
## dbl (3): Elf, Hobbit, Man
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
female
```

```
## # A tibble: 3 x 5
##   Gender Film                         Elf Hobbit   Man
##   <chr>  <chr>                      <dbl>  <dbl> <dbl>
## 1 Female The Fellowship Of The Ring  1229     14     0
## 2 Female The Two Towers               331      0   401
## 3 Female The Return Of The King       183      2   268
```

```r
male <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/Male.csv")
```

```
## Rows: 3 Columns: 5
## -- Column specification ------------------------------------------------------------
## Delimiter: ","
## chr (2): Gender, Film
## dbl (3): Elf, Hobbit, Man
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
male
```

```
## # A tibble: 3 x 5
##   Gender Film                         Elf Hobbit   Man
##   <chr>  <chr>                      <dbl>  <dbl> <dbl>
## 1 Male   The Fellowship Of The Ring   971   3644  1995
## 2 Male   The Two Towers               513   2463  3589
## 3 Male   The Return Of The King       510   2673  2459
```

Tidying the data


```r
lotr_tidy <- bind_rows(female, male) %>%
	pivot_longer(cols = Elf:Man,
		   names_to = "Race",
		   values_to = "Words")
lotr_tidy
```

```
## # A tibble: 18 x 4
##    Gender Film                       Race   Words
##    <chr>  <chr>                      <chr>  <dbl>
##  1 Female The Fellowship Of The Ring Elf     1229
##  2 Female The Fellowship Of The Ring Hobbit    14
##  3 Female The Fellowship Of The Ring Man        0
##  4 Female The Two Towers             Elf      331
##  5 Female The Two Towers             Hobbit     0
##  6 Female The Two Towers             Man      401
##  7 Female The Return Of The King     Elf      183
##  8 Female The Return Of The King     Hobbit     2
##  9 Female The Return Of The King     Man      268
## 10 Male   The Fellowship Of The Ring Elf      971
## 11 Male   The Fellowship Of The Ring Hobbit  3644
## 12 Male   The Fellowship Of The Ring Man     1995
## 13 Male   The Two Towers             Elf      513
## 14 Male   The Two Towers             Hobbit  2463
## 15 Male   The Two Towers             Man     3589
## 16 Male   The Return Of The King     Elf      510
## 17 Male   The Return Of The King     Hobbit  2673
## 18 Male   The Return Of The King     Man     2459
```

total number of words spoken in each film


```r
lotr_tidy %>%
	group_by(Film) %>%
	summarise(total_word = sum(Words))
```

```
## # A tibble: 3 x 2
##   Film                       total_word
##   <chr>                           <dbl>
## 1 The Fellowship Of The Ring       7853
## 2 The Return Of The King           6095
## 3 The Two Towers                   7297
```



---
title: chap08_2.R
author: LY
date: '2022-05-05'

---
