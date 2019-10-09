# +++++++++++++++++++++++++
# +++ R BOOTCAMP UNIT 6 +++
# +++      Example      +++
# +++++++++++++++++++++++++
# + AUTHOR: David Dobolyi +
# +++++++++++++++++++++++++

# ---------------------
# Set Working Directory
# ---------------------

# setwd("...")

# -------------
# Load Packages
# -------------

library(dplyr)
library(nycflights13)
library(ggplot2)
library(lubridate)
library(gridExtra)

# install.packages(c("dplyr", "nycflights13", "ggplot2", "lubridate", "gridExtra"))

# ---------
# Load Data
# ---------

data(flights)

head(flights)
dim(flights)
str(flights)

# -----------------
# Data Manipulation
# -----------------

# create mean arr and dep delay columns per dplyr vignette example (https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html), making sure to include the year, month, and day columns to invoid a red message about "Adding missing grouping variables"

worstDepartures <- flights %>%
  group_by(year, month, day) %>%
  select(year, month, day, arr_delay, dep_delay) %>%
  summarise(
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  ) %>%
  filter(arr > 30 | dep > 30)

worstDepartures # inspect first 10 rows as a tibble

# date conversions (via lubridate)

worstDepartures <- worstDepartures %>%
  mutate(Date = ymd(paste(year, month, day, sep = "-"))) %>% # convert year-month-day into valid Dates
  mutate(MonthFloor = floor_date(Date, unit = "month")) # floor the date to to create month groups

# --------
# Plotting
# --------

# generate plot

p1 <- ggplot(worstDepartures, aes(x = MonthFloor, y = stat(count), fill = stat(count))) + 
  geom_bar(stat = "count") # regarding stat(count), see https://ggplot2.tidyverse.org/reference/stat.html

# further modify existing plot

p2 <- p1 + 
  theme_bw(base_size = 18) + 
  scale_y_continuous(breaks = seq(0, 10, by = 2)) + 
  scale_x_date(date_breaks = "1 months", date_labels = "%b") + # for more on date_labels, see Unit 3
  scale_fill_gradient(low = "grey", high = "red") + 
  labs(title = "Months with Highly Delayed Flights in NYC During 2013",
       x = "Month",
       y = "Number of Highly Delayed Flights") + 
  guides(fill = FALSE) # turn off the fill legend

# view plots individually

p1
p2

# view plots collectively

grid.arrange(p1, p2, ncol = 1)

# save plot to disk

ggsave("WorstDepartureMonths.pdf", width = 10, height = 5)

# ------------------
# Follow-Up Analysis
# ------------------

# see sorted average delay in the worst month (i.e., June)

worstDepartures %>%
  filter(month == 6) %>%
  arrange(desc(arr, dep))

# select the worst day in June

worstDepartures %>%
  filter(month == 6) %>%
  arrange(desc(arr, dep)) %>%
  head(1) %>%
  select(year, month, day)

browseURL("http://lmgtfy.com/?q=june+2013+flight+delays+nyc")

# https://www.usatoday.com/story/todayinthesky/2013/06/13/severe-storms-snarl-flights-across-the-east/2418761/
