# +++++++++++++++++++++++++
# +++ R BOOTCAMP UNIT 1 +++
# +++++++++++++++++++++++++
# + AUTHOR: David Dobolyi +
# +++++++++++++++++++++++++

# -- KEY CONCEPTS --

# - Installing R and RStudio
# - The RStudio interface
# - Arithmetic operators and mathematical functions
# - Using functions and getting help

# ++++++++++++++++++++++++++++
# + INSTALLING R AND RSTUDIO +
# ++++++++++++++++++++++++++++

# To get started working with R, we will install two key pieces of free open source software (FOSS):

# 1) R
# 2) RStudio

# R can be retrieved from its official site: The Comprehensive R Archive Network (CRAN; https://cran.r-project.org/). Depending on your operating system (OS), you will want to download the appropriate version. These include:

# A) Mac:       https://cran.r-project.org/bin/macosx/
# B) Windows:   https://cran.r-project.org/bin/windows/base/
# C) Linux:     https://cran.r-project.org/bin/linux/

# RStudio can also be retrieved from its official site (https://www.rstudio.com/). Note that RStudio is technically not required to work with R, but it provides an integrated development environment (IDE) that has a uniform look across OSs and provides several useful features not available with base R graphical user interface (GUI) such as auto-saving and version control integration.

# Once you have installed both R and RStudio, launch RStudio and then go to File -> Open File... to open this R script (rBootcamp-Unit1.R) for the next step.

# -----------------------------------
# Side Note: RStudio File Association
# -----------------------------------

# By default, R script files opened via your file manager (e.g., Finder on Mac or File Explorer on Windows) may not open in RStudio, but rather in the base R GUI (e.g., RGui/R.app GUI) or some other app. If you'd like to ensure RStudio is the default file handler for R scripts, you will need to do the following:

# A) Mac: Open Finder and browse to an R script (e.g., rBootcamp-Unit1.R). Right click on it and select Get Info from the menu. In the window that pops up, look under "Open with:" and make sure RStudio.app is selected. Afterwards, click the "Change All..." button and click Continue to have this take effect moving forward. 
# B) Windows: The easiest option -- assuming you haven't tried double clicking on any R scripts yet -- is to open File Explorer, browse to an R script (e.g., rBootcamp-Unit1.R), and double click on it. A prompt should appear asking you "How do you want to open this file?" Select RStudio from the list, make sure "Always use this app to open .R files" is checked (the default), and click OK. You should be all set. Alternatively, if you find R is already set to open in a different app, you can still change the default app to RStudio manually. First, right click on the R script file, select Properties, and on the General tab, under "Opens with:", click the "Change..." button. Now you should see the prompt asking you "How do you want to open this file?" -- follow the steps described earlier to complete the process.

# +++++++++++++++++++++++
# THE RSTUDIO INTERFACE +
# +++++++++++++++++++++++

# In addition to the main menu (e.g., File), the RStudio interface consists of several panes. In the default configuration, the most relevant panes are on the left-hand side: R script code (e.g., this script) will appear in the top left Source pane and executed commands and output will appear in the Console in the bottom left. The right-hand side contains the environment pane in the top right (more on this later) and a viewer pane on the bottom right, which will eventually show plots, help files, etc. as we dive further into working with R.

# The RStudio interface can be customized to your liking via the Tools menu (Tools -> Global Options...). Although these options are ultimately up to the user's personal preferences, I recommend making the following adjustments for the time being (#2 is particularly important from a usability perspective when working with this script):

# 1) In the General tab, set "Save workspace to .RData on exit" to "Never"
# 2) In the Code tab, make sure "Soft-wrap R source files" is checked

# As noted above, most of the work you do in R will take place in the top left Source pane where R script code appears. While it is also possible to enter commands directly into the Console in the bottom left (e.g., try entering 1+1 and hitting enter), any work you intend to save or refer back to should be added to your script on the top left. Code entered into this pane can be saved and open later as needed via File -> Save or via the save button (Floppy Disk icon) near the top left.

# A quick but important note on R scripts: comments! Comments are text that begin with a pound sign (i.e., #) and appear in green (such as this text) that can help explain what is happening in a script. As a general rule, you should try to include plenty of comments in scripts you write so that 1) you can understand why you wrote the code you wrote, especially after coming back to it weeks/months/years later; 2) so others can also understand your code in cases where you are collaborating (e.g., group projects).

# Besides comments, R scripts will obviously contain actual code that is meant to be executed. For example, your script may contain some basic algebra:

1+1

# Regarding this line of code above, there are several ways to execute it from within the script. One option is to highlight the code you want to run with your mouse and either 1) click the Run button in the top-right portion of the Source pane; or 2) use the run shortcut (command + Enter on Mac; Ctrl + Enter on Windows). Alternatively, if you want to run an entire line of code -- as you will commonly want to do -- simply place your cursor anywhere on the relevant line of code (either using the mouse or the keyboard) and use the run button or shortcut to execute it.

