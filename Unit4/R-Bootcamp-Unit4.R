# +++++++++++++++++++++++++
# +++ R BOOTCAMP UNIT 4 +++
# +++++++++++++++++++++++++
# + AUTHOR: David Dobolyi +
# +++++++++++++++++++++++++

# -- KEY CONCEPTS --

# - R packages
# - Understanding file paths
# - The working directory
# - Reading data files
# - Writing data files
# - Other ways to access data

# ++++++++++++++
# + R Packages +
# ++++++++++++++

# The functionality of R can be vastly expanded from what it includes by default by installing additional packages. These packages are made freely available by the community and are often updated to add new features or to fix potential problems. For a full list of packages (which number in the thousands), see the following links:

# list of packages by name: https://cran.r-project.org/web/packages/available_packages_by_name.html
# list of packages by task views: https://cran.r-project.org/web/views/

# To install a package in R, you have two options once you know the package's name:

# A) interactively in RStudio: Tools -> Install Packages...
# B) using the install.packages function

# It's up to you to decide how to install a package ultimately, but in terms of best practices, you should endeavour to use R functions whenever possible. That being said, there is one key point about R packages to be aware of: namely, package installation only needs to happen once per R installation. In other words, once you have installed an R package, it will stay installed for a particular version of R (e.g., R 3.5) and you will not need to install it again. In fact, it is important to avoid reinstalling packages if possible, since the process can take some time to complete and can also cause warnings from RStudio if trying to reinstall packages that are already in use in your R session.

# Let's install our first few packages, which we will use later in this script to load data files from various file sources. The packages we want to install include "foreign", "readr", and "haven"; we can install all of these packages at once using the install.packages command, which takes a vector of one or more package names you want to install:

install.packages(c("foreign", "readr", "haven"))

# Notice how running this command may take a moment or two for the command to complete in the console: installing R packages requires downloading them from the internet and unpacking them, and this may take time to complete: the amount of time it takes will vary from package to package and on the number of packages you are trying to install. You will know package installation has completely finished when the stop sign icon disapears in the top right corner of the console pane and when a message starting with "The downloaded binary packages are in" appears in the console.

# After installing an R package, you need to take one more step to actually load them. To load a package, use the library function with the name of your package:

library(foreign)
library(readr)
library(haven)

# The library function can only load one package at a time, so it's not uncommon to see a series of calls to the library function at the top of an R script file. Moreover, loading a package with library will generally not print any special output to the console, although some packages may print various messages when they are loaded which may be worth reading.

# In addition, note that while install.packages should generally not be called repeatedly, note that you can reload package libraries as many times as you like to verify that they are available for you to work with, and the process should be immediate:

library(foreign)
library(foreign)
library(foreign)

# Lastly, you can generally get help regarding the functions included in the package via the help function in conjunction with the package argument:

help(package = "foreign")

# The help function will show you a list of functions available in a package in the lower right-hand pane.

# -----------------
# Updating Packages
# -----------------

# As mentioned earlier, R packages are updated from time to time with new features or fixes. You should generally try to keep your packages updated, and you can do this two different ways:

# A) interactively in RStudio: Tools -> Check for Package Updates...
# B) using the update.packages function: update.packages()

# Again, it's up to you to decide how to invoke the package updating process. Just be careful: R will generally complain if you try to update a package you have already loaded (or if you try to reinstall a package that has already been loaded). You will often need to restart R entirely if you want to update your packages fully.

# ------------------
# Unloading Packages
# ------------------

# Although typically unnecessary, it is possible to unload a package from R without restarting R. To do so, use the detach function with the unload argument. For example, the following code would allow you to unload the foreign package:

library(foreign) # make sure foreign is loaded
detach("package:foreign", unload = TRUE) # unload foreign
library(foreign) # load foreign again

# ----------------------------------------
# Side Note: Package Loading Order Matters
# ----------------------------------------

# Although rare, it is possible for two different R packages to have a function with the same name. For example, the dplyr and car packages both have a function named recode, which serves a similar purpose in both packages (i.e., to recode factor variable labels) but has different usage across the packages. The order in which you load the packages will determine which one R will use when referring to a function, with the precedence being to use the function from the most recently loaded package:

install.packages(c("dplyr", "car")) # install the dplyr and car packages (if you haven't already)

library(dplyr)
library(car) 

# Assuming dplyr and car are each being loaded for the first time, you will see the following red message from R when loading the car package:

# The following object is masked from ‘package:dplyr’:
#     recode

