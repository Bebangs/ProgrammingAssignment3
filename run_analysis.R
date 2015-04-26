#Author: Jerry Pang
#Date: 4.25.2015
#Purpose: For Coursera Project - tidy Data
#Notes: Dataset is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#         stored on defaultworking directory @ "UciDataset"
library(dplyr)
library(tidyr)


#******************************************************************************************************************************
#STEP1 - Initial LOAD data from csv file
#load all the datasets to memory so we can start analyzing data
#******************************************************************************************************************************

    
    #Column Labels or variables
      activity <- tbl_df( read.table("UciDataset/activity_labels.txt", header = FALSE ) )
          colnames(activity) <- c("ActivityID","Activity")
      features <- tbl_df( read.table("UciDataset/features.txt", header = FALSE ) )
    
    #load test datasets
      x_test <-  tbl_df( read.table("UciDataset/test/X_test.txt", header = FALSE)) #, nrows = 294) )
      y_test <- tbl_df( read.table("UciDataset/test/y_test.txt", header = FALSE)) #, nrows = 294) )
          colnames(y_test) <- c("ActivityID")
      subject_test <- tbl_df( read.table("UciDataset/test/subject_test.txt", header = FALSE)) #, nrows = 294) )
          colnames(subject_test) <- c("Subject")
      body_acc_x_test <- tbl_df( read.table("UciDataset/test/Inertial Signals/body_acc_x_test.txt", header = FALSE)) #, nrows = 294) ) 
      body_acc_y_test <- tbl_df( read.table("UciDataset/test/Inertial Signals/body_acc_y_test.txt", header = FALSE)) #, nrows = 294) )
      body_acc_z_test <- tbl_df( read.table("UciDataset/test/Inertial Signals/body_acc_z_test.txt", header = FALSE)) #, nrows = 294) )
      body_gyro_x_test <- tbl_df( read.table("UciDataset/test/Inertial Signals/body_gyro_x_test.txt", header = FALSE)) #, nrows = 294) )
      body_gyro_y_test <- tbl_df( read.table("UciDataset/test/Inertial Signals/body_gyro_y_test.txt", header = FALSE)) #, nrows = 294) )
      body_gyro_z_test <- tbl_df( read.table("UciDataset/test/Inertial Signals/body_gyro_z_test.txt", header = FALSE)) #, nrows = 294) )
      total_acc_x_test <- tbl_df( read.table("UciDataset/test/Inertial Signals/total_acc_x_test.txt", header = FALSE)) #, nrows = 294) )
      total_acc_y_test <- tbl_df( read.table("UciDataset/test/Inertial Signals/total_acc_y_test.txt", header = FALSE)) #, nrows = 294) )
      total_acc_z_test <- tbl_df( read.table("UciDataset/test/Inertial Signals/total_acc_z_test.txt", header = FALSE)) #, nrows = 294) )
      
    
    #load train datasets 
      x_train <- tbl_df( read.table("UciDataset/train/X_train.txt", header = FALSE)) #, nrows = 102) ))
      y_train <- tbl_df( read.table("UciDataset/train/y_train.txt", header = FALSE)) #, nrows = 102) ))
          colnames(y_train) <- c("ActivityID")
      subject_train <- tbl_df( read.table("UciDataset/train/subject_train.txt", header = FALSE)) #, nrows = 102) ))
          colnames(subject_train) <- c("Subject")
      body_acc_x_train <- tbl_df( read.table("UciDataset/train/Inertial Signals/body_acc_x_train.txt", header = FALSE)) #, nrows = 102) ))
      body_acc_y_train <- tbl_df( read.table("UciDataset/train/Inertial Signals/body_acc_y_train.txt", header = FALSE)) #, nrows = 102) ))
      body_acc_z_train <- tbl_df( read.table("UciDataset/train/Inertial Signals/body_acc_z_train.txt", header = FALSE)) #, nrows = 102) ))
      body_gyro_x_train <- tbl_df( read.table("UciDataset/train/Inertial Signals/body_gyro_x_train.txt", header = FALSE)) #, nrows = 102) ))
      body_gyro_y_train <- tbl_df( read.table("UciDataset/train/Inertial Signals/body_gyro_y_train.txt", header = FALSE)) #, nrows = 102) ))
      body_gyro_z_train <- tbl_df( read.table("UciDataset/train/Inertial Signals/body_gyro_z_train.txt", header = FALSE)) #, nrows = 102) ))
      total_acc_x_train <- tbl_df( read.table("UciDataset/train/Inertial Signals/total_acc_x_train.txt", header = FALSE)) #, nrows = 102) ))
      total_acc_y_train <- tbl_df( read.table("UciDataset/train/Inertial Signals/total_acc_y_train.txt", header = FALSE)) #, nrows = 102) ))
      total_acc_z_train <- tbl_df( read.table("UciDataset/train/Inertial Signals/total_acc_z_train.txt", header = FALSE)) #, nrows = 102) ))
      


