setwd("/Users/ria/CSA/OpenSourceProject")
red_wine <- read.csv(file = "winequality-red.csv", header = TRUE, sep = ";")
norm_data <- function(x) {(x-min(x))/(max(x)-min(x))}
red_wine_norm <- as.data.frame(lapply(red_wine[,-12], norm_data))
red_wine_train <- red_wine_norm[1:1280,]
red_wine_test <- red_wine_norm[1281:1599,]
library(class)
red_wine_pred <- knn(red_wine_train, red_wine_test, red_wine[1:1280,12], k=29)
red_wine_pred_results <- table(red_wine_pred, red_wine[1281:1599,12])
calc_acc <- function(x) {
  num_correct <- 0
  num_tot <- 0
  for(i in 1:ncol(x))
  {
    num_correct <- num_correct + x[i,i]
    num_tot <- num_tot + sum(x[i,])
  }
  num_correct / num_tot
}
print(calc_acc(red_wine_pred_results))