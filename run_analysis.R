#1 Merges the training and the test sets to create one data set
##Upload test files and cbind them together
test1= read.table("C:/Users/Fadhila/Desktop/Coursera/Data Science/Getting and cleaning data/Project/UCI HAR Dataset/test/X_test.txt")
test2= read.table("C:/Users/Fadhila/Desktop/Coursera/Data Science/Getting and cleaning data/Project/UCI HAR Dataset/test/y_test.txt")
test3= read.table("C:/Users/Fadhila/Desktop/Coursera/Data Science/Getting and cleaning data/Project/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test1, test2,test3)

##Upload train files and cbind them together
train1= read.table("C:/Users/Fadhila/Desktop/Coursera/Data Science/Getting and cleaning data/Project/UCI HAR Dataset/train/X_train.txt")
train2= read.table("C:/Users/Fadhila/Desktop/Coursera/Data Science/Getting and cleaning data/Project/UCI HAR Dataset/train/y_train.txt")
train3= read.table("C:/Users/Fadhila/Desktop/Coursera/Data Science/Getting and cleaning data/Project/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train1, train2, train3)

## rbind the two files created of train and test into one data set
data <- rbind(test, train)
head(data)                #review the data set
#########
#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
library(dplyr)          ##download the dplyr package
library(stringr)        ##download the stringr package
library(data.table)     ##download the data.table package
features= read.table("C:/Users/Fadhila/Desktop/Coursera/Data Science/Getting and cleaning data/Project/UCI HAR Dataset/features.txt")
mydata <- data[,1:562]          ##remove the duplicate column of activity labels 
fnames <- features %>% filter(str_detect(features$V2, "mean|std"))      ##subset to find names required
##subset to extract the mean and standard deviation measurments 
newdata <- mydata[,c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,
          201,202,214,215,227,228,240,241,253,253,266,267,268,269,270,271,294,295,296,346,346,347,348,349,
          350,373,374,375,424,425,426,427,428,429,452,453,454,503,504,513,516,517,526,529,530,539,543,552,562)]
#############
#3 Uses descriptive activity names to name the activities in the data set
## get the activity_label file and name the activities 
activity_labels= read.table("C:/Users/Fadhila/Desktop/Coursera/Data Science/Getting and cleaning data/Project/UCI HAR Dataset/activity_labels.txt")
by_activity<-  activity_labels$V2[newdata$V1.1]  ##match data set with activity label descriptions
newdata$V1.1 <- NULL                             ##remove unwanted extra columns
data_activity  <- mutate(newdata, by_activity)   ##add column of the activity_label into data set after removing the numbers associated with each description  

head(data_activity)
#########
#4 Appropriately labels the data set with descriptive variable names
## Replace the current defalut column names with new names in the features file
colnames(data_activity)= fnames$V2               

names(data_activity)[79] <- "Activity"       ##rename activity column 
#######
#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
actgroup <- group_by(data_activity, Activity)               ## group data set by activity
tiddata <- actgroup[ , !duplicated(colnames(actgroup))]     ## remove duplicats in the data set

tidydata <- tiddata %>% summarise_each(funs(mean))          ## get the mean for each meanurement based on activity type, each will have six averages for the six activity type
Step5 <- write.table(tidydata,"run_analysis.txt", row.names = FALSE)    ##save it as a .txt file
