# +++++++++++++++++++++++++
# +++ R BOOTCAMP UNIT 2 +++
# +++++++++++++++++++++++++
# + AUTHOR: David Dobolyi +
# +++++++++++++++++++++++++

# - Relational operators
# - R data types
# - R objects and assignment operators

# ++++++++++++++++++++++++
# + RELATIONAL OPERATORS +
# ++++++++++++++++++++++++

# The previous unit covered arithmetic operators, but R includes several other types of operators that must be discussed. The first of these are relational operators, which can be used to make comparisons:

1 < 2   # less than
1 > 2   # greater than
1 <= 2  # less than or equal to
1 >= 2  # greater than or equal to
1 == 2  # exactly equal to
1 != 2  # not equal to

# Notice that the result of these operations is TRUE (i.e., binary 1) or FALSE (i.e., binary 0), which fall under the logical data type. It is now time to discuss data types in R in further detail.

# ++++++++++++++++
# + R DATA TYPES +
# ++++++++++++++++

# Now that you have seen arithmetic and relational operators, it is time to discuss data types in R. Thus far, we have been focusing on math involving numbers, which fall under the numeric data type. However, there are several data types in R including (but not limited to):

# A) numeric (aka double/real): 2, -5.5, 10.34
# B) integer: 1L, 3L, -10L 
# C) logical (aka Boolean): TRUE (1), FALSE (0)
# D) character (aka string/text): "a", 'fish', "hello there!"

# Other core data types include complex and raw, although we will not discuss these in detail since they are utilized infrequently.

# Regarding the list provided however, note that integer values in R are a special case of numeric data and must be explicitly designated via the letter "L" to be treated as such. In other words, by default R will consider the value 2 to be numeric, whereas 2L would be literally treated as integer. It is important to stay aware of this level of specificity when working with R to avoid unintentional mistakes (e.g., if you absolutely expect to be working with integer data in R, you should explicitly declare it as such).

# Conveniently R provides several functions to test and set data types, which all return logical (i.e., TRUE or FALSE) results:

is.numeric(2)
is.integer(2)
is.numeric(2L)
is.integer(2L)
is.character(2)
is.character("2")
is.logical(2)

is.numeric("2") # "2" is a character, and characters are not numeric
is.logical(is.numeric("2")) # the result of is.numeric("2") is FALSE; as such, is.logical(FALSE) returns TRUE

# Moreover, R provides a set of functions to check the type of data you are working with such as:

str(2)
class(2)
typeof(2) # numeric is also referred to as double/real; see ?is.numeric

# As shown with the typeof(2) example, you may need to gain a deeper understanding of some R data types to fully understand the output of these functions.

# Finally, R includes various "as" functions to explicitly declare or "cast" values as a certain data type in cases where you need to convert from one data type to another. For instance:

as.integer(FALSE)
as.numeric("2") + 3
as.character(3 + 5)

# ------------------------
# Data Type Considerations
# ------------------------

# It is important to keep data types in mind constantly when working with R since only certain data types make sense for conducting certain operations. For instance, you obviously can add two numeric data values such as 2 + 3 as we have seen before, but not one numeric value with one character value such as 2 + "3", which will produce an error (more on errors later). If you are not careful, the various peculiarities regarding data types can lead to mistakes if not paying close attention. For instance, regarding logical data (i.e., TRUE vs. FALSE), keep in mind that TRUE is also represented with the value 1 and FALSE with 0:

FALSE
is.logical(FALSE)
FALSE == FALSE
FALSE == 0

# Thus, it is technically possible to add numeric data to logical data since R will attempt to infer what you are trying to do, but operations such as the following ought to be avoided for obvious reasons:

3 + TRUE

# Moreover, R occasionally provides various shorthand notations that may or may not be worth using despite the fact that they are available. For instance, when it comes to TRUE and FALSE, it is possible to use T and F as more concise alternatives (e.g., see ?TRUE):

T
F
TRUE == T
FALSE == F

# While T and F can technically be used as equivalent substitutes for TRUE and FALSE respectively, they are certainly less legible and also save little typing time. Thus, as stated in the previous unit, in general, the best advice is to be explicit and clear when writing your code, including good use of comments and white space.

# ----------------------------
# Character (String/Text) Data
# ----------------------------

# In the preceding section, a few points of clarification were made for integer and logical data. Similarly, it is worth taking a moment to detail some key aspects of character (aka string) data that may not be obvious. For example, consider the following strings taken from the list presented earlier:

"a"
'fish'
"hello there!"

# Note that the second example -- 'fish' -- appears in single quotes, yet in the output it appears in double quotes (i.e., "fish"). This occurs because R always stores character data in double quotes regardless of how you specify it.

# A more interesting issue however is the question of how you can insert a quotation mark within a character string. For example, consider the following attempt, which will not work (i.e., try running the code below without the # at the start of the line):

