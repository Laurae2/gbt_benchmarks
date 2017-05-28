# Rscript filename V1 V2 V3 V4
# V1 = $(DIR)
# V2 = number of threads
# V3 = type (whatever)
# V4 = limited (unlimited depth [leaves] or not [depth] or [hessian] or [sampling])
# V5 = debug ([release] or [debug])

suppressWarnings(suppressMessages(library(lightgbm)))
suppressWarnings(suppressMessages(library(Matrix)))
suppressWarnings(suppressMessages(library(R.utils)))

StartTime <- System$currentTimeMillis()

print(str(commandArgs(trailingOnly = TRUE)))

# SET YOUR WORKING DIRECTORY
if (interactive()) {
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  threads <- 12
  type <- "v1" # v1
  grid_search <- data.frame(Depth = c(3, 4, 5, 6, 7),
                            Leaves = c(7, 15, 31, 63, 127),
                            Hessian = rep(1, 5),
                            Colsample = rep(1, 5),
                            Subsample = rep(1, 5),
                            Rounds = c(2000, 1250, 1100, 1000, 900),
                            Eta = rep(0.25, 5))
} else {
  setwd(commandArgs(trailingOnly = TRUE)[1])
  threads <- as.numeric(commandArgs(trailingOnly = TRUE)[2])
  type <- commandArgs(trailingOnly = TRUE)[3]
  model_type <- commandArgs(trailingOnly = TRUE)[4]
  debug_mode <- commandArgs(trailingOnly = TRUE)[5]
  if (model_type == "leaves") {
    grid_search <- data.frame(Depth = rep(-1, 5),
                              Leaves = c(7, 15, 31, 63, 127),
                              Hessian = rep(1, 5),
                              Colsample = rep(1, 5),
                              Subsample = rep(1, 5),
                              Rounds = c(2000, 1250, 1100, 1000, 900),
                              Eta = rep(0.25, 5))
    printed_info <- sprintf("%04d", grid_search$Leaves)
  } else if (model_type == "depth") {
    grid_search <- data.frame(Depth = c(3, 4, 5, 6, 7),
                              Leaves = c(7, 15, 31, 63, 127),
                              Hessian = rep(1, 5),
                              Colsample = rep(1, 5),
                              Subsample = rep(1, 5),
                              Rounds = c(2000, 1250, 1100, 1000, 900),
                              Eta = rep(0.25, 5))
    printed_info <- sprintf("%02d", grid_search$Depth)
  } else if (model_type == "hessian") {
    grid_search <- data.frame(Depth = rep(6, 4),
                              Leaves = c(63, 63, 63, 63),
                              Hessian = c(1, 5, 25, 125),
                              Colsample = rep(1, 4),
                              Subsample = rep(1, 4),
                              Rounds = rep(700, 4),
                              Eta = rep(0.25, 4))
    printed_info <- sprintf("%03d", grid_search$Hessian)
  } else if (model_type == "sampling") {
    grid_search <- data.frame(Depth = rep(6, 4),
                              Leaves = rep(63, 4),
                              Hessian = rep(1, 4),
                              Colsample = rep(1, 4),
                              Subsample = c(1, 0.8, 0.6, 0.4),
                              Rounds = rep(1000, 4),
                              Eta = rep(0.25, 4))
    printed_info <- paste0(sprintf("%.01f", grid_search$Subsample))
  }
}

if (debug_mode == "debug") {
  grid_search$Rounds <- rep(2, nrow(grid_search))
}

train_data <- paste0("../data/reput_train_lgb_", type, ".data")
test_data <-  paste0("../data/reput_test_lgb_", type, ".data")
common_log <- "../summary/common"
ledger_log <- "../summary/ledger"
temp_shell <- "../windows/temp_shell"
temp_pshell <- "../windows/temp_pshell"
temp_file <- "../windows/temp_file"
spec_log <- paste0("../lgb_", type, "/", sprintf("%02d", threads), "t_reput_", model_type)
model_name <- paste0("Reput: ", threads, "-thread LightGBM ", type, ", ", model_type, " limited")
file_extension <- ".txt"

if (!file.exists(paste0(common_log, file_extension))) {
  file.create(paste0(common_log, file_extension))
  cat("Dataset,Algorithm,Type,Run,Threads,Time,Metric,Best Iteration,Iterations,Eta,Leaves,Depth,Hessian,Subsample,Colsample_bytree\n", sep = "", file = paste0(common_log, file_extension), append = TRUE)
}

if (!file.exists(paste0(ledger_log, file_extension))) {
  file.create(paste0(ledger_log, file_extension))
}

