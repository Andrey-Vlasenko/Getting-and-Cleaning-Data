# R script (run_analysis.R) that does the following
## Getting the data
setwd("C:/Users/vlasenko/YandexDisk/R_Programming/GettingData-CourseProj/")
setwd(choose.dir(default=getwd(),caption="Set working directory"))
WorkingDir <- getwd()
print(c("You can find data and results in ",WorkingDir))
UrlZip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
FileName0 <- "getdata_projectfiles_UCI HAR Dataset.zip"
DirName1 <- "UCI HAR Dataset"
ResultsDir <- "../Getting-and-Cleaning-Data"



###  Downloading/unziping (we won't do it twice). Reading of the files
if( !(FileName0 %in% dir())){
   download.file(UrlZip,FileName0)
}
   if( !(DirName1 %in% dir()) ){ unzip(FileName0) }
setwd(DirName1)

VarAdrFtrsInf <- "features_info.txt"  #### Shows information about the variables used on the feature vector.
VarAdrFtrs <- "features.txt"          #### List of all features.
VarAdrActLbl <- "activity_labels.txt" #### Links the class labels with their activity name.

VarAdrTrnSets <- "train/X_train.txt"       #### Training set.
VarAdrTrnLbls <- "train/y_train.txt"       #### Training labels.
VarAdrTstSets <- "test/X_test.txt"         #### Test set.
VarAdrTstLbls <- "test/y_test.txt"         #### Test labels.

VarAdr11 <- "train/subject_train.txt"  ####  Each row identifies the subject who performed the activity for 
####  each window sample. Its range is from 1 to 30.

VarAdr12 <- "train/Inertial Signals/total_acc_x_train.txt"  #### The acceleration signal from the smartphone 
#### accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same 
#### description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

VarAdr13 <- "train/Inertial Signals/body_acc_x_train.txt"  #### The body acceleration signal obtained by 
#### subtracting the gravity from the total acceleration.

VarAdr14 <- "train/Inertial Signals/body_gyro_x_train.txt"  #### The angular velocity vector measured by  
#### the gyroscope for each window sample. The units are radians/second.

VarAdr21 <- "test/subject_train.txt"  #### Each row identifies the subject who performed the activity for 
#### each window sample. Its range is from 1 to 30.

VarAdr22 <- "test/Inertial Signals/total_acc_x_train.txt"  #### The acceleration signal from the smartphone 
#### accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same 
#### description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

VarAdr23 <- "test/Inertial Signals/body_acc_x_train.txt"  #### The body acceleration signal obtained by 
#### subtracting the gravity from the total acceleration.

VarAdr24 <- "test/Inertial Signals/body_gyro_x_train.txt"  #### The angular velocity vector measured by 
#### the gyroscope for each window sample. The units are radians/second.

library(plyr)


TblLbs1 <- read.table(VarAdrTrnLbls)
Tbl1 <- read.table(VarAdrTrnSets)

TblLbs2 <- read.table(VarAdrTstLbls)
Tbl2 <- read.table(VarAdrTstSets)

TblVars <- read.table(VarAdrFtrs)
TblVars$V2 <- as.character(TblVars$V2)

## Merges the training and the test sets to create one data set.
names(Tbl1) <- arrange(TblVars,V1)[,2]
names(Tbl2) <- arrange(TblVars,V1)[,2]

T1 <- mutate(Tbl1,Act=TblLbs1)
T2 <- mutate(Tbl2,Act=TblLbs2)

table(T1$Act == TblLbs1)
table(T2$Act == TblLbs2)
table(T1[,1:561] == Tbl1)
table(T2[,1:561] == Tbl2)


DataTbl <- merge()


## Extracts only the measurements on the mean and standard deviation for 
## each measurement.






## Uses descriptive activity names to name the activities in the data set






## Appropriately labels the data set with descriptive variable names.




## From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.





setwd(ResultsDir)
