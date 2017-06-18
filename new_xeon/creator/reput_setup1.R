# Libraries
library(sparsity)
library(Matrix)

# SET YOUR WORKING DIRECTORY
setwd(commandArgs(trailingOnly = TRUE)[1])

data <- read.svmlight(paste0("../data/reput/Day0.svm"))
data$matrix@Dim[2] <- 3231962L
data$matrix@p[length(data$matrix@p):3231963] <- data$matrix@p[length(data$matrix@p)]
data$matrix <- data$matrix[1:(data$matrix@Dim[1] - 1), ]
label <- (data$labels[1:(data$matrix@Dim[1])] + 1) / 2
data <- data$matrix

new_data <- list()

for (i in 1:120) {
  indexed <- (i %% 10) + (10 * ((i %% 10) == 0))
  new_data[[indexed]] <- read.svmlight(paste0("../data/reput/Day", i, ".svm"))
  new_data[[indexed]]$matrix@Dim[2] <- 3231962L
  new_data[[indexed]]$matrix@p[length(new_data[[indexed]]$matrix@p):3231963] <- new_data[[indexed]]$matrix@p[length(new_data[[indexed]]$matrix@p)]
  new_data[[indexed]]$matrix <- new_data[[indexed]]$matrix[1:(new_data[[indexed]]$matrix@Dim[1] - 1), ]
  label <- c(label, (new_data[[indexed]]$labels[1:(new_data[[indexed]]$matrix@Dim[1])] + 1) / 2)
  
  if ((i %% 10) == 0) {
    
    data <- rbind(data, new_data[[1]]$matrix, new_data[[2]]$matrix, new_data[[3]]$matrix, new_data[[4]]$matrix, new_data[[5]]$matrix, new_data[[6]]$matrix, new_data[[7]]$matrix, new_data[[8]]$matrix, new_data[[9]]$matrix, new_data[[10]]$matrix)
    gc(verbose = FALSE)
    
    cat("Parsed element 'Day", i, ".svm'. Sparsity: ", sprintf("%05.0f", as.numeric(data@Dim[1]) * as.numeric(data@Dim[2]) / length(data@i)), ":1. Balance: ", sprintf("%04.02f", length(label) / sum(label)), ":1.\n", sep = "")
    
  }
  
}

# Save to RDS
gc()
saveRDS(data, file = "../data/reput_sparse.rds", compress = TRUE)

# Save labels
saveRDS(label, file = "../data/reput_label.rds", compress = TRUE)
