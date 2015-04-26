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
 then stored on locally on defaultworking directory @ "UciDataset"
 
 - Run run_analysis.R to begin transformation and analysis
 - Requires Dplyr and Tidyr Package installed
   
## Transformation Steps
 

- STEP1 - Initial LOAD data from csv file
   load all the datasets to memory so we can start analyzing data
     
      Load activity_labels and assign ColumnNames - ActivityID, Acitivity 
      Load features.text
      Load features.text and assign ColumnNames - Subject
    
      Load X_test.txt and X_Train.txt
      Load Y_test.txt and Y_Train.txt (with columnNames - ActivityID)
      
      Load the rest of the data
      		body_acc_x_test & train.text 
      		body_acc_y_test & train.text
      		body_acc_z_test & train.text& train.text
      		body_gyro_x_test & train.text  
      		body_gyro_y_test & train.text 
      		body_gyro_z_test & train.text  
      		total_acc_x_test & train.text 
      		total_acc_y_test & train.text 
      		total_acc_z_test & train.text 
     
-STEP2 -   CLEAN UP / tidy DATA 
     Cleanup1 - Extract only MEAN and STD from X_TEST and X_TRAIN
         Assign a new variable to datasets with no with these text removed "()" and "-"
         Merge  X_test and Y_test   / merge x_train and y_train   
          
        
    Cleanup2
         add a columns "Volunteers" and "RowID" so we information is not lost when we add test/train datasets together later
        
    
    Cleanup3
        tidy up data in XYZ coordinates in TEST and TRAIN  (body_acc, body_gyro, total_acc)
        combine into 1 dataset for ACC/Gyro/Total
       
    Cleanup5 - clean x_test and x_train
			add a new columns for Mean and STD for ACC/Gyro/Total
 

 
- STEP3 *** Merges the training and the test sets to create one data set.  
	   Final Tables below
			tidy_xdata  
			tidy_signaldata 

 


 