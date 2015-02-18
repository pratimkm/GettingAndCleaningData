makeDataTidy <- function(){
  
  # load required libraries first
  library(data.table)
  library(plyr)
  
  # if zip file doesn't exist download the file and unzip
  if(!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","getdata_projectfiles_UCI HAR Dataset.zip")
    unzip("getdata_projectfiles_UCI HAR Dataset.zip")
  }
  
  features <- read.table("./UCI HAR Dataset/features.txt")
  
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  
  # Task 1. Merge the training and the test sets to create one data set
  
  # first read data and merge the columns
  x_train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
  x_test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
  
  # column names are set from features.txt
  colnames(x_train_set) <- t(features[2])
  colnames(x_test_set) <- t(features[2])
  
  y_label_set <- read.table("./UCI HAR Dataset/train/y_train.txt")
  y_test_set <- read.table("./UCI HAR Dataset/test/y_test.txt")
 
  x_train_set$activity <- y_label_set[, 1]
  x_train_set$subject <- subject_train[, 1]
  x_test_set$activity <- y_test_set[, 1]
  x_test_set$subject <- subject_test[, 1]
  
  # then bind training and test rows
  merged_data <- rbind(x_train_set, x_test_set)

  # filter unique rows like select distinct
  merged_data <- unique(merged_data)
  
  
  # Task 2. Extract only the measurements on the mean and standard deviation for each measurement. 
  merged_data_mean_std <- merged_data[,grepl("mean|std|activity|subject", names(merged_data))]
  
 
  # Task 3. Use descriptive activity names to name the activities in the data set
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  merged_data_mean_std$activity[which(merged_data_mean_std$activity == "1")] <- as.character(activity_labels[1,2])
  merged_data_mean_std$activity[which(merged_data_mean_std$activity == "2")] <- as.character(activity_labels[2,2])
  merged_data_mean_std$activity[which(merged_data_mean_std$activity == "3")] <- as.character(activity_labels[3,2])
  merged_data_mean_std$activity[which(merged_data_mean_std$activity == "4")] <- as.character(activity_labels[4,2])
  merged_data_mean_std$activity[which(merged_data_mean_std$activity == "5")] <- as.character(activity_labels[5,2])
  merged_data_mean_std$activity[which(merged_data_mean_std$activity == "6")] <- as.character(activity_labels[6,2])

  # Task 4. Appropriately labels the data set with descriptive variable names. 
  # Remove parentheses
  names(merged_data_mean_std) <- gsub('\\(|\\)',"",names(merged_data_mean_std), perl = TRUE)

  # Some abbreviations expanded
  names(merged_data_mean_std) <- gsub('Acc',"Acceleration",names(merged_data_mean_std))
  names(merged_data_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(merged_data_mean_std))
  names(merged_data_mean_std) <- gsub('Gyro',"AngularSpeed",names(merged_data_mean_std))
  names(merged_data_mean_std) <- gsub('Mag',"Magnitude",names(merged_data_mean_std))
  names(merged_data_mean_std) <- gsub('^t',"TimeDomain.",names(merged_data_mean_std))
  names(merged_data_mean_std) <- gsub('^f',"FrequencyDomain.",names(merged_data_mean_std))
  names(merged_data_mean_std) <- gsub('\\.mean',".Mean",names(merged_data_mean_std))
  names(merged_data_mean_std) <- gsub('\\.std',".StandardDeviation",names(merged_data_mean_std))
  names(merged_data_mean_std) <- gsub('Freq\\.',"Frequency.",names(merged_data_mean_std))
  names(merged_data_mean_std) <- gsub('Freq$',"Frequency",names(merged_data_mean_std))

  # Task 5.  create a second, independent tidy data set with the average of each variable for each activity and each subject
  tidy_data_set = ddply(merged_data_mean_std, c("activity","subject"), numcolwise(mean))
  write.table(tidy_data_set, file = "tidy_data_set.txt",row.name=FALSE)
}