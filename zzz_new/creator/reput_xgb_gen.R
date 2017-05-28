# Libraries
library(data.table)
library(Matrix)
library(xgboost)

# SET YOUR WORKING DIRECTORY
setwd(commandArgs(trailingOnly = TRUE)[1])

# Do xgboost / LightGBM
train_sparse <- readRDS(file = "../data/reput_sparse_final.rds")
label <- readRDS(file = "../data/reput_label.rds")

# Split
train_1 <- train_sparse[1:2250000, ]
train_2 <- label[1:2250000]
test_1 <- train_sparse[2250001:2396130, ]
test_2 <- label[2250001:2396130]

# RDS output
saveRDS(train_1, "../data/reput_train_data.rds", compress = TRUE)
saveRDS(train_2, "../data/reput_train_label.rds", compress = TRUE)
saveRDS(test_1, "../data/reput_test_data.rds", compress = TRUE)
saveRDS(test_2, "../data/reput_test_label.rds", compress = TRUE)

# For xgboost
# xgb_train <- xgb.DMatrix(data = train_1, label = train_2)
# xgb_test <- xgb.DMatrix(data = test_1, label = test_2)
# xgb.DMatrix.save(xgb_test, fname = "../data/reput_test_xgb.data")
# xgb.DMatrix.save(xgb_train, fname = "../data/reput_train_xgb.data") # FIX
