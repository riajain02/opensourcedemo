setwd("/Users/ria/CSA/OpenSourceProject")
white_wine <- read.csv(file = "winequality-white.csv", header = TRUE, sep = ";")
norm_data <- function(x) {(x-min(x))/(max(x)-min(x))}
white_wine_norm <- as.data.frame(lapply(white_wine[,-12], norm_data))
num_train <- 3990
num_max <- 4898
white_wine_train <- white_wine[1:num_train,]
white_wine_test <- white_wine[(num_train+1):num_max,]
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
for(val in 250:450)
{
  white_wine_pred <- knn(white_wine_train, white_wine_test, white_wine[1:num_train,12], k=val)
  white_wine_pred_results <- table(white_wine_pred, white_wine[(num_train+1):num_max,12])
  print(c("k = ", val, ", acc = ", calc_acc(white_wine_pred_results)))
  if (calc_acc(white_wine_pred_results) > best_acc)
  {
    best_acc = calc_acc(white_wine_pred_results)
    best_k = val
  }
}
print(c("BEST ACC = ", best_acc))
print(c("OPTIMAL K = ", best_k))
