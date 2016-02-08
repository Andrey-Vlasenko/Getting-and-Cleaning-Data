# R script (run_analysis.R) that does the following
## Getting the data
rm(list=ls())
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
F_FeaturesInfo <- "features_info.txt"       #### Shows information about the variables used on the feature vector.
F_Features <- "features.txt"                #### List of all features.
F_ActivityLabels <- "activity_labels.txt"   #### Links the class labels with their activity name.

F_TrainingSet <- "train/X_train.txt"             #### Training set.
F_TrainingLabels <- "train/y_train.txt"          #### Training labels.
F_TestSet <- "test/X_test.txt"                   #### Test set.
F_TestLabels <- "test/y_test.txt"                #### Test labels.
F_TrainingSubjects <- "train/subject_train.txt"  ####  Each row identifies the subject who performed the activity 
####  for each window sample. Its range is from 1 to 30.
F_TestSubjects <- "test/subject_test.txt"  #### Each row identifies the subject who performed the activity for 
#### each window sample. Its range is from 1 to 30.

### I suppose we don't need these files, but I left them
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
library(plyr)
Features <- read.table(F_Features)
Features$V2 <- as.character(Features$V2)
VariableNames <- arrange(Features,V1)
ActivityLabels <- read.table(F_ActivityLabels)
ActivityLabels$V2 <- as.character(ActivityLabels$V2)


## 1.Merges the training and the test sets to create one data set.
TrainingSet <- read.table(F_TrainingSet)
TestSet <- read.table(F_TestSet)
Set <- rbind(TrainingSet,TestSet)


## 2.Extracts only the measurements on the mean and standard deviation for each measurement.
### Finding only exactly "-mean()" and "-std()" not get "-meanFreq()"
NumVars <- sort(unique(c(grep("-mean()",VariableNames[,2],fixed=TRUE),grep("-std()",VariableNames[,2],fixed=TRUE))))
length(NumVars)
Set_Extracted <- Set[,NumVars]


## 3.Uses descriptive activity names to name the activities in the data set
TrainingLabels <- read.table(F_TrainingLabels)
TestLabels <- read.table(F_TestLabels)
Labels <- arrange(merge(mutate(rbind(TrainingLabels,TestLabels),nRow=1:(nrow(TrainingLabels)+nrow(TestLabels))),
                  ActivityLabels),nRow)[3]
#### 'merge(rbind(TrainingLabels,TestLabels), ActivityLabels)[2]' changes the order of mesurements (it's wrong).
names(Labels) <- "ActivityLabels"
Set_Extracted <- cbind(Set_Extracted, Labels)


## 4.Appropriately labels the data set with descriptive variable names.
VariableNames <- mutate(VariableNames, VarName = gsub("[^a-zA-Z0-9]+", '_', V2))
VariableNames$VarName <- gsub("^[_]+|[_]+$", '', VariableNames$VarName)
names(Set_Extracted) <- c(VariableNames[NumVars,3],"ActivityLabels")


## 5.From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
TrainingSubjects <- read.table(F_TrainingSubjects)
TestSubjects <- read.table(F_TestSubjects)
Subjects <- rbind(TrainingSubjects,TestSubjects)
names(Subjects) <- "Subjects"
Dt_0 <- cbind(Set_Extracted,Subjects)
n <- dim(Dt_0)[2]
Dt <- aggregate(Dt_0[1:(n-2)], by = list(Dt_0$ActivityLabels, Dt_0$Subjects) ,mean)

setwd(ResultsDir)
write.table(Dt,"result.txt",row.name=FALSE)

b_Dim <- (dim(TrainingSet)[1]==dim(TrainingLabels)[1])&(dim(TestSet)[1]==dim(TestLabels)[1])&
         (dim(TrainingSet)[1]==dim(TrainingSubjects)[1])&(dim(TestSet)[1]==dim(TestSubjects)[1])
if(!b_Dim) {
	warning("Error! Inequal dimensions!")
} else {
	print("All seems ok.")
	Dir <- getwd()
	print(c("You can find result.txt in ",Dir))
}


## 6.What we have in 5.
dim(Dt)
NumOfRowsInDt <- sum( table( cbind(rbind(TrainingLabels,TestLabels),rbind(TrainingSubjects,TestSubjects))) >0)
NumOfRowsInDt
NumOfRowsInDt == dim(Dt)[1]
Names <- names(Dt)
str(Dt, comp.str = "* ", vec.len = 0)
