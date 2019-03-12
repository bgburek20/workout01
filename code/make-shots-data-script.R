# Title: make-shots-data-script.R
# Description: Imports the player shot profiles, modifies tables, creates summaries,
# and a combined table of player shot profiles.
# Inputs: ./data/stephen-curry.csv, ./data/klay-thompson.csv,
# ./data/kevin-durant.csv, ./data/andre-iguodala.csv, 
# and ./data/draymond-green.csv
# Outputs: ./output/stephen-curry-summary.txt, ./output/klay-thompson-summary.txt,
# ./output/kevin-durant-summary.txt, ./output/andre-iguodala-summary.txt,
# ./output/draymond-green_summary.txt, ./data/shots-data.csv, 
# ./output/shots-data-summary.txt,


# Ensure that current working directory is set to parent directory 
# workout01.

# Specify data types
data_types = c("character", #team_name
               "character", #game_date
               "numeric", #season
               "numeric", #period
               "numeric", #minutes_remaining
               "numeric", #seconds_remaining
               "character", #shot_made_flag
               "character", #action_type
               "character", #shot_type
               "numeric", #shot_distance
               "character", #opponent
               "numeric", #x
               "numeric") #y


# Import CSV files
curry <- read.csv("./data/stephen-curry.csv",
                  colClasses = data_types, stringsAsFactors = FALSE)
green <- read.csv("./data/draymond-green.csv",colClasses = data_types, stringsAsFactors = FALSE)
durant <- read.csv("./data/kevin-durant.csv",colClasses = data_types, stringsAsFactors = FALSE)
thompson <- read.csv("./data/klay-thompson.csv", colClasses = data_types, stringsAsFactors = FALSE)
iguodala <- read.csv("./data/andre-iguodala.csv", colClasses = data_types, stringsAsFactors = FALSE)

# Add column name with player name
curry$name <- c("Stephen Curry")
green$name <- c("Draymond Green")
durant$name <- c("Kevin Durant")
thompson$name <- c("Klay Thompson")
iguodala$name <- c("Andre Iguodala")

# Change "n" to "shot_no" and change "y" to "shot_yes"
curry$shot_made_flag[curry$shot_made_flag == "n"] <- "shot_no"
curry$shot_made_flag[curry$shot_made_flag == "y"] <- "shot_yes"
green$shot_made_flag[green$shot_made_flag == "n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag == "y"] <- "shot_yes"
durant$shot_made_flag[durant$shot_made_flag == "n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag == "y"] <- "shot_yes"
thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "shot_yes"
iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <- "shot_no"
iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <- "shot_yes"

# Add column minute
curry$minute <- (curry$period * 12) - curry$minutes_remaining
green$minute <- (green$period * 12) - green$minutes_remaining
durant$minute <- (durant$period * 12) - durant$minutes_remaining
thompson$minute <- (thompson$period * 12) - thompson$minutes_remaining
iguodala$minute <- (iguodala$period * 12) - iguodala$minutes_remaining

# Sink summary output to individual text_files in output
sink("./output/stephen-curry-summary.txt")
summary(curry)
sink()
sink("./output/draymond-green-summary.txt")
summary(green)
sink()
sink("./output/kevin-durant-summary.txt")
summary(durant)
sink()
sink("./output/klay-thompson-summary.txt")
summary(thompson)
sink()
sink("./output/andre-iguodala-summary.txt")
summary(iguodala)
sink()


# Stack tables into one single data frame
gsw -> rbind(curry, green, durant, thompson, iguodala)

# Send it as .csv to the data folder
write.csv(gsw, "./data/shots-data.csv")

# Sink a summary output of the assembled table
sink("./output/shots-data-summary.txt")
summary(gsw)
sink()

