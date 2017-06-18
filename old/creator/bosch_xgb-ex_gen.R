# Libraries
library(data.table)
library(Matrix)
library(xgboost)

# SET YOUR WORKING DIRECTORY
setwd(commandArgs(trailingOnly = TRUE)[1])

# Do xgboost / LightGBM
train_sparse <- readRDS(file = "../data/bosch_sparse.rds")
label <- readRDS(file = "../data/bosch_label.rds")

# Split
train_1 <- train_sparse[1:1000000, ]
train_2 <- label[1:1000000]
test_1 <- train_sparse[1000001:1183747, ]
test_2 <- label[1000001:1183747]

# For xgboost
xgb_train <- xgb.DMatrix(data = train_1, label = train_2)
xgb_test <- xgb.DMatrix(data = test_1, label = test_2)
xgb.DMatrix.save(xgb_train, fname = paste0("../data/bosch_train_xgb-", commandArgs(trailingOnly = TRUE)[2], ".data"))
xgb.DMatrix.save(xgb_test, fname = paste0("../data/bosch_test_xgb-", commandArgs(trailingOnly = TRUE)[2], ".data"))
