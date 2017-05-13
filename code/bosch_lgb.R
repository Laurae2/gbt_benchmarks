# Rscript filename V1 V2 V3 V4
# V1 = $(DIR)
# V2 = number of threads
# V3 = type (v1 or v2)
# V4 = limited (unlimited depth [leaves] or not [depth] or [hessian] or [sampling])

suppressWarnings(suppressMessages(library(lightgbm)))
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
  type <- "v1" # v1
  grid_search <- data.frame(Depth = c(3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
                            Leaves = c(7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095),
                            Hessian = rep(1, 10),
                            Colsample = rep(1, 10),
                            Subsample = rep(1, 10),
                            Rounds = c(2000, 1500, 1000, 1000, 500, 400, 400, 400, 400, 400),
                            Eta = rep(0.02, 10))
} else {
  setwd(commandArgs(trailingOnly = TRUE)[1])
  threads <- as.numeric(commandArgs(trailingOnly = TRUE)[2])
  type <- commandArgs(trailingOnly = TRUE)[3]
  model_type <- commandArgs(trailingOnly = TRUE)[4]
  if (model_type == "leaves") {
    grid_search <- data.frame(Depth = rep(-1, 10),
                              Leaves = c(7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095),
                              Hessian = rep(1, 10),
                              Colsample = rep(1, 10),
                              Subsample = rep(1, 10),
                              Rounds = c(2000, 1500, 1000, 1000, 500, 400, 400, 400, 400, 400),
                              Eta = rep(0.02, 10))
    printed_info <- sprintf("%04d", grid_search$Leaves)
  } else if (model_type == "depth") {
    grid_search <- data.frame(Depth = c(3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
                              Leaves = c(7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095),
                              Hessian = rep(1, 10),
                              Colsample = rep(1, 10),
                              Subsample = rep(1, 10),
                              Rounds = c(2000, 1500, 1000, 1000, 500, 400, 400, 400, 400, 400),
                              Eta = rep(0.02, 10))
    printed_info <- sprintf("%02d", grid_search$Depth)
  } else if (model_type == "hessian") {
    grid_search <- data.frame(Depth = rep(10, 4),
                              Leaves = c(1023, 1023, 1023, 1023),
                              Hessian = c(1, 5, 25, 125),
                              Colsample = rep(1, 4),
                              Subsample = rep(1, 4),
                              Rounds = rep(400, 4),
                              Eta = rep(0.02, 4))
    printed_info <- sprintf("%03d", grid_search$Hessian)
  } else if (model_type == "sampling") {
    grid_search <- data.frame(Depth = rep(6, 4),
                              Leaves = rep(63, 4),
                              Hessian = rep(1, 4),
                              Colsample = rep(1, 4),
                              Subsample = c(1, 0.8, 0.6, 0.4),
                              Rounds = rep(1000, 4),
                              Eta = rep(0.04, 4))
    #printed_info <- paste0(sprintf("%.01f", grid_search$Subsample), "s_", sprintf("%.01f", grid_search$Colsample), "c")
    printed_info <- paste0(sprintf("%.01f", grid_search$Subsample))
  }
}
train_data <- paste0("../data/bosch_train_lgb_", type, ".data")
test_data <-  paste0("../data/bosch_test_lgb_", type, ".data")
common_log <- "../summary/common"
ledger_log <- "../summary/ledger"
temp_shell <- "../windows/temp_shell"
temp_pshell <- "../windows/temp_pshell"
temp_file <- "../windows/temp_file"
spec_log <- paste0("../lgb_", type, "/", sprintf("%02d", threads), "t_bosch_", model_type)
model_name <- paste0("Bosch: ", threads, "-thread LightGBM ", type, ", ", model_type, " limited")
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

timer <- function(preds, dtrain) {
  auc <- Laurae::FastROC(preds = preds, labels = getinfo(dtrain, "label"))
  assign("niter", get("niter", envir = globalenv()) + 1, envir = globalenv())
  cat(get("niter", globalenv()), ",", (System$currentTimeMillis() - StartTime) / 1000, ",", auc, "\n", sep = "", file = get("file_name", envir = globalenv()), append = TRUE)
  max_iter <- grid_search$Rounds[get("i", envir = globalenv())]
  if (get("niter") %in% c(1, round(max_iter * 0.25), round(max_iter * 0.5), round(max_iter * 0.75))) {
    assign(paste0("FullRAM", which(c(1, round(max_iter * 0.25), round(max_iter * 0.5), round(max_iter * 0.75)) %in% get("niter"))), system(ram_call, intern = TRUE)[2], envir = globalenv())
  }
  return(list(name = "auc", value = auc, higher_better = TRUE))
}


StartRAM <- as.numeric(as.numeric(gsub("([0-9]+).*$", "\\1", system(ram_call, intern = TRUE)[2])))
FullRAM1 <- 0
FullRAM2 <- 0
FullRAM3 <- 0
FullRAM4 <- 0

train <- lgb.Dataset(train_data)
test <- lgb.Dataset(test_data)

temp_model <- lgb.train(params = list(num_threads = threads,
                                      learning_rate = 0.02,
                                      max_depth = 4,
                                      num_leaves = 15,
                                      max_bin = 255,
                                      min_gain_to_split = 1,
                                      min_sum_hessian_in_leaf = 1,
                                      min_data_in_leaf = 1,
                                      bin_construct_sample_cnt = 1000000L),
                        data = train,
                        nrounds = 1,
                        valids = list(train = train, test = test),
                        objective = "binary",
                        metric = "auc",
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
  
  cat("========== ", model_name, " ==========\n", format(Sys.time(), "%D %X"), "\n\n\nnum_threads = ", threads, "\nlearning_rate = ", grid_search$Eta[i], "\nnrounds = ", grid_search$Rounds[i], "\nmax_depth = ", grid_search$Depth[i], "\nnum_leaves = ", grid_search$Leaves[i], "\nmax_bin = 255\nmin_gain_to_split = 1\nmin_sum_hessian_in_leaf = ", grid_search$Hessian[i], "\nbagging_fraction = ", grid_search$Subsample[i], "\nfeature_fraction = ", grid_search$Colsample[i], "\nobjective = 'binary'\nversion = '", type, "'\neval_metric = 'auc'\n\nLoaded data in RAM with caching: ", (LoadedRAM - StartRAM), " bytes (", sprintf("%05.03f", (LoadedRAM - StartRAM) / 1024 / 1024), " MB, ", sprintf("%05.03f", (LoadedRAM - StartRAM) / 1024 / 1024 / 1024), " GB)\n\n", sep = "", file = paste0(ledger_log, file_extension), append = TRUE)
  
  gc(verbose = FALSE)
  gc(verbose = FALSE)
  niter <- 0
  
  FreeRAM <- as.numeric(as.numeric(gsub("([0-9]+).*$", "\\1", system(ram_call, intern = TRUE)[2])))
  
  #cat(paste0("powershell.exe ", paste0(temp_pshell, ".ps1"), "\nexit"), file = paste0(temp_shell, ".bat"), append = FALSE)
  #shell(gsub("/", "\\\\", paste0("start ", temp_shell, ".bat")), wait = FALSE)
  
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
                                        feature_fraction = grid_search$Colsample[i],
                                        min_data_in_leaf = 1,
                                        bin_construct_sample_cnt = 1000000L),
                          data = train,
                          nrounds = grid_search$Rounds[i],
                          valids = list(test = test),
                          objective = "binary",
                          eval = timer,
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
  
  temp_metric <- as.numeric(t(data.table::rbindlist(temp_model$record_evals$test$auc)))
  
  cat("Best round: ", sprintf("%04d", which.max(temp_metric)[1]), "\nBest AUC: ", sprintf("%08.07f", max(temp_metric)), "\nTotal time: ", sprintf("%08.03f", (EndTime - StartTime) / 1000), "s\nRAM used during training after 1st iteration: ", FullRAM1, " bytes (", sprintf("%05.03f", FullRAM1 / 1024 / 1024), " MB, ", sprintf("%05.03f", FullRAM1 / 1024 / 1024 / 1024), " GB)\nRAM used during training after 25% of iterations: ", FullRAM2, " bytes (", sprintf("%05.03f", FullRAM2 / 1024 / 1024), " MB, ", sprintf("%05.03f", FullRAM2 / 1024 / 1024 / 1024), " GB)\nRAM used during training after 50% of iterations: ", FullRAM3, " bytes (", sprintf("%05.03f", FullRAM3 / 1024 / 1024), " MB, ", sprintf("%05.03f", FullRAM3 / 1024 / 1024 / 1024), " GB)\nRAM used during training after 75% of iterations: ", FullRAM4, " bytes (", sprintf("%05.03f", FullRAM4 / 1024 / 1024), " MB, ", sprintf("%05.03f", FullRAM4 / 1024 / 1024 / 1024), " GB)\nRAM used before garbage collect: ", TotalRAM, " bytes (", sprintf("%05.03f", TotalRAM / 1024 / 1024), " MB, ", sprintf("%05.03f", TotalRAM / 1024 / 1024 / 1024), " GB)\nRAM used after garbage collect: ", GCRAM, " bytes (", sprintf("%05.03f", GCRAM / 1024 / 1024), " MB, ", sprintf("%05.03f", GCRAM / 1024 / 1024 / 1024), " GB)\n\n\n\n", sep = "", file = paste0(ledger_log, file_extension), append = TRUE)
  
  # Dataset,Algorithm,Type,Run,Threads,Time,Metric,Best Iteration,Iterations,Eta,Leaves,Depth,Hessian,Subsample,Colsample_bytree,Training RAM 1st,Training RAM 25%,Training RAM 50%,Training RAM 75%,Total RAM,gc RAM
  cat("'bosch','lightgbm-", type, "','", model_type, "',", i, ",", threads, ",", (EndTime - StartTime) / 1000, ",", max(temp_metric), ",", which.max(temp_metric)[1], ",", grid_search$Rounds[i], ",", grid_search$Eta[i], ",", grid_search$Leaves[i], ",", grid_search$Depth[i], ",", grid_search$Hessian[i], ",", grid_search$Subsample[i], ",", grid_search$Colsample[i], ",", FullRAM1, ",", FullRAM2, ",", FullRAM3, ",", FullRAM4, ",", TotalRAM, ",", GCRAM, "\n", sep = "", file = paste0(common_log, file_extension), append = TRUE)
  
}
