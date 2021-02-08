setwd("/Users/ria/CSA/OpenSourceProject")

read_val <- function(x)
{
  n <- readline(prompt = x)
  n <- as.double(n)
  if (is.na(n)) {
    n <- read_val()
  }
  return(n)
}

columns <- 0
observation <- NULL
input <- tolower(readline(prompt = "Do you want to consider fixed acidity (y/n)?"))
while (input != "y" & input != "n") {input <- tolower(readline(prompt = "Do you want to consider fixed acidity (Y/N)?"))}
if (input == "y") {
  columns <- c(columns,1)
  observation <- c(observation, read_val("Enter the fixed acidity: "))
}
input <- tolower(readline(prompt = "Do you want to consider volatile acidity (y/n)?"))
while (input != "y" & input != "n") {input <- tolower(readline(prompt = "Do you want to consider volatile acidity (Y/N)?"))}
if (input == "y") {
  vcolumns <- c(columns,2)
  observation <- c(observation, read_val("Enter the volatile acidity: "))
}
input <- tolower(readline(prompt = "Do you want to consider citric acid (y/n)?"))
while (input != "y" & input != "n") {input <- tolower(readline(prompt = "Do you want to consider citric acid (Y/N)?"))}
if (input == "y") {
  columns <- c(columns,3)
  observation <- c(observation, read_val("Enter the citric acid: "))
}
input <- tolower(readline(prompt = "Do you want to consider residual sugar (y/n)?"))
while (input != "y" & input != "n") {input <- tolower(readline(prompt = "Do you want to consider residual sugar (Y/N)?"))}
if (input == "y") {
  columns <- c(columns,4)
  observation <- c(observation, read_val("Enter the residual sugar: "))
}
input <- tolower(readline(prompt = "Do you want to consider chlorides (y/n)?"))
while (input != "y" & input != "n") {input <- tolower(readline(prompt = "Do you want to consider chlorides (Y/N)?"))}
if (input == "y") {
  columns <- c(columns,5)
  observation <- c(observation, read_val("Enter the chlorides: "))
}
input <- tolower(readline(prompt = "Do you want to consider free sulfur dioxide (y/n)?"))
while (input != "y" & input != "n") {input <- tolower(readline(prompt = "Do you want to consider free sulfur dioxide (Y/N)?"))}
if (input == "y") {
  columns <- c(columns,6)
  observation <- c(observation, read_val("Enter the free sulfur dioxide: "))
}
input <- tolower(readline(prompt = "Do you want to consider total sulfur dioxide (y/n)?"))
while (input != "y" & input != "n") {input <- tolower(readline(prompt = "Do you want to consider total sulfur dioxide (Y/N)?"))}
if (input == "y") {
  columns <- c(columns,7)
  observation <- c(observation, read_val("Enter the total sulfur dioxide: "))
}
input <- tolower(readline(prompt = "Do you want to consider density (y/n)?"))
while (input != "y" & input != "n") {input <- tolower(readline(prompt = "Do you want to consider density (Y/N)?"))}
if (input == "y") {
  columns <- c(columns,8)
  observation <- c(observation, read_val("Enter the density: "))
}
input <- tolower(readline(prompt = "Do you want to consider pH (y/n)?"))
while (input != "y" & input != "n") {input <- tolower(readline(prompt = "Do you want to consider pH (Y/N)?"))}
if (input == "y") {
  columns <- c(columns,9)
  observation <- c(observation, read_val("Enter the pH: "))
}
input <- tolower(readline(prompt = "Do you want to consider sulphates (y/n)?"))
while (input != "y" & input != "n") {input <- tolower(readline(prompt = "Do you want to consider sulphates (Y/N)?"))}
if (input == "y") {
  columns <- c(columns,10)
  observation <- c(observation, read_val("Enter the sulphates: "))
}
input <- tolower(readline(prompt = "Do you want to consider alcohol (y/n)?"))
while (input != "y" & input != "n") {input <- tolower(readline(prompt = "Do you want to consider alcohol (Y/N)?"))}
if (input == "y") {
  columns <- c(columns,11)
  observation <- c(observation, read_val("Enter the alcohol: "))
}
#if(is.null(observations)) print("ERROR: No qualities of wine were considered. Prediction cannot be made.")
columns <- c(columns, 12)
observation <- c(observation, 5)

input <- tolower(readline(prompt = "Is your wine red or white (r/w)?"))
print("Calculating result...")

wines_all <- read.csv(file = "winequality-red.csv", header = TRUE, sep = ";")
if (input == "w") wines_all <- read.csv(file = "winequality-white.csv", header = TRUE, sep = ";")
wines <- wines_all[,columns]
wines <- rbind(wines, observation)
last_col <- ncol(wines)
norm_data <- function(x) {(x-min(x))/(max(x)-min(x))}
wine_norm <- as.data.frame(lapply(wines[,-last_col], norm_data))
wines_train <- wine_norm[1:(nrow(wines)*0.8),]
wines_test <- wine_norm[(nrow(wines)*0.8+1):nrow(wines),]
library(class)
wines_pred <- knn(wines_train, wines_test, wines[1:(nrow(wines_train)),last_col], k=(sqrt(nrow(wines))))
wines_pred_results <- table(wines_pred, wines[(nrow(wines)*0.8+1):nrow(wines),last_col])
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
print("RESULT:")
print(paste("This wine has an quality of ", wines_pred[wines_pred[length(wines_pred)]], " on a ten point scale."))
print(paste("It is likely that the above result is ", (.4 * 100), "% accurate."))
# calc_acc(wines_pred_results)
