# Libraries
library(data.table)
library(Matrix)
library(lightgbm)

# SET YOUR WORKING DIRECTORY
setwd(commandArgs(trailingOnly = TRUE)[1])

# Do xgboost / LightGBM
train_sparse <- readRDS(file = "../data/higgs_sparse.rds")
label <- readRDS(file = "../data/higgs_label.rds")

# Split
train_1 <- train_sparse[1:10000000, ]
train_2 <- label[1:10000000]
test_1 <- train_sparse[10000001:11000000, ]
test_2 <- label[10000001:11000000]

# For LightGBM
lgb_train <- lgb.Dataset(data = train_1, label = train_2)
lgb_test <- lgb.Dataset(data = test_1, label = test_2)

# Train fake LightGBM model to use 10 million observations' columns
lgb.train(params = list(objective = "regression",
                        metric = "l2",
                        bin_construct_sample_cnt = 10000000L),
          lgb_train,
          1,
          list(train = lgb_train,
               test = lgb_test),
          verbose = 1)
lgb.Dataset.save(lgb_train, fname = paste0("../data/higgs_train_lgb_", commandArgs(trailingOnly = TRUE)[2], ".data"))
lgb.Dataset.save(lgb_test, fname = paste0("../data/higgs_test_lgb_", commandArgs(trailingOnly = TRUE)[2], ".data"))
