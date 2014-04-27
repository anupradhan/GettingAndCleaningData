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

3) 
