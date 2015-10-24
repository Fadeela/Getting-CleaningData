# Getting-CleaningData
Getting and Cleaning Data - Course Project 
In order to run this script do the following steps:
1. download the data into your working directory from this link, unzip the file;    
  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
 if you would like a full description of how the datawas collected you can find it here
  "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"

2. upload the below files into R (each separtly): y_test, X_test, subject_test
                                                  y_train, X_train, subject_train
3. create two data sets combing test data together and train togather. than merge the two to create one data set
4. extract the mean and standard deviation of each variable - you can use dplyr package "summarise_each" function
5. Name the activities in the data sets using descrptive information given in activity_label .txt file,
  add activity column to name each activity by row in your data set
6. Rename the columns with its asscoiated descriptions given in the feature.txt file
7. Group the data set by activity, than calculate the average of each variable for each activity and each subject
    you may require to remove any duplicates in the data set  
