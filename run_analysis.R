


# url<-'http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# data details (from README)
# 'features.txt': List of all features.
# 'activity_labels.txt': Links the class labels with their activity name.
# 'train/X_train.txt': Training set.
# 'train/y_train.txt': Training labels.
# 'test/X_test.txt': Test set.
# 'test/y_test.txt': Test labels.

# Retrieves data

folder<-'C:/Temp/data/UCI HAR Dataset'
fileraw<-'/features.txt'
file<-paste0(folder,fileraw)
dfeat<-read.table(file)
fileraw<-'/train/X_train.txt'
file<-paste0(folder,fileraw)
dxtrain<-read.table(file)
fileraw<-'/train/y_train.txt'
file<-paste0(folder,fileraw)
dytrain<-read.table(file)
fileraw<-'/train/subject_train.txt'
file<-paste0(folder,fileraw)
dstrain<-read.table(file)
folder<-'C:/Temp/data/UCI HAR Dataset'
fileraw<-'/test/X_test.txt'
file<-paste0(folder,fileraw)
dxtest<-read.table(file)
fileraw<-'/test/y_test.txt'
file<-paste0(folder,fileraw)
dytest<-read.table(file)
fileraw<-'/test/subject_test.txt'
file<-paste0(folder,fileraw)
dstest<-read.table(file)
fileraw<-'/activity_labels.txt'
file<-paste0(folder,fileraw)
dactlabel<-read.table(file)

# Merges the training and the test sets to create one data set.
# add subjects and activities
dtrain<-cbind(dstrain,dytrain,dxtrain)
dtest<-cbind(dstest,dytest,dxtest)
# merge training and testing sets
d<-rbind(dtrain,dtest)
#rm(dtrain,dxtrain,dytrain,dstrain)
#rm(dtest,dxtest,dytest,dstest)
# add names
dnames<-c('subject','activity',as.character(dfeat$V2))
colnames(d)<-dnames

# Add subject and activity
# Extracts only the measurements on the mean and standard deviation for each measurement. 
dnames0<-c('activity','subject')
dnames1<-dnames[setdiff(grep('mean()',dnames),grep('meanFreq()',dnames))]
dnames2<-dnames[grep('std()',dnames)]
df<-d[,c(dnames0,dnames1,dnames2)]
#rm(d)

# Uses descriptive activity names to name the activities in the data set
df$activity<-dactlabel[df$activity,'V2']

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each dimsubject.
dtidy<-aggregate(df[,-1:-2],by=list(df$activity,df$subject),mean)
colnames(dtidy)[1:2]<-colnames(df)[1:2]
filename<-'GetCleanData_Project_tidyData.txt'
write.table(dtidy,file=filename,row.names=FALSE)


