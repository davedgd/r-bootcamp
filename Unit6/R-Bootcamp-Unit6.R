# +++++++++++++++++++++++++
# +++ R BOOTCAMP UNIT 6 +++
# +++++++++++++++++++++++++
# + AUTHOR: David Dobolyi +
# +++++++++++++++++++++++++

# -- KEY CONCEPTS --

# - Basic (base) plotting
# - Saving plots to disk
# - Plotting with ggplot2
# - Plotting with lattice

# +++++++++++++++++++++++++
# + Basic (base) Plotting +
# +++++++++++++++++++++++++

# Now that we have covered the fundamentals of data.frame objects, it is worth focusing on another key aspect of data analysis: visualization. Base R provides a number of plotting functions that can be useful for quickly visualizing some data. Although not all basic R plots will be covered (e.g., pie charts and violin plots are not included), several key plot types will be showcased in the examples below:

# -------------------------------------
# Point Plots and the Formula Interface
# -------------------------------------

# The most basic of these functions is plot, which is used for "Generic X-Y Plotting" (aka scatterplots):

?plot

# To see how plot works, let's try an example involving the cars data set:

data(cars)

# As described in ?cars, the cars data set is made up of two columns:

# speed: Speed (mph)
# dist:  Stopping distance (ft)

# Let's plot these two columns against one another:

plot(x = cars$speed, y = cars$dist) # how would you describe this relationship?

# The plot should appear in the Plots pane in the lower right. Note that although the call above works, the plot function (along with many other R functions) can (and more accurately should) be used with the model formula interface, which involves the ~ (tilde) symbol:

?"~"

plot(dist ~ speed, data = cars)

# The formula can be read as y (dist) on the left determined by the model formula on the right (speed). Notice that when using this formula notation (i.e., Wilkinson-Rogers notation), it is not necessary to include the name of the data.frame when supplying formula terms, since the data argument makes this explicit (e.g., use speed and not cars$speed if using formula notation). As a rule, avoid using the name of the relevant data.frame object when writing formulas to avoid problems.

# In general, the formula notation should be preferred when working with most functions. We will refer to the formula notation in the future for many statistical functions. As a quick preview, consider the following code to add a line showing the correlation between speed and distance:

plot(dist ~ speed, data = cars)
abline(lm(dist ~ speed, data = cars))

# Regardless of how you call the plot function, keep in mind it has many arguments to tweak your plots if desired. For instance, we can use a series of arguments including 

plot(dist ~ speed, data = cars, 
     main = "Stopping Distance Relative to Car Speed", 
     xlab = "Speed (mph)", 
     ylab = "Stopping Distance (ft)",
     cex = 1.8,
     col = "blue",
     pch = 16,
     cex.axis = 1.1,
     cex.main = 2.0,
     cex.lab = 1.25)

abline(lm(dist ~ speed, data = cars), 
       col = "red",
       lty = 5,
       lwd = 3)

# ----------
# Line Plots
# ----------

# The plot function can also be used to generate other types of plots via the type argument. For instance, to generate a line plot, set the type to "l":

linePlotDat <- data.frame(
  x = 1:8,
  y = c(3,3,1,2,3,0,0,0)
) # some example data

plot(y ~ x, data = linePlotDat, type = "l")

# You can also use the "o" (overplotted) type for both points and lines:

plot(y ~ x, data = linePlotDat, type = "o")

# A more interesting example uses the LakeHuron time series data (time series data are a special data structure in R, but are comparable to a vector):

data(LakeHuron)
?LakeHuron

class(LakeHuron)
?ts

length(LakeHuron)

plot(x = 1875:1972, y = LakeHuron, type = "l", xlab = "Year", ylab = "Measured Level (ft)") # see time(LakeHuron) for an alternative x specification

# ------------------------
# Bar Plots and Histograms
# ------------------------

# The aptly named barplot function can be used to generate bar plots based on a table of data:

data(mtcars) # use the mtcars data for these examples

barplot(table(mtcars$gear))

# Similarly, the histogram function can be used to generate histograms:

hist(mtcars$mpg)

# As with plot, the histogram could be tweaked to look better by changing various arguments/defaults (breaks in particular is an important argument):

