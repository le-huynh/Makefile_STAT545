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

Prepare untidy data: Lord of the Ring


```r
# import data sets
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

```r
# add column `Film`
Film <- c("The Fellowship Of The Ring",
	"The Two Towers",
	"The Return Of The King")

for (i in seq_along(data)) {
	data[[i]] <- data[[i]] %>%
		add_column(Film = Film[[i]])
	
}

data
```

```
## $Sheet1
## # A tibble: 3 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf      1229   971 The Fellowship Of The Ring
## 2 Hobbit     14  3644 The Fellowship Of The Ring
## 3 Man         0  1995 The Fellowship Of The Ring
## 
## $Sheet2
## # A tibble: 3 x 4
##   Race   Female  Male Film          
##   <chr>   <dbl> <dbl> <chr>         
## 1 Elf       331   513 The Two Towers
## 2 Hobbit      0  2463 The Two Towers
## 3 Man       401  3589 The Two Towers
## 
## $Sheet3
## # A tibble: 3 x 4
##   Race   Female  Male Film                  
##   <chr>   <dbl> <dbl> <chr>                 
## 1 Elf       183   510 The Return Of The King
## 2 Hobbit      2  2673 The Return Of The King
## 3 Man       268  2459 The Return Of The King
```

```r
# write 3 dataframes
fship <- data[[1]]
fship
```

```
## # A tibble: 3 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf      1229   971 The Fellowship Of The Ring
## 2 Hobbit     14  3644 The Fellowship Of The Ring
## 3 Man         0  1995 The Fellowship Of The Ring
```

```r
ttow <- data[[2]]
ttow
```

```
## # A tibble: 3 x 4
##   Race   Female  Male Film          
##   <chr>   <dbl> <dbl> <chr>         
## 1 Elf       331   513 The Two Towers
## 2 Hobbit      0  2463 The Two Towers
## 3 Man       401  3589 The Two Towers
```

```r
rking <- data[[3]]
rking
```

```
## # A tibble: 3 x 4
##   Race   Female  Male Film                  
##   <chr>   <dbl> <dbl> <chr>                 
## 1 Elf       183   510 The Return Of The King
## 2 Hobbit      2  2673 The Return Of The King
## 3 Man       268  2459 The Return Of The King
```

```r
# bind 3 data sets
bind_rows(fship, ttow, rking)
```

```
## # A tibble: 9 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf      1229   971 The Fellowship Of The Ring
## 2 Hobbit     14  3644 The Fellowship Of The Ring
## 3 Man         0  1995 The Fellowship Of The Ring
## 4 Elf       331   513 The Two Towers            
## 5 Hobbit      0  2463 The Two Towers            
## 6 Man       401  3589 The Two Towers            
## 7 Elf       183   510 The Return Of The King    
## 8 Hobbit      2  2673 The Return Of The King    
## 9 Man       268  2459 The Return Of The King
```

```r
rbind(fship, ttow, rking)
```

```
## # A tibble: 9 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf      1229   971 The Fellowship Of The Ring
## 2 Hobbit     14  3644 The Fellowship Of The Ring
## 3 Man         0  1995 The Fellowship Of The Ring
## 4 Elf       331   513 The Two Towers            
## 5 Hobbit      0  2463 The Two Towers            
## 6 Man       401  3589 The Two Towers            
## 7 Elf       183   510 The Return Of The King    
## 8 Hobbit      2  2673 The Return Of The King    
## 9 Man       268  2459 The Return Of The King
```

Exercises  
Change the order of variables.
Does row binding match variables by name or position? **by name**


```r
rking2 <- rking %>% select(Film, everything())

bind_rows(rking2, ttow, fship)
```

```
## # A tibble: 9 x 4
##   Film                       Race   Female  Male
##   <chr>                      <chr>   <dbl> <dbl>
## 1 The Return Of The King     Elf       183   510
## 2 The Return Of The King     Hobbit      2  2673
## 3 The Return Of The King     Man       268  2459
## 4 The Two Towers             Elf       331   513
## 5 The Two Towers             Hobbit      0  2463
## 6 The Two Towers             Man       401  3589
## 7 The Fellowship Of The Ring Elf      1229   971
## 8 The Fellowship Of The Ring Hobbit     14  3644
## 9 The Fellowship Of The Ring Man         0  1995
```

```r
rbind(rking2, ttow, fship)
```

```
## # A tibble: 9 x 4
##   Film                       Race   Female  Male
##   <chr>                      <chr>   <dbl> <dbl>
## 1 The Return Of The King     Elf       183   510
## 2 The Return Of The King     Hobbit      2  2673
## 3 The Return Of The King     Man       268  2459
## 4 The Two Towers             Elf       331   513
## 5 The Two Towers             Hobbit      0  2463
## 6 The Two Towers             Man       401  3589
## 7 The Fellowship Of The Ring Elf      1229   971
## 8 The Fellowship Of The Ring Hobbit     14  3644
## 9 The Fellowship Of The Ring Man         0  1995
```

```r
bind_rows(ttow, rking2, fship)
```

```
## # A tibble: 9 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf       331   513 The Two Towers            
## 2 Hobbit      0  2463 The Two Towers            
## 3 Man       401  3589 The Two Towers            
## 4 Elf       183   510 The Return Of The King    
## 5 Hobbit      2  2673 The Return Of The King    
## 6 Man       268  2459 The Return Of The King    
## 7 Elf      1229   971 The Fellowship Of The Ring
## 8 Hobbit     14  3644 The Fellowship Of The Ring
## 9 Man         0  1995 The Fellowship Of The Ring
```

```r
rbind(ttow, rking2, fship)
```

```
## # A tibble: 9 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf       331   513 The Two Towers            
## 2 Hobbit      0  2463 The Two Towers            
## 3 Man       401  3589 The Two Towers            
## 4 Elf       183   510 The Return Of The King    
## 5 Hobbit      2  2673 The Return Of The King    
## 6 Man       268  2459 The Return Of The King    
## 7 Elf      1229   971 The Fellowship Of The Ring
## 8 Hobbit     14  3644 The Fellowship Of The Ring
## 9 Man         0  1995 The Fellowship Of The Ring
```

Row bind data frames where the variable x is of one type in one data frame 
and another type in the other. 
Try combinations that you think should work and some that should not. 
What actually happens?


```r
# factor and character: work
ttow2 <- ttow %>% 
	mutate(Race = factor(Race, levels = c("Elf", "Hobbit", "Man")))

