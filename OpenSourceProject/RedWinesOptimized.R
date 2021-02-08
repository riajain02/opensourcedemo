setwd("/Users/ria/CSA/OpenSourceProject")
red_wine <- read.csv(file = "winequality-red.csv", header = TRUE, sep = ";")
norm_data <- function(x) {(x-min(x))/(max(x)-min(x))}
red_wine_norm <- as.data.frame(lapply(red_wine[,-12], norm_data))
num_train <- 1280
num_max <- 1599
red_wine_train <- red_wine[1:num_train,]
red_wine_test <- red_wine[(num_train+1):num_max,]
library(class)
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
best_acc <- 0
best_k <- 0
for(val in 10:300)
{
  red_wine_pred <- knn(red_wine_train, red_wine_test, red_wine[1:num_train,12], k=29)
  red_wine_pred_results <- table(red_wine_pred, red_wine[(num_train+1):num_max,12])
  print(c("k = ", val, ", acc = ", calc_acc(red_wine_pred_results)))
  if (calc_acc(red_wine_pred_results) > best_acc)
  {
   best_acc = calc_acc(red_wine_pred_results)
   best_k = val
  }
}
print(c("BEST ACC = ", best_acc))
print(c("OPTIMAL K = ", best_k))
