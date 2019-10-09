# +++++++++++++++++++++++++
# +++ R BOOTCAMP UNIT 5 +++
# +++++++++++++++++++++++++
# + AUTHOR: David Dobolyi +
# +++++++++++++++++++++++++

# -- KEY CONCEPTS --

# - Descriptives
# - Subsetting
# - Merging
# - Logical operators
# - Data manipulation
# - Data restructuring

# ++++++++++++++++
# + Descriptives +
# ++++++++++++++++

# Now that we understand data.frame objects and can import data, we are ready to start working with data. Before we begin, let's import some data using the data function; for this example, we will use the iris data set, which is a famous data set involving iris flower species:

data(iris)
?iris
head(iris)
dim(iris)
str(iris)

# At a broad level, it may be useful to generate some descriptive statistics regarding a data set: for example, we may want to compute means and/or medians for each numeric column of iris. Although we could use the mean and/or median function to calculate these descriptives for each column of interest, it would be tedious to do so and require a lot of code. Instead, R provides us with the ability to apply a given function to all columns (or rows) of a data.frame object. and the function to do this is the aptly named apply function (also see lapply for related variants):

apply(iris[, 1:4], MARGIN = 2, FUN = mean)

# The code above is used to apply the mean function to the numeric columns of iris (i.e., iris[, 1:4]); note that MARGIN = 2 tells apply to work with rows, whereas MARGIN = 1 would allow us to apply the function to every row (although doing that would not be particularly informative in the case of the iris data).

# A limitation of the apply approach is that we must manually specify only the numeric columns when using apply in this example since the mean function does not work with non-numeric data and would produce a series of warnings. To see this, try uncommenting the following code which attempts to (incorrectly) apply the mean function to all columns of iris:

# apply(iris, MARGIN = 2, FUN = mean)

# Conveniently, R offers a more universal approach for generating many common descriptives for data.frame objects that adapts to the data on the fly. This basic functionality comes in the form of the summary function:

summary(iris)

# The summary object will give you some basic descriptives for every column of a data.frame object, with the output dependent upon the type/structure of data (e.g., numeric data produce means/medians/quantiles/ranges whereas factor data will provide level counts as shown in the example). 

# Moreover, various R packages can be used to get a fancier set of descriptives; for example, consider the describe function in the psych package:

library(psych) # remember to install the package (once) if needed!

?describe

describe(iris) # note the asterisk next to Species (see ?describe for an explanation/warning)

# By searching for the right R function, you can get a lot done quickly depending on what you want/need to do.

# ---------------------------------------
# Extracting Output Returned by Functions
# ---------------------------------------

# While the results of the describe function above are mostly self explanatory, a common question that comes up is how to extract a specific value from the function's output. While there is some variability in terms of how output is organized depending on the function, the general approach is to use the str and/or names function to investigate the output further:

str(describe(iris))
names(describe(iris))

# The function describe actually returns a data.frame object with named columns. As such, we can use standard data.frame extractors to pull out values from the result:

describe(iris)[3, c("mean", "sd")]              # the mean and sd columns for the 3rd row, Petal.Length
describe(iris)["Petal.Length", c("mean", "sd")] # same as above, except referenced by row name

# We can easily verify these results manually using the mean and sd functions:

mean(iris$Petal.Length) # verified by hand
sd(iris$Petal.Length)   # verified by hand

# ++++++++++++++
# + Subsetting +
# ++++++++++++++

# While the summary and describe functions are useful, there usefulness is limited to summarizing/describing the entire data set. For instance, a few moments ago, we were able to assess the mean petal length of all 150 iris flowers. However, what if we wanted to determine the mean values for each of the three species in the data set:

nrow(iris)                   # the number of iris instances in the data set
mean(iris[, "Petal.Length"]) # mean petal length of all instances
table(iris$Species)          # a table of the 3 different species (50 of each)

# One way to accomplish this is to subset the data; in other words, we want to only extract a specific part of the data set we are interested. For instance, suppose we wanted to calculate the mean petal lengths of only the "setosa" flowers. In R, we could do this by supplying a condition to the row argument of the data.frame bracket extractor:

