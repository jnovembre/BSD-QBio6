avg_oriented_diff <- function(cts, udirs, dir_cent) {
  gap <- mean(diff(sort(udirs)))
  spacings <- seq(gap, 180 - gap, by=gap)
  diff_avgs <- array(dim=c(length(spacings)))
  for (i in 1:length(diff_avgs)) {
    spacing <- spacings[[i]]
    d1 <- get_pairs(dir_cent, udirs, spacing)
    diff1 <- take_count_diff(cts, udirs, d1)
    d2 <- get_pairs(ensure_angle(dir_cent + 180), udirs, spacing)
    diff2 <- take_count_diff(cts, udirs, d2)
    diff_avgs[i] <- mean(c(diff1, diff2))
  }
  mean(diff_avgs)
}