get_pairs <- function(reference, udirs, dist) {
  gap <- mean(diff(sort(udirs)))
  z <- dist/gap
  c1 <- ensure_angle(udirs - reference) >= 0
  c2 <- ensure_angle(udirs - reference - 90) < 0
  ac <- c1 & c2
  if (z %% 2 == 1) {
    left <- ensure_angle(reference - dist/2)
    right <- ensure_angle(reference + dist/2)
  } else {
    l1 <- ensure_angle(reference - dist/3)
    r1 <- ensure_angle(reference + 2*dist/3)
    adj1 <- udirs - l1
    adj1 <- adj1[which.min(abs(adj1))]
    l1 <- ensure_angle(l1 + adj1)
    r1 <- ensure_angle(r1 + adj1)
    l2 <- ensure_angle(reference - 2*dist/3)
    r2 <- ensure_angle(reference + dist/3)
    adj2 <- udirs - l2
    adj2 <- adj2[which.min(abs(adj2))]
    l2 <- ensure_angle(l2 + adj2)
    r2 <- ensure_angle(r2 + adj2)
    left <- c(l1, l2)
    right <- c(r1, r2)
  }
  x <- list(left=left, right=right)
  x
}