mean(iris[iris$Species == "setosa", "Petal.Length"])

# In this case, the row condition is:

iris$Species == "setosa"

# This command uses the relational operator to evaluate which observations within the Species column of the iris data.frame are "setosa"; the result is 150 logical observations (i.e., one per row of the iris data.frame) that respond to that query in terms of TRUE vs. FALSE. In this example, the first 50 rows represent "setosa" data, so those observations yield TRUE, whereas the latter 100 belong to a non-"setosa" species and thus yield FALSE. If the number of logical results is equal to the number of rows within a data.frame, these logical values can be used to reference rows within the data.frame such that only true observations will be returned. Thus, the following command will return a data.frame of only the 50 "setosa" flowers in the overarching data set:

iris[iris$Species == "setosa",]

# The initial command we used to calculate the mean simply builds on this code to calculate the mean of a specific column, which in this case is petal length:

mean(iris[iris$Species == "setosa", "Petal.Length"])

# Using this method, we can quickly calculate the mean petal lengths of all three species:

unique(iris$Species) # find the unique species labels

mean(iris[iris$Species == "setosa", "Petal.Length"])
mean(iris[iris$Species == "versicolor", "Petal.Length"])
mean(iris[iris$Species == "virginica", "Petal.Length"])

# Alternatively, if we wanted we could also generate three separate data.frame objects with one for each species:

irisSetosa     <- iris[iris$Species == "setosa",]
irisVersicolor <- iris[iris$Species == "versicolor",]
irisVirginica  <- iris[iris$Species == "virginica",]

mean(irisSetosa$Petal.Length)
mean(irisVersicolor$Petal.Length)
mean(irisVirginica$Petal.Length)

describe(irisSetosa)
describe(irisVersicolor)
describe(irisVirginica)

# Soon however we will talk about the dplyr package, which will make doing simple tasks like this even easier.

# ---------------------------
# Subsetting and Reassignment
# ---------------------------

# When using the method of subsetting shown above, it is possible to change values in the original data.frame based on the supplied condition, which may be helpful in some cases. To see how this works, let's reinstantiate a variation of the employeeData data.frame we used in an earlier unit:

employeeData <- data.frame(
  EmployeeID = 101:106,
  FirstName = c("Kim", "Ken", "Bob", "Bill", "Cindy", "Jamie"),
  Age = c(24, 23, 54, NA, 64, 56),
  PayType = factor(c("Hourly", "Salaried", "Hourly", "Hourly", "Salaried", "Hourly")),
  NumChildren = c(0L, 2L, 1L, 0L, 3L, 0L)
)

head(employeeData)

# For example, using this data.frame, we may want to find all employees who have no children:

employeeData[employeeData$NumChildren == 0,] # the condition is employees who have exactly 0 children (as opposed to > 0 children, for instance)

# Suppose we want to transition all of these employees with no children to the "Salaried" PayType in the employeeData data.frame object. To do this, we simply need to use standard reassignment in conjunction with our conditionally-referenced data.frame object:

employeeData # before
employeeData[employeeData$NumChildren == 0,]$PayType <- "Salaried"
employeeData # after

employeeData[employeeData$NumChildren == 0,] # confirming the change

# Subsetting data in this way can be useful for changing many values within a data.frame at once based on a specific condition.

# -----------------------------
# Converting Logical to Indices
# -----------------------------

# Earlier we saw that a condition returns logical values. For instance, when working with iris, we can use the following basic command to determine which values in the Species column are "virginica":

iris$Species == "virginica" # the last 50 observations are "virginica"

# Again, these logical values can be used with the data.frame to return only the "virginica" data:

head( iris[iris$Species == "virginica",] )

# Although not necessary, R provides a function called which that you could use to find the relevant row indices of the logical values returned by a conditional:

which(iris$Species == "virginica")

# The function which returns the indices of the logical values that are TRUE (i.e., the last 50 of the 150 iris Species are "virginica"). Once you have the relevant row indices, you could use these directly to reference rows by number as we have done previously:

