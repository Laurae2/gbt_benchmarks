# Libraries
library(sparsity)
library(Matrix)
library(tcltk)
library(R.utils)

# SET YOUR WORKING DIRECTORY
setwd(commandArgs(trailingOnly = TRUE)[1])

data <- readRDS(file = "../data/reput_sparse_23636.rds")
sparse_i <- readRDS(file = "../data/reput_sparse_i.rds")
sparse_j <- readRDS(file = "../data/reput_sparse_j.rds")
sparse_x <- readRDS(file = "../data/reput_sparse_x.rds")
label <- readRDS(file = "../data/reput_label.rds")

# Signal Destruction
long_bar <- tkProgressBar(title = "Signal Destruction", label = "Signal Destruction: 00000 / 23636\nETA: unknown\n000,000,000 / 761,966,607 elements", min = 0, max = 23636, initial = 0, width = 500)
old_many <- 6843680
new_sparse_i <- numeric(6843679 + 31948 * 23636)
new_sparse_j <- numeric(6843679 + 31948 * 23636)
new_sparse_x <- numeric(6843679 + 31948 * 23636)
new_sparse_i[1:6843679] <- sparse_i
new_sparse_j[1:6843679] <- sparse_j
new_sparse_x[1:6843679] <- sparse_x
instanced <- 1:2396130
current_time <- System$currentTimeMillis()
for (i in 1:23636) {
  set.seed(i)
  which_zeroes <- sample((1:2396130)[-sparse_i[(data@p[i] + 1):(data@p[i + 1])]], 31948, replace = FALSE)
  new_many <- old_many + 31948
  which_data <- runif(31948, min = 1, max = 3)
  new_sparse_i[old_many:(new_many - 1)] <- which_zeroes
  new_sparse_j[old_many:(new_many - 1)] <- i
  set.seed(i)
  new_sparse_x[old_many:(new_many - 1)] <- which_data
  old_many <- new_many
  new_time <- System$currentTimeMillis()
  setTkProgressBar(pb = long_bar, value = i, label = paste0("Signal Destruction: ", sprintf("%05d", i), " / 23636\nETA: ", sprintf("%05.03f", (new_time - current_time) / 1000), "s / ", sprintf("%05.03f", ((new_time - current_time) / i) * 23636 / 1000), "s\n", formatC(old_many - 1, big.mark = ",", digits = 8, flag = 0, format = "d"), " / 761,966,607 elements"))
}
close(long_bar)
gc()

# Clean up stuff
rm(data, sparse_i, sparse_j, sparse_x, label, instanced, long_bar, old_many, new_many, current_time, new_time, which_data, which_zeroes, i)
gc()

# Lower memory usage
new_sparse_i <- as.integer(new_sparse_i)
new_sparse_j <- as.integer(new_sparse_j)
gc()

# Generate real matrix
real_data <- sparseMatrix(i = new_sparse_i, j = new_sparse_j, x = new_sparse_x, dims = c(2396130L, 23636L))

# Save data
saveRDS(real_data, file = "../data/reput_sparse_final.rds", compress = TRUE)
