---
output: 
    html_document:
      keep_md: TRUE
---

Read the table of word lengths histogram.tsv  


```r
library(tidyverse)

data <- read_tsv(here::here("chap36_makefile/histogram.tsv"))

data
```

```
## # A tibble: 25 x 2
##    length  freq
##     <dbl> <dbl>
##  1      1    52
##  2      2   160
##  3      3  1427
##  4      4  5285
##  5      5 10237
##  6      6 17712
##  7      7 23881
##  8      8 29999
##  9      9 32411
## 10     10 30882
## # ... with 15 more rows
```


```r
data2 = data %>% filter(freq == max(freq))

data2
```

```
## # A tibble: 1 x 2
##   length  freq
##    <dbl> <dbl>
## 1      9 32411
```


The most common word length is 9.  

Display the pre-made histogram histogram.png  


```r
knitr::include_graphics(here::here("chap36_makefile/histogram.png"))
```

<img src="C:/Users/LY/Google Drive/Git/note_STAT545/chap36_makefile/histogram.png" width="2099" />




