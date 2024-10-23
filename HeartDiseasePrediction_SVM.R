# Load necessary libraries
library(e1071)  # For SVM models
library(caret)  # For data partitioning and confusion matrix
library(ggplot2)  # For potential visualization (not used in this code)

# Load the dataset
heart_data <- read.csv("C:/Users/Hirdesh Kumar Yadav/Downloads/R Predictive Analysis/CA2 Dataset/heart_disease.csv")

# Remove rows with missing values
heart_data <- na.omit(heart_data)

# Convert target variable (presence/absence of heart disease) to a factor
heart_data$target <- factor(heart_data$target)

# Split data into training (70%) and testing (30%) sets
set.seed(123)  # Set seed for reproducibility
trainIndex <- sample(303,211)  # Partitioning data
train_data <- heart_data[trainIndex, ]  # Training data
test_data <- heart_data[-trainIndex, ]  # Testing data

# Train SVM model with a linear kernel
svm_linear <- svm(target ~ ., data = train_data, kernel = 'linear', probability = TRUE)

# Train SVM model with a polynomial kernel (degree 3)
svm_poly <- svm(target ~ ., data = train_data, kernel = 'polynomial', degree = 3, probability = TRUE)

# Train SVM model with a radial basis function (RBF) kernel
svm_rbf <- svm(target ~ ., data = train_data, kernel = 'radial', probability = TRUE)

# Predict on the test data using the linear SVM model
pred_linear <- predict(svm_linear, test_data)

# Predict on the test data using the polynomial SVM model
pred_poly <- predict(svm_poly, test_data)

# Predict on the test data using the RBF SVM model
pred_rbf <- predict(svm_rbf, test_data)

# Confusion matrix for the linear SVM model predictions
confusion_linear <- confusionMatrix(pred_linear, test_data$target)

# Confusion matrix for the polynomial SVM model predictions
confusion_poly <- confusionMatrix(pred_poly, test_data$target)

# Confusion matrix for the RBF SVM model predictions
confusion_rbf <- confusionMatrix(pred_rbf, test_data$target)

# Display the confusion matrices
confusion_linear  # Results for linear SVM
confusion_poly  # Results for polynomial SVM
confusion_rbf  # Results for RBF SVM

# Function to calculate performance metrics from confusion matrices
performance_metrics <- function(confusion_matrix) {
  accuracy <- confusion_matrix$overall['Accuracy']  # Extract accuracy
  precision <- confusion_matrix$byClass['Pos Pred Value']  # Extract precision (positive predictive value)
  recall <- confusion_matrix$byClass['Sensitivity']  # Extract recall (sensitivity)
  f1_score <- 2 * ((precision * recall) / (precision + recall))  # Calculate F1 score
  list(accuracy = accuracy, precision = precision, recall = recall, f1_score = f1_score)  # Return as a list
}

# Calculate performance metrics for the linear SVM model
metrics_linear <- performance_metrics(confusion_linear)

# Calculate performance metrics for the polynomial SVM model
metrics_poly <- performance_metrics(confusion_poly)

# Calculate performance metrics for the RBF SVM model
metrics_rbf <- performance_metrics(confusion_rbf)

# Display performance metrics for each model
metrics_linear  # Performance for linear SVM
metrics_poly  # Performance for polynomial SVM
metrics_rbf  # Performance for RBF SVM
