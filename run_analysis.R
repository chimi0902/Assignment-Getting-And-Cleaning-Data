library(data.table)
library(reshape2)
library(dplyr)

# download data 
DataFile <-"UCI HAR Dataset"
if (!file.exists(DataFile)) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile="UCI_HAR_data.zip", method="curl")
    unzip("UCI_HAR_data.zip")
}

# read data test 
x_test <- read.table(paste(DataFile,"test/X_test.txt",sep = "/"))
y_test <- read.table(paste(DataFile,"test/y_test.txt",sep = "/"))
subject_test <- read.table(paste(DataFile,"test/subject_test.txt",sep = "/"))

# read data train
x_train <- read.table(paste(DataFile,"train/X_train.txt",sep = "/"))
y_train <- read.table(paste(DataFile,"train/y_train.txt",sep = "/"))
subject_train <- read.table(paste(DataFile,"train/subject_train.txt",sep = "/"))

# read Activity 
Activity <- read.table(paste(DataFile,"activity_labels.txt",sep = "/"))

# read variable list
Variablenames <- read.table(paste(DataFile,"/features.txt",sep = "/"))

# Merges the training and the test sets to create one data set.
x_Data <- rbind(x_test,x_train)
# labels the data set with descriptive variable names. 
colnames(x_Data) <- Variablenames$V2


# Merges the training and the test label to create one data label.
y_Data <- rbind(y_test,y_train)
#labels the data label
y_Data[,2] <- Activity$V2[y_Data[,1]]
colnames(y_Data) <- c("Activity_ID", "Activity_Label")


# Merges the training and the label subject to create one data subject
subject <- rbind(subject_test,subject_train)
names(subject) <- "subject"

#Extracts mean and standard deviation on data set to create new data set.
x_Data <- x_Data[,grep("mean |std",names(x_Data))]
colMeanStd_data <- names(x_Data)

#creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject.

tidy_data <- cbind(subject, y_Data, x_Data) %>%
        melt(id = c("subject", "Activity_ID", "Activity_Label"), colMeanStd_data) %>%
        dcast(subject + Activity_Label ~ variable, mean)

#Write tidy data on txt file
write.table(tidy_data, file = paste(DataFile,"/tidy_data.txt",sep = ""), row.names=FALSE)
