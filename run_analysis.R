# run_analysis.R
# I will use two packages to help me 
# to configure the data
library(dplyr)
library(tidyr)

#+-----------------------------------------------------+
#|  Building of two parcial tables, one for each set   |
#+-----------------------------------------------------+

# The following information is the same for both tables:
# activity labels:
acts <- read.table("activity_labels.txt")

# Column headers (features):
hh <- read.table("features.txt", stringsAsFactors = F)


#--------------------------------------------
# function: build_sub_table()
build_sub_table <- function (setName) {
    # This function builds a complete table for the given set from the 
    # corresponding source files.
    # setName: the name of the set whose table is been built
    # --------------
    #   I assume two sets: "test" and "train". Their data are stored
    #   in directories with the same names, and the names of the files 
    #   containing the data are constructed with these names; for instance, the 
    #   main data file is X_<setName>.txt, e.g., X_test.txt or X_train.txt
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
    # NOTE that yact is a key to the real activity names that are 
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
