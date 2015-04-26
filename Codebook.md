# CodeBook

This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

## The data source

* Original data:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
 

## Transformation Details
 Dataset is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
 then unzip the results on defaultworking directory @ "UciDataset"
 
 - Run run_analysis.R to begin transformation and analysis
 - Requires Dplyr and Tidyr Package installed
   
## Transformation Steps
 

- STEP1 - Initial LOAD data from csv file
      1. Load all the datasets to memory so we can start analyzing data
      2. Load activity_labels and assign ColumnNames - ActivityID, Acitivity 
      3. Load features.text
      4. Load features.text and assign ColumnNames - Subject
      5. Load X_test.txt and X_Train.txt
      6. Load Y_test.txt and Y_Train.txt (with columnNames - ActivityID)
      
      7. Load the rest of the data
      		body_acc_x_test & train.text 
      		body_acc_y_test & train.text
      		body_acc_z_test & train.text& train.text
      		body_gyro_x_test & train.text  
      		body_gyro_y_test & train.text 
      		body_gyro_z_test & train.text  
      		total_acc_x_test & train.text 
      		total_acc_y_test & train.text 
      		total_acc_z_test & train.text 
     
- STEP2 -   CLEAN UP / tidy DATA 
     1. Cleanup1 - Extract only MEAN and STD from X_TEST and X_TRAIN
         Assign a new variable to datasets with no with these text removed "()" and "-"
         Merge  X_test and Y_test   / merge x_train and y_train   
           
    2. Cleanup2
         add a columns "Volunteers" and "RowID" so we information is not lost when we add test/train datasets together later
         
    3. Cleanup3
        tidy up data in XYZ coordinates in TEST and TRAIN  (body_acc, body_gyro, total_acc)
        combine into 1 dataset for ACC/Gyro/Total
       
    4. Cleanup5 - clean x_test and x_train
			add a new columns for Mean and STD for ACC/Gyro/Total
 

 
- STEP3 - Merges the training and the test sets to create one data set.  
	   Final Tables below
			tidy_xdata  
			tidy_signaldata 

 

# Notes
##tidy_xdata
         'data.frame':  18308 obs. of  7 variables:
         $ ActivityID : int  1 1 1 1 1 1 1 1 1 1 ...
         $ Volunteers : chr  "test" "test" "test" "test" ...
         $ RowID      : int  80 80 80 80 80 80 80 80 80 80 ...
         $ Activity   : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...
         $ Calculation: chr  "fBodyAcc-X" "fBodyAcc-Y" "fBodyAcc-Z" "fBodyAccFreq-X" ...
         $ Mean       : num  -0.362 -0.121 -0.521 -0.239 0.111 ...
         $ Std        : num  -0.512 -0.267 -0.462 NA NA ...

##tidy_signaldata
         'data.frame':  152064 obs. of  7 variables:
         $ Volunteers : chr  "test" "test" "test" "test" ...
         $ RowID      : int  1 2 3 4 5 6 7 8 9 10 ...
         $ Elements   : Factor w/ 128 levels "V1","V2","V3",..: 1 1 1 1 1 1 1 1 1 1 ...
         $ CoordinateX: num  0.011653 0.00928 0.005732 0.000452 -0.004362 ...
         $ CoordinateY: num  -0.0294 0.00665 0.0073 -0.02381 -0.00946 ...
         $ CoordinateZ: num  0.10683 -0.02632 0.01021 -0.027 -0.00146 ...
         $ Calculation: chr  "BodyAcc" "BodyAcc" "BodyAcc" "BodyAcc" ...


 