head( iris[which(iris$Species == "virginica"),] )

# Although you obviously do not need to use which in this example since the result is the same regardless of the approach, there are situations where using the which function can be useful to find relevant indices...

# -----------------------------
# Additional Subsetting Options
# -----------------------------

# As with many things in R, you typically have several options on how to do almost anything. Subsetting is no different; for example, consider these alternative approaches to subsetting using various R functions

head( iris[iris$Species == "setosa",] )         # the basic approach using logical values
head( iris[which(iris$Species == "setosa"),] )  # using the row indices of the TRUE logical values
head( iris[with(iris, Species == "setosa"),] )  # using the with function to avoid needing $ in the condition
head( subset(iris, Species == "setosa") )       # using the subset function in base R (see the filter function in the dplyr package as well)

# As always, it is up to you to decide which method to use. One note on the above however: the subset function cannot be used if you intend to reassign observations inside the original data.frame object; use one of the other methods if that is your goal.

# ----------------------------------------------
# A Note of Caution Regarding Subsetting and NAs
# ----------------------------------------------

# One potential caveat to subsetting with some approaches is the problem of what happens when NA values are involved in the column(s) of interest. For example, let's reestablish the employeeData data.frame:

employeeData <- data.frame(
  EmployeeID = 101:106,
  FirstName = c("Kim", "Ken", "Bob", "Bill", "Cindy", "Jamie"),
  Age = c(24, 23, 54, NA, 64, 56),
  PayType = factor(c("Hourly", "Salaried", "Hourly", "Hourly", "Salaried", "Hourly")),
  NumChildren = c(0L, 2L, 1L, 0L, 3L, 0L)
)

head(employeeData)

# Notice the Age column includes an NA value for the 4th employee. If we write a subsetting condition using the Age column in employeeData, we can run into a potentially unexpected result:

employeeData[employeeData$Age < 60,] # 5 rows, with one consisting entirely of NAs

# As noted above, the subsetted data consists of five rows despite the fact that you may have only expected four (i.e., only 24, 23, 54, and 56 are less than 60 numerically [ignoring NA]). The problem is that the result contains a row of entirely NA values due to how conditional statements are evaluated in R when NAs are present:

employeeData$Age < 60 # note the NA

table(employeeData$Age < 60, useNA = "always")

# Stated another way, when NAs occur in an index in R, they have the potential to influence the subsequent result. This can potentially be problematic and/or unexpected in certain situations, such as if nrow were used to evaluate the resulting data.frame after subsetting using logical indexing:

nrow( employeeData[employeeData$Age < 60,] )        # 5 rows
nrow( employeeData[with(employeeData, Age < 60),] ) # 5 rows

# To avoid this situation involving NAs, you should generally prefer subsetting approaches that avoid logical subsetting, such as methods that select based on row indexes via the which function:

nrow( employeeData[which(employeeData$Age < 60),] ) # 4 rows

# Alternatively, you can use the subset function to avoid the problem as well (the filter function in the dplyr package also applies here since it works similarly to the base R subset function):

nrow( subset(employeeData, Age < 60) )              # 4 rows

# +++++++++++
# + Merging +
# +++++++++++

# Occasionally it may be useful to combine two data.frame objects, particularly when both have a similar column structure. For example, in the earlier section, we created three subsets of the iris data for each of the three species:

data(iris)

irisSetosa     <- iris[iris$Species == "setosa",]
irisVersicolor <- iris[iris$Species == "versicolor",]
irisVirginica  <- iris[iris$Species == "virginica",]

# Because each of these data.frame objects has the exact same structure (i.e., the columns have the same names and the same order), we can combine them simply by stacking them together using the rbind (row bind) function:

irisMerge <- rbind(irisSetosa, irisVersicolor, irisVirginica)

# Once recombined, the data.frame above holds the same data as the original iris data set:

identical(iris, irisMerge)

# In some cases, however, it is possible that the two data.frame objects you are trying to merge may not have perfectly identical structure despite involving related data. For example, consider the following two data.frame objects based on a variation of the employeeData example:

