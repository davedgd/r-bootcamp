# +++++++++++++++++++++++++
# +++ R BOOTCAMP UNIT 3 +++
# +++     SOLUTIONS     +++
# +++++++++++++++++++++++++
# + AUTHOR: David Dobolyi +
# +++++++++++++++++++++++++

# ----------
# Exercise 1
# ----------

# Create the following vector objects:

# A) exVec1 containing the following numbers: 3, 10, -5, 4, 8
exVec1 <- c(3, 10, -5, 4, 8)

# B) exVec2 containing the following numbers: 5, -6, NA, 3, 11
exVec2 <- c(5, -6, NA, 3, 11)

# C) exVec3 containing a sequence from -5 to 5 by steps of 0.5 (e.g., -5.0, -4.5, -4.0, and so on to positive 5.0)
exVec3 <- seq(-5, 5, by = .5)

# ----------
# Exercise 2
# ----------

# Add together vectors exVec1 and exVec2 and store these in a new vector object called exVecResult using a single command.

exVecResult <- exVec1 + exVec2

# ----------
# Exercise 3
# ----------

# Use bracket notation to: 

# A) return the 3rd value inside vector exVec1
exVec1[3]

# B) return all but the 2nd and 3rd values in the exVec2
exVec2[c(-2, -3)] # option a
exVec2[-c(2, 3)]  # option b

# ----------
# Exercise 4
# ----------

# Use functions and/or relational operators to:

# A) show the length of each of the three vectors created above
length(exVec1)
length(exVec2)
length(exVec3)

# B) find the sum of the vector exVec1 (i.e., see ?sum)
sum(exVec1)

# C) find the mean of the vector exVec2 using the mean function (HINT: see the na.rm argument of the mean function)
mean(exVec2, na.rm = TRUE) # option a
mean(na.omit(exVec2))      # option b

# D) calculate the mean of exVec2 again using the sum, length, and na.omit functions
sum(exVec2, na.rm = TRUE)/length(na.omit(exVec2))

sum(exVec2, na.rm = TRUE)/4 # bad/invalid solution
sum(exVec2, na.rm = TRUE)/(length(exVec2) - 1) # bad/invalid solution

# E) show that the calculations in C and D are equivalent/identical
mean(exVec2, na.rm = TRUE) == sum(exVec2, na.rm = TRUE)/length(na.omit(exVec2))          # option a
identical(mean(exVec2, na.rm = TRUE), sum(exVec2, na.rm = TRUE)/length(na.omit(exVec2))) # option b

# ----------
# Exercise 5
# ----------
 
# Use the data function to load the built-in mtcars data set (see ?data):

?data
data(mtcars)

# Once you have loaded mtcars, use the command ?mtcars to see more information about this data set.

?mtcars

# ----------
# Exercise 6
# ----------

# Use functions to show:

# A) the structure of the data set
str(mtcars)

# B) the number of rows and number of columns in the data set
dim(mtcars)  # option a

nrow(mtcars) # option b
ncol(mtcars) # option b

# C) the names of the columns in the data set
names(mtcars)    # option a
colnames(mtcars) # option b

# D) the head of the data set
head(mtcars)

# E) the tail of the data set
tail(mtcars)

# F) the sum of the column named hp
sum(mtcars$hp)      # option a
sum(mtcars[, "hp"]) # option b

# G) the mean of the column named mpg rounded to 2 decimal places (HINT: see ?round)
round(mean(mtcars$mpg), digits = 2)

# H) a frequency table showing the counts of the values in the column named vs
table(mtcars$vs) 

# ----------
# Exercise 7
# ----------

# Factor the column am within the mtcars data set and verify this change by showing the structure of the data set with the change in place.

mtcars$am <- factor(mtcars$am, levels = c(0, 1), labels = c("Automatic", "Manual")) # option a (with meaningful labels based on ?mtcars)

mtcars$am <- as.factor(mtcars$am) # option b

str(mtcars)

# ----------
# Exercise 8
# ----------

# Working with the mtcars data.frame:

# A) show only the cyl, vs, and am columns
mtcars[, c("cyl", "vs", "am")]

# B) show the disp, hp, and mpg values for the 3rd and 6th rows (i.e., Datsun 710 and Valiant)
mtcars[c(3, 6), c("disp", "hp", "mpg")]                    # option a
mtcars[c("Datsun 710", "Valiant"), c("disp", "hp", "mpg")] # option b (using rownames)

# C) change the wt value for the 2nd row to NA within the mtcars data set
mtcars$wt[2] <- NA    # option a
mtcars[2, "wt"] <- NA # option b