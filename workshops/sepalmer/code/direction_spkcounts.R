direction_spkcounts <- function(spks, udirs, dirs, count_beg, 
                                count_end) {
  xs <- 1:dim(spks)[1]
  count_filter <- (xs >= count_beg) & (xs < count_end)
  conversion = 1000/(count_end - count_beg)
  spk_counts <- apply(spks[count_filter, ], 2, sum)*conversion
  cts = array(dim=c(length(udirs)))
  for (i in 1:length(cts)) {
    cts[i] = mean(spk_counts[udirs[i] == dirs])
  }
  cts
}