# Libraries
library(data.table)
library(Matrix)

# SET YOUR WORKING DIRECTORY
setwd(commandArgs(trailingOnly = TRUE)[1])

# Do h2o
gc()
label <- readRDS(file = "../data/bosch_label.rds")
train_dense <- readRDS(file = "../data/bosch_dense.rds")

# Split
train <- train_dense[1:1000000, ]
test <- train_dense[1000001:1183747, ]
train$Label <- label[1:1000000]
test$Label <- label[1000001:1183747]

# For h2o
gc()
fwrite(train, "../data/bosch_train_h2o.csv")
fwrite(test, "../data/bosch_test_h2o.csv")
