## Step 1: find an arrangement of the workshop such that 
## each group sits with different groups
## In a perfect solution, each group would sit with 8 other groups during the worshops

library(combinat)
all_p <- permn(4)
all_pm <- matrix(0, 24, 4)
for (i in 1:24){
  all_pm[i,] <- all_p[[i]]
}

checkmat <- function(m){
  for (i in 1:4){
    for(j in 1:4){
     if (sum(m[,i] == j) != 3) return(10000)
    }
  }
  # now count conflicts
  m1 <- (m == 1) * 1 
  m1 <- m1 %*% t(m1)
  m2 <- (m == 2) * 1
  m2 <- m2 %*% t(m2)
  m3 <- (m == 3) * 1 
  m3 <- m3 %*% t(m3)
  m4 <- (m == 4) * 1 
  m4 <- m4 %*% t(m4)
  mm <- m1 + m2 + m3 + m4
  diag(mm) <- 0
  mm <- mm^2 
  return(sum(mm))
}

ok <- 100000
bestm <- NULL
while(ok > 96){
  myrows <- sample(1:24, 12)
  m <- all_pm[myrows, ]
  tmp <- checkmat(m)
  if (tmp < ok){
    print(tmp)
    ok <- tmp
    bestm <- m
  }
}

## Step 2: produce a table to be digested by the program that prints the schedules

tt <- as.data.frame(bestm)
colnames(tt) <- c("time1", "time2", "time3", "time4")
library(dplyr)
library(tidyr)
tt <- tt %>% arrange(time1, time2, time3, time4)
tt <- apply(tt, c(1,2), function(x) paste0("w",x ))
tt <- cbind(tt, Group = paste0("G", 1:12))
tt <- as.data.frame(tt) %>% gather("id", "Activity", 1:4)
my_times <- data.frame(id = "time1", Day = 11, AMPM = "AM", Time = "8:30-10:00")
my_times <- rbind(my_times, data.frame(id = "time2", Day = 11, AMPM = "PM", Time = "1:00-2:30"))
my_times <- rbind(my_times, data.frame(id = "time3", Day = 12, AMPM = "AM", Time = "8:30-10:00"))
my_times <- rbind(my_times, data.frame(id = "time4", Day = 12, AMPM = "PM", Time = "1:00-2:30"))
final <- inner_join(tt, my_times) %>% 
  mutate(Present = 1) %>% 
  spread(Group, Present, fill = 0) %>% select(-id)
## Add the second session after the coffee break
for (i in 1:nrow(final)){
  tmp <- final[i,]
  if (tmp$AMPM == "AM") tmp$Time <- "10:30-12"
  if (tmp$AMPM == "PM") tmp$Time <- "2:45-2:30"
  final <- rbind(final, tmp)
}
final <- final %>% select(Day, AMPM, Time, Activity, G1, G2, G3, G4, G5, G6, G7, G8, G9, G10, G11, G12)

write.csv(final, file = "../tables/workshops.csv", row.names = FALSE)
