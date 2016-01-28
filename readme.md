## This is a markdown file

This file describes how "run_analysis.R" script work.

* First, setup your working directory using the setwd() function in r.

* Then, you will need to unzip the the data from the following links to your working
directory. NOTE: Make sure both the data directory and R script are in the same working
directory.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* If you're using the RStudio, you can open the script and click the "Source" icon to run
it.  Otherwise, execute source("run_analysis.r") command.

* The script will output the analysis result in the working directory called
"analysis_output.txt".  The file contains the average of each variable for each activity
and subject.