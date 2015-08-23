# Course Project
Preparing tidy data that can be used for later analysis.
The given data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Script run_analysis.R does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The analysis script reads given training and test sets, gives column names from file "features.txt", merges training and data sets.
Variables with means and standart deviations are included in tidy data set "new_data".
Activity identifiers are replaced with the activity labels from file "activity_labels.txt".
Generated data set "new_data" is grouped by subject and activity.