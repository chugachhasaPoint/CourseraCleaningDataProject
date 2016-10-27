# CourseraCleaningDataProject
This repo contains run_analysis script, codebook, and README files in the tidying of accelerometer data in a Samsung phone.
This README explains how run_analysis works and how the dataset was created.

## Step 0: Set Dependencies 
The dplyr and plyr libraries are imported. 

## Step 1: Environment Setup 
The files are downloaded into a "data" repo, are unziped, and tagged with the date. 
The test and train data are imported, in addition to the test and subject labels. 

## Step 2: Verify Records
The imported files are checked to see if any of the records have NA values. 

## Step 3: Merge Training and Testing Data Sets
The train and test data sets are combined by row. 

## Step 4: Partition out "Mean" and "Std" Variables
The variables reporting mean and standard deviation values are isolated by combing through the 
features names. The indexes of these names are used to isolate the varaible columns in order to 
return a partitioned dataset. These names were also converted to lowercase for readability before 
being assigned as the column names.

## Step 5: Finalize dataset and datasetsummary
The final dataset is made to have readable factor levels, reflecting the test activities descriptively
and to allow the data per subject to be summarized. 

The subject data per activity is meaned and reported in its own dataframe. 




