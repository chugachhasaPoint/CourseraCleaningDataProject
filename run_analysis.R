# Tidy Data Assignment 
# This R script, run_analysis.R, does the following:
# 
# * Merges the training and the test sets to create one data set.
# * Extracts only the measurements on the mean and standard deviation for each measurement.
# * Uses descriptive activity names to name the activities in the data set
# * Appropriately labels the data set with descriptive variable names.
# * From the data set in step 4, creates a second, independent tidy data set with the 
#   average of each variable for each activity and each subject.


# Step 0: Set Dependencies 
library(dplyr)
library(plyr)
 setwd("/Users/sneeno/Documents/DSU Projects/Cleaning Data/Project") 

 
# Step 1: Environment Setup
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
setwd("./data")
download.file(fileUrl,destfile ="./data.zip",method = "curl")
unzip("data.zip",exdir="./")
dateDownloaded <- date()

features <- read.table("./UCI HAR Dataset/features.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")


# Step 2: Verify Records
sum(is.na(subject_train))
sum(is.na(X_test))
sum(is.na(Y_test))
sum(is.na(subject_train))
sum(is.na(X_train))
sum(is.na(Y_train))


# Step 3: Merge Training and Test Data Sets
sensorfulldata<-rbind(X_test,X_train)
tasksfulldata<-rbind(Y_test,Y_train)
subjectfulldata<-rbind(subject_test,subject_train)


# Step 4: Partition out "Mean" and "Std" Variables
meanstdcolumns<-sort(c(grep("*[Mm]ean*",features[,2]),grep("*[Ss]td*",features[,2])))
sensorfulldata<-sensorfulldata[,meanstdcolumns]
dataset<-cbind(tasksfulldata,subjectfulldata,sensorfulldata)

columnnames<-c("activity","subjectid",gsub("()","",tolower(features[meanstdcolumns,2])))
colnames(dataset)<-columnnames


# Step 5: Finalize dataset and datasetsummary
dataset[,1:2]<-lapply(dataset[,1:2],as.factor)
dataset[,1]<-mapvalues(dataset[,1], from = c("1", "2", "3","4","5","6"), to = c("walking", "walkingupstairs","walkingdownstairs","sitting","standing","laying"))

datasetsummary<-aggregate.data.frame(dataset[,3:81],by=list(dataset[,1],dataset[,2]),mean)
write.table(datasetsummary,file="./step5tidydata.txt",row.name=FALSE)