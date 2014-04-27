run_analysis.R script details
============================

How to execute the script
--------------------------------

**'run_analysis.R'** script to be executed using the following steps
**>source("run_analysis.R")**
**>run_analysis()**

* parameters: none
* return value: none
* output: creates an ouput file named **tidydata_submission.txt** in the current working directory
               upon completion it prints following message
                 "processing completed........output file (tidydata_submission.txt) created in the current folder"
* pre-conditions/error conditions:
   folder **UCI HAR Dataset** should exist in the current directory
   following files should exist in the above menrtioned directory
   * features.txt  -- measurement features master list file
   * activity_labels.txt  -- activities master list file
   * test/subject_test.txt -- list of subjects in test phase 
   * test/X_test.txt  -- list various measurements 
   * test/y_test.txt  -- list of activities
   * train/subject_train.txt  -- list of subjects in training phase
   * train/X_train.txt  -- list of various measurements
   * train/y_train.txt  -- list of activities
   
   * file named **tidydata_submission.txt** should not exist in the current working directory

   if pre-conditions are not met then the processing stops with appropriate error message
   
