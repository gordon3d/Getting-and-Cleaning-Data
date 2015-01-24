#Course Project

Course Project Analysis was performed in one 'run_analysis.R' file.

'run_analysis.R' consist of six logical parts:

1. Downloading and preparing data.

In this part course project data was downloaded and unzipped.

2. Step 1: Merging training and test sets in one

Here all required data was transferred in R and bound in one variable (AllDataSet)

3. Step 2: Assigning descriptive activity names to name the activities

According to activity_labels.txt activity numbers (1,2,3,4,5,6) were replaced by
descriptive activity names.

4. Step 3: Extracting the measurements on the mean and 
           standard deviation for each measurement

Here by extracting features.txt was created "header" variable, which describes type of measurements. Duplicates in features.txt were avoided by merging number of type of
measurements and name of measurements. It made possible to use "select" function (dplyr package) and extract measurements on the mean and standard deviation.

5. Step 4: Assigning appropriate labels with descriptive variable names

Here by using "write.table" function was created txt file with names of type measurements (described in previous part). After that by using Notepad ++ like were [suggested](https://class.coursera.org/getdata-010/forum/thread?thread_id=49#comment-438) in Discussion Forum  was created names_edited.txt and transferred in R.

6. Step 5: Creating independent tidy data set with the average
           of each variable for each activity and each subject.
           
"ddply" function with "numcolwise" argument made possible extracting
the average of each variable for each activity and each subject

           
Course project includes the following files:

-'ReadMe.md'

-'run_analysis.R': R code for performing analysis

-'codebook.pdf': Discribing the variables

-'names_edited.txt': File that contains appropriate labels for the second data set
