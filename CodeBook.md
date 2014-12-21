Getting and Cleaning Data Course Project
========================================
Study Design
----------------------------------------
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data set that can be used for later analysis.

The project provided the source data has the following description:
> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
> 
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
> 

Code Book
----------------------------------------
### Source data
The source data represent data collected from the accelerometers from the Samsung Galaxy S smartphone, and can be downloaded from the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The following data files are used as source data:

+ __./UCI HAR Dataset/train/X_train.txt__: Training set.
+ __./UCI HAR Dataset/test/X_test.txt__: Test set.
+ __./UCI HAR Dataset/train/y_train.txt__: Training labels.
+ __./UCI HAR Dataset/test/y_test.txt__: Test labels.
+ __./UCI HAR Dataset/train/subject_train.txt__: It is for the training data set. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
+ __./UCI HAR Dataset/test/subject_test.txt__: It is for the test data set. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
+ __./UCI HAR Dataset/features.txt__: List of all features.
+ __./UCI HAR Dataset/activity_labels.txt__: Links the class labels with their activity name.

Source data is widely formatted (561 variables), for each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

__Variables__:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

__Notes__:
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

### Output data
The script `run_analysis.R` reads source data and produces two widely formatted data sets as data frames:

+ __rawData__: raw data combined in one data set.
+ __tidyData__: tidy data set with the average of each variable for each activity and each subject.

#### rawData

'data.frame':	10299 obs. of  68 variables:

+ Training and test data sets are merged.
+ Only the measurements on the mean and standard deviation are extracted for each measurement.
+ Descriptive activity names added to name the activities in the data.
+ Feature names prepared to be more tidy and descriptive for labels, with removing special characters like "-()", using CamelCase, and moving aggregation type to postfix. But variable names remain abbreviated similarly as can be found in the original description of source data, in order to provide better traceability and usability without making them too long.

#### tidyData

'data.frame':	180 obs. of  68 variables:

+ aggregated raw data with the __average__ of each variable for each __activity__ and each __subject__.
