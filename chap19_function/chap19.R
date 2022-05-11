#'---
#' output:
#'     html_document:
#'       keep_md: TRUE
#'---

#' take the difference between any two quantiles

quantile_diff <- function(x, q1 = 0, q2 = 1) {
	stopifnot(is.numeric(x))
	probs = c(q1, q2)
	quantile_value = quantile(x, probs = probs)
	max(quantile_value) - min(quantile_value)
}

(x = 1:5)

quantile_diff(x)

quantile_diff(x, q1 = 0.8, q2 = 0.5)

