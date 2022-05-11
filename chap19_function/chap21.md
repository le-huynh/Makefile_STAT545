---
output:
    html_document:
      keep_md: TRUE
---
Build a function:  
- Input: a data.frame that contains (at least) `lifeExp` and `year`  
- Output: a vector of estimated intercept and slope, 
from a linear regression of lifeExp on year  
The ultimate goal is to apply this function to the Gapminder data for 
a specific country  


```r
library(gapminder)
library(tidyverse)

func <- function(data, selected_country, offset = 1952){
	data %>%
		filter(country == selected_country) %>%
		lm(lifeExp ~ I(year - offset), data = .) %>%
		coef() %>%
		setNames(nm = c("Intercept", "Slope"))
}

func(data = gapminder, selected_country = "Vietnam")
```

```
##  Intercept      Slope 
## 39.0100769  0.6716154
```

```r
func(gapminder, selected_country = "Japan")
```

```
##  Intercept      Slope 
## 65.1220513  0.3529042
```



---
title: chap21.R
author: LY
date: '2022-05-11'

---
