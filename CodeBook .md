The run_analysis.R script prepares the data for furthur analysis and the following steps describes the same. 

==================================================================
1.Downloading the dataset
The UCI HAR Dataset downloaded from the website

==================================================================

2.Obtaining variables from the data

features <- features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

activity <- activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)

train_subjects <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed

train_x <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data

train_y <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’code labels

test_subjects <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed

test_x<- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data

test_y <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’code labels


==================================================================

3.Merging the training and the test sets to create a single data set

X is created by merging train_x and test_x using rbind() function
Y is created by merging train_y and test_y using rbind() function
Subjects is created by merging train_subjects and test_subjects using rbind() function
data is created by merging Subject, Y and X using cbind() function

==================================================================

4.Extract only the measurements on the mean and standard deviation for each measurement
tidy_datais created by subsetting dataata, selecting only columns: subject, activity and the measurements on the mean and standard deviation (std) for each measurement

==================================================================

5.Using descriptive activity names to name the activities in the data set
The numbers in the code column are replaed with the corresponding activity names

==================================================================

6.Appropriately labels the data set with descriptive variable names

Vector col_names created to operate on column names
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by FrequencyDomain_
All start with character t in column’s name replaced by TimeDomain_
All names with one,two or three '.' are replaced by removing '.'
All names with X,Y,Z denoting direction replaced with same followed by Axis 
col_names assigned as name to tidy_data

==================================================================

7. From the data set in step 4, createing a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data_avg is created by sumarizing tidy_data taking the means of each variable for each activity and each subject, after groupped by subject and activity.
finally, the data exported to the text file tidy_data_avg.txt