# In this case, recode within car will take precedence since the car package was loaded most recently, so calling recode will now use the one from car:

?recode # note that two recode help files appear in the lower right-hand pane
environment(recode)  # <environment: namespace:car> indicates we are working with the car variant by default now 

# Let's prove this is true by recoding a factor as an example using the car syntax:

(exampleFactor <- factor(c("A", "B", "B", "B", "A"))) # create a very simple factor vector example

recode(exampleFactor, recodes = "'A' = 'Case A'; 'B' = 'Case B';") # recode the example factor with the car recode function (see the car documentation under ?recode for more details)

# In this situation, there is an obvious question: what if you really wanted to use the dplyr version of recode rather than the car version? You have two options. One is to specify the package from which you want to call the particular function formally using the double colon operator (i.e., ::):

?car::recode
?dplyr::recode

car::recode(exampleFactor, recodes = "'A' = 'Case A'; 'B' = 'Case B';")
dplyr::recode(exampleFactor, "A" = "Case A", "B" = "Case B")

# Alternatively, you can unload both packages and change the one that is considered primary by loading them in a different order:

detach("package:car", unload = TRUE)
detach("package:dplyr", unload = TRUE)

library(car)
library(dplyr)

environment(recode) # <environment: namespace:dplyr>

recode(exampleFactor, "A" = "OutcomeA", "B" = "OutcomeB") # the dplyr variant of recode

# Whatever you decide to do, just be careful: the order in which you load packages matters when working with R!

# ++++++++++++++++++++++++++++
# + UNDERSTANDING FILE PATHS +
# ++++++++++++++++++++++++++++

# Before we start reading and writing data files, we need to cover a key concept of data files: specifically, working with R often involves reading or writing data from stored in various file formats (e.g., comma separated value [CSV] files). Assuming you would like to work with a data file stored locally on your computer, you will need to know each of the following aspects of the file to load it into R:

# 1) the file path: where the file is located on your disk/drive (e.g., ~/Documents/Data or C:\Data)
# 2) the file name: what the file is called (e.g., datafile; my_data_1)
# 3) the file extension: what type of file you are working with (e.g., .csv; .txt; .sav)

# A fully specified file path, name, and extension of a file may appear as follows:

# A) Mac/Linux: ~/Documents/datafile.csv
# B) Windows: C:\Data\datafile.csv

# The first thing to notice here is that Mac/Linux and Windows have some slight differences in terms of how file paths are specified: namely, Mac/Linux file paths use forward slashes while Windows paths use backslashes. The type of slash matters when it comes to R since we will need to supply various R functions file paths via character strings: as such, since the backslash is a special character in R (i.e., it is used as the escape character), we will need to either A) escape forward slashes when specifying the location of a file via a string or B) substitute forward slashes. For instance, consider the following examples of valid-looking paths:

"~/Documents" # Mac/Linux
"C:\\Data"    # Windows (option A)
"C:/Data"     # Windows (option B)

# Again, the two Windows examples above (i.e., options A and B) are identical and thus are interchangeable. Ultimately, as long as the path you specify is correct and valid, it is irrelevant how you decide to write it.

# What is not irrelevant however is the need to include both the file name and extension when referring to a file location in R. File Explorer on Windows or Finder on Mac can be used to find files you are looking for, although to see the extension you may have to adjust some options in the respective program:

# A) Finder (Mac): Finder -> Preferences -> Advanced Tab -> Check "Show all filename extensions"
# B) File Explorer (Windows 10): View Tab -> Options Button -> View Tab -> Uncheck "Hide extensions for known file types"

# Alternatively, R provides some helpful functions that allow you to interactively locate the full path, name, and extension of a file using a standard system dialogue:

# file.choose()

# --------------
# Home Directory
# --------------

# One other point regarding paths that you may or may not have noticed above is the use of a tilde (~) in the Mac/Linux file path example above. Without getting too technical, the ~ in the path refers to your home ($HOME) directory; for a Mac/Linux user, you can determine what you home directory is with the following command:

system("echo $HOME") # e.g., this might return something like /Users/xyz on Mac/Linux based on the current user

# On a Windows computer, your home directory will be the Documents folder of your current user (e.g., "C:/Users/David Dobolyi/Documents").

# Regardless of where it points, the primary purpose of ~ is to allow you to omit an explict home directory specification when writing a path in R. In other words, on a Mac, the following two paths are identical assuming the home directory of the current user is /Users/dd2es:

# A) "~"
# B) "/Users/dd2es"

