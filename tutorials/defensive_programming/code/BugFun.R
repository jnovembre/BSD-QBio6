people <- seq(1:10)

AssignRandomPartners <- function(people) {
  pairs <- data.frame(Person = people, Partner = NA)
  for (i in 1:length(people)) {
    randomPartner <- round(runif(1)*length(people))
    pairs$Partner[i] <- people[randomPartner]
  }
  return(pairs)
}

somePartners <- AssignRandomPartners(people)