employeeData_A <- data.frame(
  EmployeeID = 102:106,
  NumChildren = c(2L, 1L, 0L, 3L, 0L),
  FirstName = c("Ken", "Bob", "Bill", "Cindy", "Jamie")
)

employeeData_B <- data.frame(
  Age = c(24, 23, NA, 64, 56),
  PayType = factor(c("Hourly", "Salaried", "Hourly", "Salaried", "Hourly")),
  ID = c(101, 102, 104, 105, 106),
  FirstName = c("Kim", "Ken", "Bill", "Cindy", "Jamie")
)

str(employeeData_A)
str(employeeData_B)

# In this example, it is clear that employeeData_A and employeeData_A involve similar data (i.e., about employees), yet there are differences across the two data.frame objects. Specifically, both data.frame objects provide a column with employee identifiers, but the column names differ (i.e., "EmployeeID" vs. "ID"), as do the order of these columns (i.e., "EmployeeID" is the first column of employeeData_A, whereas "ID" is the third column of employeeData_B). Moreover, the two data.frame objects share the "FirstName" column, but information regarding other attributes differs across the two (e.g., "NumChildren" vs. "Age" and "PayType"). Finally, not every employee appears in each data.frame (i.e., 101 is missing from employeeData_A and 103 is missing from employeeData_B).

# In a complex situation such as this, rbind cannot merge the data correctly, but conveniently the merge function can when using the appropriate arguments (i.e., see ?merge for details):

employeeData_AB_merged <- merge(x = employeeData_A, y = employeeData_B, by.x = c("EmployeeID", "FirstName"), by.y = c("ID", "FirstName"), all = TRUE)

head(employeeData_AB_merged) # note the missing NA values for certain attributes involving EmployeeID 101 and 103 are added automatically as needed

# The merge function can be useful to combine information across two data.frame objects, but note that there is one crucial requirement: there must be an identifier/key column (or set of columns) available across the two data.frame objects to identify unique instances/cases/rows. In this example, the key columns of employeeData_A are "EmployeeID" and "FirstName" while the respective key columns in employeeData_B are "ID" and "FirstName"; using simply "EmployeeID" and "ID" respectively would also have worked, but would have resulted in multiple FirstName columns being created:

merge(x = employeeData_A, y = employeeData_B, by.x = c("EmployeeID"), by.y = c("ID"), all = TRUE) # note FirstName.x and FirstName.y, which refer to the corresponding columns in employeeData_A and employeeData_B, respectively

# Always check the results of your merge to make sure you have set it up correctly and have produced the expected outcome.

# +++++++++++++++++++++
# + Logical Operators +
# +++++++++++++++++++++

# All of the subsetting examples above were based on a condition with a single rule (e.g., iris$Species == "setosa"). However, it is often helpful/necessary to create conditions that involve multiple rules. To do this, we need to talk about logical operators, of which three are fundamental:

# | (logical OR)
# & (logical AND)
# ! (logical negation; aka NOT)

# These three logical operators can allow you to define complex conditions. For instance, suppose we wanted to select flowers that are either "setosa" or "virginica"; to accomplish this, we would use logical OR (i.e., |):

irisSetosaOrVirginica <- iris[iris$Species == "setosa" | iris$Species == "virginica",] # creating a new data.frame is not necessary, but helpful for this example

head(irisSetosaOrVirginica)
tail(irisSetosaOrVirginica)
summary(irisSetosaOrVirginica)

# As you can see in the summary, we have selected the 50 "setosa" and 50 "virginica" species using our conditional statement, which ultimately excludes the 50 "versicolor" instances. Note one important point: to select both "setosa" and "virginica" we must use logical OR (i.e., |); logical AND (i.e., &) will not work in this example:

iris[iris$Species == "setosa" & iris$Species == "virginica",] # 0 rows