# Again, it is up to you if you would like to use ~ when specifying paths on Mac/Linux. The upside of doing so is that you will not need to alter your scripts when working across various computers and/or user accounts (i.e., since the home directory is computer/user specific). In other words, the use of ~ is primarily for convenience and interoperability.

# +++++++++++++++++++++++++
# + THE WORKING DIRECTORY +
# +++++++++++++++++++++++++

# Now that we have a basic understanding of file paths, names, and locations, it's important to talk about the concept of a working directory. When working with R, it is generally a good idea to be organized and place your scripts and data into a directory (aka folder) on your computer where everything can be found in one place. If you do this, you will benefit greatly from setting a working directory, which is a way of letting R know where to look for or put files by default. To check your current working directory, use the getwd function:

getwd()

# RStudio will set a default working directory for you depending on how you start the program. However, generally speaking you will want to set your own working directory, which can be done in two ways:

# A) interactively in RStudio: Session -> Set Working Directory -> Choose Directory...
# B) using the setwd function with a specified path (e.g., setwd("~/Documents/ResearchProject"))

# In general, it is a good idea to use the setwd function in place of the interactive option, since the function allows you to make setting the working directory part of your R script. Conveniently, if you use the interactive approach to set your working directory, you will notice a setwd command will appear in your console after choose a working directory; you can copy and paste this command back into your R script for future reference if desired.

# In any event, you can use the R function list.files to see a list of all the files and folders in your current working directory:

list.files()

# --------------
# Relative Paths
# --------------

# A common point regarding working directories is that you may have subdirectories within a particular working directory. For instance, assuming your working directory is "~/Documents/ResearchProject", this folder may have a data subdirectory like "~/Documents/ResearchProject/Data", and this folder may in turn contain a data file you would like to load (e.g., "~/Documents/ResearchProject/Data/ExampleData.csv"). This example brings up an important aspect of working directories, which are relative paths. Relative paths allow you to specify the location of a file or folder relative to your working directory.

# To see how this works, unzip "R-Bootcamp-Unit3-Data.zip" (i.e., do not simply open/browse it) and then set your working directory to the folder "WorkingDirectoryExample":

# setwd("~/Downloads/WorkingDirectoryExample")

# The following list.files calls will show you how to access various subdirectories relative to your working directory:

getwd()

list.files()
list.files("Data Files")
list.files("Data Files/More Data")

# It is also possible to step down a folder when supplying a relative path by using periods (i.e., "."). To see how, try setting your working directory to the "Data Files" folder inside of "WorkingDirectoryExample" first:

# setwd("~/Downloads/WorkingDirectoryExample/Data Files")

getwd()

list.files()
list.files("More Data")
list.files("..")  # step down a folder

# Once again, keep in mind you do not have to use relative paths when working with R and can choose to fully specify every path in your script. However, understanding how relative paths work can drastically simplify your work while allowing you to keep your working directory organized.

# ++++++++++++++++++++++
# + READING DATA FILES +
# ++++++++++++++++++++++

# Base R provides several built-in functions to read data files; the most commonly used of these include read.table and various predefined variants including read.csv and read.delim. Each of these functions is designed to load in tabular data as a data.frame from simple, text-based data files (i.e., files that can be opened and viewed in a text editor like Notepad [Windows], TextEdit [Mac], or Atom [Universal]). 

# Typically, these data files use either a comma or a tab to separate data values; moreover, the individual data values may also be encapsulated in quotes (particularly if character/string data are involved), although this will vary from file to file (e.g., it's up to you to determine the right separator, potentially by opening the file in a text editor first).

# Common data files that fall under this umbrella include:

# CSV/TSV:    comma/tab separated value

# While base R functions such as read.csv are commonly used by many (i.e., I often use them for simple tasks myself), the readr package (https://readr.tidyverse.org/) can be significantly faster for reading these types of files, so I will provide examples below using both base R and readr functions (ultimately it's up to you to decide which to employ in your own work).

# Moreover, in the following sections, I will also cover other common data file formats including:

# XLS, XLSX:  Microsoft Excel
# SAV:        SPSS
# SAS:        SAS including .sas7bdat and .sas7bcat extensions
# DTA:        Stata

# I will show how to use various packages (e.g., foreign, haven) to work with these files.

# Finally, I will provide a brief description of the data.table package, since it offers an extremely fast and straightforward way of reading small or large (e.g., big data) text-based data files into R. Other packages worth exploring yourself include: jsonlite, XML, httr, feather, googlesheets, sparklyr (R Interface to Apache Spark), fst

