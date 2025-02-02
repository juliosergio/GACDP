---
title: "README"
author: "Julio Sergio Santana"
date: "16/02/2015"
output: html_document
---
# INTRO
This document describes the main ideas behind the creation of the main  
program **run_analysis.R** which satisfies the requirements of the  
Getting and Cleaning Data Course Project.

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
Since the structure of the information in each set is similar, I will deal with  
each set, in one and the same way, with the &lt;setName&gt; as a parameter.  
Thus, taking any of the two data sets, there are as many as five files,  
that can be viewed as tables: two at the "data" directory level, and three  
at the &lt;setName&gt; directory level (see Fig. 1), as follows:

1. **activity_labels.txt**. At the "data" directory level. This can be viewed  
as two column table: the first column is a sequence of integer numbers   
starting with 1, and the second is the label of one of the six possible  
activities, like: WALKING, STANDING, etc.
2. **features.txt**. At the "data" directory level. This can be viewed  
as two column table: the first column is a sequence of integer numbers   
starting with 1, and the second is the identifier of one of the 561 measured  
features.
3. **subject_&lt;setName&gt;.txt**. At the &lt;setName&gt; directory level.  
This is a single column table, with series of repeated integer numbers  
(between 1 and 30). The number of rows of this table varies from data set  
to data set, though it matches the number of rows of the X_&lt;setName&gt;.txt  
and the y_&lt;setName&gt;.txt tables (see below). Each one of the numbers in  
this table identifies one of the individuals subjected to the measurements.
4. **y_&lt;setName&gt;.txt**. At the &lt;setName&gt; directory level.  
This is a single column table, with repeated integer numbers (between 1  
and 6). The number of rows of this table varies from data set  
to data set, though it matches the number of rows of the X_&lt;setName&gt;.txt  
and the subject_&lt;setName&gt;.txt tables. Each one of the numbers in  
this table is an index to the activity_labels.txt table, and then identifies  
one of the activities the subject is performing in a given observation.
5. **X_&lt;setName&gt;.txt**. At the &lt;setName&gt; directory level.  
This is a table, with 561 columns (Note the coincidence with the number  
of rows of the features.txt table). The number of rows of this table  
varies from data set to data set, though it matches the number of rows of  
the y_&lt;setName&gt;.txt and the subject_&lt;setName&gt;.txt tables.  
This is the main data table, and so, its entries, real numbers, represent  
the "observed" measurements.

According to the previous description, it can be concluded that the  
structure of the data, for each data set, is similar to the one  
depicted in Fig. 2.


**Figure 2.** Structure of the data overview

![Data Structure](DataStructure.jpeg)

From this figure it can be viewed that the columns of the **X_&lt;setName&gt;.txt**  
table can be named according to the feature descriptions given in the **features.txt**  
table. Furthermore, the data lacks two columns: one for the individuals which will be   
taken from the **subject_&lt;setName&gt;.txt** table, and the other for the activities,   
each one of them performed, which will be taken in combination from tables   
**y_&lt;setName&gt;.txt** and **activity_labels.txt**.

The previous description is the key to build one similar table for each data set.  
Since, the columns of both tables agree, gluing them together in a single table  
is easy.

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

# I. BUILDING ONE DATA SET

The strategy to build this set is to build two separate sets, one for each data set from the  
given tables (files), according to the principles given in section Understanding the Structure  
of the Data, above. The function "build_sub_table(setName)" is devoted to this purpose, and its  
main directions are given in the following paragraphs.

Once the appropriate directories are traversed to locate the information, the column names  
are assigned to the X main table (see Fig. 2) as follows:
```r
    names(Xf) <- hh[[2]]
```
where, `Xf` is the table built from the **X_&lt;setName&gt;.txt** file, and `hh` is the  
table built from the **features.txt** file. 

Then the columns for the individuals and activities are added to the table as follows:
```r
    cbind(
        subject=subj[[1]], 
        activity=acts[[2]][yact[[1]]],
        Xf
    )
```
where `subj` is a table that comes from the **subject_&lt;setName&gt;.txt** file, `yact`  
is a table built from the **y_&lt;setName&gt;.txt** file, so containing activities indices,  
and `acts` is a key-value table built from the **activity_labels.txt** file.

To produce each table is simply to call the function with de appropriate set name:
```r
test_tbl <- build_sub_table("test")
train_tbl <- build_sub_table("train")
```

To have both tables merged, is simply to put each as a row of a bigger table. Since I'm  
using the "dplyr" package this is done as follows:
```r
TotalTbl <- bind_rows(
                train_tbl, 
                test_tbl
            )
```

# II. EXTRACTION OF THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT

Here, I interpreted this as "those measurements to which it is applied either of two  
statistical functions: mean() or std()", which are clearly distinguished in the features  
names, because they explicitly include the string "mean()" or the string "std()". It have  
to be noted that the names of the columns coincide with the names of the features up to this  
point. So, from the complete set only those columns containing "mean()" or "std()" must be   
selected.

Since, I'm using the "dplyr" package, I coded this in the following way:
```r
IntTbl <-
    TotalTbl %>%
    select(
        subject,  # this two columns ought to be here
        activity, #
        # to include columns with "mean()"  or "std()" 
        # I will use the 
        # regular expression matching, as follows:
        matches("(mean\\(\\))|(std\\(\\))")
    ) %>% 
```
Take note that the right regular expression to do the task is `"(mean\\(\\))|(std\\(\\))"`,  
and not `"(mean())|(std())"`, because using the latter, picks expressions that doesn't   
contain the parentheses. Remember that bare parenthesis are metacharacters, and then, for   
instance, the meaning of the "mean()" is "mean" followed by nothing.


Additionally, the resulting table is ordered according first to "activity" and  
then to "subject", and this is done with this additional code to the previous one:
```r
    arrange(activity, subject) # first activity and then subject
```

# III. CREATION OF A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT

Prior to this task, I modified the column names so that they comply with standard R  
variable names. This is more than a "lexical sugar", since it allows the use of  
these new names to do more operations, for instance when using the "mutate" verb  
(function) of the "dplyr" package.

The change is simple: replacing the dash ("-"), with underline ("_"), and eliminating the  
parentheses. This is done by using regular expressions as follows:
```r
newNames <-
    gsub("-","_",             # Changes "-" to "_" (globally)
         sub("\\(\\)", "",    # Changes "()" to "" 
             names(IntTbl)))  # The column names
# Let's set these names as the new ones:
names(IntTbl) <- newNames
```

Using the "dplyr" package facilities, computing the average for each variable upon the whole  
data set grouped by activity and then by subject, is done as follows:
```r
finalTbl <- IntTbl %>% 
    group_by(activity, subject) %>%
    summarise_each(funs(mean))
```
Here, the `summarise_each(funs(mean))` call applies the function "mean" to each of the  
columns of a given table. However, note here, that the mean function is applied  
by the previously stated group: (activity, subject).

# Project results
The results of this project are given in the "SummaryTable.txt", which is produced with  
the following code:
```r
write.table(finalTbl, "SummaryTable.txt", row.name=FALSE)
```
The table can be reloaded into a R data frame as follows:
```r
SummaryTable <- read.table("SummaryTable.txt", header=TRUE)
```
The columns of this table are described in the **Code_Book.md** document.