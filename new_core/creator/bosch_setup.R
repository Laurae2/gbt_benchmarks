# Libraries
library(data.table)
library(Matrix)

# SET YOUR WORKING DIRECTORY
setwd(commandArgs(trailingOnly = TRUE)[1])

# Load data
train <- fread("../data/bosch_data.csv",
               nrows = 1183747,
               header = TRUE,
               sep = ",",
               stringsAsFactors = FALSE,
               colClasses = rep("numeric", 970),
               verbose = TRUE)

# Get rid of ID
gc()
train[, 1] <- NULL

# Store 0s copy-less
what_is_zero <- is.na(copy(train))
gc()

# Limit to 1-2 range
for (i in 1:968) {
  train[[i]] <- train[[i]] - min(train[[i]], na.rm = TRUE)
  train[[i]] <- (train[[i]] / max(train[[i]], na.rm = TRUE)) + 1
  train[[i]][what_is_zero[, i] == TRUE] <- 0
}

# Add sum of 0s bias feature
train[[970]] <- rowSums(what_is_zero)
train[[970]] <- train[[970]] / max(train[[970]])

# Re-order columns
setcolorder(train, c(969, 1:968, 970))

# Convert to matrix
gc()
train_sparse <- Laurae::DT2mat(train[1:1183747, 2:970])

# Convert to sparse
gc()
train_sparse <- Matrix(train_sparse, sparse = TRUE)

# Save to RDS
gc()
saveRDS(train_sparse, file = "../data/bosch_sparse.rds", compress = TRUE)

# Save labels
saveRDS(train[[1]], file = "../data/bosch_label.rds", compress = TRUE)
