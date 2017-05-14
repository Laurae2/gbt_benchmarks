# Rscript filename V1 V2 V3 V4
# V1 = $(DIR)
# V2 = number of threads
# V3 = type ([depthwise] or [lossguide] or [exact])
# V4 = limited (unlimited depth [leaves] or not [depth] or [hessian] or [sampling])
# V5 = debug ([release] or [debug])

suppressWarnings(suppressMessages(library(xgboost)))
suppressWarnings(suppressMessages(library(Matrix)))
suppressWarnings(suppressMessages(library(R.utils)))

StartTime <- System$currentTimeMillis()

print(str(commandArgs(trailingOnly = TRUE)))

# SET YOUR WORKING DIRECTORY
if (interactive()) {
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  threads <- 12
  type <- "depthwise" # lossguide
  grid_search <- data.frame(Depth = c(3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
                            Leaves = c(7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095),
                            Hessian = rep(1, 10),
                            Colsample = rep(1, 10),
                            Subsample = rep(1, 10),
                            Rounds = c(2000, 1500, 1000, 800, 500, 400, 400, 400, 400, 400),
                            Eta = rep(0.02, 10))
} else {
  setwd(commandArgs(trailingOnly = TRUE)[1])
  threads <- as.numeric(commandArgs(trailingOnly = TRUE)[2])
  type <- commandArgs(trailingOnly = TRUE)[3]
  model_type <- commandArgs(trailingOnly = TRUE)[4]
  debug_mode <- commandArgs(trailingOnly = TRUE)[5]
  if (model_type == "leaves") {
    grid_search <- data.frame(Depth = rep(0, 10),
                              Leaves = c(7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095),
                              Hessian = rep(1, 10),
                              Colsample = rep(1, 10),
                              Subsample = rep(1, 10),
                              Rounds = c(2000, 1500, 750, 500, 400, 350, 325, 300, 200, 200),
                              Eta = rep(0.02, 10))
    printed_info <- sprintf("%04d", grid_search$Leaves)
  } else if (model_type == "depth") {
    grid_search <- data.frame(Depth = c(3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
                              Leaves = c(7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095),
                              Hessian = rep(1, 10),
                              Colsample = rep(1, 10),
                              Subsample = rep(1, 10),
                              Rounds = c(2000, 1500, 1000, 800, 500, 400, 400, 400, 400, 400),
                              Eta = rep(0.02, 10))
    if (type == "exact") {
      grid_search <- grid_search[c(1, 4, 8)]
    }
    printed_info <- sprintf("%02d", grid_search$Depth)
  } else if (model_type == "hessian") {
    grid_search <- data.frame(Depth = rep(10, 4),
                              Leaves = c(1023, 1023, 1023, 1023),
                              Hessian = c(1, 5, 25, 125),
                              Colsample = rep(1, 4),
                              Subsample = rep(1, 4),
                              Rounds = rep(400, 4),
                              Eta = rep(0.02, 4))
    if (type == "exact") {
      grid_search <- grid_search[c(1, 3)]
    }
    printed_info <- sprintf("%03d", grid_search$Hessian)
  } else if (model_type == "sampling") {
    grid_search <- data.frame(Depth = rep(6, 4),
                              Leaves = rep(63, 4),
                              Hessian = rep(1, 4),
                              Colsample = rep(1, 4),
                              Subsample = c(1, 0.8, 0.6, 0.4),
                              Rounds = rep(750, 4),
                              Eta = rep(0.04, 4))
    if (type == "exact") {
      grid_search <- grid_search[c(1, 3)]
    }
    printed_info <- paste0(sprintf("%.01f", grid_search$Subsample))
  }
}

if (debug_mode == "debug") {
  grid_search$Rounds <- rep(2, nrow(grid_search))
}

train_data <- "../data/bosch_train_xgb.data"
test_data <- "../data/bosch_test_xgb.data"
common_log <- "../summary/common"
ledger_log <- "../summary/ledger"
temp_shell <- "../windows/temp_shell"
temp_pshell <- "../windows/temp_pshell"
temp_file <- "../windows/temp_file"
spec_log <- paste0("../xgb_gbt_", ifelse(type == "depthwise", "dw", ifelse(type == "lossguide", "lg", "ex")), "/", sprintf("%02d", threads), "t_bosch_", model_type)
model_name <- paste0("Bosch: ", threads, "-thread xgboost ", ifelse(type == "depthwise", "Depth-wise", ifelse(type == "lossguide", "Loss-guide", "Exact")), ", ", model_type, " limited")
file_extension <- ".txt"

if (!file.exists(paste0(common_log, file_extension))) {
  file.create(paste0(common_log, file_extension))
  cat("Dataset,Algorithm,Type,Run,Threads,Time,Metric,Best Iteration,Iterations,Eta,Leaves,Depth,Hessian,Subsample,Colsample_bytree\n", sep = "", file = paste0(common_log, file_extension), append = TRUE)
}

if (!file.exists(paste0(ledger_log, file_extension))) {
  file.create(paste0(ledger_log, file_extension))
}

timer <- function(pred, dtrain) {
  auc <- Laurae::FastROC(preds = pred, labels = getinfo(dtrain, "label"))
  assign("niter", get("niter", envir = globalenv()) + 1, envir = globalenv())
  cat(get("niter", globalenv()), ",", (System$currentTimeMillis() - StartTime) / 1000, ",", auc, "\n", sep = "", file = get("file_name", envir = globalenv()), append = TRUE)
  return(list(metric = "auc", value = auc))
}

train <- xgb.DMatrix(train_data)
test <- xgb.DMatrix(test_data)

if (type == "exact") {
  
  temp_model <- xgb.train(params = list(nthread = threads,
                                        eta = 0.02,
                                        max_depth = 4,
                                        max_leaves = 15,
                                        max_bin = 255,
                                        gamma = 1,
                                        min_child_weight = 1,
                                        objective = "binary:logistic",
                                        booster = "gbtree",
                                        tree_method = "exact"),
                          data = train,
                          watchlist = list(train = train, test = test),
                          eval_metric = "auc",
                          nrounds = 1,
                          verbose = 2)
  
} else {
  
  temp_model <- xgb.train(params = list(nthread = threads,
                                        eta = 0.02,
                                        max_depth = 4,
                                        max_leaves = 15,
                                        max_bin = 255,
                                        gamma = 1,
                                        min_child_weight = 1,
                                        objective = "binary:logistic",
                                        booster = "gbtree",
                                        tree_method = "hist",
                                        grow_policy = type),
                          data = train,
                          watchlist = list(train = train, test = test),
                          eval_metric = "auc",
                          nrounds = 1,
                          verbose = 2)
  
}

rm(temp_model, train, test)
invisible(gc())
invisible(gc())

#grid_search$Rounds <- rep(10, nrow(grid_search))

for (i in 1:nrow(grid_search)) {
  
  file_name <- paste0(spec_log, "_", printed_info[i], file_extension)
  file.create(file_name)
  cat("Iteration,Time,AUC\n", sep = "", file = file_name, append = TRUE)
  
  cat("========== ", model_name, " ==========\n", format(Sys.time(), "%D %X"), "\n\n\nnthread = ", threads, "\neta = ", grid_search$Eta[i], "\nnrounds = ", grid_search$Rounds[i], "\nmax_depth = ", grid_search$Depth[i], "\nmax_leaves = ", grid_search$Leaves[i], "\nmax_bin = 255\ngamma = 1\nmin_child_weight = ", grid_search$Hessian[i], "\nsubsample = ", grid_search$Subsample[i], "\ncolsample_bytree = ", grid_search$Colsample[i], "\nobjective = 'binary:logistic'\nbooster = 'gbtree'\ntree_method = '", ifelse(type == "exact", "exact", "hist"), "'\ngrow_policy = ", ifelse(type == "'exact'", "NULL", type), "\neval_metric = 'auc'\n\n", sep = "", file = paste0(ledger_log, file_extension), append = TRUE)
  
  gc(verbose = FALSE)
  gc(verbose = FALSE)
  niter <- 0
  
  train <- xgb.DMatrix(train_data)
  test <- xgb.DMatrix(test_data)
  
  gc(verbose = FALSE)
  gc(verbose = FALSE)
  
  if (type == "exact") {
    
    set.seed(1)
    
    StartTime <- System$currentTimeMillis()
    temp_model <- xgb.train(params = list(nthread = threads,
                                          eta = grid_search$Eta[i],
                                          max_depth = grid_search$Depth[i],
                                          max_leaves = grid_search$Leaves[i],
                                          max_bin = 255,
                                          gamma = 1,
                                          min_child_weight = grid_search$Hessian[i],
                                          subsample = grid_search$Subsample[i],
                                          colsample_bytree = grid_search$Colsample[i],
                                          objective = "binary:logistic",
                                          booster = "gbtree",
                                          tree_method = "exact"),
                            data = train,
                            watchlist = list(test = test),
                            feval = timer,
                            nrounds = grid_search$Rounds[i],
                            verbose = 2)
    
    EndTime <- System$currentTimeMillis()
    
  } else {
    
    set.seed(1)
    
    StartTime <- System$currentTimeMillis()
    temp_model <- xgb.train(params = list(nthread = threads,
                                          eta = grid_search$Eta[i],
                                          max_depth = grid_search$Depth[i],
                                          max_leaves = grid_search$Leaves[i],
                                          max_bin = 255,
                                          gamma = 1,
                                          min_child_weight = grid_search$Hessian[i],
                                          subsample = grid_search$Subsample[i],
                                          colsample_bytree = grid_search$Colsample[i],
                                          objective = "binary:logistic",
                                          booster = "gbtree",
                                          tree_method = "hist",
                                          grow_policy = type),
                            data = train,
                            watchlist = list(test = test),
                            feval = timer,
                            nrounds = grid_search$Rounds[i],
                            verbose = 2)
    
    EndTime <- System$currentTimeMillis()
    
  }
  
  gc(verbose = FALSE)
  gc(verbose = FALSE)
  
  cat("Best round: ", sprintf("%04d", which.max(temp_model$evaluation_log$test_auc)[1]), "\nBest AUC: ", sprintf("%.12f", max(temp_model$evaluation_log$test_auc)), "\nTotal time: ", sprintf("%.12f", (EndTime - StartTime) / 1000), "s\n\n\n\n", sep = "", file = paste0(ledger_log, file_extension), append = TRUE)
  
  # Dataset,Algorithm,Type,Run,Threads,Time,Metric,Best Iteration,Iterations,Eta,Leaves,Depth,Hessian,Subsample,Colsample_bytree
  cat("'bosch','xgboost-", type, "','", model_type, "',", i, ",", threads, ",", sprintf("%.12f", (EndTime - StartTime) / 1000), ",", sprintf("%.12f", max(temp_model$evaluation_log$test_auc)), ",", which.max(temp_model$evaluation_log$test_auc), ",", grid_search$Rounds[i], ",", grid_search$Eta[i], ",", grid_search$Leaves[i], ",", grid_search$Depth[i], ",", grid_search$Hessian[i], ",", grid_search$Subsample[i], ",", grid_search$Colsample[i], "\n", sep = "", file = paste0(common_log, file_extension), append = TRUE)
  
  rm(temp_model, train, test)
  gc(verbose = FALSE)
  gc(verbose = FALSE)
  
}