# -----------------------
# CSV Files (base, readr)
# -----------------------

# As noted above, we will read in simple, text-based data files in R using both the base read.csv function as well as the readr package.

# Before we can read in a data file, we need to make sure we can provide a valid path to access it. Since paths can be relative as described in the preceding section, we can use setwd to establish our working directory first and then use a relative path to our file in function arguments. For example:

setwd("~/Downloads/WorkingDirectoryExample") # set the working directory (change this for yourself as needed)
list.files() # list files in the working directory
list.files("Data Files") # list files inside the Data Files subfolder

# Now that we have determined a valid path, we can read in some data. Let's start by reading in the "ExampleData.csv" file, which is a CSV file based on its extension:

CSV_base_example <- read.table(file = "Data Files/ExampleData.csv", header = TRUE, sep = ",", quote = "\"")

# A few notes regarding the arguments above:

# A) file:    the path to the data file you want to import
# B) header:  specify whether or not the data file has a header row, which lists each of the column names; if you supply the wrong argument, you will likely see an obvious problem when exploring the data you read in
# C) sep:     the separator character, which is typically (but not necessarily) "," (for CSV) or "\t" (for TSV); you may need to open the file (e.g., in a text editor if the file is small) manually to verify the separator being used
# D) quote:   the quoting character used to encapsulate data points (again, you may need to verify this manually)

# Keep in mind you may need to alter some of the arguments to suit the particular data file you are trying to import. Conveniently, read.table provides a set of functions with different default arguments to suit common text data files, including CSV (read.csv) and TSV (read.delim). For instance, read.csv would work perfectly for a typical CSV file such as the one in our example:

CSV_base_example <- read.csv("Data Files/ExampleData.csv") # identical to the read.table command above

# Regardless of which function you use or how you set up the arguments, you should verify that the imported data look correct using some data.frame functions we have seen previously:

head(CSV_base_example)
str(CSV_base_example)

# As always, be sure to run the str function to verify the data types in each of the columns and use functions to set the data types accordingly (e.g., as.factor, as.character).

# The readr package provides an alternative approach to reading in CSV and TSV data files that some may prefer:

library(readr) # make sure the readr package is loaded, just in case you didn't load it earlier

CSV_readr_example <- read_csv("Data Files/ExampleData.csv")
head(CSV_readr_example)

# Compared to base R functions, readr is typically faster, the argument specification is more consistent, and the column data types may be set more aptly. Moreover, readr loads the data table in the tibble format (i.e., see ?tibble), which is a data structure essentially interchangeable with data.frame (e.g., extractors such as $ will work identically across both) that provides a few additional features/qualities that may make it preferable to the base R data.frame structure:

head(CSV_base_example)   # data.frame output
head(CSV_readr_example)  # tibble output

class(CSV_base_example)
class(CSV_readr_example)

# It is possible to convert a data.frame to a tibble and vice versa via various functions:

head(as.data.frame(CSV_readr_example)) # convert a tibble to a data.frame

library(tibble)
head(as_tibble(CSV_base_example))      # convert a data.frame to a tibble

# It's ultimately up to you at this point to use data.frame vs. tibble, but many functions we will work with output tibbles (e.g., dplyr), so it's worth being aware of both formats.

# ------------------
# XLS, XLSX (readxl)
# ------------------

# R is capable of reading in Excel data (e.g., XLS, XSLX) directly using the readxl function. Using this function can save you the trouble of opening the file in Excel and converting it to another format (e.g., CSV) for example. The most relevant function in the package is read_excel:

library(readxl)

XSLX_readxl_example <- read_excel("Data Files/ExampleData.xlsx", sheet = 1) # note the sheet specification argument
head(XSLX_readxl_example)

# The readxl package provides various functions that can simplify working with these types of files. For example, to get a list of all sheets in an Excel file, you can use the excel_sheets function:

help(package = "readxl") # see a list of functions in readxl
excel_sheets("Data Files/ExampleData.xlsx") # this file only has one sheet

# --------------------
# SAV (foreign, haven)
# --------------------

# For SPSS users, you have two options to read SPSS files (e.g., .SAV). The first is to use the long-standing foreign package, which provides the read.spss function:

library(foreign)

SAV_foreign_example <- read.spss("Data Files/ExampleData.sav", to.data.frame = TRUE)
head(SAV_foreign_example)

# Use of this function is generally straightforward, although be sure to set the to.data.frame argument to TRUE if you want the data imported as a data.frame object. It's worth mentioning the use.value.labels argument, which can be helpful for reading in nominal (factor) columns as integer values directly instead of as SPSS value labels:

