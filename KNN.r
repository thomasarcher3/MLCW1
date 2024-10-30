library(caret)
library(dplyr)
library(ggplot2)
library(palmerpenguins)
data(penguins)
penguins_clean <- penguins %>%
select(-island, -sex) %>%
na.omit()
X <- penguins_clean %>% select(-species)
y <- penguins_clean$species
set.seed(123)
train_index <- createDataPartition(y, p = 0.8, list = FALSE)
X_train <- X[train_index, ]
y_train <- y[train_index]
X_test <- X[-train_index, ]
y_test <- y[-train_index]
X_train_scaled <- scale(X_train)
control <- trainControl(method = "cv", number = 10, savePredictions = TRUE)
knn_fit <- train(X_train_scaled, y_train, method = "knn", trControl = control,tuneLength = 10)
best_k <- knn_fit$bestTune$k
cat("Best k value:", best_k, "\n")
