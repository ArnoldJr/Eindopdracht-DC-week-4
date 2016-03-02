## You should create one R script called run_analysis.R that does the following.
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# 0. Load packages
print("Load packages")
packages <- c("data.table", "reshape2")
sapply(packages, require, character.only = TRUE, quietly = TRUE)

# 1. Download files
print("Download files")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "Dataset.zip", method = "auto")
unzip("Dataset.zip")

# 2. Load files
print("Load files")
# 1/3 Descriptive
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
# 2/3 Test
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
# 3/3 Train
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# 3. labels the data set with descriptive activity names
print("labels the data set")
# column name for subject files
names(test_subject) <- "subjectID"
names(train_subject) <- "subjectID"
# add column names for measurement files
names(test_x) <- features
names(train_x) <- features
# add column name for label files
names(test_y) <- "activity"
names(train_y) <- "activity"

# 4. Bind and mergedata
print("Bind and mergedata")
# 1/3 Test
test_data <- cbind(as.data.table(test_subject), test_y, test_x)
# 2/3 Train
train_data <- cbind(as.data.table(train_subject), train_y, train_x)
# 3/3 Merge Test and Train data
cdata = rbind(test_data, train_data)


# 5. Modeling the data
print("Modeling the data")
id_labels   = c("subjectID", "activity")
data_labels = setdiff(colnames(cdata), id_labels)
# convert the activity column from integer to factor with discriptive names
cdata$activity <- factor(cdata$activity, labels=c("Walking",
    "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))
melt_data = melt(cdata, id = id_labels, measure.vars = data_labels)
	
# 6. Apply the mean function to the tidy dataset (independent)
print("Apply the mean function to the tidy dataset (independent)")
tidy_data   = dcast(melt_data, subjectID + activity ~ variable, mean)

# 7. Write the result to file
print("Write the result to file")
write.table(tidy_data, file = "./tidy_data.txt", sep="\t")