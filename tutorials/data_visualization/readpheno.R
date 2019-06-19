# This is a short script to read the CFW phenotype data into a data
# frame, and prepare the data frame for subsequent analysis and
# plotting.

# Read the phenotype data from the CSV file. 
pheno <- read.csv("pheno.csv",quote = "",check.names = FALSE,
                  stringsAsFactors = FALSE)

# Remove the data from the methamphetamine sensitivity testing, since
# these data will not be used in the programming challenge. Also, most
# of the data from the prepulse inhibition tests will not be used, so
# we can remove those columns as well.
pheno <- pheno[c(1:38,65:67)]

# Convert some of the columns to factors.
pheno <- transform(pheno,
                   id            = as.character(id),
                   round         = factor(round,paste0("SW",1:25)),
                   FCbox         = factor(FCbox),
                   PPIbox        = factor(PPIbox),
                   methcage      = factor(methcage),
                   methcycle     = factor(methcycle),
                   discard       = factor(discard),
                   mixup         = factor(mixup),
                   earpunch      = factor(earpunch),
                   abnormalbone  = factor(abnormalbone),
                   experimenters = factor(experimenters))

# Convert the "fasting glucose" column to double precision.
pheno <- transform(pheno,fastglucose = as.double(fastglucose))

# Remove rows marked as "discard" and as possible sample mixups.
pheno <- subset(pheno,discard == "no" & mixup == "no")
