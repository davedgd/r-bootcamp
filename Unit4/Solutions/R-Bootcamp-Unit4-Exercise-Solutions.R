# +++++++++++++++++++++++++
# +++ R BOOTCAMP UNIT 4 +++
# +++     SOLUTIONS     +++
# +++++++++++++++++++++++++
# + AUTHOR: David Dobolyi +
# +++++++++++++++++++++++++

# ---------
# Run First
# ---------

setwd("...")

# ----------
# Exercise 1
# ----------

# Read in the data file "ExerciseData1.txt" in R-Bootcamp-Unit4-Data.zip and store it in an object called ExDat1. Show the structure, head, and dimensions of the data to verify you imported it correctly. HINT: the correct dimensions are six rows by five columns.

ExDat1 <- read.table("ExerciseData1.txt", header = TRUE, sep = ",") # option a
ExDat1 <- read.csv("ExerciseData1.txt") # option b

str(ExDat1)
head(ExDat1)
dim(ExDat1)

# ----------
# Exercise 2
# ----------

# Read in the data file "ExerciseData2.txt" in R-Bootcamp-Unit4-Data.zip and store it in an object called ExDat2. Show the structure, head, and dimensions of the data to verify you imported it correctly. HINT: make sure you have accounted for the correct separator in this data file.

ExDat2 <- read.table("ExerciseData2.txt", header = TRUE, sep = "\t") # option a
ExDat2 <- read.delim("ExerciseData2.txt") # option b

str(ExDat2)
head(ExDat2)
dim(ExDat2)

# ----------
# Exercise 3
# ----------

# Use the identical function (i.e., see ?identical) to show ExDat1 and ExDat2 are identical (if they are not, amend your data import code accordingly).

identical(ExDat1, ExDat2)

# ----------
# Exercise 4
# ----------

# Read in the data file "ExerciseData3.txt" in R-Bootcamp-Unit4-Data.zip and store it in an object called ExDat3. Show the structure, head, and dimensions of the data to verify you imported it correctly. HINT: make sure you have accounted for the quoting characters in this data file.

ExDat3 <- read.table("ExerciseData3.txt", header = TRUE, sep = ",", quote = "`", skip = 2) # option a
ExDat3 <- read.csv("ExerciseData3.txt", quote = "`", skip = 2) # option b

str(ExDat3)
head(ExDat3)
dim(ExDat3)

# Note that if you opened "ExerciseData3.txt" in a text editor as suggested in Unit 4, you would have found the following hint to help with reading in the data:

# Some data files occasionally (and awkwardly) put a text description at the top, which will cause a problem when reading them into R. See the skip argument of read.table for a solution to this problem. In addition, be sure to use the correct quote specification for reading this file, since this one happens to be using backticks for strings.

# ----------
# Exercise 5
# ----------

# Use the identical function to show ExDat1 and ExDat3 are identical (if they are not, amend your data import code accordingly).

identical(ExDat1, ExDat3)