hist(mtcars$mpg, 
     col = "lightblue",
     xlab = "MPG",
     main = "Histogram of MPG",
     cex.axis = 1.1,
     cex.main = 2.0,
     cex.lab = 1.25,
     breaks = 10)

# ---------
# Box Plots
# ---------

# R can also quickly generate a standard box and whisker plot via the boxplot function:

data(InsectSprays) # use the InsectSprays data for this example

?InsectSprays

# count: Insect count
# spray: The type of spray

boxplot(count ~ spray, data = InsectSprays, col = "lightgray")

# ++++++++++++++++++++++++
# + Saving Plots to Disk +
# ++++++++++++++++++++++++

# Plots generated in R can be saved to disk for use elsewhere. The RStudio interface provides a way to save plots in the lower right pane via Export -> Save as Image... and/or Export -> Save as PDF... depending upon the desired format.

# It is also possible to save R plots using code consistent with concepts introduced in previous units. To save an R plot as a PDF for example, you can use the generic pdf function in conjunction with dev.off:

# setwd("~/Downloads") # saved plots will appear in the working directory

pdf(file = "InsectSpraysBoxplot.pdf", width = 8, height = 5) # width/height in inches
boxplot(count ~ spray, data = InsectSprays, col = "lightgray")
dev.off()

# It is important to remember to run the dev.off function after your plot code to tell R all plots have been printed to the request file. If you find your plot printing is not working, run dev.off() repeatedly (until you see "null device 1") to close all plot writing devices.

# R can also save plots in other formats besides PDF, including PNG and various other image formats (e.g., bmp, jpeg, tiff; see ?png for more). To generate a PNG, use the png function in conjunction with dev.off:

png(file = "InsectSpraysBoxplot.png", width = 800, height = 500) # width/height in pixels
boxplot(count ~ spray, data = InsectSprays, col = "lightgray")
dev.off()

# Note that I will cover an alternative method of saving plots specific to ggplot2 in the following section.

# +++++++++++++++++++++++++
# + Plotting with ggplot2 +
# +++++++++++++++++++++++++

# The ggplot2 package is currently the de facto method for creating attractive plots with R:

library(ggplot2)

# Similar to dplyr, ggplot2 makes the language of plotting in R more consistent, with functions that can be used to tweak plots working similarly regardless of the type of plot in question (e.g., scatterplot vs. boxplot; these different types are referred to as geoms in the language of ggplot2).

# At their core, ggplots must include a few basic components:

# A) an initial call to the ggplot function, which sets up the plot and specifies a data source
# B) a set of aesthetics in one or more calls to the aes function, which establishes the mapping between what you want to see and where it can be found in the data (i.e., typically column names)
# C) a set of geoms -- or layers -- that determine the type of plot to be created, e.g., geom_point, geom_line, etc.

# For example, consider the following code, which recreates our earlier point (or scatter) plot:

ggplot(cars, aes(x = speed, y = dist)) + 
  geom_point()

# The first line (i.e., starting with ggplot...) establishes our plot; the data are referenced in the first argument (i.e., cars) and subsequently the aes function is used to set up our axes (i.e., speed on x and dist on y, which are columns from cars):

head(cars)

# Notice that we do not need to reference the name of the data set more than once beyond in the initial call to the ggplot function. In other words, when setting up the references

# With the data source and aesthetic mapping in place, we simply have to add (i.e., with a "+" symbol) the geom layer we desired, which in this case is geom_point. Note that without adding the geom_point, we'd simply have an empty plot with established axes but no layers:

ggplot(cars, aes(x = speed, y = dist))

# To actually see data on the plot, we need at least one geom, and possibly several:

ggplot(cars, aes(x = speed, y = dist)) +
  geom_point() + 
  geom_smooth()

# In the modified code above, we put back in the geom_point from earlier and also incorporated geom_smooth, which adds a smoothing line (loess) to the plot to help elucidate the relationship in the data. Using additional tweaks to the geom functions, we can tune the look of the plot further:

ggplot(cars, aes(x = speed, y = dist)) + 
  geom_point(color = "blue", size = 3) + 
  geom_smooth(method = "lm", color = "red", linetype = 5, size = 1.5)

