plot_PSTH_neuron <- function(filename,filter_size){
  neur <- read_neuron(filename)
  unique_dirs <- neur[['udirs']]
  s_dirs <- neur[['dirs']]
  
  stim_onset <- 500
  xs <- 1:2700 - stim_onset
  conversion <- 1000
  
  # for a boxcar filter
  filter <- rep(1/filter_size, filter_size)
  smooth_raster <- stats::filter(neur[['spks']], filter)*conversion
  
  mean_arr <- array(dim=c(length(unique_dirs), length(xs)))
  for (i in 1:length(unique_dirs)) {
    d <- unique_dirs[i]
    dir_raster <- smooth_raster[ , s_dirs == d]
    mean_arr[i, ] <- apply(dir_raster, 1, mean)
  }
  
  flat_means <- as.vector(t(mean_arr))
  d = data.frame(ts=rep(xs, length(unique_dirs)),
                 dir=rep(unique_dirs, length(unique_dirs), 
                         each=length(xs)),
                 spk_rates=flat_means)
  
  fig <- ggplot(d, aes(x=ts, y=spk_rates, color=factor(dir))) +
    geom_line(aes(group=factor(dir)), size=1) +
    labs(x='time from stimulus onset (ms)', y='spks/s', 
         color='motion direction (degrees)')
  fig
}