# +++++++++++++++++++++++++
# +++ R BOOTCAMP UNIT 3 +++
# +++++++++++++++++++++++++
# + AUTHOR: David Dobolyi +
# +++++++++++++++++++++++++

# -- KEY CONCEPTS --

# - R data structures
# - R date and date-time classes

# +++++++++++++++++++++
# + R DATA STRUCTURES +
# +++++++++++++++++++++

# Now that we have a basic understanding of data types and objects, we need to consider an additional aspect of data in R: data structures. The purpose of data structures is to provide ways of storing data in different formats suitable to a particular task. We will now discuss several of the most common data structures you will often see, which include:

# A) vectors
# B) factors
# C) data frames
# D) lists

# Again, this is not an exhaustive list. R provides several other data types which are less commonly seen (although obviously this depends on the context); examples of these include matrices and arrays.

# -------
# Vectors
# -------

# A vector is a basic data structure that is capable of storing multiple values. To create a vector in R, you use the combine/concatenate function, c:

c(3, 6, 9)

# You can also assign a vector (or any other data structure) directly to an object if desired:

vector1 <- c(3, 6, 9)

# The length of a vector can be calculated via the length function:

length(vector1)

# You can also find the value stored within a specific element of a vector by referencing its position using the bracket operator (i.e., see ?"["). It's worth noting that unlike some other programming languages, the position within an R vector extends from 1 to the length of the vector:

vector1[1] # the first element
vector1[2] # the second element
vector1[3] # the third element

# Note that both vector1[0] and vector1[4] can be attempted, but these do not return meaningful results for a vector of length 3:

vector1[0]
vector1[4]

# Negative values can also be used for returning a vector with a certain position omitted, although be careful when using this approach:

vector1
vector1[-1]
vector1[-2]
vector1[-3]

# A more useful fact about vectors is that it's also possible to return or omit multiple values from within a vector by position using the combine function within the brackets:

vector1[c(1, 3)]  # return positions 1 and 3
vector1[-c(1, 3)] # return all positions except 1 and 3
vector1[c(3, 1)]  # return positions 3 and 1 (i.e., order matters)

positionVector <- c(1, 3)
vector1[positionVector] # same as above, using a vector of positions in the brackets

# To change the value of an element within a vector, you can use the bracket notation combined with the assignment operator to make a change. For instance, to change the middle element of vector1, you could use the following command:

vector1 # before
vector1[2] <- 100
vector1 # after

# You can also change multiple values at once using the combine approach:

vector1 # before
vector1[c(1, 3)] <- c(50, 150)
vector1 # after

# Finally, you can add values to an existing vector by position:

vector1 # before
vector1[4] <- 200
vector1 # after

# Note however that adding values can result in NAs occurring depending on the position supplied:

vector1 # before
vector1[6] <- 300
vector1 # after (notice the NA in position 5)

# Vectors that contain numeric data are useful for simplifying operations that involve multiple values. For instance, consider what happens when you add a number to a numeric vector or multiply it by a number:

class(vector1)

vector1 + 1
vector1 * 2

# In these examples involving addition and multiplication using a single value, the addition or multiplication is applied to each individual element of the vector. However, it is also possible to perform operations across multiple vector objects:

vector2 <- c(1, 2, 3)
vector3 <- c(5, 7, 9)

vector2 + vector3
vector2 - vector3
vector2 * vector3
vector2 / vector3

# Note that in these examples, each corresponding element in the vectors is operated upon (i.e., vector2 + vector3 will result in three additions: 1 + 5, 2 + 7, and 3 + 9, respectively). This raises an interesting point: what happens if you perform arithmetic on two vectors of differing lengths?

vector4 <- c(1, 2, 3, 4, 5)
vector5 <- c(1, 2, 3)

vector4 + vector5

# Take a look at the output from the command above and see if you can figure out what happened (and read the warning). In any event, note that vector objects work like any other R object, meaning that the results of an operation involving vectors can be stored into a new object if desired:

