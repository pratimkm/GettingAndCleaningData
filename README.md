## Name 
makeDataTidy

## Description
        Merges the training and the test sets to create one data set.
        Extracts only the measurements on the mean and standard deviation for each measurement. 
        Uses descriptive activity names to name the activities in the data set
        Appropriately labels the data set with descriptive variable names. 
        From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each 	activity and each subject.

## Output
writes a table to current working directory named tidy_data_set.txt

## References
  # Description of dataset :  
        http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
  # Dataset
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
}

## Note
 latex codebook file generated with the command, prompt(makeDataTidy)


## Description
  Load required libraries first. If zip file getdata_projectfiles_UCI HAR Dataset.zip doesn't exist download the file and unzip.
  Read features,training,test and subject data into data frames. Merge the columns. Column names are set from features.txt.
  Row bind training and test rows. Filter out only unique rows. Thus merging of training and test data are complete.
  Extract only the measurements on the mean and standard deviation for each measurement along with activity and subject columns.
  Transform activity ids to names by mapping id to second column in activity labels data frame. 
  Remove parentheses from the column names and expand the abbreviations. This completes the descriptive variable names task.
  Now create independent tidy data set with the average of each variable for each activity and each subject and store in file tidy_data_set.txt.
}

# Examples
    makeDataTidy()
