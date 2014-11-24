# getting the data if is not present
dir <- "UCI HAR Dataset"
if (!file.exists(dir)) {
  print("Data dir is not present")
  zip.filename <- "UCI_HAR_Dataset.zip"
  if (!file.exists(zip.filename)) {
    print("Zip file is not present, downloading...")
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, zip.filename, method = "curl")
  }
  print("Unzipping file...")
  unzip(zip.filename)
}

# Merges the training and the test sets to create one data set.
print("Reading datasets and merging data... this may take a while")
training.dataset <- read.table("UCI HAR Dataset/train/X_train.txt")
test.dataset <- read.table('UCI HAR Dataset/test/X_test.txt')
one.dataset <- rbind(training.dataset, test.dataset)

# Extracts only the measurements on the mean and standard deviation for each measurement.
print("Extracting only the measurements on the mean and standard deviation for each measurement.")
features <- read.table("UCI HAR Dataset/features.txt")
std.and.mean.features <- grep("(std|mean)", features[, 2])
one.dataset <- one.dataset[, std.and.mean.features]

# Uses descriptive activity names to name the activities in the data set
print("Using descriptive activity names to name the activities in the data set")
# getting the activities
activities.training <- read.table("UCI HAR Dataset/train/y_train.txt")
activities.test <- read.table("UCI HAR Dataset/test/y_test.txt")
activities <- rbind(activities.training, activities.test)
one.dataset <- cbind(activities, one.dataset)
# using descriptive names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
one.dataset[,1] <- factor(one.dataset[,1], activity_labels[, 1], activity_labels[,2])

# Previously adding the subjects of step 5
subjects.training <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjects.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subjects <- rbind(subjects.training, subjects.test)
one.dataset <- cbind(subjects, one.dataset)

# Appropriately labels the data set with descriptive variable names.
one.dataset.names <- features[grep("(std|mean)", features[, 2]), 2]
names(one.dataset) <- c(c('Subject', 'Activity'), as.character(one.dataset.names))

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.

### Required packages
if (!require("plyr")) {
   install.packages("plyr")
   require("plyr")
}

means <- aggregate(one.dataset[, 3] ~ one.dataset$Subject + one.dataset$Activity, data = one.dataset, FUN = mean)
for (i in 4:ncol(one.dataset)){
   means[, i] <- aggregate(one.dataset[, i] ~ one.dataset$Subject + one.dataset$Activity, data = one.dataset, FUN = mean)[, 3]
}

write.table(means, file="tidy_dataset.txt", row.name=FALSE)
