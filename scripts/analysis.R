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

# Bayesian Model Selection ------------------------------------------------

# This select the best model according to bayes factor

bf_fit <- generalTestBF(Test_Memory_Abs ~ Group * Emotion * Mem,
                        whichRandom = "Subject",
                        data = moebius)

bf_fit_include <- generalTestBF(Test_Memory_Abs ~ Group * Emotion * Mem,
                                data = moebius,
                                whichRandom = "Subject",
                                whichModels = "bottom")
# NLME --------------------------------------------------------------------

# Here we fit the full model (all factors with interactions) using the Maximum
# Likelihood for the stepwise selection

fit_lme <- lme(Test_Memory_Abs ~ Group * Emotion * Mem,
               random=~1|Subject,
               data = moebius,
               method = "ML")

# This is the model with the heterogeneity of variance among
# Group and Emotion factors.

fit_lme_var <- lme(Test_Memory_Abs ~ Group * Emotion * Mem,
                   random=~1|Subject,
                   data = moebius,
                   weights=varIdent(form=~1|Group*Emotion),
                   method = "ML")


# Stepwise Selection ------------------------------------------------------

# This is the stepwise selection according to BIC and AIC for both models with and
# without the heterogeneity component 

## AIC Model Selection

aic_fit_lme <- dredge(fit_lme, rank = "AIC",
                      extra = c("R^2", "adjR^2", "BIC"))

bic_fit_lme <- dredge(fit_lme, rank = "BIC",
                      extra = c("R^2", "adjR^2", "AIC"))

## BIC Model Selection

aic_fit_lme_var <- dredge(fit_lme_var, rank = "AIC",
                          extra = c("R^2", "adjR^2", "BIC"))

bic_fit_lme_var <- dredge(fit_lme_var, rank = "BIC",
                          extra = c("R^2", "adjR^2", "AIC"))

# Saving ------------------------------------------------------------------

save(bf_fit, bf_fit_include,
     file = here("objects", "bf_fit_obj.rda"))
save(aic_fit_lme, bic_fit_lme, aic_fit_lme_var, bic_fit_lme_var,
     file = here("objects", "index_fit_obj.rda"))