#******************************************************************************************************************************
#STEP2 -   CLEAN UP / tidy DATA
#******************************************************************************************************************************
    ###Cleanup1 - Extract only MEAN and STD from X_TEST and X_TRAIN
        #Assign FeatureName to datasets
          colnames(features) <- c("Row","OrigVariable") 
        
        #clean up data, removed () and -
          features <- features %>% 
            mutate(NewVariable = gsub("\\()","",features$OrigVariable)) %>%  #replace () with "-"
            mutate(NewVariable = gsub("--","-",NewVariable))             

        #Find columns with name that contains STD or MEAN 
        # we are only interested in STR or mean in this project 
          features_filtered<- filter(features, grepl("std",NewVariable) | grepl("mean",NewVariable)) 
        
        #remove other columns in X_TEST and X_TRAIN (retain STD and MEAN)
          x_test <-  x_test[, features_filtered$Row] 
          x_train <-   x_train[, features_filtered$Row]  
          
          colnames(x_test) <- features_filtered$NewVariable 
          colnames(x_train) <- features_filtered$NewVariable 
        
        #Combine X_test and Y_test   / combine x_train and y_train  
          x_test  <- tbl_df( cbind(x_test, y_test) )
          x_train <- tbl_df( cbind(x_train, y_train) )
          
        
    ##Cleanup2
        #add a columns "Volunteers" and "RowID" so we information is not lost when we add test/train datasets together later
        #in test
          x_test <- mutate(x_test, Volunteers = "test" , RowID = 1:dim(x_test)[1]) 
          body_acc_x_test <- mutate(body_acc_x_test, Volunteers = "test" , RowID = 1:dim(body_acc_x_test)[1])
          body_acc_y_test <- mutate(body_acc_y_test, Volunteers = "test" , RowID = 1:dim(body_acc_y_test)[1])
          body_acc_z_test <- mutate(body_acc_z_test, Volunteers = "test" , RowID = 1:dim(body_acc_z_test)[1])
          body_gyro_x_test <- mutate(body_gyro_x_test, Volunteers = "test" , RowID = 1:dim(body_gyro_x_test)[1])
          body_gyro_y_test <- mutate(body_gyro_y_test, Volunteers = "test" , RowID = 1:dim(body_gyro_y_test)[1])
          body_gyro_z_test <- mutate(body_gyro_z_test, Volunteers = "test" , RowID = 1:dim(body_gyro_z_test)[1])
          total_acc_x_test <- mutate(total_acc_x_test, Volunteers = "test" , RowID = 1:dim(total_acc_x_test)[1])
          total_acc_y_test <- mutate(total_acc_y_test, Volunteers = "test" , RowID = 1:dim(total_acc_y_test)[1])
          total_acc_z_test <- mutate(total_acc_z_test, Volunteers = "test" , RowID = 1:dim(total_acc_z_test)[1])
          
          #in train
          x_train <- mutate(x_train, Volunteers = "train" , RowID = 1:dim(x_train)[1]) 
          body_acc_x_train <- mutate(body_acc_x_train, Volunteers = "train" , RowID = 1:dim(body_acc_x_train)[1])
          body_acc_y_train <- mutate(body_acc_y_train, Volunteers = "train" , RowID = 1:dim(body_acc_y_train)[1])
          body_acc_z_train <- mutate(body_acc_z_train, Volunteers = "train" , RowID = 1:dim(body_acc_z_train)[1])
          body_gyro_x_train <- mutate(body_gyro_x_train, Volunteers = "train" , RowID = 1:dim(body_gyro_x_train)[1])
          body_gyro_y_train <- mutate(body_gyro_y_train, Volunteers = "train" , RowID = 1:dim(body_gyro_y_train)[1])
          body_gyro_z_train <- mutate(body_gyro_z_train, Volunteers = "train" , RowID = 1:dim(body_gyro_z_train)[1])
          total_acc_x_train <- mutate(total_acc_x_train, Volunteers = "train" , RowID = 1:dim(total_acc_x_train)[1])
          total_acc_y_train <- mutate(total_acc_y_train, Volunteers = "train" , RowID = 1:dim(total_acc_y_train)[1])
          total_acc_z_train <- mutate(total_acc_z_train, Volunteers = "train" , RowID = 1:dim(total_acc_z_train)[1])
          
          
    
    
    ##Cleanup3
      # tidy up data in XYZ coordinates in TEST and TRAIN 
      body_acc_x_test  <- body_acc_x_test %>%    gather(  Elements, CoordinateX, -(Volunteers:RowID))
      body_acc_y_test  <- body_acc_y_test %>%    gather(  Elements, CoordinateY, -(Volunteers:RowID))
      body_acc_z_test  <- body_acc_z_test %>%    gather(  Elements, CoordinateZ,  -(Volunteers:RowID))
      body_gyro_x_test  <- body_gyro_x_test %>%  gather(  Elements, CoordinateX, -(Volunteers:RowID))
      body_gyro_y_test  <- body_gyro_y_test %>%  gather(  Elements, CoordinateY, -(Volunteers:RowID))
      body_gyro_z_test  <- body_gyro_z_test %>%  gather(  Elements, CoordinateZ, -(Volunteers:RowID))
      total_acc_x_test  <- total_acc_x_test %>%  gather(  Elements, CoordinateX, -(Volunteers:RowID))
      total_acc_y_test  <- total_acc_y_test %>%   gather(  Elements, CoordinateY, -(Volunteers:RowID))
      total_acc_z_test  <- total_acc_z_test %>%   gather(  Elements, CoordinateZ, -(Volunteers:RowID))
          
      body_acc_x_train  <- body_acc_x_train %>%    gather(  Elements, CoordinateX, -(Volunteers:RowID))
      body_acc_y_train  <- body_acc_y_train %>%    gather(  Elements, CoordinateY, -(Volunteers:RowID))
      body_acc_z_train  <- body_acc_z_train %>%    gather(  Elements, CoordinateZ,  -(Volunteers:RowID))
      body_gyro_x_train  <- body_gyro_x_train %>%  gather(  Elements, CoordinateX, -(Volunteers:RowID))
      body_gyro_y_train  <- body_gyro_y_train %>%  gather(  Elements, CoordinateY, -(Volunteers:RowID))
      body_gyro_z_train  <- body_gyro_z_train %>%  gather(  Elements, CoordinateZ, -(Volunteers:RowID))
      total_acc_x_train  <- total_acc_x_train %>%  gather(  Elements, CoordinateX, -(Volunteers:RowID))
      total_acc_y_train  <- total_acc_y_train %>%   gather(  Elements, CoordinateY, -(Volunteers:RowID))
      total_acc_z_train  <- total_acc_z_train %>%   gather(  Elements, CoordinateZ, -(Volunteers:RowID))

      #combine into 1 dataset for ACC/Gyro/Total
      body_acc_test   <-   cbind(body_acc_x_test, body_acc_y_test[,c("CoordinateY")] , body_acc_z_test[,c("CoordinateZ")]  )  
      body_gyro_test  <-   cbind(body_acc_x_test, body_acc_y_test[,c("CoordinateY")] , body_acc_z_test[,c("CoordinateZ")]  )  
      total_acc_test  <-   cbind(total_acc_x_test, total_acc_y_test[,c("CoordinateY")] , total_acc_z_test[,c("CoordinateZ")] )
      
      body_acc_train  <-   cbind(body_acc_x_train, body_acc_y_train[,c("CoordinateY")] , body_acc_z_train[,c("CoordinateZ")]  )  
      body_gyro_train <-   cbind(body_acc_x_train, body_acc_y_train[,c("CoordinateY")] , body_acc_z_train[,c("CoordinateZ")]  )  
      total_acc_train  <-   cbind(total_acc_x_train, total_acc_y_train[,c("CoordinateY")] , total_acc_z_train[,c("CoordinateZ")]  )  

      body_acc_test<- mutate(body_acc_test, Calculation = "BodyAcc")
      body_gyro_test<- mutate(body_gyro_test, Calculation = "BodyGyro")
      total_acc_test<- mutate(total_acc_test, Calculation = "TotalAcc")
      
      body_acc_train<- mutate(body_acc_train, Calculation = "BodyAcc")
      body_gyro_train<- mutate(body_gyro_train, Calculation = "BodyGyro")
      total_acc_train<- mutate(total_acc_train, Calculation = "TotalAcc")

      test_signaldata <- rbind(body_acc_test, body_gyro_test, total_acc_test)
      train_signaldata <- rbind(body_acc_train, body_gyro_train, total_acc_train)

  #Cleanup5 - clean x_test and x_train