# The reason for this is simple: in the code above, the condition is specified as columns where the value of Species in a given row is "setosa" and "virginica" simultaneously -- but this is not possible! In other words, a particular value in the species column can be either "setosa" or "virginica" but it cannot be both at the same time; thus, the correct logical operator here is OR rather than AND to achieve the intended result.

# Logical AND (&) is typically more useful when writing a condition that involves several different columns. For instance, let's select only those iris flowers that have a sepal length greater than 5.5 and a sepal width greater than 3.6:

iris[iris$Sepal.Length > 5.5 & iris$Sepal.Width > 3.6,]

# Only 5 cases satisfy this condition, including 3 "setosa" and 2 "virginica" instances. If we wanted to narrow this down further to only the "virginica" instances, we could extend our condition further:

iris[iris$Sepal.Length > 5.5 & iris$Sepal.Width > 3.6 & iris$Species == "virginica",]

# Finally, in addition to logical AND and logical OR, logical negation can be used to invert logical results. For instance, notice the following commands are functionally equivalent in the iris data set:

iris$Species == "setosa" | iris$Species == "virginica" # cases that are either setosa or virginica

!(iris$Species == "versicolor") # cases that are not versicolor

identical(
  iris$Species == "setosa" | iris$Species == "virginica",
  !(iris$Species == "versicolor")
  ) # these are indeed identical

# In the case of the iris data set, we know there are only three species: setosa, versicolor, and virginica. Thus, selecting non-versicolor cases is equivalent to selecting setosa and virginica cases. Just to be sure, let's show this another way by subsetting the iris data.frame object:

irisSetosaOrVirginica <- iris[iris$Species == "setosa" | iris$Species == "virginica",]

irisNotSetosa <- iris[!(iris$Species == "versicolor"),]

identical(irisNotSetosa, irisSetosaOrVirginica) # the result is the same and the data.frame objects are identical

summary(irisSetosaOrVirginica)
summary(irisNotSetosa)

# In this example above, the condition can be read as: not those cases where the iris species is "versicolor"; in other words, since there are only three species in the iris data set, we can ignore "versicolor" to only return the other two species of interest (i.e., "setosa" and "virginica").

# ----------------------------------------------
# A Note of Caution About Conditional Statements
# ----------------------------------------------

# Logical OR and logical AND can appear in a single condition together as well, but you should be very careful when doing so. For instance, to find the flowers with relatively long or short sepal lengths within the "virginica" species, we could do the following:

range(iris$Sepal.Length) # find the range of sepal length to get an idea of what's reasonable

iris[(iris$Sepal.Length < 5 | iris$Sepal.Length > 6.5) & iris$Species == "virginica", ]

summary( iris[(iris$Sepal.Length < 5 | iris$Sepal.Length > 6.5) & iris$Species == "virginica", ] ) # 23 virginica cases

# Note that the use of parentheses around the two conditions involving sepal length are crucial in this example, since we want these two sepal length column conditions evaluated collectively (in other words, as a composite condition). In other words, the condition above is evaluated as those cases where:

# A) the sepal length is less than 5 OR the sepal length is greater than 6.5
# AND
# B) the species is "virginica"

# By contrast, notice what happens when you omit the parentheses:

summary( iris[iris$Sepal.Length < 5 | iris$Sepal.Length > 6.5 & iris$Species == "virginica", ] ) # 44 total cases

# Because of how R interprets condition order by default, the condition above is ultimately evaluated as those cases where:

# A) the sepal length is less than 5 (across all species)
# OR
# B) the sepal length is greater than 6.5 AND the species is "virginica"

# To prove this, notice the following command with added parentheses produces the same result:

identical(
  iris[iris$Sepal.Length < 5 | (iris$Sepal.Length > 6.5 & iris$Species == "virginica"), ], 
  iris[iris$Sepal.Length < 5 | iris$Sepal.Length > 6.5 & iris$Species == "virginica", ]
  )

# Again, be very careful when writing conditional statements that combine logical AND and OR to ensure the result returned is actually what you were expecting. This is true for not only R, but every language (e.g., SQL, Python, Java). And always remember: BE SURE TO CHECK YOUR WORK/RESULTS THOROUGHLY!