vector6 <- vector4 / 5

# You can also create vectors of any data type, although note that every element within a particular vector must share the same data type:

vector8 <- c(10, 20, 30)
vector8
class(vector8)

vector9 <- c("cat", "dog", "hamster")
vector9
class(vector9)

vector10 <- c(10, "20", 30) # careful with this one: R will implicitly convert this to character for you since characters and numbers cannot be mixed
vector10
class(vector10)

# Note that similar to non-numeric data types, you cannot perform arithmetic on a vector that contains character data (e.g., try the example below with the # omitted):

# vector10 + 1

# R provides several convenient ways to create vectors of numbers in a sequence. For example, you may want to create a vector with the numbers from 1 to 5, from 101 to 105, or from 10 to 0. To accomplish this, R provides the colon operator (:) which can create a sequence in steps of either 1 or -1:

1:5
101:105
10:0
-5:5
5:-5

# The colon operator can be particularly handy when referring multiple values within a vector:

vector11 <- c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J")
vector11[3:5]
vector11[c(1, 2, 5:7)] # sequences can also be used directly inside the combine function

# For more complex sequences, you can also use the seq function:

seq(from = 0, to = 10, by = 2)
seq(0, 10, by = 2) # equivalent, but as always, be careful when omitting argument names

seq(0, 5, by = .5) # by does not necessarily need to be an integer

# Note that you should be careful when using the seq function to make sure it is returning what you expect. For instance, consider this call:

seq(1, 10, by = 5) # returns 1 and 6 only

# In other words, it's important to consider how the from/to boundaries work when using seq.

# -------
# Factors
# -------

# Factors represent a special case of the vector data structure in that they are designed for storing categorical (aka nominal) data. To define a factor, you use the aptly named factor function:

?factor

# For example, assume you wanted to store information regarding the type of phone a person owned, consisting of iPhone, Android, or Other. You could define this information via a factor. For instance, assuming you are recording the information for seven individuals, you could specify these data as:

phoneType <- factor(c("iPhone", "Android", "Android", "iPhone", "Other", NA, "iPhone")) # notice how one phone type is not known (i.e., NA)
phoneType

typeof(phoneType)
class(phoneType)
str(phoneType)

# There are several important points regarding factors illustrated by this example:

# 1) a factor consists of one or more discrete levels, which are stored as integer values from 1 to the number of levels (e.g., 1, 2, 3)
# 2) NA values are allowed to occur in factors
# 3) the list of levels shows all possible types, meaning that besides NA, only those values can occur in the factor (in other words, a factor with levels Android, iPhone, and Other could not take a value like BlackBerry)
# 4) every level of a factor takes both a value and a character label; for instance, in this example, the values and labels are: 1 ("Android"), 2 ("iPhone"), 3 ("Other"); note that the level values correspond to the order shown in the R console output

# Several functions exist in R that can help you when working with factors. Examples include:

levels(phoneType)   # show all the meaningful levels (NA excluded)
nlevels(phoneType)  # show the number of levels (again, NA excluded)

# You can also use functions we have seen before to convert factors to different data types. For instance, to convert to integer or character data use as.integer or as.character, respectively:

as.integer(phoneType)
as.character(phoneType)

# The default ordering of levels is automatically determined alphabetically (e.g., Android before iPhone). You can also change the order of levels and the corresponding values of the levels via either relevel (which changes only the first [aka reference] level) or by explicitly specifying the order when creating the factor:

phoneType <- factor(c("iPhone", "Android", "Android", "iPhone", "Other", NA, "iPhone"))
phoneType # by default, the levels are: 1 ("Android"), 2 ("iPhone"), 3 ("Other")
as.integer(phoneType)

phoneType <- relevel(phoneType, ref = "iPhone") # here we reassign phoneType after changing the reference level to iPhone (IMPORTANT: be sure to actually reassign after using relevel if you want the changes to "stick")
phoneType # now the levels are: 1 ("iPhone"), 2 ("Android"), 3 ("Other")
as.integer(phoneType)