tidy_xtest  <- x_test %>%
           merge( activity, by.x = "ActivityID", by.y = "ActivityID", all = TRUE)    %>%   
              gather( Calculation, Value,  -ActivityID, -(Volunteers:Activity))    %>%  
                mutate( CalculationType = ifelse(grepl("std",Calculation), "Std","Mean" ))   %>% 
                  mutate( Calculation  = gsub("-mean","",Calculation))     %>% 
                    mutate( Calculation  = gsub("-std","",Calculation))      %>%  
                      spread( CalculationType, Value)

tidy_xtrain  <- x_train %>%
          merge( activity, by.x = "ActivityID", by.y = "ActivityID", all = TRUE)    %>%   
            gather( Calculation, Value,  -ActivityID, -(Volunteers:Activity))    %>%  
              mutate( CalculationType = ifelse(grepl("std",Calculation), "Std","Mean" ))   %>% 
               mutate( Calculation  = gsub("-mean","",Calculation))     %>% 
                mutate( Calculation  = gsub("-std","",Calculation))      %>%  
                  spread( CalculationType, Value)



#******************************************************************************************************************************
#STEP3 *** Merges the training and the test sets to create one data set. 
#****************************************************************************************************************************** 
tidy_xdata <- rbind(tidy_xtest, tidy_xtrain)
tidy_signaldata <- rbind(test_signaldata, train_signaldata) 


