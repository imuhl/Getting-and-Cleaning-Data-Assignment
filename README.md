# Getting and Cleaning Data Assignment

This Repository contains as Script "run_analysis.R" which loads train and test data from the 
subfolder "UCI HAR Dataset" in addition with descriptive column names, the subject and activity information.

It combines the train and test data and the subject and activity information and filters on columns with mean
and standard deviation values.

It merges the activity names to the created dataset.

In the end a new dataset with means of the columns grouped by subject id and activity name is created and written as 
text file to the main directory.