phoneType <- factor(c("iPhone", "Android", "Android", "iPhone", "Other", NA, "iPhone"), levels = c("Other", "Android", "iPhone")) # here we explicitly specify the levels as Other, Android, and then iPhone
phoneType # the levels are: 1 ("Other"), 2 ("Android"), 3 ("iPhone")
as.integer(phoneType)

# In general, it is very important to use meaningful labels when working with factors. Level names consisting exclusively of numbers can also cause confusion. For instance, consider this odd example:

(weirdFactor <- factor(c(3, 1, 2, 2, 3, 3), levels = c(3, 1, 2)))
as.character(weirdFactor) # label names
as.integer(weirdFactor) # notice how the label "1" corresponds to the value of 3, which is counter intuitive; as.integer does not turn the initial numeric values specified in the call to factor, since those become labels

as.integer(as.character(weirdFactor)) # converting to character and then integer in steps can return the actual integer values of the labels, if that is needed

# Finally, similar to vectors, you can refer to a factor element by position and also reassign it:

phoneType
phoneType[3] <- "Other"
phoneType

# Note that any changes should respect the levels of the factor:

phoneType
phoneType[3] <- "BlackBerry" # generates a warning since BlackBerry is not a valid level
phoneType # note the unintended NA that now appears in the third element, which is probably not what was desired

# If you do need to add a new level to a factor, you will need to refactor it first, making sure to include the new factor level (even if it does not yet appear in the data):

phoneType <- factor(phoneType, levels = c("Android", "iPhone", "BlackBerry", "Other"))
phoneType
phoneType[3] <- "BlackBerry" # no longer a problem
phoneType

# A simple function that can be handy for getting counts of factor levels is table:

table(phoneType)
table(phoneType, useNA = "always") # if you want to see a count of NAs as well

# It's also worth noting that since factors are just a special case of vectors, you can add or omit by position in the exact same manner as you would for a regular vector:

phoneType # before
length(phoneType)
phoneType[8] <- "Other"
phoneType # after
length(phoneType)

phoneType
phoneType[-c(1:4)]

# Finally, it is occasionally necessary and/or helpful to recode factor labels (e.g., for clarity or for plotting purposes), although accomplishing this in base R is not particularly straightforward. The easier way to do this is to use a function like recode in either the dplyr or car package specifically designed for this task, although we will wait to do this in a forthcoming unit.

# -----------
# Data Frames
# -----------

# Data frames are another fundamental data type in R, since they are used to store relational data (i.e., rows and columns) similar to an Excel sheet. Data frames in R are typically instantiated using existing data files rather than specifying them directly (R and various R functions also provide some built-in example data sets; see ?data for more). However, we can create one manually using one or more vectors and the data.frame function. For instance, let's instantiate a data.frame called "employeeData":

employeeData <- data.frame(
  EmployeeID = 101:105,
  FirstName = c("Kim", "Ken", "Bob", "Bill", "Cindy"),
  Age = c(24, 23, 54, NA, 64),
  PayType = factor(c("Hourly", "Salaried", "Hourly", "Hourly", "Salaried"))
)

employeeData

str(employeeData)   # see the structure of the data frame (very useful)
dim(employeeData)   # get the dimensions
ncol(employeeData)  # number of columns
nrow(employeeData)  # number of rows
names(employeeData) # see column names

head(employeeData, n = 2) # see only the first two rows
tail(employeeData, n = 2) # see only the last two rows

# A couple things are worth pointing out here regarding the data frame employeeData:

# 1) Data frames can consist of multiple columns, each with a distinct name and data type.
# 2) Each column is a vector, and each vector must be of the same length (NAs can be used to pad missing data, as in the Age column in the example).
# 3) R will automatically try to convert the columns into a suitable data type based on the data, but the assumption may not always be ideal (see ?data.frame for options on how to control this process).

