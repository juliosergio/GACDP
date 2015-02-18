# run_analysis.R
#+--------------------------------------------------------------------+
#|                 GETTING AND CLEANING DATA PROJECT                  |
#|                                                                    |
#| This program takes two data sets given in the directories "test"   |
#| and "train", and does the following:                               |
#|                                                                    |
#|                        REQUIREMENTS LIST                           |
#|  1. Merges the training and the test sets to create one data set.  |
#|  2. Extracts only the measurements on the mean and standard        |
#|     deviation for each measurement.                                |
#|  3. Uses descriptive activity names to name the activities in the  |
#|     data set                                                       |
#|  4. Appropriately labels the data set with descriptive variable    |
#|     names.                                                         |
#|  5. From the data set in step 4, creates a second, independent     |
#|     tidy data set with the average of each variable for each       |
#|     activity and each subject.                                     |
#|                                                                    |
#| To cope with these requeriments, however, and for efficiency       |
#| reasons, the project is divided into three main tasks, namely:     |
#|                                                                    |
#|                      ACTUAL TASKS LIST                             |
#| I. BUILDING ONE DATA SET. This comprises steps 1, 3, and,partially,|
#|    step 4 from the previous list, because having appropriately     |
#|    labeled the columns (variables) of the data set, greatly helps  |
#|    to extract the information asked for in step 2. The names of    |
#|    the variables, however, must suffer a further change in         |
#|    task III, due to particular needs of the operation there.       |
#| II. EXTRACTION OF THE MEASUREMENTS ON THE MEAN AND STANDARD        |
#|    DEVIATION FOR EACH MEASUREMENT. This is step 2 from the         |
#|    previous list.                                                  |
#| III. CREATION OF A SECOND, INDEPENDENT TIDY DATA SET WITH THE      |
#|    AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.    |
#|    This is step 5 from the previous list, but, as noted before,    |
#|    a further tranformation in the names of the variables (step 4   |
#|    of the requirements list) is performed here in order to         |
#|    adequately specify the summarization operation.                 |
#+--------------------------------------------------------------------+

# I will use two packages to help me 
# to configure the data
library(dplyr)
library(tidyr)

#+====================================================================+
#|                   I. BUILDING ONE DATA SET                         |
#+--------------------------------------------------------------------+
#| The strategy here consists in building two independent tables,     |
#| though with a similar structure: one for each data set, and then   |
#| merging them into a single one.                                    |
#+====================================================================+

#+-----------------------------------------------------+
#|  Building of two parcial tables, one for each set   |
#+-----------------------------------------------------+

#--------------
# The following information is the same for both tables:
# activity labels:
acts <- read.table("activity_labels.txt")
# from this table the descriptive activity names of the activities
# stated in step 3 of the requirements list, will be taken. 
#--------

#---------------
# Column headers (features):
hh <- read.table("features.txt", stringsAsFactors = F)
# from this table the descriptive variable names, stated in
# step 4 of the requirements list will be taken.
#--------

#--------------------------------------------
# function: build_sub_table(..)
build_sub_table <- function (setName) {
    # This function builds a complete table for the given set from the 
    # corresponding source files.
    # setName: the name of the set whose table is been built.
    # --------------
    #   I assume two sets: "test" and "train". Their data are stored
    #   in directories with the same names, and the names of the files 
    #   containing the data are constructed with these names; for instance, the 
    #   main data file is X_<setName>.txt, ie, X_test.txt or X_train.txt, for
    #   each data set.
    #---------------
    
    # the directory where the set files are:
    dir <- paste0(setName, "/")
    
    # Let's read the main data file: 
    fname <- paste0("X_", setName, ".txt")
    Xf <- read.table(paste0(dir, fname))
    # The columns of this data.frame are to be named according to the
    # elements stored in the headers table 'hh'
    names(Xf) <- hh[[2]]
    # We need to add two columns: one corresponding to the subjects 
    # (according to the file subject_<setName>.txt), and one 
    # corresponding to the activity (according to the file y_<setName>.txt,
    # and to the table 'acts'). Let's read these files
    subj <- read.table(paste0(dir,paste0("subject_", setName, ".txt")))
    yact <- read.table(paste0(dir,paste0("y_", setName, ".txt")))
    # NOTE that 'yact' is a key to the real descriptive activity names that are 
    #      registered in the 'acts' table
    # Let's build the table and give it as a data frame tbl.
    tbl_df(
        cbind(
            subject=subj[[1]], 
            activity=acts[[2]][yact[[1]]],
            Xf
        )
    )
}


#------------
# We proceed to build the tables for the two data sets:

test_tbl <- build_sub_table("test")
train_tbl <- build_sub_table("train")

#+-----------------------------------------------------+
#|  Merging of the two parcial tables into one         |
#+-----------------------------------------------------+

TotalTbl <- bind_rows(train_tbl, test_tbl)
#=======================  END OF TASK I ==============================

#+====================================================================+
#|          II.  EXTRACTION OF THE MEASUREMENTS ON THE MEAN           |
#|              AND STANDARD DEVIATION FOR EACH MEASUREMENT           |
#+--------------------------------------------------------------------+
#| The main strategy here, consists in looking for the column names   |
#| containing either the phrase "mean()" or the phrase"std()", so to  |
#| include  them in the intermediate data set. in this intermediate   |
#| data set.                                                          |
#|                                                                    |
#| Additionally, in preparation for the ending task III, I will sort  |
#| this intermediate table, according to the activity and subject     |
#| columns (variables).                                               | 
#+====================================================================+

IntTbl <-
    TotalTbl %>%
    select(
        subject,
        activity,
        # The alternative:
        #     contains("mean()"), contains("std()")  does not
        # respect the order of the columns, so I will use the
        # regular expression alternative instead, as follows:
        matches("(mean\\(\\))|(std\\(\\))")
    ) %>% 
    arrange(activity, subject) # first activity and then subject

#=======================  END OF TASK II =============================

#+====================================================================+
#|          III. CREATION OF A SECOND, INDEPENDENT TIDY DATA          |
#|                SET WITH THE AVERAGE OF EACH VARIABLE FOR           |
#|                     EACH ACTIVITY AND EACH SUBJECT                 |
#+--------------------------------------------------------------------+
#|                                                                    |
#+====================================================================+

# Since the names of the columns are not appropriate for the 'summarize'
# operation we need to change them, using regular expressions, as follows:
newNames <-
    gsub("-","_",             # Changes "-" to "_" (globally)
         sub("\\(\\)", "",    # Changes "()" to "" 
             names(IntTbl)))  # The column names
# Let's set these names as the new ones:
names(IntTbl) <- newNames

# Let's compute the average for each variable upon the whole
# data set grouped by activity and subject
finalTbl <- IntTbl %>% 
    group_by(activity, subject) %>%
    summarise_each(funs(mean))
