# Getting and Cleaning Data

## Course Project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Steps to work on this course project


1. Download the  required file ```run_analysis.R``` and optionaly the files ```readme.md```, ```codebook.md``` and ```tidy_data.txt```
2. Make sure that required packages ```reshape2``` and ```data.table``` are installed, the script will load the packages  automatically
3. The file ```run_analysis.R``` will automatically download and extract the files
4. The data will be modeld to tidy data with the means and std
5. The output file ```tidy_data.txt``` will contain the means and stdof each variable for each activity and each subject.

## Package dependencies 

```run_analysis.R``` file will load the required packages automatically. ```reshape2``` and ```data.table```. 

## Notes

Tested on Windows 8.1, this can mather for the download method.(```auto``` vs ```curl```)
