# Libraries
library(data.table)
library(Matrix)

# SET YOUR WORKING DIRECTORY
setwd(commandArgs(trailingOnly = TRUE)[1])

# Load data
train <- fread("../data/higgs_data.csv",
               nrows = 11000000,
               header = FALSE,
               sep = ",",
               stringsAsFactors = FALSE,
               colClasses = rep("numeric", 29),
               verbose = TRUE)

# Store 0s copy-less
what_is_zero <- (copy(train[1:11000000, 2:29]) == 0)
gc()

# Limit to 1-2 range
for (i in 2:29) {
  train[[i]] <- train[[i]] - min(train[[i]])
  train[[i]] <- (train[[i]] / max(train[[i]])) + 1
  train[[i]][what_is_zero[, i - 1] == TRUE] <- 0
}

# Add sum of 0s bias feature
train[[30]] <- rowSums(what_is_zero)
train[[30]] <- train[[30]] / max(train[[30]])

# Convert to matrix
gc()
train_sparse <- Laurae::DT2mat(train[1:11000000, 2:30])

# Convert to sparse
gc()
train_sparse <- Matrix(train_sparse, sparse = TRUE)

# Save to RDS
gc()
saveRDS(train_sparse, file = "../data/higgs_sparse.rds", compress = TRUE)

# Save labels
saveRDS(train[[1]], file = "../data/higgs_label.rds", compress = TRUE)