# Regarding the third point, it's worth noting that IDs likely ought to be factored since they aren't really integer data per se (e.g., would you ever add up two employee IDs?). To accomplish this, we can use the assignment operator approach combined with the $ operator, which is used to refer to a specific column name within the data:

employeeData$EmployeeID # return the column vector of employeeData named EmployeeID

str(employeeData) # EmployeeID is int (integer)
employeeData$EmployeeID <- factor(employeeData$EmployeeID) # factor employeeData$EmployeeID and reassign it back into the data.frame employeeData
str(employeeData) # EmployeeID is now Factor in the data.frame

# Regarding the $ operator, it's worth noting that column names can be placed in quotes, which is sometimes necessary if the column names include spaces (which should be avoided whenever possible). Thus, the following are all equivalent:

employeeData$EmployeeID
employeeData$"EmployeeID"
employeeData$'EmployeeID'
employeeData$`EmployeeID` # ` is called backtick (aka grave accent or backquote)

# As noted above, once a column is called via the $ operator, it is returned in the format of a vector. Thus, you can refer to elements by position as with any other vector:

employeeData$EmployeeID[3] # the employee on the third row has the EmployeeID 103

# When it comes to data.frame objects, you can also reassign a value within the data.frame using this approach:

employeeData                # before
employeeData$Age[3]         # the age of the employee on the third row is 54
employeeData$Age[3] <- 55   # reassign this employee's age to 55
employeeData$Age[3]         # the age is now updated to 55
employeeData                # after

# In addition to the $ operator, R supports several others that can be used for extracting or replacing values (e.g., see ?"$"). The most fundamental of these is again bracket notation, similar to vectors, although this time with two dimensions: rows and columns, which are delineated with a comma. First, let's look at specifying rows by number:

employeeData
employeeData[1, ]       # reference a single row (i.e., the first row)
employeeData[2:3, ]     # reference the second and third rows
employeeData[c(1, 4), ] # reference the first and fourth rows

# Notice that we specified particular rows but left the column specification blank in the preceding examples (e.g., [2:3, ]): when no specific columns are specified, R will return all columns. Now let's look at specifying columns by number:

employeeData
employeeData[, 2]       # reference a single column (FirstName in this case, which is returned as a vector)
identical(employeeData[, 2], employeeData$FirstName) # these are identical

employeeData[, 1:3]     # reference the first three columns
employeeData[, c(1, 4)] # reference the first and fourth columns

# In these examples, we specify particular columns but not particular rows: in this case, R again will return all rows. As you might expect, it is possible to specify both a specific row and column in a single command:

employeeData
employeeData[1, 2]              # reference the value in the first row, second column
employeeData[c(1, 3), c(2, 4)]  # reference the first and third rows with respect to the second and fourth columns

# All of these examples reference rows and columns by position. It's also possible to provide references by name; for example, when working with columns:

employeeData[, c("EmployeeID", "PayType")] # identical to employeeData[, c(1, 4)]

# As may be apparent, you thus have a lot of flexibility in terms of how to reference rows and columns within a data.frame. The following are all equivalent:

employeeData$Age
employeeData[, "Age"]
employeeData[, 3]

# What's more, double brackets and single brackets can be combined. Putting it all together, here is an example of several different ways of referencing data in the third row, second column of the EmployeeData data.frame:

employeeData$FirstName[3]
employeeData[3, "FirstName"]
employeeData[3, 2]
employeeData[, "FirstName"][3]
employeeData[, 2][3]
employeeData[3, ][, "FirstName"] # you should probably avoid this one, but it is possible...

# Ultimately, it's up to you to decide how best to make references to data.frame objects, but clarity should always be the goal (e.g., the first or second option above are potentially clearer than many of the others). As a general rule, it is best to refer to columns by name however, since column order is essentially arbitrary, thereby making references by column number potentially unreliable/hazardous. For example, consider a variation on the existing data.frame employeeData that rearranges the column order:

