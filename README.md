---
title: "README"
author: "Julio Sergio Santana"
date: "16/02/2015"
output: html_document
---
# INTRO
## Understanding the structure of the data

![Data Structure](DataStructure.jpeg)

# Requirements of the project
From the two data sets: "train" (for training), and "test", the main program  
"run_analysis.R", have to

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for  
each measurement.
3. Use descriptive activity names to name the activities in the data set.                                                      
4. Appropriately label the data set with descriptive variable names.                                                        
5. From the data set in step 4, create a second, independent tidy data  
set with the average of each variable for each activity and each subject.

# The tasks of the project
To cope with these requeriments, however, and for efficiency reasons, the project  
is divided into three main tasks, namely:

- **I. BUILDING ONE DATA SET.** This comprises steps 1, 3, and,partially, step 4  
from the requirements list, because having appropriately labeled the columns  
(variables) of the data set, greatly helps to extract the information asked for  
in step 2. The names of the variables, however, will suffer a further change in  
task III, just to have column names that comply with R variable standard names.
- **II. EXTRACTION OF THE MEASUREMENTS ON THE MEAN AND STANDARD  
DEVIATION FOR EACH MEASUREMENT.** This is step 2 from the requirements  
list. Here, the given variable names are used to perform this operation.
- **III. CREATION OF A SECOND, INDEPENDENT TIDY DATA SET WITH THE  
AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.**  
This is step 5 from the previous list, but, as noted before, a further tranformation  
in the names of the variables (step 4 of the requirements list) is performed  
here in order to adequately specify the colum names as standard R variable  
names.

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```r
summary(cars)
```

You can also embed plots, for example:

```r
if (something) {
    plot(cars)
}
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
