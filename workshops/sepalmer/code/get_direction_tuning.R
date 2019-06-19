get_direction_tuning <- function(filename, count_beg, count_end, 
                                 category_bound=NA) {
  n <- read_neuron(filename)
  cts <- direction_spkcounts(n[['spks']], n[['udirs']], n[['dirs']],
                             count_beg, count_end)
  plot_direction_tuning(cts, n[['udirs']], category_bound, n[['name']])
}