# README
Valeriy V. Artukhin  
Friday, August 15, 2014  

(code fragments are not evaluated here - there is script file for that, information about resulting tidy data is in the *codebook.md*)

According to the task, script works as follows:

1. Setting working path (you don't need to execute steps 1, 2 and 3 if script is in the same 
directory as extracted zip file and working directory is set accordingly).

```r
#setwd("C:/Work/Samsung2")
```

2. Zip archive with raw data downloaded from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>.

```r
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="Dataset.zip")
```

3. Zip archive unpacked.

```r
#unzip("Dataset.zip")
```

4. Train and test sets measurements data are read from the *X_train.txt* and 
*X_test.txt* files to the data frames.

```r
trainSet <- read.csv("UCI HAR Dataset/train/X_train.txt",sep="",header=FALSE)
testSet <- read.csv("UCI HAR Dataset/test/X_test.txt",sep="",header=FALSE)
```

5. Column names are read from *features.txt* into data frame. Train and test data 
frames column names are changing.

```r
features <- read.csv("UCI HAR Dataset/features.txt",sep="",header=FALSE)
names(trainSet)<-features[,2]
names(testSet)<-features[,2]
```

6. Activity codes are read from *y_train.txt* and *y_test.txt* files. New columns
**ActivityCode** with corresponding values are created in train and test data frames.

```r
trainLabels <- read.csv("UCI HAR Dataset/train/y_train.txt",sep="",header=FALSE)
trainSet$ActivityCode<-trainLabels[,1]
testLabels <- read.csv("UCI HAR Dataset/test/y_test.txt",sep="",header=FALSE)
testSet$ActivityCode<-testLabels[,1]
```

7. Subject codes are read from *subject_train.txt* and *subject_test.txt* files. New columns
**SubjectCode** with corresponding values are created in train and test data frames.

```r
trainSubjects <- read.csv("UCI HAR Dataset/train/subject_train.txt",sep="",header=FALSE)
trainSet$SubjectCode<-trainSubjects[,1]
testSubjects <- read.csv("UCI HAR Dataset/test/subject_test.txt",sep="",header=FALSE)
testSet$SubjectCode<-testSubjects[,1]
```

8. Reading table with activity codes and names from *activity_labels.txt*. Merging train and test datasets with that table by **ActivityCode** to get new columns **ActivityName** with corresponding activity descriptive name.

```r
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt",sep="",header=FALSE)
names(activityLabels)<-c("ActivityCode","ActivityName")

trainSetLabeled<-merge(trainSet,activityLabels,by.x="ActivityCode",by.y="ActivityCode",sort=FALSE)
testSetLabeled<-merge(testSet,activityLabels,by.x="ActivityCode",by.y="ActivityCode",sort=FALSE)
```

9. Concatenating train and test data frames.

```r
combinedSet<-rbind(trainSetLabeled,testSetLabeled)
```

10.Searching for indexes of columns whose labels contain "mean()" or "std()" and also columns created by us previously. Need extra care: if we simply use "mean()" in pattern, we will also include columns like **meanFreq()** whose are not needed.

```r
dfNames=names(combinedSet)
indicesOfInterest=grep("SubjectCode|ActivityName|std()|mean\\(\\)",dfNames)
```

11. Extracting all rows of combined data frame and only columns of interest.

```r
strippedSet<-combinedSet[,indicesOfInterest]
```

12. Creating tidy data frame by aggregating stripped data frame on activities and subjects. Two last columns (67 and 68) are **ActivityName** and **SubjectCode**, we don't need mean on those.

```r
tidyData<-aggregate(strippedSet[,1:66], list(Activity = strippedSet$ActivityName, Subject = strippedSet$SubjectCode), mean)
```

13. Saving tidy data and checking if its readable correctly.

```r
write.table(tidyData,"tidyData.txt",row.names=FALSE)
#tidyDataCheck <- read.csv("tidyData.txt",sep="")
```