employeeDataReorder <- employeeData[, c("EmployeeID", "Age", "FirstName", "PayType")] # instantiate a new data.frame, employeeDataReorder, which contains all the columns of employeeData, but in a slightly different order

employeeData        # column order: EmployeeID, FirstName, Age, PayType
employeeDataReorder # column order: EmployeeID, Age, FirstName, PayType

# Notice how references by column number are no longer reliable across the two data.frame objects, yet references by column name are not a problem:

employeeData[, 2]
employeeDataReorder[, 2]      # these are different

employeeData$FirstName
employeeDataReorder$FirstName # these are the same

# All of these examples have focused on referencing or updating existing data within a data.frame object. There are of course ways you can add new rows and/or columns to a data.frame via assignment. To add a new row, you must supply a valid value for each respective column. To see how, consider this example, which covers some potential data type/structure issues:

employeeData
str(employeeData) # note that EmployeeID and FirstName are factors, and thus to add new/novel levels, we will need to unfactor these columns first (e.g., one option is to convert them to strings first); by contrast, we can leave PayType alone if we do not expect our new data to contain a novel factor level (i.e., something besides the defined levels of Hourly or Salaried)

employeeData$EmployeeID <- as.character(employeeData$EmployeeID)
employeeData$FirstName <- as.character(employeeData$FirstName)

employeeData
str(employeeData) # notice the EmployeeID and FirstName columns are no longer factored (i.e., they are just simple character vectors), but the data values are still the same after these conversions

employeeData[6, ] <- c(106, "Jamie", 56, "Hourly") # notice 106 is automatically converted to a string by R
employeeData
str(employeeData) # we've successfully added the new row of data; if we want to revert the structure back to our starting point, we could also refactor the EmployeeID and FirstName columns...

employeeData$EmployeeID <- as.factor(employeeData$EmployeeID)
employeeData$FirstName <- as.factor(employeeData$FirstName)

employeeData
str(employeeData) # all set (and note: it's ultimately your task to make sure the data types in your data.frame object are set in the way you think makes the most sense [e.g., it's debatable whether or not FirstName should be stored as a factor or more simply as a character string; you should decide how it should be set up and then make the necessary changes])

# Omitting or deleting rows is more straightforward than adding them. Simply use the bracket notation with negative values, similar to how you would for vectors:

employeeData
employeeData[-c(2:4), ] # omit rows 2 through 4

# Remember, if you actually want to remove these rows from the data.frame permanently, you will need to combine the command above with an assignment. For example:

employeeDataCopy <- employeeData # let's copy employeeData to employeeDataCopy so we don't lose our existing, "complete" version
identical(employeeDataCopy, employeeData) # as expected, the copy is identical

employeeDataCopy # before
employeeDataCopy <- employeeDataCopy[-c(2:4), ]
employeeDataCopy # after

# That covers the basics of adding or omitting/removing rows. To add a new column vector to a data.frame, simply assign it to the data.frame object with a meaningful name and provide a vector of data to fill it with the appropriate length (i.e., equal to the number of rows in the data.frame):

employeeData # before
employeeData$NumChildren <- c(0L, 2L, 1L, 0L, 3L, 0L) # this will only work if there are six rows in employeeData
employeeData # after

# Finally, to omit columns from a data.frame (as opposed to referencing only the ones you want, which we covered earlier), you have several options, although none of them are particularly straightforward (we will cover other/potentially better options later; more on this later). One basic option is to omit columns by position using bracket notation, similar to vectors:

employeeData
employeeData[, -c(2:4)] # omit columns 2 through 4 by position

# Another somewhat unintuitive option is to use the value matching %in% operator (e.g., see ?"%in%) in conjunction with logical negation (i.e., !) to exclude matching columns by name:

employeeData
names(employeeData)
employeeData[, !( names(employeeData) %in% c("FirstName", "Age", "PayType") )]

