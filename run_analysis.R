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
colnames(test_temp) <- c("Acitivity","Subject")

## binding columns y_train and subject_train
train_temp <- cbind(y_train, subject_train) 
colnames(train_temp) <- c("Acitivity","Subject")