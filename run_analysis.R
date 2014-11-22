setwd("C:/Users/dd/Documents") 
training = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE) 
training[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE) 
training[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE) 
testing = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE) 


testing[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE) 
testing[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE) 


activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE) 


# Read and make the feature names suited for R with substitutions 

features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE) 
features[,2] = gsub('-mean', 'Mean', features[,2]) 
features[,2] = gsub('-std', 'Std', features[,2]) 
features[,2] = gsub('[-()]', '', features[,2]) 

# Merge dat sets together 

allData = rbind(training, testing) 

# Get only the data on mean and std. dev. 

colsWeWant <- grep(".*Mean.*|.*Std.*", features[,2]) 

# Reduce the features table as per requirement 

features <- features[colsWeWant,] 

# Add the last two columns

colsWeWant <- c(colsWeWant, 562, 563) 

# Remove the unwanted columns

allData <- allData[,colsWeWant] 

# Add column names 

colnames(allData) <- c(features$V2, "Activity", "Subject") 

colnames(allData) <- tolower(colnames(allData)) 

currentActivity = 1 

for (currentActivityLabel in activityLabels$V2) { 

  allData$activity <- gsub(currentActivity, currentActivityLabel, allData$activity) 

  currentActivity <- currentActivity + 1 
} 

allData$activity <- as.factor(allData$activity) 

allData$subject <- as.factor(allData$subject) 

tidy = aggregate(allData, by=list(activity = allData$activity, subject=allData$subject), mean) 

# Remove column with a mean value 

tidy[,90] = NULL 
tidy[,89] = NULL 

write.table(tidy, "tidy.txt", sep="\t") 