# A third and slightly more easy-to-interpret option is to use the subset function:

?subset
subset(employeeData, select = -c(FirstName, Age, PayType)) # note the column names are NOT in quotes, which is a peculiarity of subset (the only quotes allowed using subset are backticks)
subset(employeeData, select = -c(`FirstName`, `Age`, `PayType`)) # same as above using backticks

# Again, this is just a preview of basic approaches; we will spend a lot more time manipulating data.frame objects with the dplyr package in a forthcoming unit, which should streamline these types of operations.

# -----
# Lists
# -----

# Although typically less common than the other data types we have discussed thus far, lists are another data structure in R that are relatively frequently encountered (and for certain programming tasks, they are invaluable). At the most basic level, lists provide a way to nest many different types of R objects inside a single object (e.g., you might think of lists like Matryoshka dolls). To see how lists work, let's learn by example. First, let's create a few arbitrary objects to put in our list:

demoVec <- c(97, 98:101)
demoDF <- data.frame(
  ColA = 1:3,
  ColB = factor(c("A", "A", "B")),
  ColC = demoVec[1:3]
)

# Now let's create a list using these objects along with some additional list elements we create on the fly:

list1 <- list(
  Element1 = demoVec,
  Element2 = c("A", "B"),
  Element3 = 3,
  Element4 = demoDF
)

# Now let's see what our list looks like:

list1

# In this example, list1 contains four elements of various sizes/lengths and data types/structures. Each element has a name and can be returned using various extractor operators including $ (using the same rules as for data.frame objects), single bracket, and a new one: double bracket (i.e., see ?"[["). Let's consider the $ approach first:

str(list1)
length(list1)
names(list1)

list1$Element1
list1$Element2
list1$Element3
list1$Element4

# When a list element is returned using the $ operator, it is returned in its respective data structure. In other words, since Element4 in list1 is a data.frame, we can also reference individual values inside it using row/column bracket notation after extracting it from the list:

list1
list1$Element4

str(list1$Element4)   # proof that the extracted element is a data.frame
list1$Element4[2, 3]  # here we extract the data.frame and reference the 2nd row/3rd column in a single command to show the relevant value (i.e., the number 98)

# Double bracket notation works similarly to the $ operator, except double bracket allows us to reference list elements not only by name, but also by position. Thus, the following commands are all equivalent:

list1$Element4
list1[["Element4"]]
list1[[4]]

# As always, be careful when specifying list objects by numeric position rather than by name, since numeric position is arbitrary, less precise, and subject to change (and thus mistakes).

# Last but not least, single bracket notation can also be used with lists to return one or more elements by either name or position. However, be careful when using single bracket notation with lists, since the returned object will always be a list even when returning a single list element (i.e., this differs from how the $ operator and double bracket work above, since those operators are designed to extract only a single list element as opposed to potentially several):

list1
list1["Element4"]       # notice the "$Element4" shown above the data.frame output
str(list1["Element4"])  # this occurs because single bracket returns a list of length 1

list1[c("Element1", "Element3")] # returning two elements of our list by name

list1[1]        # first element by position (returned as a list)
list1[c(1, 3)]  # first and third elements by position

# This covers referencing data stored in a list. As you may expect, it's possible to add more elements to an existing list using approaches we have already seen. For example, one option is to use the $ operator:

list1 # before
list1$NewElement <- "Let's add this string..."
list1 # after

# Another option is to add a new element by position:

list1 # before
length(list1)
list1[[6]] <- seq(0, 5, by = 1)
list1 # after

# You may notice one oddity about the above code: namely, the newly added element does not have a name when added by position since no name was supplied. Notice the difference between $NewElement and [[6]]:

list1$NewElement  # NewElement can be referenced by name
list1[[5]]        # or by position

list1[[6]]        # by contrast, list element six has no name and can only be referenced by position

names(list1)      # notice how the sixth name is blank (i.e., "")

