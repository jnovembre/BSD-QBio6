take_count_diff <- function(cts, udirs, comp_dirs) {
  n_pairs <- length(comp_dirs[['left']])
  ds <- array(dim=n_pairs)
  for (i in 1:n_pairs) {
    l <- comp_dirs[['left']][i]
    r <- comp_dirs[['right']][i]
    ds[i] <- abs(cts[l == udirs] - cts[r == udirs])
  }
  absdiff <- mean(ds)
  absdiff
}