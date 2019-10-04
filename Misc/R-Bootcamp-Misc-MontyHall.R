# +++++++++++++++++++++++++
# +++  R BOOTCAMP MISC  +++
# +++     MontyHall     +++
# +++++++++++++++++++++++++
# + AUTHOR: David Dobolyi +
# +++++++++++++++++++++++++

# -----
# Notes
# -----

# This script provides one possible simulation of the Monty Hall problem (that is intentionally relatively verbose). For other R implementations that helped inspire this example, see:

# http://www.bodowinter.com/tutorial/bw_doodling_monty_hall.pdf
# https://www.lilianccheung.com/data-blog/the-monty-hall-problem-with-r
# http://www.samsi.info/sites/default/files/Sun_R_lab_february2012.pdf

# ---------
# Libraries
# ---------

library(dplyr)
library(ggplot2)
library(scales)

# --------------
# Misc Functions
# --------------

# Establish required outersect function (source: https://www.r-bloggers.com/outersect-the-opposite-of-rs-intersect-function/):

outersect <- function(x, y) {
  sort(c(setdiff(x, y),
         setdiff(y, x)))
}

# ------------------------------
# Monty Hall Simulation Function
# ------------------------------

montyHall <- function(decision = "stay", iterations = 10000, seed = 123) {
  
  # set random seed (for replicability)
  set.seed(seed)
  
  # establish the doors
  doors <- c("Prize", "No Prize", "No Prize")
  
  # create an empty vector for simulation outcomes
  theResult <- rep(NA, iterations)
  
  # run the simulation repeatedly for multiple iterations via for loop
  for (i in 1:iterations) {
    
    # randomize the doors
    theDoors <- sample(doors)
    
    # randomly choose a door for the contestant
    theChoice <- sample(1:3, 1)
    
    # determine host choice based on contest choice
    if (theDoors[theChoice] == "No Prize")
      theHostChoice <- outersect(which(theDoors == "No Prize"), theChoice)
    else if (theDoors[theChoice] == "Prize")
      theHostChoice <- sample(which(theDoors == "No Prize"), 1)
    
    # determine the contestant's final choice based on switch or stay decision preference
    if (decision == "switch")
      theFinalChoice <- outersect(c(theChoice, theHostChoice), 1:3)
    else if (decision == "stay")
      theFinalChoice <- theChoice
    
    # determine the result (i.e., win or lose)
    theResult[i] <- ifelse(theDoors[theFinalChoice] == "Prize", "Win", "Lose")
    
  }
  
  # calculate the proportion of wins
  winProp <- sum(theResult == "Win") / length(theResult)
  
  # print the win percentage to the console
  message("Proportion of Wins: ", winProp * 100, "% (", decision, ")\n", sep = "")
  
  # return results
  return(
    list(
      WinProp = winProp,
      SimulationResults = theResult
    )
  )
  
}

# --------------------------------------
# Run the Simulation for Stay vs. Switch
# --------------------------------------

stayResults   <- montyHall(decision = "stay",   iterations = 10000)
switchResults <- montyHall(decision = "switch", iterations = 10000)

# ----------------
# Organize Results
# ----------------

# Create a data.frame of the simulation results based on decision type:

overallResults <- data.frame(
  Decision = c(rep("Stay",   length(stayResults$SimulationResults)), 
               rep("Switch", length(switchResults$SimulationResults))),
  Outcome  = c(stayResults$SimulationResults,
               switchResults$SimulationResults)
)

head(overallResults)

# ---------------------------
# Manipulate and Plot Results
# ---------------------------

# Calculate win/lose percentages by decision:

plotDat <- overallResults %>% 
  group_by(Decision) %>% 
  count(Outcome) %>% 
  mutate(Percent = n/sum(n))

head(plotDat)

ggplot(plotDat, aes(x = Decision, y = Percent, fill = Outcome)) + 
  geom_bar(stat = "identity", color = "black", size = 2) + 
  geom_text(aes(label = paste0(sprintf("%1.1f", Percent * 100), "%")), position = position_stack(vjust = 0.5), color = "white", fontface = "bold", size = 8) + 
  scale_y_continuous(labels = percent) + 
  ylab("Percentage of Trials") + 
  theme_bw(base_size = 20) + 
  labs(title = "Monty Hall Simulation Results",
       caption = paste0("Total Trials: ", nrow(overallResults), " (", nrow(filter(overallResults, Decision == "Stay")), " Stay and ", nrow(filter(overallResults, Decision == "Switch")), " Switch)")) + 
  theme(plot.caption = element_text(hjust = 0.5))

# To understand this code (e.g., percentage labels using geom_text), see: https://stackoverflow.com/questions/37817809/r-ggplot-stacked-bar-chart-with-counts-on-y-axis-but-percentage-as-label
