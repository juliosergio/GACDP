---
title: "README"
author: "Julio Sergio Santana"
date: "16/02/2015"
output: html_document
---
# INTRO
## Getting and sorting out information
At the beginning of the course we were provided with a compressed file named  
"UCI HAR Dataset.zip". I'm working in Ubuntu/Linux, so I uncompressed the  
zip file into my working directory, and then renamed the resuting directory  
as follows:
```sh
unzip "UCI HAR Dataset.zip"
mv "UCI HAR Dataset" data
mv "UCI HAR Dataset.zip" <another-location>
```
The resulting structure of the files is shown in Fig. 1, as the blue colored  
objects.

**Figure 1.** Structure of the files (a conceptual map)

![Files Structure](FilesStructure.jpg)

Also, in Fig. 1, I have defined the place for the new files resulting during  
the development of this project. These are shown as the orange colored  
objects.

## Understanding the structure of the data
As can be observed in Fig. 1, there are two directories "train" and "test", that  
correspond to the two data sets, namely: the training data set, and the test  
data set. Let's use these two directory names to identify the corresponding  
data sets. Since, both data sets have a similar structure, let's define a syntactic  
element, setName, as follows:
```
<setName> ::= "train" | "test".
```

**Figure 2.** Structure of the data overview

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
The step 3 of the requirements (using descriptive activity names) could be done  
here or as separate task. Since it is only substituting an index by a label,  
I opted for doing it here.
- **II. EXTRACTION OF THE MEASUREMENTS ON THE MEAN AND STANDARD  
DEVIATION FOR EACH MEASUREMENT.** This is step 2 from the requirements  
list. Here, the given variable names are used to perform this operation.
- **III. CREATION OF A SECOND, INDEPENDENT TIDY DATA SET WITH THE  
AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.**  
This is step 5 from the previous list, but, as noted before, a further tranformation  
in the names of the variables (step 4 of the requirements list) is performed  
here in order to adequately specify the colum names as standard R variable  
names.

