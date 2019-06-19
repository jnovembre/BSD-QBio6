wcd <- function(cts, udirs, category_bound) {
  avg_oriented_diff(cts, udirs, ensure_angle(category_bound + 90))
}