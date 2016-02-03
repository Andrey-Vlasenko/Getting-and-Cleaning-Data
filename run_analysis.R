# R script (run_analysis.R) that does the following
## Getting the data
setwd("C:/Users/vlasenko/YandexDisk/R_Programming/GettingData-CourseProj/")
setwd(choose.dir(default=getwd(),caption="Set working directory"))
WorkingDir <- getwd()
print(c("You can find data and results in ",WorkingDir))
UrlZip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
FileName0 <- "getdata_projectfiles_UCI HAR Dataset.zip"
DirName1 <- "UCI HAR Dataset"


###  Downloading/unziping (we won't do it twice). Reading of the files
if( !(FileName0 %in% dir())){
   download.file(UrlZip,FileName0)
}
   if( !(DirName1 %in% dir()) ){ unzip(FileName0) }
setwd(DirName1)

## Merges the training and the test sets to create one data set.




## Extracts only the measurements on the mean and standard deviation for 
## each measurement.




## Uses descriptive activity names to name the activities in the data set




## Appropriately labels the data set with descriptive variable names.




## From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.





setwd("../Getting-and-Cleaning-Data")