# No matter how you run code from within a script, you will see output in the Console pane in the bottom left. Specifically, the command you ran will appear next to a greater than sign (e.g., "> 1+1") followed by the result immediately after (e.g., "[1] 2"). Note that in the example of 1+1, the result is 2, but you will also see a bracketed [1] on the start of the result output. This [1] simply provides an indication of how many different pieces of output have been returned; for now, we only have one value returned, but as we will see later, it is possible for the result to contain many values.

# Finally, it's worth noting that you can combine code and comments on a single line if desired as long as code precedes the comment:

1+1 # the result will be 2

# Before moving on to basic arithmetic operations in R beyond 1+1, there are a few important aspects of the interface worth pointing out that should help with your productivity:

# First, it is possible to clear the Console window at any time; this can be done from the menus via Edit -> Clear Console or via the shortcut control + L.

# Second, the Console provides a history of executed commands that can be accessed using the keyboard. To see this history, click inside the Console to activate it. Notice that the cursor will become solid black and begin to blink when you click within either the Source or Console panes, respectively, depending on where you want to input code (i.e., you can switch between them as needed). To see the history, use the up and down arrow keys on the keyboard. Although you should typically avoid entering code directly in the Console and use the Source pane instead (i.e., so you have a permanent history of your work), this history feature can still be useful on occasion (as an aside, you can also see your history via the History tab in the top right pane).

# Third, you can use find and/or find and replace functionality to quickly make multiple changes throughout a script file, similar to office applications such as MS Word. You can access find and replace via the Edit menu (Edit -> Find...). A useful aspect of find and replace is the ability to use the "In selection" checkbox to match instances only within highlighted code as opposed to the entire script.

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# + ARITHMETIC OPERATORS AND MATHEMATICAL FUNCTIONS IN R +
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# As we saw earlier with the example of 1+1, basic arithmetic can easily be done with R:

1+1

# As you might expect, R provides all of the important arithmetic operators you might need besides addition. The following is a complete list:

2+2   # addition
2-2   # subtraction
2*2   # multiplication
2/2   # division
2^2   # exponents (see note below)
5%%2  # modulo (aka modulus or remainder)
5%/%2 # integer division (quotient with the remainder discarded)

# Within the list above, it is important to be careful with some of these operators when working within a programming context. For example, regarding exponents, notice that while 2^2 will return what you expect (i.e., 4), you may be surprised by what -2^2 returns:

-2^2

# The solution to this problem is careful use of parentheses, which we will discuss further in the next section:

(-2)^2

# It is also worth noting that there is flexibility regarding how you use spaces (i.e., white space) when typing code. The following commands all work and are all equivalent for example:

2+2
2+ 2
2 +2
2 + 2
2   +   2

# It is up to you to decide how best to use spaces when writing your code, but generally speaking, you should focus on maximizing code readability (e.g., many would argue 2+2 is less legible than 2 + 2). Moreover, it is worth noting that besides spaces, there are other types of white space characters you can use including tabs and newlines/line breaks (i.e., hitting enter while entering text). For example, consider the following code that includes a line break:

2 -
2

# If you place your cursor on either line of the code above and hit run, you will receive the expected result of 0: ultimately this code works because R expects an addition operation will consist of two values, so it will run both lines of codes automatically. Generally speaking however, it is a good idea to avoid splitting up code across multiple lines in this fashion since it can lead to unintentional mistakes.

# Another important point to mention is what happens when you fail to provide R with enough information regarding a command to execute. For instance, try running the following code without the leading pound sign (i.e., #) highlighted:

# 2 * 
  
# Notice that no result is returned, which is unsurprising given that you would need to provide another value to perform multiplication. However, what's more important is that R will wait for you to provide the missing value, as seen in the console:
  
# > 2 *
# + 
  
# At this point, you have two options: 1) you can provide the missing value to complete the operation (e.g., by typing it into the Console); or 2) you can hit the escape key (i.e., esc) to cancel the operation.

# Although this example is trivial, keep in mind the escape key solution, since it is very possible to get "stuck" in the console when working with R, particularly, when working with parentheses, so it's important to know how to resolve the situation when it arises.

# -------------------
# Multiple Operations
# -------------------

# Thus far, all the examples that we have seen involve a single operation. However, R allows you to execute multiple operations in a single command. For example:

2 * 2 * 3 - 1 + 5

# As with any arithmetic operation, the standard order of operations applies: 1) parentheses; 2) exponents; 3) multiplication/division; 4) addition/subtraction. Regarding parentheses in particular, these can be very useful to make order of operations clearer when the command is complex:

((5 * 3) - (2 * 4)) / (3 + 1)

# Dealing with multiple parentheses is common but can be difficult when code is dense. Fortunately, RStudio provides a highlighting system to help see which parentheses belong together (e.g., place your cursor on the far-left side of the command above and use the right arrow key to move the cursor to the right -- notice how different parentheses become highlighted as you do this).

