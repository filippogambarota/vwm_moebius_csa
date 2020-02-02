# Data Cleaning -----------------------------------------------------------

# Packages

library(tidyverse)
library(here)

moebius <- read.table(here("data/raw/moebius_raw.txt"))

# Cleaning Data --------------------------------------------------------------

# Converting to character for extracting numbers, renaming
# and removing missing values

moebius <- moebius %>%
    mutate(Test.Tag = parse_number(as.character(Test.Tag)),
           Memory = parse_number(as.character(moebius$Memory))) %>%
    rename("Test" = Test.Tag) %>%
    drop_na()

# Creating the Group Variable
# From 1 to 7 they are moebius subject, from 8 to 37 they are the control group

moebius <- moebius %>%
    mutate(Group = case_when(Subject <= 7 ~ "Moebius",
                             Subject > 7 ~ "Control")) %>%
    select(Subject, Group, Emotion, Memory, Test)

# Creating Score Values ---------------------------------------------------

## Test - Memory

moebius <- moebius %>%
    mutate(Test_Memory_Abs = abs(Test - Memory))


# Creating Memory Factor --------------------------------------------------

moebius <- moebius %>%
    mutate("Mem" = as.factor(
        case_when(Memory == 0 ~ "Level 0",
                              Memory == 1 ~ "Level 1",
                              Memory == 2 ~ "Level 2",
                              Memory == 3 ~ "Level 3",
                              Memory == 4 ~ "Level 4",
                              Memory == 5 ~ "Level 5",
                              Memory == 6 ~ "Level 6",
                              Memory == 7 ~ "Level 7")))

# Final Cleaning

moebius <- moebius %>%
    mutate(Mem = as.factor(Mem),
           Emotion = as.factor(Emotion),
           Group = as.factor(Group)) %>%
    select(Subject, Group, Emotion, Memory, Mem, Test, Test_Memory_Abs) %>%
    arrange(Subject, Group, Emotion)

# Saving Datasets ---------------------------------------------------------

saveRDS(moebius, file = here("data", "cleaned", "moebius_cleaned.rds"))