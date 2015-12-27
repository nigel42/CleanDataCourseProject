# Getting and Cleaning Data Course Project
#
# This analysis uses files downloaded from the course shared folder:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# originally obtained from:
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Merge files and select measurements from the training and test datasets to
# create one dataset for analysis
# Then do some simple analysis on the resulting table

# Assumes the files are in the current working directory

library(utils)


# Get and clean the test data

# open the subject_test.txt    subject ID's
# open the y_test.txt          activity IDs
# open the x_test.txt          measurements

# Get the subjectID for each set of measurements
subjects <- read.csv("subject_test.txt",header=FALSE)
colnames(subjects) <- c("subjectID")

# Get the activities, name the column
activities <- read.csv("y_test.txt",header=FALSE)
colnames(activities) <- c("activityID")

# load the measurements and get the column names from features.txt
measurements <- read.csv("X_test.txt",header=FALSE,sep="")
cols <- read.csv("features.txt",sep="",header=FALSE)
colnames(measurements) <- cols[,2]

# find out which columns are mean or std variables - based on the names
meanOrStd_index <- c(grep("mean",cols[,2]),grep("std",cols[,2]))

# create a clean dataframe with the subject, activity and only the mean/std variables
cleanTestData <- cbind(subjects,activities,measurements[,meanOrStd_index])


# Get and clean the train data

# open the subject_train.txt    subject ID's
# open the y_train.txt          activity IDs
# open the x_train.txt          measurements

# Get the subjectID for each set of measurements
subjects <- read.csv("subject_train.txt",header=FALSE)
colnames(subjects) <- c("subjectID")

# Get the activities, name the column
activities <- read.csv("y_train.txt",header=FALSE)
colnames(activities) <- c("activityID")

# load the measurements and get the column names from features.txt
measurements <- read.csv("X_train.txt",header=FALSE,sep="")
cols <- read.csv("features.txt",sep="",header=FALSE)
colnames(measurements) <- cols[,2]

# find out which columns are mean or std variables - based on the names
meanOrStd_index <- c(grep("mean",cols[,2]),grep("std",cols[,2]))

# create a clean dataframe with the subject, activity and only the mean/std variables
cleanTrainData <- cbind(subjects,activities,measurements[,meanOrStd_index])



# combine the two datasets
# NOTE: combined after removing columns to reduce the memory required for the operation
cleanData <- rbind(cleanTestData,cleanTrainData)

# Add the activity description to each row
activityNames <- read.csv("activity_labels.txt",sep='',header=FALSE)
colnames(activityNames) <- c("activityID","activityName")
cleanData <- merge.data.frame(activityNames,cleanData,all = TRUE)  # this does NOT keep the rows in the same order

# calculate the average of each measurement for each activity and each subject
out <- aggregate(cleanData[,-2],list(cleanData$subjectID,cleanData$activityID,cleanData$activityName),mean)

# write the table out to submit
write.table(out,file="projectOut.txt")
