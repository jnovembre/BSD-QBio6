circular_shift <- function(vec, steps) {
  if (steps == 0) vec else c(tail(vec, -steps), head(vec, steps))
}