# -----------------
# The %in% Operator
# -----------------

# One way to reduce the likelihood of making mistakes when writing conditional statements is to use the %in% operator to write conditions involving multiple values in a particular column. Similar to the IN operator in SQL, %in% allows you to write a condition based on value matching. The following example shows how this works:

irisSetosaOrVirginica    <- iris[iris$Species == "setosa" | iris$Species == "virginica",] # select setosa or virginica species using logical OR as we did earlier

irisSetosaOrVirginicaAlt <- iris[iris$Species %in% c("setosa", "virginica"), ] # select species that match either setosa or virginica

identical(irisSetosaOrVirginica, irisSetosaOrVirginicaAlt) # identical

# The nice thing about the %in% operator is that it can help avoid mistakes when writing complex conditional statements. For example, let's investigate iris flowers with really long sepal lengths within the "setosa" and "virginica" species:

iris[(iris$Species == "setosa" | iris$Species == "virginica") & iris$Sepal.Length > 7.5,] # 6 cases

# The conditional statement above is evaluated as:

# A) the species is either "setosa" or "virginica"
# AND
# B) the sepal length is greater than 7.5

# If we accidentally omitted the parentheses, we'd get the following result:

iris[iris$Species == "setosa" | iris$Species == "virginica" & iris$Sepal.Length > 7.5,] # 56 cases

# The conditional statement above is evaluated as:

# A) the species is "setosa"
# OR
# B) the species is "virginica" and the sepal length is greater than 7.5

# Using the %in% operator to rewrite the conditions above avoids having to worry about the parentheses:

iris[iris$Species %in% c("setosa", "virginica") & iris$Sepal.Length > 7.5,] # 6 cases

# The conditional statement above is evaluated as:

# A) the species matches either "setosa" or "virginica"
# AND
# B) the sepal length is greater than 7.5

# +++++++++++++++++++++
# + Data Manipulation +
# +++++++++++++++++++++

# Data manipulation is a core competency when it comes to working with R. Thankfully, the dplyr package provides an extremely powerful, fast, and simple way of working with complex data sets. To understand dplyr, let's load the package:

library(dplyr)

# Once dplyr is loaded, suppose we wanted to calculate means and SDs for the petal length and petal width columns of iris for each of the species in the data.frame. To do this, we could use the following command:

iris %>% 
  group_by(Species) %>% 
  summarise(mean_petal_length = mean(Petal.Length), 
            sd_petal_length = sd(Petal.Length)) %>%
  arrange(desc(mean_petal_length))

# The result shows the means and standard deviations of petal length for each of the three species sorted from longest (i.e., virginica) to shortest (i.e., setosa).

# When working with dplyr, commands involve steps/stages, which are separated by an operator known as the pipe (i.e., %>%). The command above pipes through the following steps:

# 1) using the iris data set
# 2) group the data set by the Species column
# 3) summarise the data set by creating a mean_petal_length column and an sd_petal_length column using the requisite R functions (i.e., mean and sd, respectively)
# 4) arrange the data in descending order by mean_petal_length

# Several of these steps invoke dplyr functions known as verbs to help with the data manipulation process. In the example above, the verbs used included:

# group_by:   "Group by one or more variables"
# summarise:  "Reduces multiple values down to a single value"
# arrange:    "Arrange rows by variables"
# desc:       "Descending order"

# The dplyr package contains many more useful verbs in addition to the ones mentioned above verbs and is extremely flexible to suit many data manipulation needs. The best way to become comfortable working with the dplyr package is to read its introductory package vignette, which is available at:

# https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html

# This vignette covers all of the dplyr verbs noted above (and several more), along with providing helpful code examples with annotated output (i.e., similar to this bootcamp). Many R packages provide similarly useful vignettes, which can make learning new packages substantially easier. Moreover, some packages provide multiple vignettes (and this includes dplyr). To see a list of available vignettes for a package, visit its CRAN page and look under the "Vignettes" heading (e.g., you might Google "dplyr r cran" to turn up the dplyr CRAN package page and its associated vignettes) :