# Notice how we used the "color" and "size" arguments in each geom to set up our plot as desired. This is a key advantage of ggplot: the argument names are generally very consistent across geoms, making it easier to pick up a new geom after you've gotten a handle on one previously.

# Taking this a step further, we can add in additional ggplot functions to make the plot look even better. For example, let's customize the labels with labs and adjust the plot theme and label sizing with theme_bw:

ggplot(cars, aes(x = speed, y = dist)) + 
  geom_point(color = "blue", size = 3) + 
  geom_smooth(method = "lm", color = "red", linetype = 5, size = 1.5) + 
  labs(title = "Stopping Distance Relative to Car Speed", 
       x = "Speed (mph)",
       y = "Stopping Distance (ft)") + 
  theme_bw(base_size = 20)

# The example above provide a relatively quick and simple introduction to ggplot2. Due to space/time constraints, rather than including a full description and tutorial for ggplot2 within this bootcamp unit, I will provide code that recreates the bulk of the R plot examples above via ggplot2 geoms and then also provide links to relevant ggplot2 tutorials to help you learn more (e.g., see "Learning ggplot2" at the official package page: https://ggplot2.tidyverse.org/). I will also provide a supplementary example of a ggplot2-based analysis via an R script named R-Bootcamp-Unit6-ExampleScript.R as part of this unit.

# Since the examples provided below are only a tiny subset of what ggplot2 offers, use the following help command to get a more complete sense of what ggplot2 offers:

help.search("geom_", package = "ggplot2")

# Finally, at the end of this section I will provide a few quick notes regarding ggplot2 including:

# A) storing a ggplot as an object
# B) saving via ggplot2

# ----------------------------------------------
# Side Note: Aesthetic Mapping or Layer Setting?
# ----------------------------------------------

# One aside to avoid a common point of confusion. Notice that inside the aes function, all arguments refer to columns from the data source (i.e., speed and dist from the cars data set in this case):

ggplot(cars, aes(x = speed, y = dist)) +
  geom_point()

# To change the color of the points to a fixed value, we do not modify the aesthetic, but rather the relevant layer itself. For example, to color the points blue, we make the following modification:

ggplot(cars, aes(x = speed, y = dist)) +
  geom_point(color = "blue")

# A common point of confusion is changing colors via the aesthetic. For example, let's try moving the color argument from the geom (i.e., geom_smooth) to the aesthetic (i.e., to aes):

ggplot(cars, aes(x = speed, y = dist, color = "blue")) +
  geom_point()

# Notice we now have a line that is red (rather than blue as desired) and an odd legend. The reason for this is that we incorrectly tried to set an aesthetic to a fixed value, which is not what aesthetics are intended for. Instead, if we wanted to map the points to a color usin the aesthetic, we'd have to provide R with a column to use. For instance:

ggplot(cars, aes(x = speed, y = dist, color = dist)) +
  geom_point()

# Now we have the points colored by dist, such that each point has a unique color value pulled from the data (i.e., if the cars data.frame has 50 rows, then the dist column in cars also must have 50 values to assign a color scale/gradient). Using a color aesthetic in this way is somewhat redundant, since a point's position on the y-axis already provides dist information; nevertheless, at least the mapping is correct, and the legend/color setup is accurate with respect to the data being visualized.

# In any event, think carefully about where an argument belongs in a ggplot call: typically, if you are trying to assign things to a fixed value (i.e., "red" or 3), these do not belong in the aesthetic (i.e., not in aes).

# -----------
# Point Plots
# -----------

# --- Data ---

data(cars)

# Using base:

plot(dist ~ speed, data = cars, 
     main = "Stopping Distance Relative to Car Speed", 
     xlab = "Speed (mph)", 
     ylab = "Stopping Distance (ft)",
     cex = 1.8,
     col = "blue",
     pch = 16,
     cex.axis = 1.1,
     cex.main = 2.0,
     cex.lab = 1.25)

abline(lm(dist ~ speed, data = cars), 
       col = "red",
       lty = 5,
       lwd = 3)

# Using ggplot2:

ggplot(cars, aes(x = speed, y = dist)) + 
  geom_point(color = "blue", size = 3) + 
  geom_smooth(method = "lm", color = "red", linetype = 5, size = 1.5) + 
  labs(title = "Stopping Distance Relative to Car Speed", 
       x = "Speed (mph)",
       y = "Stopping Distance (ft)") + 
  theme_bw(base_size = 20)

