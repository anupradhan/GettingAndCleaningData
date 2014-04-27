# README


There is only one script file run_anaysis.R.  Please make sure that you put your script file in your working directory.  You can set your working directory by using setwd(work_directory) command.

1) At first, it checks whether the dataset folder (UCI HAR Dataset) is in the current working directory or not. If the dataset folder is not available, it will download from the UCI URL and unzip the file under the UCI HAR Dataset folder.

2) It will read text files from test and train folders inside the dataset folder. The files are X_test.txt, y_test.txt, subject_test.xt from the test folder, and the files are X_train.txt, y_train.txt, subject_train.xt from the train folder.

3) 