# "this " causes a problem"

# To actually include a double quote within a character string that is defined with double quotes, you must use the escape character, which is backslash (i.e., \) in R and several other programming languages such as Python:

"this \" is not a problem"

# It is worth noting here that R will show \" within the result when running the code above, but \" is simply representing a single " character despite how it may look in the code. To prove this, consider the following trivial example:

"\""

# This string is actually 1 character long and not 2; you can confirm this with the nchar function:

nchar("fish")  # 4 characters
nchar("\"")   # 1 character

# Alternatively, you can display the unescaped form via the cat function:

cat("\"")
cat("in other words, notice how \" does not include the escape character when output using cat")

# It is worth mentioning two related issues when it comes to character strings, quotes, and escape characters. The first is that you can generally avoid escaping double quotes by embedding double quotes within single quotes:

'this " is not a problem' # R will escape this " for you
'this " is not a problem' == "this \" is not a problem" # these strings are treated as identical

# Note that there is no issue embedding a single quote within double quotes, but keep in mind a single quote is not literally identical to a double quote character:

"this ' is not a problem" # a single quote can appear in double quotes without causing any issue
"this ' is not a problem" == 'this " is not a problem' # however these strings are NOT identical (i.e., single quote != double quote, meaning '"' != "'")

# Finally, note that the escape character \ (backslash) is special when it comes to strings since it serves a unique purpose of escaping characters, so if you want to include an actual/literal backslash in a string, the backslash itself must be escaped:

"this \ won't show a backslash in the result" # note the \ is missing in the result
"this \\ will however" # note the \ does appear now as escaped backslash, i.e., \\
nchar("\\") # again, 1 character
cat("as expected, cat will output a single backslash here: \\")
"unlike backslashes, forward slashes like / aren't special and don't need to be escaped"

# Several other special, escapable characters are also defined in R in relation to quotes; for a list, you can find more help on quotes and escape characters via:

?"'" # see the list and examples

# Common ones you may encounter when working with data include the tab (i.e., \t) and newline character (i.e., \n), which we will talk about more when we discuss importing and exporting data:

"this strong contains a tab \t and a newline \n as well"
cat("this strong contains a tab \t and a newline \n as well")

# We will spend more time later talking about various string operations in R, which can be important for text analytics, natural language processing (NLP), etc. For now, here's a quick preview of a handful of relevant functions:

paste("You can", "combine strings", "with the paste function...", sep = " ")
toupper("you can CAPITALIZE an entire string with toupper")
tolower("OR MAKE IT ALL LOWERCASE WITH tolower")

# -------------
# Missing Data 
# -------------

# Another fundamental aspect of data types is understanding missing data. In R, missing data is usually/typically represented as NA (without quotes), although you may also occasionally encounter NaN (Not a Number) as well in certain contexts:

NA
is.na(NA)
is.nan(NA)
str(NA)

NaN
is.na(NaN)
is.nan(NaN)
str(NaN)

# Missing data is a common occurrence when working with real-world data problems and a topic we will see again later when working with various statistical functions. Note that having NA values involved in calculations will typically result in an NA being returned in the result:

2 + NA + 3

# Keep in mind there is a substantial difference between missing values (i.e., NA) and numeric values such as zero (i.e., 0); the two are NOT interchangeable and the choice of which to use should be considered carefully depending on the context (e.g., saying you have 0 dollars is not the same as saying you have NA dollars -- the former means you have none, whereas the latter means you don't actually know how many dollars you have; be particularly careful about this when calculating statistics such as means).

# ++++++++++++++++++++++++++++++++++++++
# + R OBJECTS AND ASSIGNMENT OPERATORS +
# ++++++++++++++++++++++++++++++++++++++

# A fundamental aspect of working with data in R involves the use of named objects -- otherwise known as variables -- to store data. The most common way to create an object is to use the <- assignment operator:

var1 <- 2

# The line above creates an object called "var1" in the current R environment that contains the numeric value of 2. To check the value stored in an object, you have several options. One option is to simply call it to have the value printed out to the console:

var1

# Another option is to look in the Environment tab of the top-right pane in R (e.g., under the heading Values, you should see var1 and its value of 2). In any event, if you ever need to get a list of all objects defined in your current R environment, you can use the ls function to find their names:

ls()

# Finally, it's worth mentioning that you can have the value of an object printed out when you assign it in a single step by wrapping the object assignment command in parentheses:

var1 <- 2   # this command will not print the value to the console
(var1 <- 2) # but this one will

# Once an R object is defined, it is possible to use it in a calculation. For example, consider the following command using the object var1, which contains the value 2:

var1 + 2
2 * var1
var1 / 2

# If you define several R objects, a command may be composed entirely of objects and no literal values:

var2 <- 10
var3 <- 5

var2/var3

# Values held inside R objects can be updated via reassignment:

