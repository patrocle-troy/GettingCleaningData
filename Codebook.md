# Codebook: Human Activity Recognition Using Smartphones Data Set
## Study design

The tidy dataset attached summarizes some metrics captured by sensors put on 30 volunteers. Measures were taken when the person performed any of one of the six main activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). 

The source data set is presented in [Human Activity Recognition database][1] The dataset can be downloadable as a [zip file][2]. It contains several datafiles, including the README.txt files that presents the datafiles.

[1]:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
[2]:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Description of the data
List of the variables and the units.

1. "activity": WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING            

2. "subject": Volunteer id (1-30)                    

All the remaining data (features) are normalized and bounded within [-1,1]. This explains that some standard deviation can be negative.
For each measure, we provide the mean measurement first and then the standard deviation.

3. "tBodyAcc-mean()-X"          

4. "tBodyAcc-mean()-Y"          

5. "tBodyAcc-mean()-Z"          

6. "tGravityAcc-mean()-X"       

7. "tGravityAcc-mean()-Y"       

8. "tGravityAcc-mean()-Z"       

9. "tBodyAccJerk-mean()-X"      

10. "tBodyAccJerk-mean()-Y"      

11. "tBodyAccJerk-mean()-Z"      

12. "tBodyGyro-mean()-X"         

13. "tBodyGyro-mean()-Y"         

14. "tBodyGyro-mean()-Z"         

15. "tBodyGyroJerk-mean()-X"     

16. "tBodyGyroJerk-mean()-Y"     

17. "tBodyGyroJerk-mean()-Z"     

18. "tBodyAccMag-mean()"         

19. "tGravityAccMag-mean()"      

20. "tBodyAccJerkMag-mean()"     

21. "tBodyGyroMag-mean()"        

22. "tBodyGyroJerkMag-mean()"    

23. "fBodyAcc-mean()-X"          

24. "fBodyAcc-mean()-Y"          

25. "fBodyAcc-mean()-Z"          

26. "fBodyAccJerk-mean()-X"      

27. "fBodyAccJerk-mean()-Y"      

28. "fBodyAccJerk-mean()-Z"      

29. "fBodyGyro-mean()-X"         

30. "fBodyGyro-mean()-Y"         

31. "fBodyGyro-mean()-Z"         

32. "fBodyAccMag-mean()"         

33. "fBodyBodyAccJerkMag-mean()" 

34. "fBodyBodyGyroMag-mean()"    

35. "fBodyBodyGyroJerkMag-mean()"

36. "tBodyAcc-std()-X"           

37. "tBodyAcc-std()-Y"           

38. "tBodyAcc-std()-Z"           

39. "tGravityAcc-std()-X"        

40. "tGravityAcc-std()-Y"        

41. "tGravityAcc-std()-Z"        

42. "tBodyAccJerk-std()-X"       

43. "tBodyAccJerk-std()-Y"       

44. "tBodyAccJerk-std()-Z"       

45. "tBodyGyro-std()-X"          

46. "tBodyGyro-std()-Y"          

47. "tBodyGyro-std()-Z"          

48. "tBodyGyroJerk-std()-X"      

49. "tBodyGyroJerk-std()-Y"      

50. "tBodyGyroJerk-std()-Z"      

51. "tBodyAccMag-std()"          

52. "tGravityAccMag-std()"       

53. "tBodyAccJerkMag-std()"      

54. "tBodyGyroMag-std()"         

55. "tBodyGyroJerkMag-std()"     

56. "fBodyAcc-std()-X"           

57. "fBodyAcc-std()-Y"           

58. "fBodyAcc-std()-Z"           

59. "fBodyAccJerk-std()-X"       

60. "fBodyAccJerk-std()-Y"       

61. "fBodyAccJerk-std()-Z"       

62. "fBodyGyro-std()-X"          

63. "fBodyGyro-std()-Y"          

64. "fBodyGyro-std()-Z"          

65. "fBodyAccMag-std()"          

66. "fBodyBodyAccJerkMag-std()"  

67. "fBodyBodyGyroMag-std()"     

68. "fBodyBodyGyroJerkMag-std()"

## Transformation of the data

#### Retrieve the datasets

```r
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
```

#### Merges the training and the test sets to create one data set and add subjects and activities


```r
dtrain<-cbind(dstrain,dytrain,dxtrain)
dtest<-cbind(dstest,dytest,dxtest)
d<-rbind(dtrain,dtest)
dnames<-c('subject','activity',as.character(dfeat$V2))
colnames(d)<-dnames
```

#### Extracts only the measurements on the mean and standard deviation for each measurement. 

```r
dnames0<-c('activity','subject')
dnames1<-dnames[setdiff(grep('mean()',dnames),grep('meanFreq()',dnames))]
dnames2<-dnames[grep('std()',dnames)]
df<-d[,c(dnames0,dnames1,dnames2)]
df$activity<-dactlabel[df$activity,'V2']
```

#### Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

```r
dtidy<-aggregate(df[,-1:-2],by=list(df$activity,df$subject),mean)
colnames(dtidy)[1:2]<-colnames(df)[1:2]
filename<-'GetCleanData_Project_tidyData.txt'
write.table(dtidy,file=filename)
```

