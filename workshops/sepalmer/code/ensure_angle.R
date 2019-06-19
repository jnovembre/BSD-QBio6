ensure_angle <- function(ang) {
  ang <- ang %% 360
  ang[ang < 0] <- ang[ang < 0] + 360
  ang[ang == 360] <- 0
  ang
}