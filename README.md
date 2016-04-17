## Getting & Cleaning Data - Assignment on Human Activity Recognition using Smartphone Dataset

This program is designed to create tidy dataset.  The input data is obtained from following location,

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The program performs following operations,

1. It assumes that the data has been downloaded and unzipped in the current working directory.
2. Reads the activity\_labels.txt and stores in a data frame with proper variable names ( This is a master data representing description of each activity type)
3. Reads the features.txt and stores in a data frame with proper variable names ( This is a master data represent each feature names)
4. Creates the test data frame which has both labels and data( X\_test.txt and Y\_test.txt files). This uses column binding function in R
5. Creates the training data frame which has both labels and data ( X\_train.txt and y_train.txt).  This uses column binding function in R
6. Merges both the test and training data. This uses row binding function in R
7. Extracts only the mean features.  This uses grep and select features of dplyr
8. Prepares final output with descriptive activity and variable names
9. It creates tidy data having average across activity type and each variable and write to a file. This uses group\_by and summarize features of dplyr






