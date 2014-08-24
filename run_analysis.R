#Download data from source and unzip it
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, "data.zip", method = "curl")
unzip("data.zip")

#Read the relevant data in the tables
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") 
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") 
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Add labels to the train and test data
colnames(features) <- c("Index", "Variables")
colnames(x_train) <- features$Variables
colnames(x_test) <- features$Variables
colnames(activity_labels) <- c("Index", "Activity")
colnames(subject_test) <- c("Subject")
colnames(subject_train) <- c("Subject")
colnames(y_train) <- c("Activity_num")
colnames(y_test) <- c("Activity_num")

#Combine all the columns of test data
test_data <- cbind(subject_test, y_test, x_test)
train_data <- cbind(subject_train, y_train, x_train)
combined_data <- rbind(test_data, train_data)

#Use descriptive activity names
master_data <- merge(combined_data, activity_labels, by.x = "Activity_num", by.y = "Index", all = TRUE)

#Separate the columns that are pertaining to mean and std dev
selected_data <- master_data[,(grepl("mean", colnames(master_data)) | grepl("std", colnames(master_data)) | colnames(master_data) == "Activity" | colnames(master_data) == "Subject")]

#Create separate tidy data set for writing
master_data$Subject <- as.factor(master_data$Subject)
pretidy_data <- master_data[,!(colnames(master_data) == "Subject" | colnames(master_data) == "Activity" | colnames(master_data) == "Activity_num")]
tidy_data <- aggregate(pretidy_data, by = list(master_data$Subject, master_data$Activity), FUN = mean)
colnames(tidy_data)[1] = "Subject"
colnames(tidy_data)[2] = "Activity"

#Write data using write.table
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)