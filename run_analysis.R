## This work is licensed under a Creative Commons Attribution-NonCommercial 
## 4.0 International License: http://creativecommons.org/licenses/by-nc/4.0/
## (c) 2014 Istvan Szente - szente.istvan@gmail.com

## Description: The goal is to prepare tidy data set that can be used for
##              later analysis. The source represent data collected from the
##              accelerometers from the Samsung Galaxy S smartphone. A full 
##              description is available at the following site:
##              http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
##              !!!Important!!!: The script expects the source data to be 
##              extracted into the "UCI HAR Dataset" folder in the working
##              directory.
##              The source data can be downloaded from the following URL:
##              https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
##              The script consists of the following execution steps:
##              1) Merges the training and the test sets to create one data set.
##              2) Extracts only the measurements on the mean and standard 
##                 deviation for each measurement. 
##              3) Uses descriptive activity names to name the activities in the 
##                 data set.
##              4) Appropriately labels the data set with descriptive variable names. 
##              5) From the data set in step 4, creates a second, independent tidy 
##                 data set with the average of each variable for each activity and 
##                 each subject.


###############################################################################
## Step 1 - Merges the training and the test sets to create one data set.
###############################################################################

## Reads and merges training and test data sets.
rawData <- read.table("./UCI HAR Dataset/train/X_train.txt")
rawData <- rbind(rawData, read.table("./UCI HAR Dataset/test/X_test.txt"))

## Reads and merges training and test activity labels.
activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
activity <- rbind(activity, read.table("./UCI HAR Dataset/test/y_test.txt"))

## Reads and merges training and test subjects.
subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject <- rbind(subject, read.table("./UCI HAR Dataset/test/subject_test.txt"))

###############################################################################
## Step 2 - Extracts only the measurements on the mean and standard deviation 
## for each measurement.
###############################################################################

## Reads features data.
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)

## Keeps only the measurements on the mean and std for each measurement.
features <- features[grep("mean\\(|std\\(", features[, 2]), ]
rawData <- rawData[, features[, 1]]

###############################################################################
## Step 3 - Adds descriptive activity names to name the activities in the data 
## set.
###############################################################################

## Reads activity labels and merges into activity data preserving the original
## order of records.
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity <- cbind(id=1:nrow(activity), activity)
activity <- merge(activity, activityLabels, by="V1", sort=FALSE)
activity <- activity[order(activity$id), c("V1", "V2")]

## Deletes objects not needed hereafter.
rm(activityLabels)

###############################################################################
## Step 4 - Appropriately prepares and labels the data set with descriptive 
## variable names.
###############################################################################

## Prepares feature names to be more tidy and descriptive for labels, with 
## removing special characters like "-()", using CamelCase, and moving 
## aggregation type to postfix. But variable names remain abbreviated similarly
## as can be found in the original description of source data (features_info.txt),
## in order to provide better traceability and usability without making them too
## long. The full description of variables can be found in the related code book.
idx <- grep("-mean..(-)?", features[, 2])
features[idx, 2] <- paste(gsub("-mean..(-)?", "", features[idx, 2]), "Mean", sep="")
idx <- grep("-std..(-)?", features[, 2])
features[idx, 2] <- paste(gsub("-std..(-)?", "", features[idx, 2]), "Std", sep="")

## Creates one data set with appropriate labels.
rawData <- cbind(subject[, 1], activity[, 2], rawData)
names(rawData) <- c("Subject", "Activity", features[, 2])

## Deletes objects not needed hereafter.
rm(subject)
rm(activity)
rm(features)
rm(idx)

###############################################################################
## Step 5 - Creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.
###############################################################################

## Aggregates raw data by Subject and Activity calculating the average of the variables.
tidyData <- aggregate(rawData[, -(1:2)], by=rawData[, c("Subject", "Activity")], FUN=mean)
## Orders tidy data set by Subject and Activity.
tidyData <- tidyData[order(tidyData$Subject, tidyData$Activity), ]

## Extends variable names denoting that each variable is an average.
names(tidyData) <- c(names(tidyData[,1:2]), gsub("Mean$", "AvgMean", names(tidyData[,-(1:2)])))
names(tidyData) <- c(names(tidyData[,1:2]), gsub("Std$", "AvgStd", names(tidyData[,-(1:2)])))

## Optionally the raw and tidy data set can be written to disk using the 
## following commands.
#write.table(rawData, "raw_data.txt", row.names=FALSE)
#write.table(tidyData, "tidy_data.txt", row.names=FALSE)
