CleaningDataProject
===================

### README

### This is a summary of the course project

## Objective
The goal of this project is to summarize the means and standard deviations of several measures contained in two data sets (X_train.txt and X_test.txt) into a tidy data set. This data set will have the average of the means and standard deviations by activity and subject.

### Process scheme

1. Upload the information from the original text files
2. Create the descriptive names for each variable of the data sets
3. Extract the relevant information for the analysis (mean and standard deviation)
4. Merge the data sets
5. Create a new, tidy data set with the average of the variables of the merged data set, conditiones on the activity and the subject ID

## Input 
(description taken from the original README.txt at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip):
- features.txt: List of all features.
- activity_labels.txt: Links the class labels with their activity name.
- train/X_train.txt: Training set.
- train/y_train.txt: Training labels.
- test/X_test.txt: Test set.
- test/y_test.txt: Test labels.

## Output:
a tidy data set (separated by spaces) with 180 observations of 75 variables. The first two are the activities and subject ID, the next 73 are the average of the means and standard deviations of the measures (check CodeBook.md for more details).
- tidyDataset.txt

## R Scripts
- run_analysis.R

### Preliminar considerations
In order to run this R code you must have all the input (.txt) files in your working directory. You will need the plyr package installed too.

### Description of the run_analysis.R

Line 2: just uploading the plyr package

Line 6 to 11: uploads the information from the six .txt files into separated data frames

Line 12 to 15: designates the names of the two subjects’ IDs data frames (test and train), as well to the two activities data frames. They’ll be used in the merging of all the data sets.

Line 19 to 21: uploads the activities labels, and creates an auxiliary vector which is going to be used to change the activity number to the activity label.

Line 25 to 30: this cycle replaces the code number of the activities with their labels.

Line 34 to 46: uploads the labels of the variables of the X_trian and X_test data sets, which contain all the measures we’re interested to summarize. Here I replaced all the special characters that could produce errors afterwards, like “-“, “()” and the like. I also fixed the typo “BodyBody” here.

Line 50 to 55: merges the six data frames (X_train, X_test, y_train, y_test, subject_train and subject_test) in a single data frame called bigDataset. In this process I selected the columns from X_train and X_test that contain the means (mean) and standard deviation (std) of the 33 measures, as well as the 7 “angle” measures, which are averages of several correlations. Note that I did not include the meanFreq() variable, since it’s a different statistic from each measure (like min, max, etc).

Line 59 to 62: creates the tidy data set named tidyDataset. I used the aggregate() function in order to compute the  average of the 73 variables filtered by activity and subject id. After fixing some names (basically putting an extra “Average_” on each variable label) I created the file tidyDataset.txt with the write.table() function.

Line 64 to 65: this part of the code is not necessary in the building of the tidy data set, but it provides the specifications for uploading tidyDataset.txt in R.
