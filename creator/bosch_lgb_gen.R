# Libraries
library(data.table)
library(Matrix)
library(lightgbm)

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

# For LightGBM
lgb_train <- lgb.Dataset(data = train_1, label = train_2)
lgb_test <- lgb.Dataset(data = test_1, label = test_2)

# Train fake LightGBM model to use 1 million observations' columns
lgb.train(params = list(objective = "regression",
                        metric = "l2",
                        bin_construct_sample_cnt = 1000000L),
          lgb_train,
          1,
          list(train = lgb_train,
               test = lgb_test),
          verbose = 1)
lgb.Dataset.save(lgb_train, fname = paste0("../data/bosch_train_lgb_", commandArgs(trailingOnly = TRUE)[2], ".data"))
lgb.Dataset.save(lgb_test, fname = paste0("../data/bosch_test_lgb_", commandArgs(trailingOnly = TRUE)[2], ".data"))
