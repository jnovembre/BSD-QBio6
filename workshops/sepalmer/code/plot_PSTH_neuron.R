plot_PSTH_neuron <- function(filename,filter_size,specify_dirs=-1000){
  neur <- read_neuron(filename)
  unique_dirs <- neur[['udirs']]
  s_dirs <- neur[['dirs']]
  
  if (specify_dirs != -1000) {
    plot_dirs = specify_dirs;
  }
  else {
    plot_dirs = unique_dirs
  }
  
  stim_onset <- 500
  xs <- 1:2700 - stim_onset #set up the zero on the x-axis at stimulus onset
  conversion <- 1000 #convert times from seconds to milliseconds
  
  # for a boxcar filter
  filter <- rep(1/filter_size, filter_size)
  smooth_raster <- stats::filter(neur[['spks']], filter)*conversion
  
  mean_arr <- array(dim=c(length(plot_dirs), length(xs)))
  for (i in 1:length(plot_dirs)) {
    d <- plot_dirs[i]
    dir_raster <- smooth_raster[ , s_dirs == d]
    mean_arr[i, ] <- apply(dir_raster, 1, mean)
  }
  
  flat_means <- as.vector(t(mean_arr))
  d = data.frame(ts=rep(xs, length(plot_dirs)),
                 dir=rep(plot_dirs, length(plot_dirs), 
                         each=length(xs)),
                 spk_rates=flat_means)
  
  fig <- ggplot(d, aes(x=ts, y=spk_rates, color=factor(dir))) +
    geom_line(aes(group=factor(dir)), size=1) +
    labs(x='time from stimulus onset (ms)', y='spks/s', 
         color='motion direction (degrees)')
  fig
}