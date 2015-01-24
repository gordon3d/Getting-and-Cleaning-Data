
#Download and prepare data
#NOTE: If you downloaded course project zip file in your working
#directory and extracted files in UCI HAR Dataset dir,
#this part may be skipped
====================================================================
 url<-https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 download.file("url","project.zip",mode="wb")
 unzip("project.zip")
#Check extraced files
 list.files("./UCI HAR Dataset")
====================================================================


#Step 1. Merge training and test sets, create one data set
#===================================================================
#Transfer test data files into R:
 subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
 X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
 y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
#Merge all test data:
 AllTestData<-cbind(subject_test,y_test,X_test)

#Transfer test data files into R
 subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
 X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
 y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")

 AllTrainData<-cbind(subject_train,y_train,X_train)

 if dim(AllTestData)[2]==dim(AllTrainData)[2]
    AllDataSet<-rbind(AllTrainData,AllTestData)
#====================================================================


#Step 2. Assign descriptive activity names to name the activities in
#        the data set
#====================================================================
 AllDataSet$activity<-factor(AllDataSet$activity,
                             labels=c("walking","walkingupstairs",
                                     "walkingdownstairs","sitting",
                                     "standing","laying"))

#====================================================================

  
#Step 3.Extract only the measurements on the mean and
#       standard deviation for each measurement
#=====================================================================
#Create temprorary "header" vector for AllDataSet from feature.txt
 features<-read.table("./UCI HAR Dataset/features.txt")
 features_comb<-paste(as.character(features[,1]),
                     as.character(features[,2]))
#In Step 1 before main data set were cbinded
#subject and activity data, so "header" vecor must contain that names
 header<-c("subject","activity",features_comb)
 names(AllDataSet)<-header

 library(plyr)
 library(dplyr)
#Create meas_mean data frame that contains the measurements
#on the mean observations for each subject and activity
 meas_mean<-cbind(select(AllDataSet,(subject:activity)),
                 select(AllDataSet,contains("mean")))
#Check column names of extracted data
 names(meas_mean)
#There are some additional columns (angle), so cut them
 meas_mean<-select(meas_mean,-(49:55))
#Create meas_std data frame that contains the measurements
#on the std observations for each subject and activity
 meas_std<-select(AllDataSet,contains("std"))
#Check column names of extracted data
 names(meas_std)
#Everything is ok

#Check dimensions and marge meas_mean and meas_std in one data set
 if dim(meas_mean)[1]==dim(meas_std)[1] 
    Mean_Std<-cbind(meas_mean,meas_std)
======================================================================


#Step 4. Assign appropriate labels with descriptive variable names
======================================================================
#Write txt file with current header (It's not necessary for marker,
#so it's commented)
# write.table(names(Mean_Std),"Mean_Std.txt")

#names_edited.txt was created in Notepad++ by editing Mean_Std.txt
 names_edited<-read.table("names_edited.txt")
 names(Mean_Std)<-names_edited[,1]
======================================================================


#Step 5. Create second, independent tidy data set with the average
#        of each variable for each activity and each subject.
#=====================================================================
 SecondDataSet<-ddply(Mean_Std, .(subject,activity),numcolwise(mean))
 write.table(SecondDataSet,"SecondDataSet.txt",row.name=FALSE )
======================================================================