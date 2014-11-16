# getting the data if is not present
dir = "UCI HAR Dataset"
if (!file.exists(dir)) {
  print("Data dir is not present")
  zip.filename = "UCI_HAR_Dataset.zip"
  if (!file.exists(zip.filename)) {
    print("Zip file is not present, downloading...")
    url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, zip.filename, method = "curl")
  }
  print("Unzipping file...")
  unzip(zip.filename)
}

# Merges the training and the test sets to create one data set.
print("Reading datasets and merging data")
training.dataset <- read.table("UCI HAR Dataset/train/X_train.txt")
test.dataset <- read.table('UCI HAR Dataset/test/X_test.txt')
one.dataset <- rbind(training.dataset, test.dataset)
