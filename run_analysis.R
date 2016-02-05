# R script (run_analysis.R) that does the following
## Getting the data
setwd("C:/Users/vlasenko/YandexDisk/R_Programming/GettingData-CourseProj/")
setwd(choose.dir(default=getwd(),caption="Set working directory"))
WorkingDir <- getwd()
print(c("You can find data and results in ",WorkingDir))
UrlZip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
F_Name0 <- "getdata_projectfiles_UCI HAR Dataset"
DirName1 <- "UCI HAR Dataset"
ResultsDir <- ".."   #/Getting-and-Cleaning-Data" #### Saving results above the DirName


###  Downloading/unziping
if( !(F_Name0 %in% dir())){ download.file(UrlZip,F_Name0) }
if( !(DirName1 %in% dir()) ){ unzip(F_Name0) }
setwd(DirName1)


###  Addresses of the data Files
F_FeaturesInfo <- "features_info.txt"   #### Shows information about the variables used on the feature vector.
F_Features <- "features.txt"           #### List of all features.
F_ActivityLabels <- "activity_labels.txt" #### Links the class labels with their activity name.

F_TrainingSet <- "train/X_train.txt"       #### Training set.
F_TrainingLabels <- "train/y_train.txt"       #### Training labels.
F_TestSet <- "test/X_test.txt"         #### Test set.
F_TestLabels <- "test/y_test.txt"         #### Test labels.

F_11 <- "train/subject_train.txt"  ####  Each row identifies the subject who performed the activity for 
####  each window sample. Its range is from 1 to 30.
F_21 <- "test/subject_test.txt"  #### Each row identifies the subject who performed the activity for 
#### each window sample. Its range is from 1 to 30.

F_12 <- "train/Inertial Signals/total_acc_x_train.txt"  #### The acceleration signal from the smartphone 
#### accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same 
#### description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' Files for the Y and Z axis.
F_13 <- "train/Inertial Signals/body_acc_x_train.txt"  #### The body acceleration signal obtained by 
#### subtracting the gravity from the total acceleration.
F_14 <- "train/Inertial Signals/body_gyro_x_train.txt"  #### The angular velocity vector measured by  
#### the gyroscope for each window sample. The units are radians/second.
F_22 <- "test/Inertial Signals/total_acc_x_test.txt"  #### The acceleration signal from the smartphone 
#### accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same 
#### description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' Files for the Y and Z axis.
F_23 <- "test/Inertial Signals/body_acc_x_test.txt"  #### The body acceleration signal obtained by 
#### subtracting the gravity from the total acceleration.
F_24 <- "test/Inertial Signals/body_gyro_x_test.txt"  #### The angular velocity vector measured by 
#### the gyroscope for each window sample. The units are radians/second.


### Reading tables
TrainingSet <- read.table(F_TrainingSet)
TestSet <- read.table(F_TestSet)
Set <- rbind(TrainingSet,TestSet)

TrainingLabels <- read.table(F_TrainingLabels)
TestLabels <- read.table(F_TestLabels)
Labels <- rbind(TrainingLabels,TestLabels)

TrainingSubjects <- read.table(F_11)
TestSubjects <- read.table(F_21)
Subjects <- rbind(TrainingSubjects,TestSubjects)

Features <- read.table(F_Features)
Features$V2 <- as.character(Features$V2)

ActivityLabels <- read.table(F_ActivityLabels)
ActivityLabels$V2 <- as.character(ActivityLabels$V2)


library(plyr)
## Appropriately labels the data set with descriptive variable names.
names(TrainingSet) <- arrange(Features,V1)[,2]
names(TestSet) <- arrange(Features,V1)[,2]


## Uses descriptive activity names to name the activities in the data set

TrainingLabels <- merge(TrainingLabels,ActivityLabels)
TestLabels <- merge(TestLabels,ActivityLabels)

b_Dim <- (dim(TrainingSet)[1]==dim(TrainingLabels)[1])&(dim(TestSet)[1]==dim(TestLabels)[1])

if (!b_Dim) {print("Dimensions of Set and Labels aren't equal!")}

T1 <- mutate(TrainingSet,ActivityType=TrainingLabels$V2,TypeOfSet="Train")
T2 <- mutate(TestSet,ActivityType=TestLabels$V2,TypeOfSet="Test")

dim(T1)
dim(T2)

b_AllTrue <- all(table(T1$ActivityType == TrainingLabels$V2)) & all(table(T2$ActivityType == TestLabels$V2)) & 
all(table(T1[,1:561] == TrainingSet)) & all(table(T2[,1:561] == TestSet)) & all(table(names(T1)==names(T2)))

if(!b_AllTrue){print("ERROR!!!")}else{print("Ok. T1&T1 could be rbind")}


## Merges the training and the test sets to create one data set.
DataTbl <- rbind(T1,T2)


## Extracts only the measurements on the mean and standard deviation for 
## each measurement.

NumVars <- unique(c(grep("-mean()",names(DataTbl)),grep("-std()",names(DataTbl)),562,563))
DataTbl_Cut <- DataTbl[,NumVars]


## From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

Activities <- rbind(TrainingLabels,TestLabels)
Activities <- Activities[2]
names(Activities) <- "Activity"

Subjects <- rbind(TrainingSubjects,TestSubjects)
names(Subjects) <- "Subject"

dim(Activities)
dim(Subjects)

table(Activities)
table(Subjects)

dim((DataTbl_Cut))[1] == dim(Activities)[1];  dim((DataTbl_Cut))[1] == dim(Subjects)[1]

Dt_0 <- cbind(DataTbl_Cut[1:79], Activities, Subjects)

Dt <- aggregate(Dt_0[1:79], by = list(Dt_0$Activity, Dt_0$Subject) ,mean)

setwd(ResultsDir)
write.table(Dt,"result.txt",row.name=FALSE)
