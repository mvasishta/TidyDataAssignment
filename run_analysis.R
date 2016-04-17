library(dplyr)

## Read the file activity_labels.txt and store in data frame and assign proper variable names
activity_label_df <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,sep="")
names(activity_label_df) = c("Activity_Type_Cd","Activity_Description")

## Read the file features.txt and store in data frame and assign proper variable names
feature_df <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,sep="")
names(feature_df) = c("Feature_Cd","Feature_Name")

## Create test data frame.  Proper variable names will be assigned later
test_data_df <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE,sep="")

## Create test labels data frame.  Assign proper variable names
test_data_labels_df <- read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE,sep="")
names(test_data_labels_df) = c("Activity_Type_Cd")

## Create final test data frame that contains both test labels and data
test_data_final_df <- cbind(test_data_labels_df, test_data_df)

## Create training data frame.  Proper variable names will be assigned later
train_data_df <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE,sep="")

## Create training labels data frame.  Assign proper variable names
train_data_labels_df <- read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE,sep="")
names(train_data_labels_df) = c("Activity_Type_Cd")

## Create final training data frame that contains both training labels and data
train_data_final_df <- cbind(train_data_labels_df, train_data_df)

## Merge the test and training data
merged_data_final_df <- rbind(test_data_final_df,train_data_final_df)

## Create a list of feature names having mean values
mean_only_feature_df <- feature_df[grep("mean",feature_df$Feature_Name),]
## As the merged data has Activity code as the first column, increase the index value by 1
mean_only_feature_df$Feature_Cd = mean_only_feature_df$Feature_Cd + 1
## Convert the feature name into character datatype from factor
mean_only_feature_df$Feature_Name = as.character(mean_only_feature_df$Feature_Name)

## Create a data frame having extracts of only mean values and assign proper names
mean_only_data_df <- select(merged_data_final_df,1,mean_only_feature_df$Feature_Cd)
colnames(mean_only_data_df) = c("Activity_Type_Cd",mean_only_feature_df$Feature_Name)

## Create a data frame having descriptive values for activity type code by joining with activity labels data
descriptive_data_df <-  merge(mean_only_data_df,activity_label_df,by.x = "Activity_Type_Cd",by.y="Activity_Type_Cd",all.x=TRUE)

## Final output contain only descriptive values and variable names
final_output_df <- select(descriptive_data_df,48,2:47)
final_output_df$Activity_Description = as.character(final_output_df $Activity_Description)

## Final output needs to use dplyr package to apply group_by and summarise functions
final_output_tbl <- tbl_df(final_output_df)

## Create summary table group by activity description
summary_output_tbl <- group_by(final_output_tbl,Activity_Description)

## Apply the mean function across the activity and each variable
final_summary_tbl <- summarise_each(summary_output_tbl,funs(mean),2:46)

## Write the final tidy data to file
write.table(final_summary_tbl,"tidy_output_data.txt",row.name=FALSE)
