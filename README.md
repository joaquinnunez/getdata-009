# Course Project

## What it does and how to use it.

The R script `run_analysis.R` downloads (if not present) and process the required data. Then, it creates one new tidy dataset with the average of each variable for each activity and each subject.

To run, enter in R, and type `source('run_analysis.R')`, and it will create:

- a `tidy_dataset.txt`: that combines training and test datasets (together with subject and activity data).

## Source

Information about used data is available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Dependencies

`run_analysis.R` depends on `plyr` library (NOTE: The R script will install and load it if necessary).
