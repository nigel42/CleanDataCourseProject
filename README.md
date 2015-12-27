# CleanDataCourseProject

## Overview
This repository contains code developed for the course project as part of the 'Getting and Cleaning Data' course.
The file run_analysis.R contains the R script to process the data files provided by the course.
The rest of this README describes the source of the data, the processing steps and the output produced.

# Study Design

## Data Source
Data for this analysis was downloaded from the Coursera 'Getting and Cleaning Data' course shared folder:

	[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

which was originally obtained from:

	[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### From the downloaded data set:
		==================================================================
		Human Activity Recognition Using Smartphones Dataset
		Version 1.0
		==================================================================
		Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
		Smartlab - Non Linear Complex Systems Laboratory
		DITEN - Università degli Studi di Genova.
		Via Opera Pia 11A, I-16145, Genoa, Italy.
		activityrecognition@smartlab.ws
		www.smartlab.ws
		==================================================================

		The experiments have been carried out with a group of 30 volunteers within an 
		age bracket of 19-48 years. Each person performed six activities (WALKING, 	
		WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
		wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded 
		accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-
		axial angular velocity at a constant rate of 50Hz. The experiments have been 
		video-recorded to label the data manually. The obtained dataset has been 
		randomly partitioned into two sets, where 70% of the volunteers was selected 
		for generating the training data and 30% the test data. 

		The sensor signals (accelerometer and gyroscope) were pre-processed by 
		applying noise filters and then sampled in fixed-width sliding windows of 2.56 
		sec and 50% overlap (128 readings/window). The sensor acceleration signal, 
		which has gravitational and body motion components, was separated using a 
		Butterworth low-pass filter into body acceleration and gravity. The gravitational 
		force is assumed to have only low frequency components, therefore a filter with 
		0.3 Hz cutoff frequency was used. From each window, a vector of features was 
		obtained by calculating variables from the time and frequency domain. See 
		'features_info.txt' for more details. 

		For each record it is provided:
		======================================

		- Triaxial acceleration from the accelerometer (total acceleration) and the 
		estimated body acceleration.
		- Triaxial Angular velocity from the gyroscope. 
		- A 561-feature vector with time and frequency domain variables. 
		- Its activity label. 
		- An identifier of the subject who carried out the experiment.

		The dataset includes the following files:
		=========================================

		- 'README.txt'

		- 'features_info.txt': Shows information about the variables used on the feature 
		vector.

		- 'features.txt': List of all features.

		- 'activity_labels.txt': Links the class labels with their activity name.

		- 'train/X_train.txt': Training set.

		- 'train/y_train.txt': Training labels.

		- 'test/X_test.txt': Test set.

		- 'test/y_test.txt': Test labels.

		The following files are available for the train and test data. Their descriptions are 
		equivalent. 

		- 'train/subject_train.txt': Each row identifies the subject who performed the 
		activity for each window sample. Its range is from 1 to 30. 

		- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the 
		smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 
		128 element vector. The same description applies for the 'total_acc_x_train.txt' 
		and 'total_acc_z_train.txt' files for the Y and Z axis. 

		- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal 
		obtained by subtracting the gravity from the total acceleration. 

		- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector 
		measured by the gyroscope for each window sample. The units are 
		radians/second. 

		Notes: 
		======
		- Features are normalized and bounded within [-1,1].
		- Each feature vector is a row on the text file.
		
		For more information about this dataset contact:  
		activityrecognition@smartlab.ws

		License:
		========
		Use of this dataset in publications must be acknowledged by referencing the 
		following publication [1] 

		[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
		Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
		Hardware-Friendly Support Vector Machine. International Workshop of Ambient 
		Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

		This dataset is distributed AS-IS and no responsibility implied or explicit can be 
		addressed to the authors or their institutions for its use or misuse. Any 
		commercial use is prohibited.

		Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 
		2012.

### For this analysis, the following file were used from the above dataset
#### labels
- activity_labels.txt	- names of the activities
- features.txt			- names of the variables in each of the feature vectors (rows)

#### data from test set
- subject_test.txt		- subject IDs corresponding to the feature vectors (rows)
- X_test.txt			- feature vectors (rows)
- y_test.txt			- activity ID corresponding to each feature vector

#### data from training set
- subject_train.txt
- X_train.txt
- y_train.txt


# Code Book

The analysis was performed with:
- RStudio: Version 0.99.489 – © 2009-2015 RStudio, Inc.
- R: R version 3.2.2 (2015-08-14)  (platform: x86_64-w64-mingw32 )

## Procedure:

- copy the select files to the working directory
- open and run 'run_analysis.R' to process the data and generate the output file 'projectOut.txt'

###Summary of run_analysis.R processing:

#### Read the test data set including activities and the test subject identifiers and add column names
- read the subjectID's from subject_test.txt into a dataframe  (1 column, no header)
- name the column "subjectID"
- read the activities from y_test.txt into a dataframe (1 column, no header)
- name the column 'activityID"
- load the feature vectors from X_test,txt into a dataframe (561 columns, no headers)
- read the column IDs and names from features.txt into a dataframe (2 columns, 561 rows, no header)
- use the column names from features to name the columns in the feature vector dataframe.  Use the exact names to preserve the traceability.

##### Identify the 'mean' and 'standard deviation' columns and assemble the cleaned up test data set
- search the column names (from the features.txt) for 'mean' or 'std'
- bind the subjectID and activities columns with ONLY the columns from the feature vector that matched the 'mean' or 'std' search

#### Repeat all the steps above for the training data set using the corresponding files
#### Combine the test and training datasets - done after removing columns to reduce the memory required for the operation
- column bind the activity, subjectID and feature vector dataframes together - all the dataframes should have the same number of rows and still be in the original order

#### Add the activity description to every row based on its activityID.  This is done after column binding because the merge operation does not keep the rows in order
- read the activity names from "activity_labels.txt" (2 columns, no header)
- name the columns "activityID","activityName" to enable the merge and add clarity
- merge (join) the activityName to the feature vector by activityID - this does NOT keep the rows in the same order

#### We now have a dataframe containing the joined test and training datasets with the activities labelled, the test subjects identified and only the mean and standard deviation columns from the original feature vector.

#### Summarize the dataset and write the results to a file for reference.
- calculate the average of each measurement for each activity and each subject using aggregate().  Drop the activity name column as it cannot be averaged and is already included in the label of the group.
- remove the redundant columns added by the aggregation and clean up the column names
- write the results out to a file as a table

## Output

A file containing the average of each 'mean' and 'standard deviation' for each activity for each subject

### Variables:

- Group.1		- (numeric) grouping column - subjectID
- Group.2		- (numeric) grouping column - activityID
- Group.3		- (character string) grouping column activityName
- activityID	- (numeric 1-6)
- subjectID	- (numeric 1-30)

#### These variable are an average of source data over the subject and activity - see below for description of source data.  The names were carried forward from the source to provide traceability with '-avg()' appended to each to differentiate it from the source.
- tBodyAcc-mean()-X-avg()
- tBodyAcc-mean()-Y-avg()
- tBodyAcc-mean()-Z-avg()
- tGravityAcc-mean()-X-avg()
- tGravityAcc-mean()-Y-avg()
- tGravityAcc-mean()-Z-avg()
- tBodyAccJerk-mean()-X-avg()
- tBodyAccJerk-mean()-Y-avg()
- tBodyAccJerk-mean()-Z-avg()
- tBodyGyro-mean()-X-avg()
- tBodyGyro-mean()-Y-avg()
- tBodyGyro-mean()-Z-avg()
- tBodyGyroJerk-mean()-X-avg()
- tBodyGyroJerk-mean()-Y-avg()
- tBodyGyroJerk-mean()-Z-avg()
- tBodyAccMag-mean()-avg()
- tGravityAccMag-mean()-avg()
- tBodyAccJerkMag-mean()-avg()
- tBodyGyroMag-mean()-avg()
- tBodyGyroJerkMag-mean()-avg()
- fBodyAcc-mean()-X-avg()
- fBodyAcc-mean()-Y-avg()
- fBodyAcc-mean()-Z-avg()
- fBodyAcc-meanFreq()-X-avg()
- fBodyAcc-meanFreq()-Y-avg()
- fBodyAcc-meanFreq()-Z-avg()
- fBodyAccJerk-mean()-X-avg()
- fBodyAccJerk-mean()-Y-avg()
- fBodyAccJerk-mean()-Z-avg()
- fBodyAccJerk-meanFreq()-X-avg()
- fBodyAccJerk-meanFreq()-Y-avg()
- fBodyAccJerk-meanFreq()-Z-avg()
- fBodyGyro-mean()-X-avg()
- fBodyGyro-mean()-Y-avg()
- fBodyGyro-mean()-Z-avg()
- fBodyGyro-meanFreq()-X-avg()
- fBodyGyro-meanFreq()-Y-avg()
- fBodyGyro-meanFreq()-Z-avg()
- fBodyAccMag-mean()-avg()
- fBodyAccMag-meanFreq()-avg()
- fBodyBodyAccJerkMag-mean()-avg()
- fBodyBodyAccJerkMag-meanFreq()-avg()
- fBodyBodyGyroMag-mean()-avg()
- fBodyBodyGyroMag-meanFreq()-avg()
- fBodyBodyGyroJerkMag-mean()-avg()
- fBodyBodyGyroJerkMag-meanFreq()-avg()
- tBodyAcc-std()-X-avg()
- tBodyAcc-std()-Y-avg()
- tBodyAcc-std()-Z-avg()
- tGravityAcc-std()-X-avg()
- tGravityAcc-std()-Y-avg()
- tGravityAcc-std()-Z-avg()
- tBodyAccJerk-std()-X-avg()
- tBodyAccJerk-std()-Y-avg()
- tBodyAccJerk-std()-Z-avg()
- tBodyGyro-std()-X-avg()
- tBodyGyro-std()-Y-avg()
- tBodyGyro-std()-Z-avg()
- tBodyGyroJerk-std()-X-avg()
- tBodyGyroJerk-std()-Y-avg()
- tBodyGyroJerk-std()-Z-avg()
- tBodyAccMag-std()-avg()
- tGravityAccMag-std()-avg()
- tBodyAccJerkMag-std()-avg()
- tBodyGyroMag-std()-avg()
- tBodyGyroJerkMag-std()-avg()
- fBodyAcc-std()-X-avg()
- fBodyAcc-std()-Y-avg()
- fBodyAcc-std()-Z-avg()
- fBodyAccJerk-std()-X-avg()
- fBodyAccJerk-std()-Y-avg()
- fBodyAccJerk-std()-Z-avg()
- fBodyGyro-std()-X-avg()
- fBodyGyro-std()-Y-avg()
- fBodyGyro-std()-Z-avg()
- fBodyAccMag-std()-avg()
- fBodyBodyAccJerkMag-std()-avg()
- fBodyBodyGyroMag-std()-avg()
- fBodyBodyGyroJerkMag-std()-avg()

### From the downloaded data set (features_info,txt):

		Feature Selection 
		=================

		The features selected for this database come from the accelerometer and 
		gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain 
		signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then 
		they were filtered using a median filter and a 3rd order low pass Butterworth 
		filter with a corner frequency of 20 Hz to remove noise. Similarly, the 
		acceleration signal was then separated into body and gravity acceleration 
		signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth 
		filter with a corner frequency of 0.3 Hz. 

		Subsequently, the body linear acceleration and angular velocity were derived in 
		time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the 
		magnitude of these three-dimensional signals were calculated using the 
		Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, 
		tBodyGyroMag, tBodyGyroJerkMag). 

		Finally a Fast Fourier Transform (FFT) was applied to some of these signals 
		producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, 
		fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain 
		signals). 

		These signals were used to estimate variables of the feature vector for each 
		pattern:  
		'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

		tBodyAcc-XYZ
		tGravityAcc-XYZ
		tBodyAccJerk-XYZ
		tBodyGyro-XYZ
		tBodyGyroJerk-XYZ
		tBodyAccMag
		tGravityAccMag
		tBodyAccJerkMag
		tBodyGyroMag
		tBodyGyroJerkMag
		fBodyAcc-XYZ
		fBodyAccJerk-XYZ
		fBodyGyro-XYZ
		fBodyAccMag
		fBodyAccJerkMag
		fBodyGyroMag
		fBodyGyroJerkMag
		
		The set of variables that were estimated from these signals are: 

		mean(): Mean value
		std(): Standard deviation
		mad(): Median absolute deviation 
		max(): Largest value in array
		min(): Smallest value in array
		sma(): Signal magnitude area
		energy(): Energy measure. Sum of the squares divided by the number of values. 
		iqr(): Interquartile range 
		entropy(): Signal entropy
		arCoeff(): Autorregresion coefficients with Burg order equal to 4
		correlation(): correlation coefficient between two signals
		maxInds(): index of the frequency component with largest magnitude
		meanFreq(): Weighted average of the frequency components to obtain a mean
		frequency
		skewness(): skewness of the frequency domain signal 
		kurtosis(): kurtosis of the frequency domain signal 
		bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of 
		each winow.
		angle(): Angle between to vectors.

		Additional vectors obtained by averaging the signals in a signal window sample. 
		These are used on the angle() variable:

		gravityMean
		tBodyAccMean
		tBodyAccJerkMean
		tBodyGyroMean
		tBodyGyroJerkMean
	
		The complete list of variables of each feature vector is available in 'features.txt'




