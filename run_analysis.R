#
library(data.table)
#---------------------------------------------------------------
## 
##The URL of the FILE to be downloaded, the fileURL variable stores the link of the file

fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# This is where the zip file will be stored locally
dataFileZIP <- "./getdata-projectfiles-UCI-HAR-Dataset.zip"

##This section downloads the data from the web:
if(file.exists(dataFileZIP) == FALSE) {
        download.file(fileURL, destfile = dataFileZIP)
}
#------------------------------------------------------------------
#1. Merges the training and the test sets to create one data set.
# This section does two main tasks:
# Read the data from different variables and store them in their respective vectors
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

##Merges the training and the test sets to create one data set
x <- rbind(x_train, X_test)
y <- rbind(y_train, y_test)
s <- rbind(subject_train, subject_test)
#---------------------------------------
##2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./UCI HAR Dataset/features.txt")

#The following steps change the names to Recognizable forms
##search for the condition to be matched for mean and SD
### Replaces all matches of a string features
names(features) <- c('feat_id', 'feat_name')
index_features <- grep("-mean\\(\\)|-std\\(\\)", features$feat_name) 
x <- x[, index_features] 
names(x) <- gsub("\\(|\\)", "", (features[index_features, 2]))
#---------------------------------------------
###3. Uses descriptive activity names to name the activities in the data set
###4. Appropriately labels the data set with descriptive variable names.
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
#Passing the recognizable names
names(activities) <- c('act_id', 'act_name')
y[, 1] = activities[y[, 1], 2]
names(y) <- "Activity"
names(s) <- "Subject"

#combining the data tables by columns
tidyDataSet <- cbind(s, y, x)
#-----------------------------------------
#####5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
p <- tidyDataSet[, 3:dim(tidyDataSet)[2]]
tidyDataAVGSet <- aggregate(p,list(tidyDataSet$Subject, tidyDataSet$Activity), mean)
names(tidyDataAVGSet)[1] <- "Subject"
names(tidyDataAVGSet)[2] <- "Activity"

#Writing the tidy data to a new file
write.table(tidyDataSet, "./tidydataset.txt",row.names = FALSE)
write.table(tidyDataAVGSet, "./tidydataset-AVERAGE.txt")

