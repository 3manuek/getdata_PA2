
progAssignment <- function() {

	library(dplyr)

	# Configuration section (paths)
	HAR_dataset 		<- "UCI HAR Dataset"
	setwd(HAR_dataset)
	working_dirs 		<- c("test/", "train/")
	test_dir 			<- file.path(working_dirs[1], "/")
	train_dir 			<- file.path(working_dirs[2], "/")

	# Functions
	# Step 4 function
	trim <- function (x) gsub("\\s+|\\(|\\)|\\-|\\,", "", x)

	# ... and Step 4 ;)
	colnames <- trim(read.csv("features.txt", row.names = NULL, header = FALSE, sep =" ")[,2])


	testDataSet <- read.table(file.path(test_dir, "X_test.txt"), row.names = NULL, header = FALSE,
	                    col.names = colnames)

	# Step 1
	# rbind Train with the testDataSet
	dataset <- rbind(testDataSet, read.table(file.path(train_dir, "X_train.txt"), 
	                                         row.names = NULL, header = FALSE,
	                                         col.names = colnames))

	datasetmean  <- select(dataset, ends_with("mean"))
	datasetstd   <- select(dataset, ends_with("std"))

	# Step 2 
	step2 <- cbind(datasetmean,datasetstd)

	testActivities   <- read.csv(file.path(test_dir, "y_test.txt"), header= FALSE , col.names = "Activity")
	trainActivities  <- read.csv(file.path(train_dir, "y_train.txt"), header= FALSE , col.names = "Activity")
	allActivities    <- rbind(testActivities,trainActivities)
	labelss <- read.csv("activity_labels.txt", header = FALSE, row.names = NULL, sep = " ", col.names = c("Activity", "Label"))

	# Step 3
	step3 <- mutate(step2, Activity = (left_join(allActivities,labelss, by="Activity")[,2]))

	# Step 5
	testSubject  <- read.csv(file.path(test_dir, "subject_test.txt"), header = FALSE , col.names = "Subject")
	trainSubject <- read.csv(file.path(train_dir, "subject_train.txt"), header = FALSE , col.names = "Subject")
	allSubjects  <- rbind(testSubject, trainSubject)


	preStep5 <- cbind(step3, allSubjects)

	step5 <- aggregate(preStep5[,1:24], preStep5[,25:26], FUN=mean)
	write.table(step5, file ="step5.txt", row.name = FALSE)

	setwd("..")

	# Return:
	dataset

}


