---
output:
  html_document:
    keep_md: TRUE
---
[Tidy data using Lord of the Rings](https://github.com/jennybc/lotr-tidy)


```r
library(here)
library(tidyverse)
library(readxl)
```

Import data: .xlsx, multiple sheets


```r
path <- here("chap08_tidyr/lord_of_the_ring.xlsx")

data <- path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path, skip = 1)
data
```

```
## $Sheet1
## # A tibble: 3 x 3
##   Race   Female  Male
##   <chr>   <dbl> <dbl>
## 1 Elf      1229   971
## 2 Hobbit     14  3644
## 3 Man         0  1995
## 
## $Sheet2
## # A tibble: 3 x 3
##   Race   Female  Male
##   <chr>   <dbl> <dbl>
## 1 Elf       331   513
## 2 Hobbit      0  2463
## 3 Man       401  3589
## 
## $Sheet3
## # A tibble: 3 x 3
##   Race   Female  Male
##   <chr>   <dbl> <dbl>
## 1 Elf       183   510
## 2 Hobbit      2  2673
## 3 Man       268  2459
```

Tidying data


```r
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
```

```
## $Sheet1
## # A tibble: 6 x 4
##   Race   film                       Gender Words
##   <chr>  <chr>                      <chr>  <dbl>
## 1 Elf    The Fellowship Of The Ring Female  1229
## 2 Elf    The Fellowship Of The Ring Male     971
## 3 Hobbit The Fellowship Of The Ring Female    14
## 4 Hobbit The Fellowship Of The Ring Male    3644
## 5 Man    The Fellowship Of The Ring Female     0
## 6 Man    The Fellowship Of The Ring Male    1995
## 
## $Sheet2
## # A tibble: 6 x 4
##   Race   film           Gender Words
##   <chr>  <chr>          <chr>  <dbl>
## 1 Elf    The Two Towers Female   331
## 2 Elf    The Two Towers Male     513
## 3 Hobbit The Two Towers Female     0
## 4 Hobbit The Two Towers Male    2463
## 5 Man    The Two Towers Female   401
## 6 Man    The Two Towers Male    3589
## 
## $Sheet3
## # A tibble: 6 x 4
##   Race   film                   Gender Words
##   <chr>  <chr>                  <chr>  <dbl>
## 1 Elf    The Return Of The King Female   183
## 2 Elf    The Return Of The King Male     510
## 3 Hobbit The Return Of The King Female     2
## 4 Hobbit The Return Of The King Male    2673
## 5 Man    The Return Of The King Female   268
## 6 Man    The Return Of The King Male    2459
```

```r
data <- data %>%
	reduce(full_join) %>%
	select(Film = film, everything())
```

```
## Joining, by = c("Race", "film", "Gender", "Words")
## Joining, by = c("Race", "film", "Gender", "Words")
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

What’s the total number of words spoken by male hobbits?


```r
data %>%
	filter(Gender == "Male", Race == "Hobbit") %>%
	summarise(total_word = sum(Words))
```

```
## # A tibble: 1 x 1
##   total_word
##        <dbl>
## 1       8780
```

Does a certain race dominate a movie?
Does the dominant race differ across the movies?


```r
data %>%
	group_by(Film, Race) %>%
	summarise(Words = sum(Words)) %>%
	ggplot(aes(x = Film, y = Words, fill = Race)) +
	geom_bar(stat = "identity", position = "dodge") +
	coord_flip()
```

```
## `summarise()` has grouped output by 'Film'. You can override using the
## `.groups` argument.
```

![](chap08_1_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

Save data: .csv


```r
write_csv(data,
	file = "chap08_tidyr/tidy_lord.csv")
```



---
title: chap08_1.R
author: LY
date: '2022-05-05'

---