# Note: use se = FALSE in geom_smooth to turn off confidence interval.

# ----------
# Line Plots
# ----------

# --- Data ---

linePlotDat <- data.frame(
  x = 1:8,
  y = c(3,3,1,2,3,0,0,0)
) # some example data

data(LakeHuron)

# --- Example 1 ---

# Using base:

plot(y ~ x, data = linePlotDat, type = "l") # "l" for lines

# Using ggplot2:

ggplot(linePlotDat, aes(x = x, y = y)) + 
  geom_line() + 
  theme_bw(base_size = 20) # lines

# --- Example 2 ---

# Using base:

plot(y ~ x, data = linePlotDat, type = "o") # "o" for overplotted

# Using ggplot2:

ggplot(linePlotDat, aes(x = x, y = y)) + 
  geom_line() + 
  geom_point() + 
  theme_bw(base_size = 20) # equivalent to overplotted (i.e., lines and points)

# --- Example 3 ---

# Using base:

plot(x = 1875:1972, y = LakeHuron, type = "l", xlab = "Year", ylab = "Measured Level (ft)") # see time(LakeHuron) for an alternative x specification

# Using ggplot2:

ggplot(data.frame(LakeHuron), aes(x = 1875:1972, y = as.numeric(LakeHuron))) + 
  geom_line() + 
  xlab("Year") + 
  ylab("Measured Level (ft)") + 
  theme_bw(base_size = 20)

# ------------------------
# Bar Plots and Histograms
# ------------------------

# --- Data ---

data(mtcars)

# --- Bar Plot Example ---

# Using base:

barplot(table(mtcars$gear))

# Using ggplot2:

ggplot(mtcars, aes(x = gear)) + 
  geom_bar()

# Alternative ggplot2 (with tweaks):

ggplot(mtcars, aes(x = factor(gear), fill = factor(gear))) + 
  geom_bar() + 
  xlab("Number of Forward Gears") + 
  ylab("Count") + 
  theme_bw(base_size = 20) +
  theme(legend.position = "none") # turn off the legend

# --- Histogram Example ---

# Using base:

hist(mtcars$mpg, 
     col = "lightblue",
     xlab = "MPG",
     main = "Histogram of MPG",
     cex.axis = 1.1,
     cex.main = 2.0,
     cex.lab = 1.25,
     breaks = 10)

# Using ggplot2:

ggplot(mtcars, aes(x = mpg)) + 
  geom_histogram(bins = 10, fill = "lightblue", color = "black") + 
  labs(title = "Histogram of MPG", 
       x = "MPG",
       y = "Frequency") + 
  theme_bw(base_size = 20)

# ---------
# Box Plots
# ---------

# --- Data ---

data(InsectSprays)

# --- Bar Plot Example ---

# Using base:

boxplot(count ~ spray, data = InsectSprays, col = "lightgray")

# Using ggplot2:

ggplot(InsectSprays, aes(x = spray, y = count)) + 
  geom_boxplot(fill = "lightgray") + 
  theme_bw(base_size = 20)

# ------------------------------
# Side Note: The "stat" Argument 
# ------------------------------

# Another common point of confusion with ggplot2 is the "stat" argument, which appears in several geoms. By default, stat will be set to a value that is common for a particular geom. For instance, with geom_bar, the default stat value is "count" (i.e., stat = "count"):

ggplot(mtcars, aes(x = gear)) + 
  geom_bar(stat = "count")

# In this case, "count" implies that geom_bar will compute the count of each distinct level of the x variable being plotted based on the aesthetic. In other words, the plot function automatically conducts a calculation on your behalf, which could be calculated by hand as follows via dplyr:

library(dplyr)

mtcars %>%
  group_by(gear) %>%
  summarise(n = n())

# Alternatively, we could even simply this further using the count function in dplyr, which performs the same calculation in fewer steps (it wraps the group_by and summarise procedure):

mtcars %>%
  count(gear)

