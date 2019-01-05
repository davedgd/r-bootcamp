# +++++++++++++++++++++++++
# +++ R BOOTCAMP UNIT 2 +++
# +++    PART 1 OF 2    +++
# +++     EXERCISES     +++
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

# ----------
# Exercise 2
# ----------

# Using a comment, explain why the first comparison below returns TRUE whereas the second one returns FALSE:

varD == varE
typeof(varD) == typeof(varE)

# ----------
# Exercise 3
# ----------

# Using a comment, explain why the comparison below returns TRUE:

FALSE == 0
 
# ----------
# Exercise 4
# ----------
 
# Use an "as" function to convert varE to the integer data type and assign it to a new variable called varE_int in a single command.

# ----------
# Exercise 5
# ----------

# Use a function to convert varB to all uppercase characters and assign it to a new variable called varB.allUpper in a single command.
 
# ----------
# Exercise 6
# ----------

# Using a comment, explain why calling VarA (as opposed to varA) returns an error:

varA
VarA
