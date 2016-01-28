# This R script will do the following....
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, 
#    independent tidy data set with the average of each variable for each activity and each subject.

# Load all the require libaray for this project
library(dplyr)
library(plyr)

# Read data:
# Features Data: features.txt
# Activity Label: Descriptive name for the actiivty enum
features <- read.table("features.txt",header = FALSE)
activityLabel <- read.table("activity_labels.txt",header = FALSE)

# Training Data: 
#   X_train.txt: Training Set
#   y_train.txt: The activity in enum (1-6) that was performed for each observation
#   subject_train.txt: Each row identifies the subject who performed the activitiy

trainLabel <- read.table("train/y_train.txt",header = FALSE)
trainSet <- read.table("train/X_train.txt", header = FALSE,col.names = features$V2)
subjectTrain <- read.table("train/subject_train.txt",header = FALSE)
# Add the activity enum that was performed for each observation
trainSet <- mutate(trainSet,activity = trainLabel$V1)
# Add the subject (volunteer) that performed the activity for each observation
trainSet <- mutate(trainSet,subject = subjectTrain$V1)

# Test Data: 
#   X_test.txt: Test Set
#   y_test.txt: The activity in enum (1-6) that was performed for each observation
#   subject_test.txt: Each row identifies the subject who performed the activitiy

testLabel <- read.table("test/y_test.txt",header = FALSE)
testSet <- read.table("test/X_test.txt",header = FALSE,col.names = features$V2)
subjectTest <- read.table("test/subject_test.txt",header = FALSE)

# Add the activity enum that was performed for each observation
testSet <- mutate(testSet,activity = testLabel$V1)
# Add the subject (volunteer) that performed the activity for each observation
testSet <- mutate(testSet,subject = subjectTest$V1)

# 1. Merges the training and the test sets to create one data set.
combineData <- merge(trainSet,testSet,all = TRUE)

# Store combine data into tbl_df
combineData <- tbl_df(combineData)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Greb "mean" and "std" from combineData set
toMatch <- c("mean","std")
grepResult <- grep(paste(toMatch,collapse = "|"),names(testSet))

# Extract only the Mean, STD, activity and subject data from combineData
combineData2 <- select(combineData,grepResult,activity,subject)
combineData2 <- tbl_df(combineData2)

# 3. Uses descriptive activity names to name the activities in the data set
combineData2 <- merge(combineData2,activityLabel,by.x = "activity",by.y = "V1")
# Rename colname with descriptive name
combineData2 <- rename(combineData2,c('V2' = 'activityName'))

# 4. Appropriately labels the data set with descriptive variable names.
names(combineData2) <- gsub("^t","time",names(combineData2))
names(combineData2) <- gsub("^f","freq",names(combineData2))

# 5. From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable for each activity and each subject.
combineData3 <- combineData2 %>% group_by(subject,activity) %>% summarise_each(funs(mean))

# Generate data file to submit for the course
write.table(combineData3,file = "analysis_output.txt",row.names = FALSE)

# Remove unwanted data set
rm(features, subjectTest, subjectTrain, testLabel, trainLabel,grepResult,toMatch)