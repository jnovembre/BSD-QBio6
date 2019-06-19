get_ci_dist <- function(folder, category_bound, count_beg, count_end) {
  names <- list.files(folder)
  ci_dist <- array(dim=c(length(names)))
  for (i in 1:length(names)) {
    n <- names[[i]]
    neur_path <- paste(folder, n, sep='')
    ci_dist[i] <- get_category_index(neur_path, category_bound, 
                                     count_beg, count_end)
  }
  ci_dist
}