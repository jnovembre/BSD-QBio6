plot_direction_tuning <- function(cts, sorted_udirs, category_bound,
                                  neuron_name) {
  # now for the shifting we did earlier
  if (!is.na(category_bound)) {
    bound_dists <- abs(sorted_udirs - category_bound)
    mindist <- min(bound_dists)
    first_min <- which(mindist == bound_dists)[1]
    target <- length(sorted_udirs)/2
    steps <- first_min - target
    shift_udirs <- circular_shift(sorted_udirs, steps)
    shift_cts <- circular_shift(cts, steps)
  } else {
    shift_udirs <- sorted_udirs
    shift_cts <- cts
  }
  dummy_x <- 1:length(shift_udirs)
  d <- data.frame(dirs=shift_udirs, cts=shift_cts, xs=dummy_x)
  fig <- ggplot(d, aes(x=dummy_x, y=shift_cts)) + 
    geom_line() +
    labs(x='motion direction (degrees)', y='spks/s') +
    scale_x_continuous(breaks=dummy_x, 
                       labels=as.character(shift_udirs))
  if (!is.na(category_bound)) {
    fig <- fig + geom_vline(aes(xintercept=(length(dummy_x) + 1)/2),
                            linetype="dashed", size=1)
  }
  fig
}