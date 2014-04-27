## code snippet to download and unzip file if it is not downloaded and unzipped
if (!file.exists("UCI HAR Dataset")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile="UCIDataset.zip", method = "curl")
    unzip(zipfile="UCIDataset.zip")
}

## setting the working directory
setwd("UCI HAR Dataset")

## Reading Test files
x_test <- read.table(file="test/X_test.txt")
y_test <- read.table(file="test/y_test.txt")
subject_test <- read.table(file="test/subject_test.txt")

## Reading Training files
x_train <- read.table(file="train/X_train.txt")
y_train <- read.table(file="train/y_train.txt")
subject_train <- read.table(file="train/subject_train.txt")

## binding columns y_test and subject_test
test_temp <- cbind(y_test, subject_test) 
colnames(test_temp) <- c("Activity_ID","Subject")

## binding columns y_train and subject_train
train_temp <- cbind(y_train, subject_train) 
colnames(train_temp) <- c("Activity_ID","Subject")

activity_subject <- rbind(train_temp,test_temp)
x_variables <- rbind(x_train, x_test)

## removing unnecessary variables to conserve memory
rm(list=c("y_test","subject_test","y_train","subject_train", "train_temp","test_temp", "x_test", "x_train"))

## reading features.txt to get feature names and assigning to x_variables
featurenames <- read.table(file="features.txt", stringsAsFactors=FALSE)
colnames(x_variables) <- featurenames[,2]

## identifying column names that are associated with mean 
meanColnames <- featurenames[grep("mean()", featurenames[,2], fixed=TRUE),2]

## identifying column names that are associated with std
stdColnames <- featurenames[grep("std()", featurenames[,2], fixed=TRUE),2]

## Extracting columns associated with mean and std 
x_variables <- x_variables[,c(meanColnames, stdColnames)]

## reading activity_labels.txt
activity_labels <- read.table(file="activity_labels.txt")
colnames(activity_labels) <- c("Activity_ID", "Activity_Label")
temp <- merge(activity_subject, activity_labels, by.x="Activity_ID", by.y="Activity_ID")


