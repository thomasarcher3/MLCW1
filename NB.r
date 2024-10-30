library(palmerpenguins) 
library(caret)           
library(e1071)         
library(ggplot2) 
data("penguins")
penguins_clean <- na.omit(penguins)
train_index <- createDataPartition(penguins_clean$species, p = 0.8, list = FALSE)
train_data <- penguins_clean[train_index, ]
test_data <- penguins_clean[-train_index, ]
control <- trainControl(method = "cv", number = 10)
naiveBayes_model <- train(species ~ ., 
                  data = train_data, 
                  method = "nb", 
                  trControl = control)
predictions <- predict(nb_model, newdata = test_data)
confusionMatrix(predictions, test_data$species)
cm <- confusionMatrix(predictions, test_data$species)
cm_table <- as.data.frame(cm$table)
ggplot(cm_table, aes(x = Reference, y = Prediction)) +
  geom_tile(aes(fill = Freq), color = "white") +
  geom_text(aes(label = Freq), vjust = 1) +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(title = "Confusion Matrix for Naive Bayes",
       x = "Actual Species", y = "Predicted Species")
