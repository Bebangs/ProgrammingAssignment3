# Getting and Cleaning Data Project

## File:run_analysis.R

## Requirements
	 - Requires Dplyr and Tidyr Package installed
 
## Running the script

To run the script, source `run_analysis.R`. 

Download the following dataset 
Original data:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Save the results into defaultworking directory @ "UciDataset" folder as 
 
  - UciDataset\activity_labels.text
  - UciDataset\features_info.txt
  - UciDataset\features.txt
  - UciDataset\README.txt
  - UciDataset\test\
  - UciDataset\train\
  
 
## Cleaned Data

  After running run_analysis.R the tidy data will be save at the following text files
    - tidy_xdata.txt
    - tidy_signaldata.txt

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



 