# Libraries
library(data.table)
library(Matrix)
library(xgboost)

# SET YOUR WORKING DIRECTORY
setwd(commandArgs(trailingOnly = TRUE)[1])

# Do xgboost / LightGBM
train_sparse <- readRDS(file = "../data/higgs_sparse.rds")
label <- readRDS(file = "../data/higgs_label.rds")

# Split
train_1 <- train_sparse[1:10000000, ]
train_2 <- label[1:10000000]
test_1 <- train_sparse[10900001:11000000, ]
test_2 <- label[10900001:11000000]

# For xgboost
xgb_train <- xgb.DMatrix(data = train_1, label = train_2)
xgb_test <- xgb.DMatrix(data = test_1, label = test_2)
xgb.DMatrix.save(xgb_train, fname = "../data/higgs_train_xgb.data")
xgb.DMatrix.save(xgb_test, fname = "../data/higgs_test_xgb.data")
