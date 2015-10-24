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
library(dplyr)                  ##download the dplyr package
mydata <- data[,1:562]          ##remove the duplicate column of activity labels 

mean_sd <- mydata %>%           ##extract the mean and standar deviation of each measurement 
        summarise_each(funs(mean, sd), matches("V")) %>%
        as.data.frame 
#############
#3 Uses descriptive activity names to name the activities in the data set
## get the activity_label file and name the activities 
activity_labels= read.table("C:/Users/Fadhila/Desktop/Coursera/Data Science/Getting and cleaning data/Project/UCI HAR Dataset/activity_labels.txt")
by_activity<-  activity_labels$V2[mydata$V1.1]  ##match data set with activity label descriptions
mydata$V1.1 <- NULL                         
data_activity  <- mutate(mydata, by_activity)   ##add column of the activity_label into data set after removing the numbers associated with each description  

head(data_activity)
#########
#4 Appropriately labels the data set with descriptive variable names
## get the features and replace the current defalut column names with new names in the features file
library(data.table)
features= read.table("C:/Users/Fadhila/Desktop/Coursera/Data Science/Getting and cleaning data/Project/UCI HAR Dataset/features.txt")

colnames(data_activity)= features$V2
names(data_activity)[562] <- "Activity"       ##rename activity column 
#######
#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
actgroup <- group_by(data_activity, Activity)               ## group data set by activity
tiddata <- actgroup[ , !duplicated(colnames(actgroup))]     ## remove duplicats in the data set

tidydata <- tiddata %>% summarise_each(funs(mean))          ## get the mean for each meanurement based on activity type, each will have six averages for the six activity type
Step5 <- write.table(tidydata,"run_analysis.txt", row.names = FALSE)    ##save it as a .txt file