timer <- function(preds, dtrain) {
  auc <- Laurae::FastROC(preds = preds, labels = getinfo(dtrain, "label"))
  assign("niter", get("niter", envir = globalenv()) + 1, envir = globalenv())
  cat(get("niter", globalenv()), ",", (System$currentTimeMillis() - StartTime) / 1000, ",", auc, "\n", sep = "", file = get("file_name", envir = globalenv()), append = TRUE)
  return(list(name = "auc", value = auc, higher_better = TRUE))
}

train <- lgb.Dataset(train_data)
test <- lgb.Dataset(test_data)

temp_model <- lgb.train(params = list(num_threads = threads,
                                      learning_rate = 0.25,
                                      max_depth = 4,
                                      num_leaves = 15,
                                      max_bin = 255,
                                      min_gain_to_split = 1,
                                      min_sum_hessian_in_leaf = 1,
                                      min_data_in_leaf = 1,
                                      bin_construct_sample_cnt = 2250000L),
                        data = train,
                        nrounds = 1,
                        valids = list(train = train, test = test),
                        objective = "binary",
                        metric = "auc",
                        verbose = 2)
rm(temp_model, train, test)
invisible(gc())
invisible(gc())

#grid_search$Rounds <- rep(10, nrow(grid_search))

for (i in 1:nrow(grid_search)) {
  
  file_name <- paste0(spec_log, "_", printed_info[i], file_extension)
  file.create(file_name)
  cat("Iteration,Time,AUC\n", sep = "", file = file_name, append = TRUE)
  
  cat("========== ", model_name, " ==========\n", format(Sys.time(), "%D %X"), "\n\n\nnum_threads = ", threads, "\nlearning_rate = ", grid_search$Eta[i], "\nnrounds = ", grid_search$Rounds[i], "\nmax_depth = ", grid_search$Depth[i], "\nnum_leaves = ", grid_search$Leaves[i], "\nmax_bin = 255\nmin_gain_to_split = 1\nmin_sum_hessian_in_leaf = ", grid_search$Hessian[i], "\nbagging_fraction = ", grid_search$Subsample[i], "\nfeature_fraction = ", grid_search$Colsample[i], "\nobjective = 'binary'\nversion = '", type, "'\neval_metric = 'auc'\n\n", sep = "", file = paste0(ledger_log, file_extension), append = TRUE)
  
  gc(verbose = FALSE)
  gc(verbose = FALSE)
  niter <- 0
  
  train <- lgb.Dataset(train_data)
  test <- lgb.Dataset(test_data)
  
  gc(verbose = FALSE)
  gc(verbose = FALSE)
  
  set.seed(1)
  
  StartTime <- System$currentTimeMillis()
  temp_model <- lgb.train(params = list(num_threads = threads,
                                        learning_rate = grid_search$Eta[i],
                                        max_depth = grid_search$Depth[i],
                                        num_leaves = grid_search$Leaves[i],
                                        max_bin = 255,
                                        min_gain_to_split = 1,
                                        min_sum_hessian_in_leaf = grid_search$Hessian[i],
                                        bagging_fraction = grid_search$Subsample[i],
                                        bagging_freq = 1,
                                        bagging_seed = 1,
                                        feature_fraction = grid_search$Colsample[i],
                                        min_data_in_leaf = 1,
                                        bin_construct_sample_cnt = 2250000L),
                          data = train,
                          nrounds = grid_search$Rounds[i],
                          valids = list(test = test),
                          objective = "binary",
                          eval = timer,
                          verbose = 2)
  
  EndTime <- System$currentTimeMillis()
  
  gc(verbose = FALSE)
  gc(verbose = FALSE)
  
  temp_metric <- as.numeric(t(data.table::rbindlist(temp_model$record_evals$test$auc)))
  
  cat("Best round: ", sprintf("%04d", which.max(temp_metric)[1]), "\nBest AUC: ", sprintf("%.12f", max(temp_metric)), "\nTotal time: ", sprintf("%.12f", (EndTime - StartTime) / 1000), "s\n\n\n\n", sep = "", file = paste0(ledger_log, file_extension), append = TRUE)
  
  # Dataset,Algorithm,Type,Run,Threads,Time,Metric,Best Iteration,Iterations,Eta,Leaves,Depth,Hessian,Subsample,Colsample_bytree
  cat("'reput','lightgbm-", type, "','", model_type, "',", i, ",", threads, ",", sprintf("%.12f", (EndTime - StartTime) / 1000), ",", sprintf("%.12f", max(temp_metric)), ",", which.max(temp_metric)[1], ",", grid_search$Rounds[i], ",", grid_search$Eta[i], ",", grid_search$Leaves[i], ",", grid_search$Depth[i], ",", grid_search$Hessian[i], ",", grid_search$Subsample[i], ",", grid_search$Colsample[i], "\n", sep = "", file = paste0(common_log, file_extension), append = TRUE)
  
  rm(temp_model, train, test)
  gc(verbose = FALSE)
  gc(verbose = FALSE)
  
}