#******************************************************************************************************************************
#STEP4 *** Extracts only the measurements on the mean and standard deviation for each measurement. 
#****************************************************************************************************************************** 
#see - tidy_xdata
#         'data.frame':  18308 obs. of  7 variables:
#           $ ActivityID : int  1 1 1 1 1 1 1 1 1 1 ...
#         $ Volunteers : chr  "test" "test" "test" "test" ...
#         $ RowID      : int  80 80 80 80 80 80 80 80 80 80 ...
#         $ Activity   : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...
#         $ Calculation: chr  "fBodyAcc-X" "fBodyAcc-Y" "fBodyAcc-Z" "fBodyAccFreq-X" ...
#         $ Mean       : num  -0.362 -0.121 -0.521 -0.239 0.111 ...
#         $ Std        : num  -0.512 -0.267 -0.462 NA NA ...

#see - tidy_signaldata
#         'data.frame':  152064 obs. of  7 variables:
#           $ Volunteers : chr  "test" "test" "test" "test" ...
#         $ RowID      : int  1 2 3 4 5 6 7 8 9 10 ...
#         $ Elements   : Factor w/ 128 levels "V1","V2","V3",..: 1 1 1 1 1 1 1 1 1 1 ...
#         $ CoordinateX: num  0.011653 0.00928 0.005732 0.000452 -0.004362 ...
#         $ CoordinateY: num  -0.0294 0.00665 0.0073 -0.02381 -0.00946 ...
#         $ CoordinateZ: num  0.10683 -0.02632 0.01021 -0.027 -0.00146 ...
#         $ Calculation: chr  "BodyAcc" "BodyAcc" "BodyAcc" "BodyAcc" ...