# As shown in this example, it is technically possible for list elements to not be formally named when declared. In fact, an entire list could be declared with one or more names omitted:

list2 <- list(
  Element1 = seq(1, 5, by = .5),
  c("A", "C", "E"),
  demoDF,
  Element4 = c(TRUE, NA, FALSE)
)

str(list2)
names(list2)

# Alternatively, not a single name must necessarily be provided:

list3 <- list(
  seq(1, 5, by = .5),
  c("A", "C", "E"),
  demoDF,
  c(TRUE, NA, FALSE)
)

str(list3)
names(list3) # NULL indicates no names

# In cases such as this when names are occasionally or entirely missing, the $ operator may not helpful, since $ only works with names. Thus, you must use single or double bracket notation to reference lists with unnamed elements by position, similar to our previous examples:

list3[c(1, 3)]
list3[[3]]

# Moving on, note that like all other data structures in R, you can reassign values within lists using the same general approach we have seen before. For instance, we can change the first list element into something else via reassignment:

list4 <- list(
  seq(1, 5, by = .5),
  c("A", "C", "E"),
  demoDF,
  c(TRUE, NA, FALSE)
)

list4 # before
list4[[1]] <- "let's replace the number sequence with this string"
list4 # after

# We could also have used a series of operations to make a more complex change. For instance, we could replace the value in the top right hand corner of the data.frame in list4 (i.e., 97) like so:

list4 # let's see what we are working with

list4[[3]][1, 3] <- 0 # we are interested in the data.frame in the third list element; more specifically, the first row and third column of that data frame; let's replace that value with a 0

list4 # let's see the result

# Finally, we technically can omit values from a list by position, although be careful since doing so will change list positions in the returned output due to a peculiarity of how list indexing works:

list2
list2[-c(1, 3)] # notice how the resulting list is reindexed from [[1]] for unnamed list elements, which may be unexpected

identical(list2[[2]], list2[-c(1, 3)][[1]]) # somewhat confusingly, this is indeed TRUE

# Alternatively, you can delete list elements by assigning their value to NULL as needed:

list2Copy <- list2

list2Copy # before
list2Copy$Element1 <- NULL
list2Copy[[1]] <- NULL
list2Copy # after (again, notice how the list indexing has been reset for unnamed elements; in other words, what was [[3]] initially is now [[1]])
identical(list2Copy[[1]], list2[[3]])

# ++++++++++++++++++++++++++++++++
# + R DATE AND DATE-TIME CLASSES +
# ++++++++++++++++++++++++++++++++

# Now that we have covered the key R data types and structures, it is worth discussing one additional form of data commonly encountered in R: calendar dates and times.

# R provides several classes for working with dates and times, and the simplest of these is the Date class:

?Date

# The Date class is useful for working with calendar dates. For example, to see the current date in R, we can use the Sys.Date() function to generate it:

Sys.Date()

# Running this function will display the current local date in a standardized year, month, day format (i.e., ISO 8601). While the output of this function may look like a simple character string, it is actually in the Date format, as shown via str:

str(Sys.Date())

# Compared to a string, a Date object provides significantly more information and functionality. For example, R provides various functions to extract parts of a Date object:

weekdays(Sys.Date())
months(Sys.Date())
quarters(Sys.Date())

# Moreover, as shown in the examples in ?Date, dates can be displayed in various ways using the format function:

(today <- Sys.Date())
format(today, "%d %b %Y") # two digit day of month, abbreviated month name, four digit year

# The formatting of a date is highly customizable (for additional formatting options, see the details section of ?strptime):

format(today, "%A, %B %d, %y") # full weekday name, full month name, two digit day, two digit year

# Dates represent much more than strings however, since they can be used for calculations. For example, to determine the date 3 days from now, you can simply add 3L to today's date:

Sys.Date() + 3

# Moreover, we can also calculation the distance between two dates using some basic algebra. First, let's define dates beyond just today's date. To accomplish this, we can use R's as.Date conversion function, which expects dates to be formatted as four digit year, two digit month, and two digit day:

