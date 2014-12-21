Getting and Cleaning Data Course Project
======================
Summary
----------------------
This repository contains my work for the course project of Coursera's Getting and Cleaning Data Course. The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data set that can be used for later analysis. The source data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the following site: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Content
----------------------
The repository contains the following files:

+ __run_analysis.R__: the script performing the analysis and creating tidy data set from the source data.
+ __CodeBook.md__: a code book that describes the variables, the data, and any transformations or work that is performed to clean up the data.
+ __Readme.md__: this is to explain how the script works.

Usage
----------------------
There is only one script called `run_analysis.R`, that is to be used as follows.
### run_analysis.R
##### Preconditions
The script expects the source data to be extracted into the "UCI HAR Dataset" folder in the working directory. The source data can be downloaded from the following URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##### Input parameters
The script has no parameters.
##### Output result set
The script produces two widely formatted data sets as data frames:

+ __rawData__: raw data combined in one data set.
+ __tidyData__: tidy data set with the average of each variable for each activity and each subject.

More information on the data sets can be found in the code book.
##### Description
The script performs tha following execution steps:

1. The script reads source data from the "UCI HAR Dataset" folder from the working directory, and merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

More information can be found in comments of the script.
