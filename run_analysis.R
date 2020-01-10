library(dplyr)
# read train data
features <- read.table("UCI HAR Dataset/features.txt")
trainData <- read.table("UCI HAR Dataset/train/X_train.txt", 
                        col.names = features[,2])
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                           col.names = "subject")
trainLabels <- read.table("UCI HAR Dataset/train/y_train.txt", 
                          col.names = "labelId")

trainData <- cbind(trainSubject, trainLabels, trainData)

# read test data
testData <- read.table("UCI HAR Dataset/test/X_test.txt", 
                       col.names = features[,2])
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                          col.names = "subject")
testLabels <- read.table("UCI HAR Dataset/test/y_test.txt", 
                         col.names = "labelId")

testData <- cbind(testSubject, testLabels, testData)

# 1. Merge train and test dataset
data <- rbind(trainData, testData)

# 2. Extracts only the measurements on the mean and standard deviation for each 
# measurement
dataMeanStd <- data[,c(1,2,grep(pattern = "[Mm]ean|[Ss]td", names(data)))]


# 3. Uses descriptive activity names to name the activities in the data set
labelNames <- read.table("UCI HAR Dataset/activity_labels.txt", 
                         col.names = c("labelId", "activity"))
dataMeanStd <- merge(dataMeanStd, labelNames, by = "labelId")
dataMeanStd$labelId <- NULL

# 4. Appropriately labels the data set with descriptive variable names.
# already done while reading in the train and test data
names(dataMeanStd)

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
dataMeans <- dataMeanStd %>% group_by(subject, activity) %>% summarise_all(list(mean))

write.table(dataMeans, "result.txt", row.names = FALSE)