# A common error when working with R is the failure to close all parentheses (or to close them incorrectly, which can be even worse since it may produce the wrong result -- be careful and always check your work!). For instance, try running the code below without the # sign:

# ((5 * 3) - (2 * 4) / (3 + 1)

# Notice R will not complete the command. Instead, you will see the following in the console:

# > ((5 * 3) - (2 * 4) / (3 + 1)
# +

# The issue here is a missing parenthesis after "4)"; again, keep in mind you will need to use the escape key (i.e., esc) to resolve the stuck console caused by entering an incomplete command.

# ----------------------
# Mathematical Functions
# ----------------------

# We have already discussed arithmetic operators, but R also provides several useful mathematical functions that are worth knowing about. A non-exhaustive list of these includes:

sqrt(25)      # square root
abs(-25)      # absolute value
log10(100)    # logarithm (base 10)
log(100)      # natural log
exp(4.60517)  # natural exponent (i.e., e)

# Unlike the operators shown earlier which involved a single symbol, each of these operations requires the use of a function, which is an aspect of R we will work with a lot moving forward. All functions in R have: 1) a name; and 2) one or more arguments that the function takes within the parentheses. In the case of the first example above involving square root, the name of the function is sqrt and the argument is a single value (e.g., 25).

# ++++++++++++++++++++++++++++++++++++
# + USING FUNCTIONS AND GETTING HELP +
# ++++++++++++++++++++++++++++++++++++

# The introduction of functions raises an important point about R: namely that it is possible to get documentation for any function (or operator, etc.) via the help operator "?":

?sqrt

# Notice when you run the line above, a help document will appear in the lower right pane with the heading "Miscellaneous Mathematical Functions". By reading through this help file, you can get a sense of what a function does, what arguments it takes, and also see some example code that uses the function in question at the very bottom:

require(stats) # for spline
require(graphics)
xx <- -9:9
plot(xx, sqrt(abs(xx)),  col = "red")
lines(spline(xx, sqrt(abs(xx)), n=101), col = "pink")

# The most useful aspect of help files however is typically the list of arguments, shown under the "Arguments" subheading. Arguments are used to control what a function does; some arguments may be mandatory, while others may be optional or have default setting values.

# Because arguments are so fundamental when working with functions, you can also preview them in RStudio by hovering your mouse cursor over a function name to see what arguments are required/available. Notice that for sqrt, only a single argument is listed: x (a numeric or complex vector or array). Technically, this means that sqrt could be called precisely via:

sqrt(x = 25)

# This command indicates that we are supplying the argument named x a value of 25, which is the number we want to find the square root for. When it comes to functions like sqrt that take a single argument, it is common to omit the argument name when specifying the function call as shown earlier in this script:

sqrt(25) # equivalent to sqrt(x = 25)

# However, some functions take more than one argument; for example, the log function used earlier can take up to two, as shown via ?log:

?log

# Notice how for the second argument, base, a default value of exp(1) is indicated in the help file; this means that by default, R will assume you want to use a base of exp(1) (i.e., e) when calling the log function, which is equivalent to a natural log. Thus, all of the following commands return an identical result:

log(100)
log(100, base = exp(1))
log(x = 100)
log(x = 100, base = exp(1))
log(base = exp(1), x = 100)
log(100, exp(1)) # this is slightly dangerous; for example, try log(exp(1), 100)

# Note that by providing the names of arguments explicitly, you can change the order in which you supply them. If you do not supply argument names explicitly, R will assume you are providing arguments in the order they are listed in the Arguments subsection of the help file. In general, it is a bad idea to omit the name of an argument for any argument besides the first one. In other words, the following commands are generally acceptable practice:

log(100)
log(100, base = exp(1))

# However, the following commands can be dangerous if you accidentally provide arguments in the wrong order:

log(100, exp(1)) # if this is the intended call
log(exp(1), 100) # this call could lead to a big mistake

# Thus, you should pay attention when working with any function that takes more than one argument. 

# Regardless of how you specify them, arguments are extremely useful. For example, by changing the base of the log function, you can use it for multiple purposes. For example, to calculate a 10-based log rather than the natural log, you could use the following command:

log(100, base = 10) # equivalent to log10(100)

# Whenever you encounter a new function, be sure to familiarize yourself with its arguments so you fully understand how it works and what possibilities it provides.

# ------------------
# Help for Operators
# ------------------

# In the case of operators such as addition, note that you need to slightly change the way you call help by placing the operator in quotes (i.e., ?+ won't work):

?"+"

# Technically you can use quotes with any function to look up help, but it is generally not necessary. In other words, the following help commands are all equivalent:

?sqrt
?"sqrt"
?'sqrt'

# Finally, you can also use the help.search function to try to find relevant help files, although it is often better/easier to search Google instead:

help.search("arithmetic operator")

# Results of help.search will appear in the lower right pane. Compare this result with the following URL (you can execute a URL from RStudio via control + click or command + click on the Mac or via shift + click on Windows):

# http://lmgtfy.com/?q=arithmetic+operator+r