SAV_foreign_example_alt <- read.spss("Data Files/ExampleData.sav", to.data.frame = TRUE, use.value.labels = FALSE)
head(SAV_foreign_example_alt)

SAV_foreign_example$satisfaction_score # value labels from SAV_foreign_example
SAV_foreign_example_alt$satisfaction_score # actual values from SAV_foreign_example_alt

# Moreover, in case you want to see the column labels provided by SPSS when working with read.spss, you can use the attr function to extract them:

attr(SAV_foreign_example, "variable.labels")

# Finally, as an alternative, you can use the read_sav (aka read_spss) function in the haven package to read in SPSS files:

library(haven)
help(package = "haven") # see a list of functions in haven

SAV_haven_example <- read_sav("Data Files/ExampleData.sav")
head(SAV_haven_example)

# ---------------------
# SAS and Stata (haven)
# ---------------------

# For SAS and Stata users, the haven package also allows for you to read in files from those programs:

library(haven)

SAS_haven_example <- read_sas("Data Files/ExampleData.sas7bdat") # read SAS
head(SAS_haven_example)

DTA_haven_example <- read_dta("Data Files/ExampleData.dta") # read Stata (DTA)
head(DTA_haven_example)

# For older Stata data files (lower than version 8), you may also consider using the read.dta function in the foreign package.

# ----------------------
# Noteworthy: data.table
# ----------------------

# I will not cover reading or writing data with the data.table package in this tutorial primarily because it requires explaining another variation on the data.frame data structure: the data.table, which has its own unique syntax and rules. However, the data.table package is worth mentioning since it is an excellent package for working with larger data files efficiently. In terms of reading data, data.table's fread function is both extremely fast and extremely smart: it is capable of automatically determining the correct separator/quote parameters for various text data files. Moreover, the fwrite function provides an extremely fast way of writing CSV data files compared to the base write.csv function. I highly recommend checking out the data.table package if you ever need to work with big data files or if you have trouble reading in data with either base R or readr.

# ++++++++++++++++++++++
# + WRITING DATA FILES +
# ++++++++++++++++++++++

# When it comes to writing data with R, it is highly recommended to use a data format that is not proprietary (e.g., SPSS), since these data formats may cause problems when importing them elsewhere (e.g., you cannot open an SPSS SAV file directly in Excel). Generally speaking, CSV files are universal and thus are a good option, although file sizes can become large (e.g., zipping CSV files can save a lot of space).

# In this tutorial we will focus on writing data to CSV files while also touching on alternatives for other formats.

# ------------------
# Writing CSV (base)
# ------------------

# Writing a CSV file with R is straightforward using the write.csv function. The key arguments you will need to specify are the data.frame you want to export and a path for the desired output file. The default values are mostly fine for the remaining arguments, but you will likely want to set row.names to FALSE to avoid writing out R's row name labels to your CSV file:

write.csv(CSV_readr_example, file = "Data Files/More Data/WriteExampleData.csv", row.names = FALSE)

# Notice that no assignment is necessary to write a data file with R (i.e., because the data are being exported out of R).

# As mentioned earlier, see the fwrite function in the data.table package for an extremely fast alternative to the write.csv function for working with big data sets.

# -----------------------------
# Writing Other Formats (haven)
# -----------------------------

# The haven package supports writing SPSS, SAS, and Stata files. Again, the key arguments you will need to specify are the data.frame you want to export and a path for the desired output file:

write_sav(CSV_readr_example, "Data Files/More Data/WriteExampleData.sav")
write_sas(CSV_readr_example, "Data Files/More Data/WriteExampleData.sas7bdat")
write_dta(CSV_readr_example, "Data Files/More Data/WriteExampleData.dta")

# Remember, this tutorial only covers a few options for writing data files. There are many other packages available that can help with specific use cases (e.g., to write Excel data, see the package xlsx).

# +++++++++++++++++++++++++++++
# + OTHER WAYS TO ACCESS DATA +
# +++++++++++++++++++++++++++++

# R supports reading data from sources besides files. One such example is R's ability to read data directly from SQL databases: the R package odbc will allow you to connect to any of the following DBMS platforms: "SQL Server, Oracle, MySQL, PostgreSQL, SQLite and others" (see https://db.rstudio.com/odbc/ for details and usage examples). Other relevant packages for working with SQL database in R include: dbplyr, RMySQL, RPostgreSQL, ROracle, sqldf