category_index <- function(cts, udirs, category_bound) {
  n_bcd <- bcd(cts, udirs, category_bound)
  n_wcd <- wcd(cts, udirs, category_bound)
  (n_bcd - n_wcd)/(n_bcd + n_wcd)
}