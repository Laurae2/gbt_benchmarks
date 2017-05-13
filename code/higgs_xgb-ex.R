# Rscript filename V1 V2 V3 V4
# V1 = $(DIR)
# V2 = number of threads
# V3 = type (depthwise or lossguide)
# V4 = limited (unlimited depth [leaves] or not [depth] or [hessian] or [sampling])
# V5 = optimization tag

suppressWarnings(suppressMessages(library(xgboost)))
suppressWarnings(suppressMessages(library(Matrix)))
suppressWarnings(suppressMessages(library(R.utils)))

StartTime <- System$currentTimeMillis()

#ram_call <- "wmic OS get FreeVirtualMemory /Value"
ram_call <- paste0("wmic PROCESS ", Sys.getpid(), " get workingsetsize")

print(str(commandArgs(trailingOnly = TRUE)))

# SET YOUR WORKING DIRECTORY
if (interactive()) {
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  threads <- 12
  type <- "depthwise" # lossguide
  optimization <- ""
  grid_search <- data.frame(Depth = c(3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
                            Leaves = c(7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095),
                            Hessian = rep(1, 10),
                            Colsample = rep(1, 10),
                            Subsample = rep(1, 10),
                            Rounds = rep(500, 10),
                            Eta = rep(0.25, 10))
} else {
  setwd(commandArgs(trailingOnly = TRUE)[1])
  threads <- as.numeric(commandArgs(trailingOnly = TRUE)[2])
  type <- commandArgs(trailingOnly = TRUE)[3]
  model_type <- commandArgs(trailingOnly = TRUE)[4]
  optimization <- commandArgs(trailingOnly = TRUE)[5]
  if (model_type == "leaves") {
    grid_search <- data.frame(Depth = rep(0, 10),
                              Leaves = c(7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095),
                              Hessian = rep(1, 10),
                              Colsample = rep(1, 10),
                              Subsample = rep(1, 10),
                              Rounds = rep(500, 10),
                              Eta = rep(0.25, 10))
    printed_info <- sprintf("%04d", grid_search$Leaves)
  } else if (model_type == "depth") {
    grid_search <- data.frame(Depth = c(3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
                              Leaves = c(7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095),
                              Hessian = rep(1, 10),
                              Colsample = rep(1, 10),
                              Subsample = rep(1, 10),
                              Rounds = rep(500, 10),
                              Eta = rep(0.25, 10))
    printed_info <- sprintf("%02d", grid_search$Depth)
  } else if (model_type == "hessian") {
    grid_search <- data.frame(Depth = rep(10, 4),
                              Leaves = c(1023, 1023, 1023, 1023),
                              Hessian = c(1, 5, 25, 125),
                              Colsample = rep(1, 4),
                              Subsample = rep(1, 4),
                              Rounds = rep(500, 4),
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
    #printed_info <- paste0(sprintf("%.01f", grid_search$Subsample), "s_", sprintf("%.01f", grid_search$Colsample), "c")
    printed_info <- paste0(sprintf("%.01f", grid_search$Subsample))
  }
}
train_data <- paste0("../data/higgs_train_xgb-", optimization, ".data")
test_data <- paste0("../data/higgs_test_xgb-", optimization, ".data")
common_log <- "../summary/common"
ledger_log <- "../summary/ledger"
temp_shell <- "../windows/temp_shell"
temp_pshell <- "../windows/temp_pshell"
temp_file <- "../windows/temp_file"
spec_log <- paste0("../xgb-", optimization, "ex_gbt_", ifelse(type == "depthwise", "dw", "lg"), "/", sprintf("%02d", threads), "t_higgs_", model_type)
model_name <- paste0("Higgs: ", threads, "-thread xgboost ", ifelse(type == "depthwise", "Depth-wise", "Loss-guide"), "-", optimization, ", ", model_type, " limited")
file_extension <- ".txt"

if (!file.exists(paste0(common_log, file_extension))) {
  file.create(paste0(common_log, file_extension))
  cat("Dataset,Algorithm,Type,Run,Threads,Time,Metric,Best Iteration,Iterations,Eta,Leaves,Depth,Hessian,Subsample,Colsample_bytree,Training RAM 1st,Training RAM 25%,Training RAM 50%,Training RAM 75%,Total RAM,gc RAM\n", sep = "", file = paste0(common_log, file_extension), append = TRUE)
}

if (!file.exists(paste0(ledger_log, file_extension))) {
  file.create(paste0(ledger_log, file_extension))
}

# if (!file.exists(paste0(temp_pshell, ".ps1"))) {
#   cat(paste0("Start-Sleep -s 3\n", ram_call, " | Out-File ", temp_file, file_extension, " -encoding ASCII", "\nexit"), file = paste0(temp_pshell, ".ps1"), append = FALSE)
# }

timer <- function(pred, dtrain) {
  auc <- Laurae::FastROC(preds = pred, labels = getinfo(dtrain, "label"))
  assign("niter", get("niter", envir = globalenv()) + 1, envir = globalenv())
  cat(get("niter", globalenv()), ",", (System$currentTimeMillis() - StartTime) / 1000, ",", auc, "\n", sep = "", file = get("file_name", envir = globalenv()), append = TRUE)
  max_iter <- grid_search$Rounds[get("i", envir = globalenv())]
  if (get("niter") %in% c(1, round(max_iter * 0.25), round(max_iter * 0.5), round(max_iter * 0.75))) {
    assign(paste0("FullRAM", which(c(1, round(max_iter * 0.25), round(max_iter * 0.5), round(max_iter * 0.75)) %in% get("niter"))), system(ram_call, intern = TRUE)[2], envir = globalenv())
  }
  return(list(metric = "auc", value = auc))
}

StartRAM <- as.numeric(as.numeric(gsub("([0-9]+).*$", "\\1", system(ram_call, intern = TRUE)[2])))
FullRAM1 <- 0
FullRAM2 <- 0
FullRAM3 <- 0
FullRAM4 <- 0

train <- xgb.DMatrix(train_data)
test <- xgb.DMatrix(test_data)

temp_model <- xgb.train(params = list(nthread = threads,
                                      eta = 0.25,
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
                        watchlist = list(test = test),
                        eval_metric = "auc",
                        nrounds = 1,
                        verbose = 2)
rm(temp_model)
invisible(gc())
invisible(gc())

LoadedRAM <- as.numeric(as.numeric(gsub("([0-9]+).*$", "\\1", system(ram_call, intern = TRUE)[2])))

#grid_search$Rounds <- rep(10, nrow(grid_search))

for (i in 1:nrow(grid_search)) {
  
  file_name <- paste0(spec_log, "_", printed_info[i], file_extension)
  file.create(file_name)
  cat("Iteration,Time,AUC\n", sep = "", file = file_name, append = TRUE)
  
  cat("========== ", model_name, " ==========\n", format(Sys.time(), "%D %X"), "\n\n\nnthread = ", threads, "\neta = ", grid_search$Eta[i], "\nnrounds = ", grid_search$Rounds[i], "\nmax_depth = ", grid_search$Depth[i], "\nmax_leaves = ", grid_search$Leaves[i], "\nmax_bin = 255\ngamma = 1\nmin_child_weight = ", grid_search$Hessian[i], "\nsubsample = ", grid_search$Subsample[i], "\ncolsample_bytree = ", grid_search$Colsample[i], "\nobjective = 'binary:logistic'\nbooster = 'gbtree'\ntree_method = 'hist'\ngrow_policy = '", type, "'\nversion = '", optimization, "'\neval_metric = 'auc'\n\nLoaded data in RAM with caching: ", (LoadedRAM - StartRAM), " bytes (", sprintf("%05.03f", (LoadedRAM - StartRAM) / 1024 / 1024), " MB, ", sprintf("%05.03f", (LoadedRAM - StartRAM) / 1024 / 1024 / 1024), " GB)\n\n", sep = "", file = paste0(ledger_log, file_extension), append = TRUE)
  
  gc(verbose = FALSE)
  gc(verbose = FALSE)
  niter <- 0
  
  FreeRAM <- as.numeric(as.numeric(gsub("([0-9]+).*$", "\\1", system(ram_call, intern = TRUE)[2])))
  
  #cat(paste0("powershell.exe ", paste0(temp_pshell, ".ps1"), "\nexit"), file = paste0(temp_shell, ".bat"), append = FALSE)
  #shell(gsub("/", "\\\\", paste0("start ", temp_shell, ".bat")), wait = FALSE)
  
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
  
  #FullRAM <- FreeRAM - as.numeric(gsub(pattern = "FreeVirtualMemory=", replacement = "", x = readLines(con = paste0(temp_file, file_extension))[5])) + StartRAM - LoadedRAM
  FullRAM1 <- as.numeric(gsub("([0-9]+).*$", "\\1", FullRAM1)) - StartRAM
  FullRAM2 <- as.numeric(gsub("([0-9]+).*$", "\\1", FullRAM2)) - StartRAM
  FullRAM3 <- as.numeric(gsub("([0-9]+).*$", "\\1", FullRAM3)) - StartRAM
  FullRAM4 <- as.numeric(gsub("([0-9]+).*$", "\\1", FullRAM4)) - StartRAM
  TotalRAM <- as.numeric(gsub("([0-9]+).*$", "\\1", system(ram_call, intern = TRUE)[2])) - StartRAM
  gc(verbose = FALSE)
  gc(verbose = FALSE)
  GCRAM <- as.numeric(gsub("([0-9]+).*$", "\\1", system(ram_call, intern = TRUE)[2])) - StartRAM
  
  cat("Best round: ", sprintf("%04d", which.max(temp_model$evaluation_log$test_auc)[1]), "\nBest AUC: ", sprintf("%08.07f", max(temp_model$evaluation_log$test_auc)), "\nTotal time: ", sprintf("%08.03f", (EndTime - StartTime) / 1000), "s\nRAM used during training after 1st iteration: ", FullRAM1, " bytes (", sprintf("%05.03f", FullRAM1 / 1024 / 1024), " MB, ", sprintf("%05.03f", FullRAM1 / 1024 / 1024 / 1024), " GB)\nRAM used during training after 25% of iterations: ", FullRAM2, " bytes (", sprintf("%05.03f", FullRAM2 / 1024 / 1024), " MB, ", sprintf("%05.03f", FullRAM2 / 1024 / 1024 / 1024), " GB)\nRAM used during training after 50% of iterations: ", FullRAM3, " bytes (", sprintf("%05.03f", FullRAM3 / 1024 / 1024), " MB, ", sprintf("%05.03f", FullRAM3 / 1024 / 1024 / 1024), " GB)\nRAM used during training after 75% of iterations: ", FullRAM4, " bytes (", sprintf("%05.03f", FullRAM4 / 1024 / 1024), " MB, ", sprintf("%05.03f", FullRAM4 / 1024 / 1024 / 1024), " GB)\nRAM used before garbage collect: ", TotalRAM, " bytes (", sprintf("%05.03f", TotalRAM / 1024 / 1024), " MB, ", sprintf("%05.03f", TotalRAM / 1024 / 1024 / 1024), " GB)\nRAM used after garbage collect: ", GCRAM, " bytes (", sprintf("%05.03f", GCRAM / 1024 / 1024), " MB, ", sprintf("%05.03f", GCRAM / 1024 / 1024 / 1024), " GB)\n\n\n\n", sep = "", file = paste0(ledger_log, file_extension), append = TRUE)
  
  # Dataset,Algorithm,Type,Run,Threads,Time,Metric,Best Iteration,Iterations,Eta,Leaves,Depth,Hessian,Subsample,Colsample_bytree,Training RAM 1st,Training RAM 25%,Training RAM 50%,Training RAM 75%,Total RAM,gc RAM
  cat("'higgs','xgboost-", type, "-", optimization, "','", model_type, "',", i, ",", threads, ",", (EndTime - StartTime) / 1000, ",", max(temp_model$evaluation_log$test_auc), ",", which.max(temp_model$evaluation_log$test_auc), ",", grid_search$Rounds[i], ",", grid_search$Eta[i], ",", grid_search$Leaves[i], ",", grid_search$Depth[i], ",", grid_search$Hessian[i], ",", grid_search$Subsample[i], ",", grid_search$Colsample[i], ",", FullRAM1, ",", FullRAM2, ",", FullRAM3, ",", FullRAM4, ",", TotalRAM, ",", GCRAM, "\n", sep = "", file = paste0(common_log, file_extension), append = TRUE)
  
}
