#Setting working path
#setwd("C:/Work/Samsung2")

#Downloading file
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
#              destfile="Dataset.zip")

#Extracting files from archive
#unzip("Dataset.zip")

#Reading in two data frames
trainSet <- read.csv("UCI HAR Dataset/train/X_train.txt",sep="",header=FALSE)
testSet <- read.csv("UCI HAR Dataset/test/X_test.txt",sep="",header=FALSE)

#Labeling columns of both data frames
features <- read.csv("UCI HAR Dataset/features.txt",sep="",header=FALSE)
names(trainSet)<-features[,2]
names(testSet)<-features[,2]

#Reading activity codes for both data frames and creating corresponding columns
trainLabels <- read.csv("UCI HAR Dataset/train/y_train.txt",sep="",header=FALSE)
trainSet$ActivityCode<-trainLabels[,1]
testLabels <- read.csv("UCI HAR Dataset/test/y_test.txt",sep="",header=FALSE)
testSet$ActivityCode<-testLabels[,1]

#Reading subject codes for both data frames and creating corresponding columns
trainSubjects <- read.csv("UCI HAR Dataset/train/subject_train.txt",sep="",header=FALSE)
trainSet$SubjectCode<-trainSubjects[,1]
testSubjects <- read.csv("UCI HAR Dataset/test/subject_test.txt",sep="",header=FALSE)
testSet$SubjectCode<-testSubjects[,1]

#Reading table with activity codes and names
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt",sep="",header=FALSE)
names(activityLabels)<-c("ActivityCode","ActivityName")

#Merging train and test data frames with activity names data frame on activity code column
trainSetLabeled<-merge(trainSet,activityLabels,by.x="ActivityCode",by.y="ActivityCode",sort=FALSE)
testSetLabeled<-merge(testSet,activityLabels,by.x="ActivityCode",by.y="ActivityCode",sort=FALSE)

#Combining train and test data frames
combinedSet<-rbind(trainSetLabeled,testSetLabeled)

#Searching for column indexes with "mean()", "std()" and also columns
#created by us previously
dfNames=names(combinedSet)
indicesOfInterest=grep("SubjectCode|ActivityName|std()|mean\\(\\)",dfNames)

#Extracting all rows and only columns of interest
strippedSet<-combinedSet[,indicesOfInterest]

#Creating tidy data frame by aggregating stripped data frame on activities and subjects
tidyData<-aggregate(strippedSet[,1:66], list(Activity = strippedSet$ActivityName,
                                             Subject = strippedSet$SubjectCode), mean)

#Saving tidy data to txt
write.table(tidyData,"tidyData.txt",row.names=FALSE)

#Tidy data loading check
#tidyDataCheck <- read.csv("tidyData.txt",sep="")