# In any case, the geom_bar function also performed this calculation on our behalf and plotted the result (i.e., compare the values from the dplyr output to the plot, and you will see they match one-to-one). Suppose, however, that we had already computed some summarized data and wanted to plot it directly ourselves. This is a scenario where the stat argument can be helpful, since "identity" is another possible setting:

plotDat <- mtcars %>%
  count(gear)

ggplot(plotDat, aes(x = gear, y = n)) + 
  geom_bar(stat = "identity")

# The code above produces essentially the same plot as we had using stat set to the default of "count" earlier, albeit with a minor difference in column labels, which could easily be fixed:

ggplot(plotDat, aes(x = gear, y = n)) + 
  geom_bar(stat = "identity") + 
  labs(y = "count")

# Now the plots match perfectly. While this isn't a particularly useful example in practice, be aware that the stat argument is powerful and can change the underlying processing performed by various geoms to produce exactly the plot you may need given how you've chosen to process the data.

# -----------------------------
# Storing a ggplot as an Object
# -----------------------------

# Unlike base plots, ggplots can be stored inside an object via assignment. This is useful for various purposes, including adjusting existing ggplots you have created. Let's show this using one of the preceding examples:

linePlotDat <- data.frame(
  x = 1:8,
  y = c(3,3,1,2,3,0,0,0)
) # some example data

ggplot(linePlotDat, aes(x = x, y = y)) + 
  geom_line() + 
  theme_bw(base_size = 20) # lines

# The code above simply prints the ggplot to the Plots pane in the lower right. To store the ggplot in an object, we can simply assign it:

storedPlot1 <- ggplot(linePlotDat, aes(x = x, y = y)) + 
  geom_line() + 
  theme_bw(base_size = 20) # lines

# To print a stored ggplot object, simply call it back:

dev.off() # clear the plot window

storedPlot1

# More interestingly, you can modify an existing ggplot object by adding additional elements. For example, to add points to the existing line plot (i.e., to make it overplotted), you can simply add to the existing plot we created above:

storedPlot1 + geom_point()

# The ability to store and/or make changes to existing plots can be useful on some occasions, including saving via ggsave as noted in the section below.

# -------------------------
# Saving Plots with ggplot2
# -------------------------

# As an alternative to the base R functions such as pdf and png, ggplot2 provides a function for saving plots named ggsave:

?ggsave

# For example, suppose you have a plot stored into an object named storedPlot2:

data(cars)

storedPlot2 <- ggplot(cars, aes(x = speed, y = dist)) + 
  geom_point(color = "blue", size = 3) + 
  geom_smooth(method = "lm", color = "red", linetype = 5, size = 1.5) + 
  labs(title = "Stopping Distance Relative to Car Speed", 
       x = "Speed (mph)",
       y = "Stopping Distance (ft)") + 
  theme_bw(base_size = 20)

# To save this plot via ggsave, use a command similar to the following (adjusting the arguments as desired):

ggsave(filename = "storedPlot2.png")

# Conveniently, the ggsave function will automatically save the plot in the appropriate format based on the extension used in your filename argument (e.g., for a PDF, use the .pdf extension):

ggsave("storedPlot2.pdf", width = 8, height = 5)

# +++++++++++++++++++++++++
# + Plotting with Lattice +
# +++++++++++++++++++++++++

# Although it will not be covered in a significant way within this bootcamp (since the focus will be on ggplot2 instead), the lattice package provides an alternative to base with several useful/valuable features. To learn more about lattice, load the library and see its relevant help file:

library(lattice)

?Lattice

# A few examples of lattice plots pulled from function examples appear below:

?cloud # 3d Scatter Plot and Wireframe Surface Plot
cloud(Sepal.Length ~ Petal.Length * Petal.Width | Species, data = iris,
      screen = list(x = -90, y = 70), distance = .4, zoom = .6)

wireframe(volcano, shade = TRUE,
          aspect = c(61/87, 0.4),
          light.source = c(10,0,10))

?bwplot # Common Bivariate Trellis Plots

bwplot(voice.part ~ height, data=singer, xlab="Height (inches)")

xyplot(Sepal.Length + Sepal.Width ~ Petal.Length + Petal.Width | Species,
       data = iris, scales = "free", layout = c(2, 2),
       auto.key = list(x = .6, y = .7, corner = c(0, 0)))