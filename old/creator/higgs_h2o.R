# Libraries
library(data.table)
library(Matrix)

# SET YOUR WORKING DIRECTORY
setwd(commandArgs(trailingOnly = TRUE)[1])

# Do h2o
gc()
label <- readRDS(file = "../data/higgs_label.rds")
train_dense <- readRDS(file = "../data/higgs_dense.rds")

# Split
train <- train_dense[1:10000000, ]
test <- train_dense[10000001:11000000, ]
train$Label <- label[1:10000000]
test$Label <- label[10000001:11000000]

gc()
fwrite(train, "../data/higgs_train_h2o.csv")
fwrite(test, "../data/higgs_test_h2o.csv")
