---
title: "Code Book"
author: "Julio Sergio Santana"
date: "19/02/2015"
output: html_document
---

This text describes each variable (column) of the resulting data set of the Getting and Cleaning Data Course Project. This data set is produced running the main program "run_analysis" from the R console:

```r
source("run_analysis.R")
```
to get as a result the file "SummaryTable.txt", which, in turn, can be reloaded into R, as follows:

```r
SummaryTable <- read.table("SummaryTable.txt", header=TRUE)
```
The variables are as follows:

1. **activity**. The activities each person performed: WALKING, WALKING_UPSTAIRS,  
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.                                     
2. **subject**. Person id: 1,2, ..., 30.
3. **tBodyAcc_mean_X, tBodyAcc_mean_Y, tBodyAcc_mean_Z**. The three components  
of the average of the mean of body acceleration signals in the time domain.
4. **tBodyAcc_std_X, tBodyAcc_std_Y, tBodyAcc_std_Z**. The three components of  
the average of the standard deviation of body acceleration signals in the time  
domain.
5. **tGravityAcc_mean_X, tGravityAcc_mean_Y, tGravityAcc_mean_Z**. The three  
components of the average of the mean of gravity acceleration signals in the  
time domain.
6. **tGravityAcc_std_X, tGravityAcc_std_Y, tGravityAcc_std_Z**. The three  
components of the average of the standard deviation of gravity acceleration  
signals in the time domain.
7. **tBodyAccJerk_mean_X, tBodyAccJerk_mean_Y, tBodyAccJerk_mean_Z**. The three  
components of the average of the mean of body linear acceleration jerk signals  
in the time domain.
8. **tBodyAccJerk_std_X, tBodyAccJerk_std_Y, tBodyAccJerk_std_Z**. The three  
components of the average of the standard deviation of body linear acceleration  
jerk signals in the time domain.
9. **tBodyGyro_mean_X, tBodyGyro_mean_Y, tBodyGyro_mean_Z**. The three  
components of the average of the mean of body angular velocity signals  
in the time domain.
10. **tBodyGyro_std_X, tBodyGyro_std_Y, tBodyGyro_std_Z**. The three  
components of the average of the standard deviation of body angular velocity  
signals in the time domain.
11. **tBodyGyroJerk_mean_X, tBodyGyroJerk_mean_Y, tBodyGyroJerk_mean_Z**. The three  
components of the average of the mean of body angular velocity jerk signals  
in the time domain.
12. **tBodyGyroJerk_std_X, tBodyGyroJerk_std_Y, tBodyGyroJerk_std_Z**. The three  
components of the average of the standard deviation of body angular velocity  
jerk signals in the time domain.
13. **tBodyAccMag_mean**. Average of the Euclidean norm of the mean of  
body acceleration signals in the time domain.
14. **tBodyAccMag_std**. Average of the Euclidean norm of the standard  
deviation of body acceleration signals in the time domain.
15. **tGravityAccMag_mean**. Average of the Euclidean norm of the mean of   
gravity acceleration signals in the time domain.
16. **tGravityAccMag_std**. Average of the Euclidean norm of the standard  
deviation of gravity acceleration signals in the time domain.
17. **tBodyAccJerkMag_mean**. Average of the Euclidean norm of the mean of  
body linear acceleration jerk signals in the time domain.
18. **tBodyAccJerkMag_std**. Average of the Euclidean norm of the standard  
deviation of body linear acceleration jerk signals in the time domain.
19. **tBodyGyroMag_mean**. Average of the Euclidean norm of the mean of body  
angular velocity signals in the time domain.
20. **tBodyGyroMag_std**. Average of the Euclidean norm of the standard  
deviation of body angular velocity signals in the time domain.
21. **tBodyGyroJerkMag_mean**. Average of the Euclidean norm of the mean of  
body angular velocity jerk signals in the time domain.
22. **tBodyGyroJerkMag_std**. Average of the Euclidean norm of the standard  
deviation of body angular velocity jerk signals in the time domain.
23. **fBodyAcc_mean_X, fBodyAcc_mean_Y, fBodyAcc_mean_Z**. The three components  
of the average of the mean of body acceleration signals in the frequency domain.
24. **fBodyAcc_std_X, fBodyAcc_std_Y, fBodyAcc_std_Z**. The three components of  
the average of the standard deviation of body acceleration signals in the frequency  
domain.
25. **fBodyAccJerk_mean_X, fBodyAccJerk_mean_Y, fBodyAccJerk_mean_Z**. The three  
components of the average of the mean of body linear acceleration jerk signals  
in the frequency domain.
26. **fBodyAccJerk_std_X, fBodyAccJerk_std_Y, fBodyAccJerk_std_Z**. The three  
components of the average of the standard deviation of body linear acceleration  
jerk signals in the frequency domain.
27. **fBodyGyro_mean_X, fBodyGyro_mean_Y, fBodyGyro_mean_Z**. The three  
components of the average of the mean of body angular velocity signals  
in the frequency domain.
28. **fBodyGyro_std_X, fBodyGyro_std_Y, fBodyGyro_std_Z**. The three  
components of the average of the standard deviation of body angular velocity  
signals in the frequency domain.
29. **fBodyAccMag_mean**. Average of the Euclidean norm of the mean of  
body acceleration signals in the frequency domain.
30. **fBodyAccMag_std**. Average of the Euclidean norm of the standard  
deviation of body acceleration signals in the frequency domain.
31. **fBodyAccJerkMag_mean**. Average of the Euclidean norm of the mean of  
body linear acceleration jerk signals in the frequency domain.
32. **fBodyAccJerkMag_std**. Average of the Euclidean norm of the standard  
deviation of body linear acceleration jerk signals in the frequency domain.
33. **fBodyGyroMag_mean**. Average of the Euclidean norm of the mean of body  
angular velocity signals in the frequency domain.
34. **fBodyGyroMag_std**. Average of the Euclidean norm of the standard  
deviation of body angular velocity signals in the frequency domain.
35. **fBodyGyroJerkMag_mean**. Average of the Euclidean norm of the mean of  
body angular velocity jerk signals in the frequency domain.
36. **fBodyGyroJerkMag_std**. Average of the Euclidean norm of the standard  
deviation of body angular velocity jerk signals in the frequency domain.