bind_rows(ttow2, rking, fship)
```

```
## # A tibble: 9 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf       331   513 The Two Towers            
## 2 Hobbit      0  2463 The Two Towers            
## 3 Man       401  3589 The Two Towers            
## 4 Elf       183   510 The Return Of The King    
## 5 Hobbit      2  2673 The Return Of The King    
## 6 Man       268  2459 The Return Of The King    
## 7 Elf      1229   971 The Fellowship Of The Ring
## 8 Hobbit     14  3644 The Fellowship Of The Ring
## 9 Man         0  1995 The Fellowship Of The Ring
```

```r
rbind(ttow2, rking, fship)
```

```
## # A tibble: 9 x 4
##   Race   Female  Male Film                      
##   <fct>   <dbl> <dbl> <chr>                     
## 1 Elf       331   513 The Two Towers            
## 2 Hobbit      0  2463 The Two Towers            
## 3 Man       401  3589 The Two Towers            
## 4 Elf       183   510 The Return Of The King    
## 5 Hobbit      2  2673 The Return Of The King    
## 6 Man       268  2459 The Return Of The King    
## 7 Elf      1229   971 The Fellowship Of The Ring
## 8 Hobbit     14  3644 The Fellowship Of The Ring
## 9 Man         0  1995 The Fellowship Of The Ring
```

```r
# bind_rows(): character and double: NOT work
ttow3 <- ttow %>% mutate(Race = if_else(Race == "Man", 1, 0))
ttow3

bind_rows(ttow3, rking, fship)

# rbind(): character and double: work
rbind(ttow3, rking, fship)
```

Row bind data frames in which the factor x has different levels in 
one data frame and different levels in the other. What happens?


```r
fship2 <- fship %>% 
	mutate(Race = factor(Race, levels = c("Elf", "Man", "Hobbit")))

# bind_rows(): convert all into character
bind_rows(fship2, ttow2, rking)
```

```
## # A tibble: 9 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf      1229   971 The Fellowship Of The Ring
## 2 Hobbit     14  3644 The Fellowship Of The Ring
## 3 Man         0  1995 The Fellowship Of The Ring
## 4 Elf       331   513 The Two Towers            
## 5 Hobbit      0  2463 The Two Towers            
## 6 Man       401  3589 The Two Towers            
## 7 Elf       183   510 The Return Of The King    
## 8 Hobbit      2  2673 The Return Of The King    
## 9 Man       268  2459 The Return Of The King
```

```r
# rbind(): use levels of 1st dataframe
test_factor = rbind(fship2, ttow2, rking)

levels(fship2$Race)
```

```
## [1] "Elf"    "Man"    "Hobbit"
```

```r
levels(ttow2$Race)
```

```
## [1] "Elf"    "Hobbit" "Man"
```

```r
levels(test_factor$Race)
```

```
## [1] "Elf"    "Man"    "Hobbit"
```

Join in dplyr


```r
library(gapminder)
gapminder %>% 
	select(country, continent) %>% 
	group_by(country) %>% 
	slice(1) %>% 
	left_join(country_codes)
```

```
## Joining, by = "country"
```

```
## # A tibble: 142 x 4
## # Groups:   country [142]
##    country     continent iso_alpha iso_num
##    <chr>       <fct>     <chr>       <int>
##  1 Afghanistan Asia      AFG             4
##  2 Albania     Europe    ALB             8
##  3 Algeria     Africa    DZA            12
##  4 Angola      Africa    AGO            24
##  5 Argentina   Americas  ARG            32
##  6 Australia   Oceania   AUS            36
##  7 Austria     Europe    AUT            40
##  8 Bahrain     Asia      BHR            48
##  9 Bangladesh  Asia      BGD            50
## 10 Belgium     Europe    BEL            56
## # ... with 132 more rows
```



---
title: chap14.R
author: LY
date: '2022-05-10'

---
