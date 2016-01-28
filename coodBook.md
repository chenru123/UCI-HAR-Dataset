## This is the CodeBook for the "Getting and Cleaning Data Project

The link below point to the original data set that was obtained for this project.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for this project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script will do the following work...

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the 
   average of each variable for each activity and each subject.
   
First, the script will load all the require libraries for the function that will be use in the script.
Before any functions can be applied, we'll need to read in all the data set.  There are total
8 data files and I've list them below.  I have also include the # of obs/variables for 
each file.

	1. features.txt: Data Frame object with 561 obs of 2 variables
	2. activity_labels.txt: Data Frame object with 6 obs of 2 variables
	3. X_train.txt: Data Frame object with 7352 obs of 563 variables (Noted: the variables
	counts include the 2 new added variables from the script.)
	4. y_train.txt: Data Frame object with 7352 obs of 1 variable
	5. subject_train.txt: Data Frame object with 7352 obs of 1 variable
	6. X_test.txt: Data Frame object with 2947 obs of 563 variables (Noted: the variables
	counts include the 2 new added variables from the script.)
	7. y_test.txt: Data Frame object with 2947 obs of 1 variable
	8. subject_test.txt: Data Frame object with 2947 obs of 1 variable

Before we can merges both data set, we'll need to construct "testSet" and "trainSet" dataframes.  
Two additional new variables have been added as part of the data construct.  They are 
"activity" and "subject".  The "activity" variable contains activity enumeration (1-6) 
that was performed for each observation.  The "subject" variable contains the volunteer (1-30)
that performed the activity for each observation. 

Once both data sets are constructed, I used the "merge" function to combine both set and
create a new data set.

Next, in order to extract measurements only on the "mean" and "standard deviation", I used
the grep function to search those colnames that contains the "mean" and "std" and created
another new dataset.  Calculated the mean from the new data set and write out the output
into a text file to submit for course credit.

Also rename some of the variables in the data set with more descriptive names.