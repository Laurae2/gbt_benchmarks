# Libraries
library(sparsity)
library(Matrix)
library(tcltk)
library(R.utils)

# SET YOUR WORKING DIRECTORY
setwd(commandArgs(trailingOnly = TRUE)[1])

data <- readRDS(file = "../data/reput_sparse.rds")
label <- readRDS(file = "../data/reput_label.rds")

# Select 29006 columns most dense
new_data <- data[1:2396130, (data@p[2:3231963] - data@p[1:3231962]) >= 100]

# Select 23636 columns least dense
new_data <- new_data[1:2396130, (new_data@p[2:29007] - new_data@p[1:29006]) <= 1000]

# Denegative
long_bar <- tkProgressBar(title = "Denegative Parsing", label = "Denegative Parsing: 00000 / 23636\nETA: unknown\n0,000,000 / 6,843,679 elements", min = 0, max = 23636, initial = 0, width = 500)
old_many <- 1
sparse_i <- numeric(6843679)
sparse_j <- numeric(6843679)
sparse_x <- numeric(6843679)
current_time <- System$currentTimeMillis()
for (i in 1:23636) {
  which_zeroes <- (which(new_data[, i] != 0))
  new_many <- old_many + length(which_zeroes)
  which_data <- new_data[which_zeroes, i]
  sparse_i[old_many:(new_many - 1)] <- which_zeroes
  sparse_j[old_many:(new_many - 1)] <- i
  set.seed(i)
  sparse_x[old_many:(new_many - 1)] <- runif(length(which_zeroes), min = 1.5, max = 2.5)
  old_many <- new_many
  new_time <- System$currentTimeMillis()
  setTkProgressBar(pb = long_bar, value = i, label = paste0("Denegative Parsing: ", sprintf("%05d", i), " / 23636\nETA: ", sprintf("%05.03f", (new_time - current_time) / 1000), "s / ", sprintf("%05.03f", ((new_time - current_time) / i) * 23636 / 1000), "s\n", formatC(old_many - 1, big.mark = ",", digits = 6, flag = 0, format = "d"), " / 6,843,679 elements"))
}
close(long_bar)
gc()

# Save data
saveRDS(new_data, file = "../data/reput_sparse_23636.rds", compress = TRUE)
saveRDS(sparse_i, file = "../data/reput_sparse_i.rds", compress = TRUE)
saveRDS(sparse_j, file = "../data/reput_sparse_j.rds", compress = TRUE)
saveRDS(sparse_x, file = "../data/reput_sparse_x.rds", compress = TRUE)
