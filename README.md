#Getting and Cleaning Data
This document clarifies how to analyse data using run_analysis.R file:
##What is this R script capable of?
It can perform the following sets of activities:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##How to use this R Script?
1. Download the data source and put into a folder on your local drive.
2. Download the run_analysis.R script in the same folder as your downloaded data.
3. Source the code in R and make the use of the code.

##Do I need any Special Packages to run this script?
Yes, this file needs 'data.table' to be loaded in the library. It can be done by passing this in your R load(data,table).

##Where can I download the original dataset?
* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