#******************************************************************************************************************************
#STEP5 *** Uses descriptive activity names to name the activities in the data set
#******************************************************************************************************************************
#see - tidy_xdata 
#         $ Activity   : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...


#******************************************************************************************************************************
#STEP6 *** Appropriately labels the data set with descriptive variable names. 
#******************************************************************************************************************************
#see - tidy_xdata
#         'data.frame':  18308 obs. of  7 variables:
#           $ ActivityID : int  1 1 1 1 1 1 1 1 1 1 ...
#         $ Volunteers : chr  "test" "test" "test" "test" ...
#         $ RowID      : int  80 80 80 80 80 80 80 80 80 80 ...
#         $ Activity   : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...
#         $ Calculation: chr  "fBodyAcc-X" "fBodyAcc-Y" "fBodyAcc-Z" "fBodyAccFreq-X" ...
#         $ Mean       : num  -0.362 -0.121 -0.521 -0.239 0.111 ...
#         $ Std        : num  -0.512 -0.267 -0.462 NA NA ...

#see - tidy_signaldata
#         'data.frame':  152064 obs. of  7 variables:
#           $ Volunteers : chr  "test" "test" "test" "test" ...
#         $ RowID      : int  1 2 3 4 5 6 7 8 9 10 ...
#         $ Elements   : Factor w/ 128 levels "V1","V2","V3",..: 1 1 1 1 1 1 1 1 1 1 ...
#         $ CoordinateX: num  0.011653 0.00928 0.005732 0.000452 -0.004362 ...
#         $ CoordinateY: num  -0.0294 0.00665 0.0073 -0.02381 -0.00946 ...
#         $ CoordinateZ: num  0.10683 -0.02632 0.01021 -0.027 -0.00146 ...
#         $ Calculation: chr  "BodyAcc" "BodyAcc" "BodyAcc" "BodyAcc" ...





#******************************************************************************************************************************
#STEP7 *** From the data set in STEP 6, creates a second, independent tidy data set with the average 
#          of each variable for each activity and each subject.
#******************************************************************************************************************************


write.table(tidy_xdata, file = "./tidy_xdata.txt",  row.names = FALSE)
write.table(tidy_signaldata, file = "./tidy_signaldata.txt",  row.names = FALSE)





#CleanupLast memory - remove these to avoid confusion and resusing these later
rm(y_test)
rm(y_train)
rm(subject_test)
rm(subject_train)

rm(body_acc_x_test)
rm(body_acc_y_test)
rm(body_acc_z_test)
rm(body_gyro_x_test)
rm(body_gyro_y_test)
rm(body_gyro_z_test)
rm(total_acc_x_test)
rm(total_acc_y_test) 
rm(total_acc_z_test)

rm(body_acc_x_train)
rm(body_acc_y_train)
rm(body_acc_z_train)
rm(body_gyro_x_train)
rm(body_gyro_y_train)
rm(body_gyro_z_train)
rm(total_acc_x_train)
rm(total_acc_y_train) 
rm(total_acc_z_train)
rm(body_acc_test)  
rm(body_acc_train)  
rm(body_gyro_test)  
rm(body_gyro_train) 
rm(total_acc_test)  
rm(total_acc_train) 
rm(test_signaldata)  
rm(train_signaldata) 
 
rm(tidy_xtest)  
rm(tidy_xtrain) 

rm(x_test)  
rm(x_train) 

