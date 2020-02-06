#### Preparing Workspace ####

set.seed(200)

options(scipen = 999)

# Packages ----------------------------------------------------------------

library(tidyverse)
library(here)
library(BayesFactor)
library(effects)
library(nlme)
library(MuMIn)

# Loading Data ------------------------------------------------------------

moebius <- readRDS(here("data", "cleaned", "moebius_cleaned.rds"))

# NLME --------------------------------------------------------------------

# This is the model with the heterogeneity of variance among
# Group and Emotion factors.

fit_lme_var <- lme(Test_Memory_Abs ~ Group * Emotion * Memory,
                   random=~1|Subject,
                   data = moebius,
                   weights=varIdent(form=~1|Group*Emotion),
                   method = "ML")

# Stepwise Selection ------------------------------------------------------

# This is the stepwise selection according to BIC and AIC for both models
# with and without the heterogeneity component 


## AIC-BIC Model Selection (with difference variance component)

aic_fit <- dredge(fit_lme_var, rank = "AIC",
                          extra = c("R^2", "adjR^2", "BIC"))

bic_fit <- dredge(fit_lme_var, rank = "BIC",
                          extra = c("R^2", "adjR^2", "AIC"))

# This return an object with all models

all_models <- get.models(aic_fit, subset = TRUE)

# Saving ------------------------------------------------------------------

save(aic_fit, bic_fit, all_models,
     file = here("objects", "index_fit_memory.rda"))