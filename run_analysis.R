#Set the working directory where the files should be to analyze
setwd("/Users/dbikiel/Documents/R/Coursera/Cleaning/project1")

#Load libraries
library(dplyr)
library(tidyr)

#X data extraction and merging train and test
X_test <- read.table("X_test.txt")
X_train <- read.table("X_train.txt")
X <- rbind(X_test,X_train)
rm("X_test","X_train")
as.matrix(X)

#activity extraction from file
activity <- read.table("activity_labels.txt")

#Features extraction fromfile
features <- read.table("features.txt")
varNames <- as.character(features$V2)

#subject extraction from file and merging train and test
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")
subject <- rbind(subject_test,subject_train)
rm("subject_test","subject_train")

#y extaction and merging train and test
y_test <- read.table("y_test.txt")
y_train <- read.table("y_train.txt")
y <- rbind(y_test,y_train)
rm("y_test","y_train")

#Generates list of activities for the set from the labels
task <- y
for (i in c(1:6)) {
        task[task == i] <- as.character(activity[i,2])
}

#Search and crop the mean and std variables
m <- grep(c("mean\\(\\)"),varNames,ignore.case=FALSE)
s <- grep(c("std\\(\\)"),varNames,ignore.case=FALSE)
ms <- sort(c(m,s))
varNames_ms <- varNames[ms]

#Crop the data by these variables
data <- as.data.frame(X[,ms])
colnames(data)<- varNames_ms

#Starts to manipulate and merge tables
data_df <- tbl_df(data)

#generate a table for subjects
as.data.frame(subject)
colnames(subject) <- c("Subject")
subject_df <- tbl_df(subject)

#Generate a table for the activities
as.data.frame(task)
colnames(task) <- c("Activity")
task_df <- tbl_df(task)

#Merge subject, activity and data in a table
data_df <- cbind(subject_df, task_df, data_df)

#dplyr operations: order the table by subject
by_subject <- group_by(data_df,Subject,Activity)

#Generate a new matrix that wll containd the mean data
res <- matrix(nrow = 180, ncol = 68)
k <- 1
for (i in c(1:30)) {
        for (j in activity[,2]){
                res[k,1] <- i
                res[k,2] <- j
                #For each subjects, filter an activity and calculate it means
                res[k,3:68] <-colMeans(select(filter(data_df, 
                                       Subject == i, Activity == j),contains("mean")))
                k <- k + 1
        }
}

#Takes the names of the variables
colnames(res) <- colnames(data_df)
res <- as.data.frame(res)
res <- tbl_df(res)

#Generates a smaller table with only the means
res2 <- select(res,Subject,Activity,contains("mean"))
#Output file
write.table(res2,file = "project1.txt", row.names = FALSE)