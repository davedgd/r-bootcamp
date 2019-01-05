# +++++++++++++++++++++++++
# +++ R BOOTCAMP UNIT 3 +++
# +++     EXERCISES     +++
# +++++++++++++++++++++++++
# + AUTHOR: David Dobolyi +
# +++++++++++++++++++++++++

# ----------
# Exercise 1
# ----------

# Create the following vector objects:

# A) exVec1 containing the following numbers: 3, 10, -5, 4, 8
# B) exVec2 containing the following numbers: 5, -6, NA, 3, 11
# C) exVec3 containing a sequence from -5 to 5 by steps of 0.5 (e.g., -5.0, -4.5, -4.0, and so on to positive 5.0)

# ----------
# Exercise 2
# ----------

# Add together vectors exVec1 and exVec2 and store these in a new vector object called exVecResult using a single command.

# ----------
# Exercise 3
# ----------

# Use bracket notation to: 

# A) return the 3rd value inside vector exVec1
# B) return all but the 2nd and 3rd values in the exVec2

# ----------
# Exercise 4
# ----------

# Use functions and/or relational operators to:

# A) show the length of each of the three vectors created above
# B) find the sum of the vector exVec1 (i.e., see ?sum)
# C) find the mean of the vector exVec2 using the mean function (HINT: see the na.rm argument of the mean function)
# D) calculate the mean of exVec2 again using the sum, length, and na.omit functions
# E) show that the calculations in C and D are equivalent/identical
 
# ----------
# Exercise 5
# ----------
 
# Use the data function to load the built-in mtcars data set (see ?data):

data(mtcars)

# Once you have loaded mtcars, use the command ?mtcars to see more information about this data set.

# ----------
# Exercise 6
# ----------

# Use functions to show:

# A) the structure of the data set
# B) the number of rows and number of columns in the data set
# C) the names of the columns in the data set
# D) the head of the data set
# E) the tail of the data set
# F) the sum of the column named hp
# G) the mean of the column named mpg rounded to 2 decimal places (HINT: see ?round)
# H) a frequency table showing the counts of the values in the column named vs
 
# ----------
# Exercise 7
# ----------

# Factor the column am within the mtcars data set and verify this change by showing the structure of the data set with the change in place.

# ----------
# Exercise 8
# ----------

# Working with the mtcars data.frame:

# A) show only the cyl, vs, and am columns
# B) show the disp, hp, and mpg values for the 3rd and 6th rows (i.e., Datsun 710 and Valiant)
# C) change the wt value for the 2nd row to NA within the mtcars data set