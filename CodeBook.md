# Description of the R script.
The R script called run_analysis.R does the following.

    0. Dowloading and unziping the files (if they doesn't exist in working directory)
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names.
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Extracted Data content (step 5)
In our dataset there are variables which were got as means of original dataset variables (from training and test sets) and new variables which were added from files with labels and subjects.

## The new variables are

 * "Group.1" - text label (chr) of activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
 * "Group.2" - subjects IDs (int) (volunteer, 1:30)

## The following 66 variables are the averages of each variable (from original data set, only the measurements on the mean and standard deviation for each measurement) for each activity and each subject: (original dataset variables are described below)

 * tBodyAcc_mean_X          (num)
 * tBodyAcc_mean_Y          (num)
 * tBodyAcc_mean_Z          (num)
 * tBodyAcc_std_X           (num)
 * tBodyAcc_std_Y           (num)
 * tBodyAcc_std_Z           (num)
 * tGravityAcc_mean_X       (num)
 * tGravityAcc_mean_Y       (num)
 * tGravityAcc_mean_Z       (num)
 * tGravityAcc_std_X        (num)
 * tGravityAcc_std_Y        (num)
 * tGravityAcc_std_Z        (num)
 * tBodyAccJerk_mean_X      (num)
 * tBodyAccJerk_mean_Y      (num)
 * tBodyAccJerk_mean_Z      (num)
 * tBodyAccJerk_std_X       (num)
 * tBodyAccJerk_std_Y       (num)
 * tBodyAccJerk_std_Z       (num)
 * tBodyGyro_mean_X         (num)
 * tBodyGyro_mean_Y         (num)
 * tBodyGyro_mean_Z         (num)
 * tBodyGyro_std_X          (num)
 * tBodyGyro_std_Y          (num)
 * tBodyGyro_std_Z          (num)
 * tBodyGyroJerk_mean_X     (num)
 * tBodyGyroJerk_mean_Y     (num)
 * tBodyGyroJerk_mean_Z     (num)
 * tBodyGyroJerk_std_X      (num)
 * tBodyGyroJerk_std_Y      (num)
 * tBodyGyroJerk_std_Z      (num)
 * tBodyAccMag_mean         (num)
 * tBodyAccMag_std          (num)
 * tGravityAccMag_mean      (num)
 * tGravityAccMag_std       (num)
 * tBodyAccJerkMag_mean     (num)
 * tBodyAccJerkMag_std      (num)
 * tBodyGyroMag_mean        (num)
 * tBodyGyroMag_std         (num)
 * tBodyGyroJerkMag_mean    (num)
 * tBodyGyroJerkMag_std     (num)
 * fBodyAcc_mean_X          (num)
 * fBodyAcc_mean_Y          (num)
 * fBodyAcc_mean_Z          (num)
 * fBodyAcc_std_X           (num)
 * fBodyAcc_std_Y           (num)
 * fBodyAcc_std_Z           (num)
 * fBodyAccJerk_mean_X      (num)
 * fBodyAccJerk_mean_Y      (num)
 * fBodyAccJerk_mean_Z      (num)
 * fBodyAccJerk_std_X       (num)
 * fBodyAccJerk_std_Y       (num)
 * fBodyAccJerk_std_Z       (num)
 * fBodyGyro_mean_X         (num)
 * fBodyGyro_mean_Y         (num)
 * fBodyGyro_mean_Z         (num)
 * fBodyGyro_std_X          (num)
 * fBodyGyro_std_Y          (num)
 * fBodyGyro_std_Z          (num)
 * fBodyAccMag_mean         (num)
 * fBodyAccMag_std          (num)
 * fBodyBodyAccJerkMag_mean (num)
 * fBodyBodyAccJerkMag_std  (num)
 * fBodyBodyGyroMag_mean    (num)
 * fBodyBodyGyroMag_std     (num)
 * fBodyBodyGyroJerkMag_mean(num)
 * fBodyBodyGyroJerkMag_std (num)


#Original Data Description
##Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are (only the first and the second points were used in analysis): 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean
