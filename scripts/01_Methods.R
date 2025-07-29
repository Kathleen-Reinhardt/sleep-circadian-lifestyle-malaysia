### Visual inspection of post-GGIR processed actigraphy
### Date: 2025-06-06
### Author: XXX

library(dplyr)

#attach nightsummary part4 data from GGIR_output_batch_run_2025-05-15
sleep_nightsummary <- read.csv("data/GGIR_part4_nightsummary_sleep_cleaned_2025-05-15.csv", stringsAsFactors = F) 
#attach file with identified sleep artifacts for removal from visual inspection
nightsummary_removals <- read.csv("data/sleep_acculturation/GGIR_Visual_inspection_removals_2025-06-04.csv", stringsAsFactors = F) 

# Remove all nights that were identified to have sleep artifacts in the visual inspection of the GGIR output Sleep Visualization PDF file
cleaned_sleep_nightsummary <- anti_join(sleep_nightsummary, nightsummary_removals, 
                                        by = c("filename", "night")) #5212 nights of sleep measurements

# Keep only rows where SptDuration is greater than 2 and less than 12
cleaned_sleep_nightsummary <- cleaned_sleep_nightsummary %>%
  filter(SleepDurationInSpt > 2, SleepDurationInSpt < 12) #results in 5122 nights of sleep measurements

#count how many of the nights removed were potential biphasic sleep patterns
sum(nightsummary_removals$biphasic == "yes", na.rm = TRUE) #333

# Write the cleaned data to a new csv file
write.csv(cleaned_sleep_nightsummary, file = "data/Final_cleaned_nightsummary_2025-06-06.csv", row.names = F)

