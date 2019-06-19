get_category_index <- function(path, category_bound, count_beg,
                               count_end) {
  neur <- read_neuron(path)
  cts <- direction_spkcounts(neur[['spks']], neur[['udirs']], 
                             neur[['dirs']], count_beg, count_end)
  category_index(cts, neur[['udirs']], category_bound)
}