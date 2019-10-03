library(dplyr)
library(tidyr)
library(rex)

## Read all the '.txt' files as a table

features <-       read.table("UCI HAR Dataset/features.txt",col.names= c("S.no","feature_name"), check.names=FALSE)
activity <-       read.table("UCI HAR Dataset/activity_labels.txt",col.names= c("S.no","Activity"))
train_subjects <- read.table("UCI HAR Dataset/train/Subject_train.txt",col.names= "Subject")
train_x <-        read.table("UCI HAR Dataset/train/X_train.txt",col.names= features$feature_name,)
train_y <-        read.table("UCI HAR Dataset/train/Y_train.txt",col.names= "Activity")
test_subjects <-  read.table("UCI HAR Dataset/test/Subject_test.txt",col.names= "Subject")
test_x <-         read.table("UCI HAR Dataset/test/X_test.txt",col.names= features$feature_name, )
test_y <-         read.table("UCI HAR Dataset/test/Y_test.txt",col.names= "Activity")

##Merge the Data
X <- rbind(train_x,test_x)
Y <- rbind(train_y,test_y)
Subjects <- rbind(train_subjects,test_subjects)
data <- cbind(Subjects,Y,X)
tidy_data <- select(data,Subject,Activity,contains("mean"),contains("std"))
tidy_data$Activity <- activity[tidy_data$Activity,2]
print(tidy_data$Activity)
## Assign the column names of data to col_names to label them appropriately
col_names <- names(tidy_data)
col_names <- gsub("Acc","Acceleration",col_names)
col_names <- gsub("Gyro","Gyroscope",col_names)
col_names <- gsub("Mag","Magnitude",col_names)
col_names <- gsub("BodyBody","Body",col_names)
col_names <- gsub("^t","TimeDomain_",col_names)
col_names <- gsub("freq","Frequency",col_names, ignore.case = TRUE)
col_names <- gsub("^f","FrequencyDomain_",col_names)
col_names <- gsub("mean","Mean",col_names, )
col_names <- gsub("std","STD_Deviation",col_names)
col_names <- gsub("\\.|\\.\\.|\\.\\.\\.","",col_names)
col_names <- gsub("X","-XAxis",col_names)
col_names <- gsub("Y","-YAxis",col_names)
col_names <- gsub("Z","-ZAxis",col_names)
col_names <- gsub("angle","Angle",col_names)
col_names <- gsub("gravity","Gravity",col_names)

#Assigning the updated names to the table
names(tidy_data) <- col_names

#Grouping the data by subjects and then activity using Chain operations
tidy_data_avg <- tidy_data %>% group_by(Subject, Activity) %>% summarize_all(funs(mean))


## the data into text file
##we do not need to give row names. Hence, row.name= FALSE
  write.table(tidy_data_avg,"tidy_data_avg.txt",row.name=FALSE)