var2          # var2 is currently 10
var2 <- 50    # var2 is now 50

# Values held within R objects can also be copied into other R objects:

var2 # 50
var2copy <- var2
var2copy # also 50

identical(var2, var2copy) # the aptly-named identical function can be used to check if two objects are identical

# Moreover, an object can be assigned directly as the result of a calculation involving one or more other objects:

var4 <- (var2 + var3) * var1 + 15
var4 # 125

# Note that the calculation is processed before assignment occurs. In other words, var4 in this example is not storing a calculation, but rather the result of the calculation (i.e., the numeric value 125 in the example above). This means that changing the value of var2 after assigning var4 would not retroactively affect the value of var4, despite the fact that var2 was used to calculate the value of var4 initially. To see this more explicitly, consider the following set of assignments below:

var2 <- 50
var3 <- 5
var1 <- 2
var4 <- (var2 + var3) * var1 + 15
var4 # 125
var2 <- 500 # change var2 from 50 to 500
var4 # still 125 despite the subsequent changes to var2

# It's worth noting that the data type of objects can and will change on the fly as needed during value reassignment (i.e., the R language is dynamically [weakly] typed):

var4        # 125 (numeric)
var4 <- 10L # reassign the value of var4 to 10 (integer)
var4        # 10 (integer)

# R allows you to store any type of data into an object, meaning you are not limited to numeric data types:

str(var4)
(var4 <- "var4 is now a string")
str(var4)

# Note that changing var4 to a character object means it can no longer be used for arithmetic (e.g., the command 3+var4 would cause an error because you cannot add a numeric value [3] to a non-numeric object [var4, assuming it contains a string]).

# Finally, you can remove individual objects from the R environment if desired using the rm function:

ls()
rm(var2)
ls()

# Or you can remove all objects at once using the following command:

rm(list = ls())

# Alternatively, you can remove all objects via Session -> Clear Workspace... in the RStudio menus.

# ------------------------------
# Side Note: Errors and Warnings
# ------------------------------

# It's worth taking a moment to talk about errors and warnings in R, which you may have already encountered while working with R. Errors and warnings are R's way of telling you something is wrong or potentially wrong with your code, respectively. To see an example of an error in R, try calling var2 once you have removed it from your R environment (i.e., run the command below without the # sign, making sure var2 has been removed via rm):

# var2 

# Unsurprisingly, this command now returns an error in red within the console: "Error: object 'var2' not found". The rationale behind this error is straightforward: R cannot return an object that does not exist.

# In contrast to errors that indicate a critical mistake, warnings are designed to point out a potential issue that may or may not actually cause a problem. For example, consider what happens if you try to remove var2 repeatedly after it has already been removed:

rm(var2)

# Since we are attempting to remove a variable that has already been removed, this command will subsequently return a warning: "Warning message: In rm(var2) : object 'var2' not found". As stated in the warning message, the warning occurs because the rm command cannot remove a variable that has already been removed; however, the end result is not really a concern for us: no object called var2 will exist after calling rm, so a warning suffices here in place of an error.

# As a general rule, make sure your R scripts are completely error (and ideally warning) free, as this can cause a variety of problems down the road.

# --------------------------
# Other Assignment Operators
# --------------------------

# By far the most common way of assigning an object is using the single arrow operator that introduced earlier:

var5 <- 5

# However, R offers two other assignment operators you could use:

var5 = 5
var5 <<- 5

# Moreover, the two operators involving arrows can be used in either leftward or rightward form:

var5 <- 5
5 -> var5

var5 <<- 5
5 ->> var5

# In general, however, you should stick to the basic arrow operator in the leftward form (i.e., <-). The other operators are meant for more specific use cases (e.g., <<- is typically reserved for use in functions; see ?"<-" for more on this).

# ----------------
# Naming R Objects
# ----------------

# One important point about naming R objects is that there are rules on what is allowed. The most basic rule is that R object names may contain a combination of numbers, upper case or lower case letters, periods, and underscores:

.this.is_a_VALID_name.345 <- "no error"

# Although the name of the object above is allowed, you should endeavour to give objects names that are meaningful, clear, and consistent (the above object name is obviously not representative of this guideline; moreover, be careful using variables that start with a period, since these do not appear in the environment unless you set the all.names argument to TRUE when calling ls).

# In terms of what is NOT allowed when it comes to naming object, be aware that R object names may NOT:

# - start with a number or underscore
# - start with a period followed by a number
# - contain other symbols such as @ or %

# Also note that R object names are case sensitive, meaning that an object called "var6" would not be the same as "Var6" or "VAR6":

var6 <- "all lowercase"
Var6 <- "title case"
VAR6 <- "all uppercase"

var6
Var6
VAR6

# Finally, you might consider using camel case or other naming schemes for defining variable names, especially when variable names consist of multiple words:

camelCaseExample <- "(for example)"