date1 <- as.Date("2019-09-10")
date2 <- as.Date("2019/09/15") # note we can use / in place of - when defining a date

# To calculate the time difference between these two dates, we can simply subtract them:

date2 - date1

# Finally, we can use logical operators to test dates as well. For example:

date1 > date2
date1 + 10 > date2

# ---------
# Date Time
# ---------

# In addition to dates, R also provides classes for dealing with date-time data. For example, to see the current date and time, we can use the Sys.time function:

Sys.time()

# This function will provide the current date -- similar to Sys.Date() -- as well as the current time in a 24 hour format (i.e., military time). Unlike simple dates, date-times provide information on both the date and the time, including additional formatting options:

format(Sys.time(), "%d %b %Y")    # just the date
format(Sys.time(), "%d %b %Y %T") # date and time (24 hour format)
format(Sys.time(), "%d %b %Y %r") # date and time (12 hour format with am/pm)

# Somewhat confusingly, date-time classes in R consist of two variants: POSIXct and POSIXlt, with the latter being designed to simplify use in data.frame objects. Practically speaking, you can typically use either format to define date-times. To create a date-time object in R, use the as.POSIXct or as.POSIXlt functions; for instance:

as.POSIXct("2019-09-01 12:30:45") # September 1, 2019; 30 minutes and 45 seconds past noon
as.POSIXlt("2019-09-01 12:30:45") # same as above

# More importantly, note that times in R by default are defined on a 24 hour clock. Therefore, care should be taken to avoid mistakes regarding AM vs. PM times:

format(as.POSIXct("2019-09-01 01:30:00"), "%F %T %r") # 1:30 AM
format(as.POSIXct("2019-09-01 13:30:00"), "%F %T %r") # 1:30 PM

# Moreover, note that time zone matters when working with both dates and date-times. By default, R will assume dates and date-times are being specified in your system's current time zone (e.g., EDT, or Eastern Daylight Time):

(time3 <- as.POSIXct("2019-09-01 12:00:00")) # default time zone for your system (e.g., EDT, or eastern daylight time)
format(time3, "%F %T %Z (%z)") # showing time zone and offset relative to coordinated universal time (UTC)

# You can specify an alternate time zone for a date using the tz argument:

(time4 <- as.POSIXct("2019-09-01 12:30:45", tz = "UTC")) # specify in UTC time

# Using the attributes function, it is possible to inspect the time zone of a date-time object:

attributes(time4)

# Using this function, it's also possible to adjust the time zone to something else:

attributes(time4)$tzone <- "EST5EDT" # note: EST5EDT is the formal representation for eastern standard time that complies with daylight savings (i.e., eastern daylight time)
time4

# Besides the issue of time zone, date-times work similarly to dates and can also be used in calculations. For example:

time5 <- as.POSIXct("2019-09-01 12:30:45", tz = "UTC")
time6 <- as.POSIXct("2019-09-01 08:30:45", tz = "UTC")

time6 - time5

# Finally, note that it is important to pay strict attention to time zones to avoid potential mistakes. For example, the following two times may appear different (i.e., several hours apart):

time7 <- as.POSIXct("2019-09-01 12:30:45", tz = "UTC")
time8 <- as.POSIXct("2019-09-01 08:30:45", tz = "EST5EDT")

# Nevertheless, they are actually represent the same time if time zone is taken into account:

time8 - time7

# ------------------------------------------------------------
# Side Note: Time Zones, Daylight Savings Time, and Leap Years
# ------------------------------------------------------------

# Various aspects of time including time zones, daylight savings time, and leap years can add significant complexity to working with dates that extend over long periods or when data comes from across the globe. For cases such as these, take a look at the lubridate and anytime packages, which can significantly simplify work involving with dates/times, thereby helping to avoid basic mistakes. The following unit provides details on how to work with packages in R.

