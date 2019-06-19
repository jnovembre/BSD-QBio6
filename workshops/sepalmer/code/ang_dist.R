ang_dist <- function(ang1, ang2) {
  d1 <- ensure_angle(ang1 - ang2)
  d2 <- ensure_angle(ang2 - ang1)
  d <- min(c(d1, d2))
  d
}