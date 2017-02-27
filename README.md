# Getting and Cleaning Data Course Project

### Description 
This script cleaned a data set in order prepare tidy data.

### Usage

library: data.table, reshape2, dplyr

dwonload run_analysis.R and source(run_analysis.R)

the chek if the file "UCI HAR Dataset" exist 
If not, the download the file UCI_HAR_data.zip with contain all data using in this script. Then the unuzip the fil and make the tidy data.
if yes the make the tidy data. 


### Script description of Run_analysis.R  by Step

1) read data, list and variable list

- read data test  
- read data train
- read Activity 
- read variable list

2) Merges the training and the test data and labels

- merge training and test sets to obtain data set
- labels the data set with descriptive variable names

- merge training and test labels to obtain data labels
- labels the data labels 

- merge training and test subject to obtain data subject
- labels the data subject 

3) Extracts mean and standard deviation on data set 


4)creates a second, independent tidy data set with the average of each variable for each activity and each subject.

5) Write tidy data on txt file


### Note

For more informations about the data see CodeBook.md

### Value
return file tidy_data.txt

### Authors
Olivier Chimi C.