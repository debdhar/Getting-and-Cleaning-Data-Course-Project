Code Book
====================

#### Data Set 

* The tidy data set contains the mean of all mean and std values of each subject and each activity.
* The data set is stored as a txt file using one space(" ") as the delimiter.
* The first line of the data is the variable name of the data, the names are all quoted by '"'.

#### Variables

* subject, each subject identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* activity, each activity identifies a specific activity subject did. It has 6 different type of activities, including "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", and "LAYING"
* all other variables are measurement collected from the accelerometer and gyroscope 3-axial raw signal.
* the variable name convention is like the following
  * All variable names start with "mean.of." prefixes since they are "mean" of some measurement.
  * Besides the suffix, the variable names contains either a "mean" or "std", to tell if it is a "mean" or "standard deviation" measurement.
  * If the variable end with ".X" or ".Y" or ".Z", means it is the measurement of X/Y/Z direction of a 3-axial singals.  
  * The left part of the variable name mean what the signal really means:
    * prefix 't' to denote time, they were time domain signals captured at a constant rate of 50 Hz.
    * prefix 'f' to indicate frequency domain signals, they were applied by a Fast Fourier Transform (FFT) of the original signal.
* Let me show you some examples:
  * variable name : mean.of.tBodyAcc.mean.X
    * It is the mean of the mean in X direction of the time domain signals on Body Acceleration
  * variable name : mean.of.fBodyBodyGyroMag.std
    * It is the mean of the standard deviation of the FFT applied Body Body Gyro Mag.

#### Transformation 

The data set is a transformation of the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
   
The transformation process is like the following:

* Assume the data is already downloaded in local file system
* Unzip the zip file, which will get me a "UCI HAR Dataset" directory contains all the data required.
* Merged the X_train.txt, y_train.txt, subject_train.txt to a single train data set, using features.txt as the column names of the merged data.
* Merged the X_test.txt, y_test.txt, subject_test.txt to a single test data set, using features.txt as the column names of the merged data.
* Append the test data set to train data set to get a full data set.
* Keep only columns which contains mean() or std() in column names since they are the measurements we need.
* Join the full data set with the activity_labels.txt by label id comes from y_train.txt and y_test.txt to get the activity name.
* Drop the no longer used label id.
* Using reshape2 lib, to melt and dcast method to get the mean of all variables for each subject and each activity as the result dataset.
* Reset the dataset column names with a "mean.of" prefix
* Write the result dataset to local file system.
