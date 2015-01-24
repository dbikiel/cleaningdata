# Project 1 for Getting and Cleaning Data

This repo contains the analysis script and the Code Book.

The script reads the following files (which should be on your working directory):

X_test.txt            Table of measurements - test data
X_train.txt           Table of measurements - train data
activity_labels.txt   List of activities
features.txt          List of variables measured in X
subject_test.txt      List of subjects - test data
subject_train.txt     List of subjects - train data
y_test.txt            List of activities performed by each subject in X - test data
y_train.txt           List of activities performed by each subject in X - test data

1) After reading the data, the script merges every test and train set in one set (i.e X_test.txt + X_train.txt -> X).
2) Using the labels from activity_labels, replace each number in y by its activity code.
3) Searchs all the features that contain the word "mean()" or "std()" and extract these columns from X.
4) Merges the list of subjects, the activity labels for each measurement and the measurements that only involves mean() and std().
5) Reorder the data by grouping the table by subject
6) For each subject, filter the rows that contain a particular activity and calculate the mea for each variable.
7) Regenerate a new table containing just the mean for each subject, activity and variable.
8) Filter from the new table the variables that contain mean().
9) Saves the new table in a project1.txt file.

