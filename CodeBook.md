# Code Book

1) At first, the script checks whether the dataset folder (UCI HAR Dataset) is in the current working directory or not. If the dataset folder is not available, it will download from the UCI URL and unzip the file under the UCI HAR Dataset folder. The code snippet is pasted below:

``` code
## code snippet to download and unzip file if it is not downloaded and unzipped
if (!file.exists("UCI HAR Dataset")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile="UCIDataset.zip", method = "curl")
    unzip(zipfile="UCIDataset.zip")
}
```

2) It will read text files from test and train folders inside the dataset folder. The files are X_test.txt, y_test.txt, subject_test.xt from the test folder, and the files are X_train.txt, y_train.txt, subject_train.xt from the train folder. The read.table function is used to read the text files.  The code snippet is shown below:

``` code
## Reading Test files
x_test <- read.table(file="test/X_test.txt")
y_test <- read.table(file="test/y_test.txt")
subject_test <- read.table(file="test/subject_test.txt")

## Reading Training files
x_train <- read.table(file="train/X_train.txt")
y_train <- read.table(file="train/y_train.txt")
subject_train <- read.table(file="train/subject_train.txt")
``` 

3) Combine columns of y_test and subject_test and assign column names "Activity_ID" and "Subject".  Do the same y_train and subject_train. 

``` code
## binding columns y_test and subject_test
test_temp <- cbind(y_test, subject_test) 
colnames(test_temp) <- c("Activity_ID","Subject")

## binding columns y_train and subject_train
train_temp <- cbind(y_train, subject_train) 
colnames(train_temp) <- c("Activity_ID","Subject")
```

4) Merge training and testdatasets using rbind method. 
``` code
## Merge training and test datasets
activity_subject <- rbind(train_temp,test_temp)
x_variables <- rbind(x_train, x_test)
```

5) Read feature.txt file to get feature names and assign to x_variables
``` code
## reading features.txt to get feature names and assigning to x_variables
featurenames <- read.table(file="features.txt", stringsAsFactors=FALSE)
colnames(x_variables) <- featurenames[,2]
```

6) Identify mean and std columns and only use those columns.  Merge raw dataset (x_variables) with activity_subject.
```code
## identifying column names that are associated with mean 
meanColnames <- featurenames[grep("mean()", featurenames[,2], fixed=TRUE),2]

## identifying column names that are associated with std
stdColnames <- featurenames[grep("std()", featurenames[,2], fixed=TRUE),2]

## Extracting columns associated with mean and std 
x_variables <- x_variables[,c(meanColnames, stdColnames)]

## merging x_variables with activity_subject 
dataset <- cbind(x_variables, activity_subject)
```

7) Read activity_labels.txt and assign colnames to the activity_label variable
```code
## reading activity_labels.txt
activity_labels <- read.table(file="activity_labels.txt")
colnames(activity_labels) <- c("Activity_ID", "Activity_Label")
```

8)  Average of each variable for each activity and each subject. This is done using split function and sapply.  One has to tranform the matrix using t command.
```code
#split based on activity subject and ID
split_Act_Subject <- split(dataset, list(dataset$Activity_ID, dataset$Subject))
avg_dataset <- t(sapply(split_Act_Subject, colMeans))
```

9) Appropriately labels the data set with descriptive activity names. 
```code
## Assigning labels to activity id and removing activity id column with null assignment
finalData <- merge(avg_dataset, activity_labels, by.x="Activity_ID", by.y="Activity_ID")
finalData$Activity_ID <- NULL
```

10) Write the final tidy output to a CSV file using write.table command
```code
## writing the final output to csv file
write.table(finalData, file="finaloutput.txt", col.names=TRUE, row.names=FALSE, sep=",")
```