# https://cran.r-project.org/web/packages/dplyr/index.html

# Again, in the case of dplyr, the "Introduction to dplyr" vignette linked above provides annotated examples for commonly used verbs using the flights data set available in the package nycflights. Let's go ahead and load the nycflights13 package now as well before we explore the vignette further:

library(nycflights13)

?flights

# The flights data consists of 336,776 rows of flight data for NYC airports in 2013 (i.e., it is a relatively large data set) with 19 columns:

head(flights)
dim(flights)

# Within the vignette, you will see examples of various verbs and how they interact with the flights data set. For example, the first verb shown is filter, which allows you to subset data:

filter(flights, month == 1, day == 1) # select flights where the month is 1 and the day is 1

# Once you know a verb, you can apply it to any data set. For instance, we could use filter with the iris data set to select certain species (similar to the subset function):

summary( filter(iris, Species == "setosa" | Species == "versicolor") )

# Although most anything you can do in dplyr can also be done with base R, I highly recommend taking the time to work through the vignette and the various examples to get a handle on how dplyr works. It can save you a lot of time and help you to write clean/consistent code (I personally use it frequently).

# ++++++++++++++++++++++
# + Data Restructuring +
# ++++++++++++++++++++++

# In addition to data manipulation which can be made much easier/faster with dplyr, the package tidyr can be helpful for data restructuring tasks. A common example of data restructuring involves converting data from wide to long (aka tall) format. First, let's talk about the difference between wide and long data. Wide data has data organized primarily into sequential columns; for example, consider the following variation on the employeeData example tibble data.frame called employeeSurveyWide:

employeeSurveyWide <- tibble(
  EmployeeID = 101:106,
  FirstName = c("Kim", "Ken", "Bob", "Bill", "Cindy", "Jamie"),
  Age = c(24, 23, 54, NA, 64, 56),
  PayType = factor(c("Hourly", "Salaried", "Hourly", "Hourly", "Salaried", "Hourly")),
  SurveyItem1 = c(4, 3, 2, 5, 1, 3),
  SurveyItem2 = c(1, 2, 3, 3, 1, 4),
  SurveyItem3 = c(5, 4, 5, 5, 4, 1),
  SurveyItem4 = c(1, 1, 3, 4, 1, 1),
  SurveyItem5 = c(2, 2, 1, 3, 2, 5)
)

head(employeeSurveyWide)
dim(employeeSurveyWide) # 6 rows and 9 columns (including 5 survey item columns)

# In this example, the five "SurveyItem" columns suggest these data are arranged in the wide format, since each survey item is being given its own column, and each row represent a single participant in the survey. In other words, there are a total of 6 participants (i.e., six employees) and 5 survey item columns for a total of 30 observations (i.e., 6*5 = 30).

# Let's convert this data set to the alternative long format using the tidyr package:

library(tidyr)

employeeSurveyLong <- employeeSurveyWide %>% 
  pivot_longer(cols = SurveyItem1:SurveyItem5,
               names_to = "SurveyItem",
               values_to = "Response") # covert wide to long

head(employeeSurveyLong, 15)
dim(employeeSurveyLong) # 30 rows and 6 columns (5 survey item columns collapsed into the SurveyItem and Response columns)

# These data are now organized as long data such that each of the 6 participants has 5 rows of data (i.e., one row per survey item). This long version of the data.frame still holds the same data in terms of total observations (i.e., 6*5 = 30), but the structure is different. We can convert the long version back to wide using the spread function:

employeeSurveyBackToWide <- employeeSurveyLong %>% 
  pivot_wider(names_from = SurveyItem,
              values_from = Response)

identical(employeeSurveyBackToWide, employeeSurveyWide) # these are identical

# Some R functions expect data to be organized as long or wide depending upon how they are coded, so knowing how to transform data sets can be very valuable. A vignette for tidyr is available here with more examples:

# https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html

# Moreover, for general data manipulation in R, be sure to check out the various packages included in the tidyverse:

# https://www.tidyverse.org/packages/