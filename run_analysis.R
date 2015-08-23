# You should create one R script called run_analysis.R that does the following. 
#   1. Merges the training and the test sets to create one data set.
#   2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#   3. Uses descriptive activity names to name the activities in the data set
#   4. Appropriately labels the data set with descriptive variable names. 
#   5. From the data set in step 4, creates a second, independent tidy data set with the average
#      of each variable for each activity and each subject.

library(data.table)
library(reshape2)


                                        # TASKS 1-4

# variable names
features <- read.table("Getting and cleaning data/course project/UCI HAR Dataset/features.txt")[,2]
features <- as.character(features)
# activity names
activity_labels <- read.table("Getting and cleaning data/course project/UCI HAR Dataset/activity_labels.txt")[,2]

# training set with only means and standart deviations
x_train <- read.table("Getting and cleaning data/course project/UCI HAR Dataset/train/X_train.txt")
names(x_train) <- features                                      # naming
x_train <- x_train[,grepl("mean[^F]|std", names(x_train))]      # subsetting
# activities for training set
x_train <- as.data.table(x_train)
x_train <- x_train[, activity:=read.table("Getting and cleaning data/course project/UCI HAR Dataset/train/y_train.txt")]

# testing set with only means and standart deviations
x_test  <- read.table("Getting and cleaning data/course project/UCI HAR Dataset/test/X_test.txt")
names(x_test) <- features                                    # naming
x_test <- x_test[,grepl("mean[^F]|std", names(x_test))]      # subsetting
# activities for testing set
x_test <- as.data.table(x_test)
x_test <- x_test[, activity:=read.table("Getting and cleaning data/course project/UCI HAR Dataset/test/y_test.txt")]

# subjects for both sets
s_train  <- read.table("Getting and cleaning data/course project/UCI HAR Dataset/train/subject_train.txt")
s_test   <- read.table("Getting and cleaning data/course project/UCI HAR Dataset/test/subject_test.txt"  )
subjects <- rbind(s_train, s_test)

# merging sets
data <- x_train
data <- rbind(data, x_test)             # training + testing
data <- data[, subject:=subjects]       # + subjects

# names fo activities
data$activity <- as.character(data$activity)
data$activity[data$activity == 1] <- as.character(activity_labels[1])
data$activity[data$activity == 2] <- as.character(activity_labels[2])
data$activity[data$activity == 3] <- as.character(activity_labels[3])
data$activity[data$activity == 4] <- as.character(activity_labels[4])
data$activity[data$activity == 5] <- as.character(activity_labels[5])
data$activity[data$activity == 6] <- as.character(activity_labels[6])


                                        # TASK 5

measurements <- setdiff(colnames(data), c("subject", "activity"))
new_data     <- melt(data, measure.vars = measurements)
new_data     <- dcast(new_data, subject + activity ~ variable, mean)

write.table(x = new_data, file = "Getting and cleaning data/course project/new_data.txt", row.name = FALSE)







