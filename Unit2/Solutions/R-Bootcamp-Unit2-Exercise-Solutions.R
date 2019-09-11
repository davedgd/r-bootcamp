# +++++++++++++++++++++++++
# +++ R BOOTCAMP UNIT 2 +++
# +++     SOLUTIONS     +++
# +++++++++++++++++++++++++
# + AUTHOR: David Dobolyi +
# +++++++++++++++++++++++++

# ---------
# Run First
# ---------

# Run the following code before completing the exercises below:

varA <- 3.3
varB <- "hello there"
varC <- FALSE
varD <- 5L
varE <- 5
varF <- varD + varE
varG <- 2 * varC

# ----------
# Exercise 1
# ----------

# Show the data type for each of the variables above using the typeof, class, or str function(s).

typeof(varA) # numeric
typeof(varB) # character
typeof(varC) # logical
typeof(varD) # integer
typeof(varE) # numeric
typeof(varF) # numeric
typeof(varG) # numeric

# ----------
# Exercise 2
# ----------

# Using a comment, explain why the first comparison below returns TRUE whereas the second one returns FALSE:

varD == varE
typeof(varD) == typeof(varE)

# In terms of value, varD and varE are equivalent, but in terms of type, they are not (i.e., one is integer while the other is numeric).

# ----------
# Exercise 3
# ----------

# Using a comment, explain why the comparison below returns TRUE:

FALSE == 0

# The logical FALSE has a numeric value equal to 0.

# ----------
# Exercise 4
# ----------
 
# Use an "as" function to convert varE to the integer data type and assign it to a new variable called varE_int in a single command.

varE_int <- as.integer(varE)

# ----------
# Exercise 5
# ----------

# Use a function to convert varB to all uppercase characters and assign it to a new variable called varB.allUpper in a single command.

varB.allUpper <- toupper(varB)

# ----------
# Exercise 6
# ----------

# Using a comment, explain why calling VarA (as opposed to varA) returns an error:

varA
VarA

# R variable names are case sensitive; varA was defined earlier, but VarA was not.
