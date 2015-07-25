# Programming assignment 2 - Cleaning Data (coursera)


run_analysis.R does:

    - Merges the training and the test sets to create one data set.
    - Extracts only the measurements on the mean and standard deviation for each measurement. 
    - Uses descriptive activity names to name the activities in the data set
    - Appropriately labels the data set with descriptive variable names. 
    - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Returns:
    Dataset (Step 1)
    "step5.txt" as a text file.

How to execute:

> source("run_analysis.R")
>
> progAssignment()


How it works:

	- Step one is done by simple rbind
	- Step two is done using select and cbind. At this point, Step 4 is been done
	  using the custom "trim" function at the beginning of teh code.
	- Step three it's a bit tricky, but basically is done by the line:
	  step3 <- mutate(step2, Activity = (left_join(allActivities,labelss, by="Activity")[,2]))
	- Step 5 is just one aggregate, with the following:
		preStep5 <- cbind(step3, allSubjects)
		step5 <- aggregate(preStep5[,1:24], preStep5[,25:26], FUN=mean)
		write.table(step5, file ="step5.txt", row.name = FALSE)


CodeBook:

	The configuration section, is made at this way cause I though at the first time, to iterate 
	the dirs. That is, in case if you want to add an extra set. I didn't have enough time to 
	do it at this way :S 

	HAR_dataset  : Location of the UCI data	
	working_dirs : Which directories are we going to parse.	
	test_dir 	 : Test dir		
	train_dir 	 : Tran dir 	

# Links

Article about wereable technology:
http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/

Data Set descrition (Samsung Galaxy S) 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data Set:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

